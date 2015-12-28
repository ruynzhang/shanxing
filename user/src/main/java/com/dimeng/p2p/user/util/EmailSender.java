package com.dimeng.p2p.user.util;

import java.io.UnsupportedEncodingException;
import java.security.Security;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeUtility;


public class EmailSender {
	private static String loginname = "master"; 

	private static String password = "mastersl123";
	private final static String SMTP_HOST = "myshanxing.com"; // 
	@SuppressWarnings("restriction")
	public static void gmailSend(final String subject, final String body, final String email) {
		new Thread(new Runnable() {
			@Override
			public void run() {
				Security.addProvider(new com.sun.net.ssl.internal.ssl.Provider());
				Properties props = System.getProperties();
				props.setProperty("mail.smtp.host", SMTP_HOST);
				props.setProperty("mail.smtp.socketFactory.fallback", "false");
				props.setProperty("mail.smtp.port", "25");
				props.put("mail.smtp.auth", "true");
				Session session = Session.getInstance(props,
						new Authenticator() {
							@Override
							protected PasswordAuthentication getPasswordAuthentication() {
								return new PasswordAuthentication(loginname, password);
							}
						});
		
				// -- Create a new message --
				Message mimeMessage = new MimeMessage(session);
		
				// -- Set the FROM and TO fields --
				try {
					String nick = null;
					try {
						nick = MimeUtility.encodeText("善行创投");
					} catch (UnsupportedEncodingException e) {
						e.printStackTrace();
						nick = "";
					}
					mimeMessage.setFrom(new InternetAddress(nick + "<master@myshanxing.com>")); // @findex8.com
					mimeMessage.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email, false));
					mimeMessage.setSubject(subject);
					mimeMessage.setText(body);
					mimeMessage.setSentDate(new java.util.Date());// 发送日期   
					Transport.send(mimeMessage);
		//			System.out.println("Message sent.");
				} catch (AddressException e) {
					System.out.println("发送的邮件地址异常:" + e.getMessage());
					e.printStackTrace();
		//			logger.error("查询常见问题出错：" + e.getMessage(), e); 
				} catch (MessagingException e) {
					System.out.println("发送的邮件异常:" + e.getMessage());
					e.printStackTrace();
		//			logger.error("查询常见问题出错：" + e.getMessage(), e); 
					
				}
			}
		}).start();
	}

//	@SuppressWarnings("restriction")
//	public static void gmailHtmlSend(String title, String strPlainBody,
//			String email, String strHtmlBody) {
//		Security.addProvider(new com.sun.net.ssl.internal.ssl.Provider());
//		// final String SSL_FACTORY = "javax.net.ssl.SSLSocketFactory";
//		// Get a Properties object
//		Properties props = System.getProperties();
//		props.setProperty("mail.smtp.host", SMTP_HOST);
//		// props.setProperty("mail.smtp.socketFactory.class", SSL_FACTORY);
//		props.setProperty("mail.smtp.socketFactory.fallback", "false");
//		props.setProperty("mail.smtp.port", "25");
//		// props.setProperty("mail.smtp.socketFactory.port", "25");
//		props.put("mail.smtp.auth", "true");
//		//final String username = Loginname;
//		//final String password = Password;
//		Session session = Session.getInstance(props,
//				new Authenticator() {
//					@Override
//					protected PasswordAuthentication getPasswordAuthentication() {
//						return new PasswordAuthentication(loginname, password);
//					}
//				});
//
//		// -- Create a new message --
//		Message mimeMessage = new MimeMessage(session);
//
//		// -- Set the FROM and TO fields --
//		try {
//			mimeMessage.setFrom(new InternetAddress("sunnywei@myshanxing.com"));
//
//			mimeMessage.setRecipients(Message.RecipientType.TO, InternetAddress.parse(
//					email, false));
//			mimeMessage.setSubject(title);
//
//			// msg.setText(body);
//			{
//				// Create an "Alternative" Multipart message
//				Multipart mp = new MimeMultipart("alternative");
//
//				// Read text file, load it into a BodyPart, and add it to the
//				// message.
//				{
//					BodyPart messageBodyPart = new MimeBodyPart();
//					messageBodyPart.setContent(strPlainBody, "text/html;charset=UTF-8");
//					mp.addBodyPart(messageBodyPart);
//				}
//
//				// Do the same with the HTML part
//				{
//					BodyPart messageBodyPart = new MimeBodyPart();
//					messageBodyPart.setContent(strHtmlBody, "text/html;charset=UTF-8");
//					mp.addBodyPart(messageBodyPart);
//				}
//
//				// Set the content for the message and transmit
//				mimeMessage.setContent(mp);
//
//			}
//			mimeMessage.setSentDate(new Date());
//			Transport.send(mimeMessage);
//			System.out.println("Message sent.");
//		} catch (AddressException e) {
//			logger.error("查询常见问题出错：" + e.getMessage(), e); 
//		} catch (MessagingException e) {
//			logger.error("查询常见问题出错：" + e.getMessage(), e); 
//		}
//	}

	public static void main(String[] args) {
		System.out.println(11111);

		String content="本次修改邮箱的验证码是：499677。如非本人操作请致电400-111-7168。 [善行创投]";
		
		gmailSend("善行创投修改邮箱验证码(新邮箱)",content,"webking168@126.com");
	}

}
