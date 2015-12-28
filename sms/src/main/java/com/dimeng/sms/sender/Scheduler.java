package com.dimeng.sms.sender;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.concurrent.LinkedBlockingQueue;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;

import com.dimeng.framework.config.ConfigureProvider;
import com.dimeng.framework.message.sms.Extracter;
import com.dimeng.framework.message.sms.entity.SmsTask;
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
	protected transient boolean alive = true;
	protected final ResourceProvider resourceProvider;
	protected final ConfigureProvider configureProvider;
	protected final ServiceProvider serviceProvider;

	public Scheduler(ResourceProvider resourceProvider) {
		this.resourceProvider = resourceProvider;
		configureProvider = resourceProvider
				.getResource(ConfigureProvider.class);
		serviceProvider = resourceProvider.getResource(ServiceProvider.class);
		executor = new ThreadPoolExecutor(10, 50, 30, TimeUnit.SECONDS,
				new LinkedBlockingQueue<Runnable>());
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
			SmsTask[] smsTasks = null;
			try (ServiceSession serviceSession = serviceProvider
					.createServiceSession()) {
				serviceSession.openTransactions();
				int maxCount = IntegerParser.parse(configureProvider
						.getProperty(MessageVariable.SMS_MAX_COUNT));
				int expirsMinutes = IntegerParser.parse(configureProvider
						.getProperty(MessageVariable.SMS_EXPIRES_MINUTES));
				Extracter extracter = serviceSession
						.getService(Extracter.class);
				smsTasks = extracter.extract(maxCount, expirsMinutes);
				serviceSession.commit();
			} catch (Throwable e) {
				resourceProvider.log(e);
			}
			if (smsTasks != null && smsTasks.length > 0) {
				Runner runner = new Runner(smsTasks);
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
		protected SmsTask[] smsTasks;
		protected final StringBuilder sb = new StringBuilder();
		protected final String encode = "UTF-8";

		public Runner(SmsTask[] smsTasks) {
			this.smsTasks = smsTasks;
		}

		public String send(SmsTask smsTask) {
			int len = smsTask.receivers.length;
			if (len <= 0) {
				return null;
			}
			sb.setLength(0);
			try {
				String sn = configureProvider.getProperty(MessageVariable.SMS_SN);
				sb.append("sn=");
				sb.append(sn);
				sb.append("&pwd=");
				sb.append(getMD5(sn+configureProvider
						.getProperty(MessageVariable.SMS_USER_PASSWORD)));
				sb.append("&mobile=");
				for (int i = 0; i < len; i++) {
					if (i > 0) {
						sb.append(",");
					}
					sb.append(smsTask.receivers[i]);
				}
				sb.append("&content=");
				//String sign = configureProvider.getProperty(MessageVariable.SMS_SIGN);
				sb.append(URLEncoder.encode(smsTask.content, "GBK"));
				sb.append("&ext=");
				sb.append("&stime=");
				sb.append("&rrid=");
				sb.append("&msgfmt=");
				URL postUrl = new URL(
						configureProvider.getProperty(MessageVariable.SMS_URI));
				URLConnection connection = postUrl.openConnection();
				connection.setRequestProperty("accept", "*/*");
				connection.setRequestProperty("connection", "Keep-Alive");
				connection.setRequestProperty("Content-Type",
						"application/x-www-form-urlencoded");
				connection.setDoOutput(true);
				connection.setDoInput(true);
				try (OutputStreamWriter out = new OutputStreamWriter(
						connection.getOutputStream())) {
					out.write(sb.toString());
					out.flush();
				}
				StringBuilder result = new StringBuilder();
				String line = null;
				try (BufferedReader in = new BufferedReader(
						new InputStreamReader(connection.getInputStream(), encode))) {
					while((line = in.readLine()) != null){
						result.append(line);
					}
				}
				resourceProvider.log(String.format("短信ID：%s，内容：%s，发送完成，返回状态码：%s",
						Long.toString(smsTask.id), smsTask.content, result.toString()));
				return result.toString();
			} catch (Exception e) {
				resourceProvider.log(String.format("短信ID：%s，内容：%s，发送失败",
						Long.toString(smsTask.id), smsTask.content));
				resourceProvider.log(e);
				return null;
			}
		}

		@Override
		public void run() {
			if (smsTasks == null || smsTasks.length == 0) {
				return;
			}
			try (ServiceSession serviceSession = serviceProvider
					.createServiceSession()) {
				Extracter extracter = serviceSession
						.getService(Extracter.class);
				for (SmsTask smsTask : smsTasks) {
					serviceSession.openTransactions();
					String code = send(smsTask);
					extracter.mark(smsTask.id, !StringHelper.isEmpty(code) && !code.contains("-"), code);
					serviceSession.commit();
				}
			} catch (Throwable e) {
				resourceProvider.log(e);
			}
		}
	}
	
	/*
	 * 方法名称：getMD5 功 能：字符串MD5加密 参 数：待转换字符串 返 回 值：加密之后字符串
	 */
	protected String getMD5(String sourceStr) throws UnsupportedEncodingException {
		String resultStr = "";
		try {
			byte[] temp = sourceStr.getBytes();
			MessageDigest md5 = MessageDigest.getInstance("MD5");
			md5.update(temp);
			// resultStr = new String(md5.digest());
			byte[] b = md5.digest();
			for (int i = 0; i < b.length; i++) {
				char[] digit = { '0', '1', '2', '3', '4', '5', '6', '7', '8',
						'9', 'A', 'B', 'C', 'D', 'E', 'F' };
				char[] ob = new char[2];
				ob[0] = digit[(b[i] >>> 4) & 0X0F];
				ob[1] = digit[b[i] & 0X0F];
				resultStr += new String(ob);
			}
			return resultStr;
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
			return null;
		}
	}

}
