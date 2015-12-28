package com.dimeng.email.sender;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Properties;
import java.util.concurrent.LinkedBlockingQueue;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;

import javax.mail.Address;
import javax.mail.Authenticator;
import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

import com.dimeng.framework.config.ConfigureProvider;
import com.dimeng.framework.message.email.Extracter;
import com.dimeng.framework.message.email.entity.EmailTask;
import com.dimeng.framework.resource.ResourceProvider;
import com.dimeng.framework.service.ServiceProvider;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.variables.defines.MessageVariable;
import com.dimeng.util.StringHelper;
import com.dimeng.util.parser.IntegerParser;

/**
 * 调度器
 */
public class Scheduler extends Thread {

	protected final ThreadPoolExecutor executor;
	private transient boolean alive = true;
	private final ResourceProvider resourceProvider;
	protected final ConfigureProvider configureProvider;
	protected final ServiceProvider serviceProvider;

	public Scheduler(ResourceProvider resourceProvider) {
		this.resourceProvider = resourceProvider;
		executor = new ThreadPoolExecutor(10, 50, 30, TimeUnit.SECONDS,
				new LinkedBlockingQueue<Runnable>());
		configureProvider = resourceProvider
				.getResource(ConfigureProvider.class);
		serviceProvider = resourceProvider.getResource(ServiceProvider.class);
	}

	public void halt() {
		alive = false;
		try {
			executor.shutdownNow();
		} finally {
			this.interrupt();
		}
	}

	@Override
	public void run() {
		while (alive) {
			ConfigureProvider configureProvider = resourceProvider
					.getResource(ConfigureProvider.class);

			EmailTask[] emailTasks = null;

			try (ServiceSession serviceSession = serviceProvider
					.createServiceSession()) {
				serviceSession.openTransactions();
				Extracter extracter = serviceSession
						.getService(Extracter.class);
				int maxCount = IntegerParser.parse(configureProvider
						.getProperty(MessageVariable.MAIL_MAX_COUNT));
				int expirsMinutes = IntegerParser.parse(configureProvider
						.getProperty(MessageVariable.MAIL_EXPIRES_MINUTES));
				emailTasks = extracter.extract(maxCount, expirsMinutes);
				serviceSession.commit();
			} catch (Throwable e) {
				resourceProvider.log(e);
			}
			if (emailTasks != null && emailTasks.length > 0) {
				Runner runner = new Runner(emailTasks);
				executor.submit(runner);
			}
			try {
				sleep(3000);
			} catch (InterruptedException e) {
				alive = false;
				break;
			}
		}
	}

	protected class Runner implements Runnable {
		protected EmailTask[] emailTasks;

		public Runner(EmailTask[] emailTasks) {
			this.emailTasks = emailTasks;
		}

		@Override
		public void run() {
			if (emailTasks == null) {
				return;
			}
			try (ServiceSession serviceSession = serviceProvider
					.createServiceSession()) {
				Extracter extracter = serviceSession
						.getService(Extracter.class);
				Properties props = new Properties(); // 获取系统环境
				props.put("mail.smtp.host", configureProvider
						.getProperty(MessageVariable.MAIL_SMTP_HOST));
				props.put("mail.smtp.auth", "true");
				props.setProperty("mail.smtp.user", configureProvider
						.getProperty(MessageVariable.MAIL_USER_NAME));
				props.setProperty("mail.smtp.password", configureProvider
						.getProperty(MessageVariable.MAIL_USER_PASSWORD));
				props.setProperty("mail.smtp.auth", "true");
				Session session = Session.getInstance(props,
						new Authenticator() {
							protected PasswordAuthentication getPasswordAuthentication() {
								return new PasswordAuthentication(
										configureProvider
												.getProperty(MessageVariable.MAIL_USER_NAME),
										configureProvider
												.getProperty(MessageVariable.MAIL_USER_PASSWORD));
							};
						});
				for (EmailTask emailTask : emailTasks) {
					extracter.mark(emailTask.id);
					send(emailTask, session);
				}
			} catch (Throwable e) {
				resourceProvider.log(e);
			}
		}

		public void send(EmailTask emailTask, Session session) {
			if (emailTask == null || emailTask.addresses == null
					|| emailTask.addresses.length == 0) {
				return;
			}
			MimeMessage message = new MimeMessage(session);
			try {
				List<Address> toAddresses = new ArrayList<>(
						emailTask.addresses.length);
				for (String addr : emailTask.addresses) {
					if (StringHelper.isEmpty(addr)) {
						continue;
					}
					try {
						toAddresses.add(new InternetAddress(addr));
					} catch (AddressException e) {
						resourceProvider.log(String.format(
								"邮件ID： %s 中包含错误的收件人地址%s",
								Long.toString(emailTask.id), addr));
					}
				}
				if (toAddresses.size() == 0) {
					resourceProvider.log(String.format(
							"邮件ID： %s， 主题: %s, 没有有效的收件人地址，发送失败.",
							Long.toString(emailTask.id), emailTask.subject));
					return;
				}
				message.setSubject(emailTask.subject);
				message.setSentDate(new Date());
				Address address = new InternetAddress(
						configureProvider
								.getProperty(MessageVariable.MAIL_USER_NAME),
						configureProvider
								.getProperty(MessageVariable.MAIL_USER_PERSONALNAME));
				message.setFrom(address); // 设置邮件发送者的地址
				Multipart mainPart = new MimeMultipart();
				BodyPart html = new MimeBodyPart();
				html.setContent(emailTask.content, "text/html; charset=utf-8");
				mainPart.addBodyPart(html);
				message.setContent(mainPart);
				message.addRecipients(Message.RecipientType.TO,
						toAddresses.toArray(new Address[toAddresses.size()]));
				Transport.send(message);
				resourceProvider.log(String.format("邮件ID： %s， 主题: %s, 发送成功",
						Long.toString(emailTask.id), emailTask.subject));
			} catch (Exception e) {
				resourceProvider.log(String.format("邮件ID： %s， 主题: %s, 发送失败",
						Long.toString(emailTask.id), emailTask.subject));
				resourceProvider.log(e);
			}
		}
	}
}
