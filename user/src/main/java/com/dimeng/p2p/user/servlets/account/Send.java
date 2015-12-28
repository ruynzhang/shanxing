package com.dimeng.p2p.user.servlets.account;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.config.ConfigureProvider;
import com.dimeng.framework.config.Envionment;
import com.dimeng.framework.http.servlet.Controller;
import com.dimeng.framework.http.session.Session;
import com.dimeng.framework.http.session.authentication.AuthenticationException;
//import com.dimeng.framework.message.email.EmailSender;
import com.dimeng.framework.message.sms.SmsSender;
import com.dimeng.framework.resource.ResourceProvider;
import com.dimeng.framework.resource.ResourceRegister;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.account.user.service.SafetyManage;
import com.dimeng.p2p.user.servlets.Login;
import com.dimeng.p2p.user.util.EmailSender;
import com.dimeng.p2p.variables.defines.EmailVariavle;
import com.dimeng.p2p.variables.defines.MsgVariavle;
import com.dimeng.p2p.variables.defines.SystemVariable;
import com.dimeng.util.StringHelper;
import com.dimeng.util.parser.DateTimeParser;

public class Send extends AbstractAccountServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, final ServiceSession serviceSession)
			throws Throwable {
		PrintWriter out = response.getWriter();
		String emil = request.getParameter("emil");
		String phone = request.getParameter("phone");
		// 获取发送邮件类型
		String type = request.getParameter("type");

		SafetyManage safetyManage = serviceSession
				.getService(SafetyManage.class);

		final ConfigureProvider configureProvider = ResourceRegister
				.getResourceProvider(getServletContext()).getResource(
						ConfigureProvider.class);
		String senType = "";
		if (!StringHelper.isEmpty(emil)) {
			safetyManage.udpateSendTotal("emil");
//			EmailSender emailSender = serviceSession
//					.getService(EmailSender.class);
			String tem = "";
			String title = "";

			// 绑定邮箱时发送邮件和code
			if ("band".equals(type)) {
				title = configureProvider.getProperty(SystemVariable.SITE_NAME)
						+ EmailVariavle.RIGISTER_VERIFIY_CODE.getDescription();
				tem = configureProvider
						.getProperty(EmailVariavle.RIGISTER_VERIFIY_CODE);
				senType = "eband";
			}

			// 通过旧邮箱修改时给旧邮箱发送邮件和code
			if ("update".equals(type)) {
				title = configureProvider.getProperty(SystemVariable.SITE_NAME)
						+ EmailVariavle.UPDATE_OLD_CODE.getDescription();
				tem = configureProvider
						.getProperty(EmailVariavle.UPDATE_OLD_CODE);
				senType = "eupdate";
			}

			// 绑定邮箱时发送邮件和code
			if ("new".equals(type)) {
				if (safetyManage.isEmil(emil)) {
					StringBuilder sb = new StringBuilder();
					sb.append("[{'num':00,'msg':'");
					sb.append("邮箱已存在" + "'}]");
					out.write(sb.toString());
					return;
				} else {
					title = configureProvider
							.getProperty(SystemVariable.SITE_NAME)
							+ EmailVariavle.UPDATE_NEW_CODE.getDescription();
					tem = configureProvider
							.getProperty(EmailVariavle.UPDATE_NEW_CODE);
					senType = "enew";
				}
			}

			Envionment envionment = configureProvider.createEnvionment();
			Session session = serviceSession.getSession();
			String code = session.getVerifyCode(senType);
			envionment.set("date", DateTimeParser.format(new Timestamp(System
					.currentTimeMillis())));
			envionment.set("code", code);
			//TODO
			EmailSender.gmailSend(title, StringHelper.format(tem, envionment), emil);
//			emailSender.send(0, title, StringHelper.format(tem, envionment),
//					emil);
		}
		if (!StringHelper.isEmpty(phone)) {
			safetyManage.udpateSendTotal("phone");
			SmsSender emailSender = serviceSession.getService(SmsSender.class);
			String tem = "";
			// 绑定手机号时发送短信和code
			if ("band".equals(type)) {
				tem = configureProvider
						.getProperty(MsgVariavle.RIGISTER_VERIFIY_CODE);
				senType = "pband";
			}

			// 修改邮箱是发送短信
			if ("phoneemil".equals(type)) {
				tem = configureProvider
						.getProperty(MsgVariavle.UPDATE_EMAIL_CODE);
				senType = "pphoneemil";
			}

			if ("update".equals(type)) {
				tem = configureProvider
						.getProperty(MsgVariavle.RIGISTER_VERIFIY_CODE);
				senType = "pupdate";
			}

			if ("getoldpas".equals(type)) {
				tem = configureProvider.getProperty(MsgVariavle.FIND_PASSWORD);
				senType = "pgetoldpas";
			}

			if ("new".equals(type)) {
				if (safetyManage.isPhone(phone)) {
					StringBuilder sb = new StringBuilder();
					sb.append("[{'num':00,'msg':'");
					sb.append("手机号码已存在" + "'}]");
					out.write(sb.toString());
					return;
				} else {
					tem = configureProvider
							.getProperty(MsgVariavle.RIGISTER_VERIFIY_CODE);
					senType = "pnew";
				}
			}
			Envionment envionment = configureProvider.createEnvionment();
			Session session = serviceSession.getSession();
			String code = session.getVerifyCode(senType);
			envionment.set("date", DateTimeParser.format(new Timestamp(System
					.currentTimeMillis())));
			envionment.set("code", code);
			emailSender.send(0, StringHelper.format(tem, envionment), phone);
		}

		StringBuilder sb = new StringBuilder();
		sb.append("[{'num':01,'msg':'");
		sb.append("sussess" + "'}]");
		out.write(sb.toString());
	}

	@Override
	protected void onThrowable(HttpServletRequest request,
			HttpServletResponse response, Throwable throwable)
			throws ServletException, IOException {
		ResourceProvider resourceProvider = getResourceProvider();
		resourceProvider.log(throwable);
		PrintWriter out = response.getWriter();
		StringBuilder sb = new StringBuilder();
		sb.append("[{'num':00,'msg':'");
		sb.append(throwable.getMessage() + "'}]");
		out.write(sb.toString());
		if (throwable instanceof AuthenticationException) {
			Controller controller = getController();
			controller.redirectLogin(request, response,
					controller.getViewURI(request, Login.class));
		}

	}

}
