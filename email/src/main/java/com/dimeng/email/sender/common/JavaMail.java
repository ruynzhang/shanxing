package com.dimeng.email.sender.common;

import java.util.Date;
import java.util.Properties;

import javax.mail.Address;
import javax.mail.Authenticator;
import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

import com.dimeng.framework.config.ConfigureProvider;
import com.dimeng.framework.message.email.entity.EmailTask;
import com.dimeng.p2p.variables.defines.MessageVariable;

public class JavaMail {

	private ConfigureProvider configureProvider;

	// 邮箱服务器

	public JavaMail(ConfigureProvider configureProvider) {
		this.configureProvider = configureProvider;
	}

	/**
	 * 此段代码用来发送普通电子邮件
	 */
	public synchronized void send(EmailTask emailTask) throws Exception {
		if (emailTask == null) {
			return;
		}
		Properties props = new Properties(); // 获取系统环境
		props.put("mail.smtp.host",
				configureProvider.getProperty(MessageVariable.MAIL_SMTP_HOST));
		props.put("mail.smtp.auth", "true");
		props.setProperty("mail.smtp.user",
				configureProvider.getProperty(MessageVariable.MAIL_USER_NAME));
		props.setProperty("mail.smtp.password", configureProvider
				.getProperty(MessageVariable.MAIL_USER_PASSWORD));
		props.setProperty("mail.smtp.auth", "true");
		Session session = Session
				.getDefaultInstance(
						props,
						new MyAuthenricator(
								configureProvider
										.getProperty(MessageVariable.MAIL_USER_NAME),
								configureProvider
										.getProperty(MessageVariable.MAIL_USER_PASSWORD)));
		// 设置session,和邮件服务器进行通讯。
		MimeMessage message = new MimeMessage(session);
		// message.setContent("foobar", "application/x-foobar"); // 设置邮件格式
		if (emailTask.addresses != null && emailTask.addresses.length > 0) {
			Address[] toAddresses = new InternetAddress[emailTask.addresses.length]; // 设置邮件接收方的地址
			int i = 0;
			for (String addr : emailTask.addresses) {
				toAddresses[i] = new InternetAddress(addr);
				i++;
			}
			message.setSubject(emailTask.subject); // 设置邮件主题s
			// message.setText(emailInfo.getContent()); // 设置邮件正文
			// message.setHeader(MAIL_HEAD_NAME,MAIL_HEAD_NAME); // 设置邮件标题
			message.setSentDate(new Date()); // 设置邮件发送日期
			Address address = new InternetAddress(
					configureProvider
							.getProperty(MessageVariable.MAIL_USER_NAME),
					configureProvider
							.getProperty(MessageVariable.MAIL_USER_PERSONALNAME));
			message.setFrom(address); // 设置邮件发送者的地址
			Multipart mainPart = new MimeMultipart();
			BodyPart html = new MimeBodyPart();
			// 设置HTML内容
			html.setContent(emailTask.content, "text/html; charset=utf-8");
			mainPart.addBodyPart(html);
			// 将MiniMultipart对象设置为邮件内容
			message.setContent(mainPart);

			// message.addRecipient(Message.RecipientType.TO, toAddress);
			message.addRecipients(Message.RecipientType.TO, toAddresses);
			Transport.send(message); // 发送邮件
		}
	}

	/**
	 * 用来进行服务器对用户的认证
	 */
	static class MyAuthenricator extends Authenticator {
		String user = null;
		String pass = "";

		public MyAuthenricator(String user, String pass) {
			this.user = user;
			this.pass = pass;
		}

		@Override
		protected PasswordAuthentication getPasswordAuthentication() {
			return new PasswordAuthentication(user, pass);
		}
	}

}
