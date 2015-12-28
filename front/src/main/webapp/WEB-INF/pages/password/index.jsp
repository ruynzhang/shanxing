<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.front.servlets.password.Send"%>
<%@page import="com.dimeng.p2p.front.servlets.password.IndexVerify"%>
<html>
<head>
<title><%configureProvider.format(out,SystemVariable.SITE_TITLE);%>-找回密码</title>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
<%@include file="/WEB-INF/include/script.jsp"%>
</head>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<%
		String type = ObjectHelper.convert(request.getAttribute("type"), String.class);
		String emailError = ObjectHelper.convert(request.getAttribute("EMAIL_ERROR"), String.class);
		String evCodeError = ObjectHelper.convert(request.getAttribute("EMAIL_VERIFYCODE_ERROR"), String.class);
		String phoneError = ObjectHelper.convert(request.getAttribute("PHONE_ERROR"), String.class);
		String pvCodeError = ObjectHelper.convert(request.getAttribute("PHONE_VERIFYCODE_ERROR"), String.class);
	%>
	<div class="contain clearfix">
		<div class="contain_main">
			<div class="login">
				<div class="pub_title">找回密码</div>
				<div class="secret clearfix">
					<div class="secre_tab clearfix">
						<div class="email pr20" style="cursor: pointer;">
							<span id="one1" onclick="setTab('one',1,2)">使用绑定邮箱找回密码</span>
						</div>
						<div class="bound" style="cursor: pointer;">
							<span id="one2" onclick="setTab('one',2,2)">使用绑定手机号找回密码</span>
						</div>
					</div>
					<form action="<%=controller.getURI(request, Send.class)%>" method="post" class="form1">
						<input type="hidden" name="type" value="email" />
						<div class="secrebd mt30 ml30 f14 clearfix" id="con_one_1"
								<%="email".equals(type)?"":"style=\"display: none;\"" %>>
							<div class="scell clearfix pb15">
								<div class="sbt">
									<span class="red pr10">*</span>邮箱：
								</div>
								<div class="sinfo">
									<input name="email" type="text" class="stext required e-mail" />
									<p tip><%=StringHelper.isEmpty(emailError)?"请输入邮箱地址":"" %></p>
									<p errortip class="error_tip"><%=StringHelper.isEmpty(emailError)?"":emailError %></p>
								</div>
							</div>
							<div class="scell clearfix pb15">
								<div class="sbt">
									<span class="red pr10">*</span>验证码：
								</div>
								<div class="sinfo">
									<input name="verifyCode" type="text" class="stext required isint min-length-6 max-length-6" /> <img
										src="<%=controller.getURI(request, IndexVerify.class)%>?t=e"
										width="100"
										onclick='this.src="<%=controller.getURI(request, IndexVerify.class)%>?t=e&"+Math.random()'
										height="40" />
									<p tip><%=StringHelper.isEmpty(evCodeError)?"请输入6位验证码":"" %></p>
									<p errortip class="error_tip"><%=StringHelper.isEmpty(evCodeError)?"":evCodeError %></p>
								</div>
							</div>
							<div class="d_btn">
								<input class="btn btn01 sumbitForme" fromname="form1" type="submit" value="提 交" />
							</div>
						</div>
					</form>
					<form action="<%=controller.getURI(request, Send.class)%>" method="post" class="form2">
						<input type="hidden" name="type" value="phone" />
						<div class="secrebd mt30 ml30 f14 clearfix" id="con_one_2"
							<%="phone".equals(type)?"":"style=\"display: none;\"" %>>
							<div class="scell clearfix pb15">
								<div class="sbt">
									<span class="red pr10">*</span>手机号：
								</div>
								<div class="sinfo">
									<input name="phone" type="text" class="stext required min-length-11 max-length-11 phonenumber" />
									<p tip><%=StringHelper.isEmpty(phoneError)?"请输入11位手机号":"" %></p>
									<p errortip class="error_tip"><%=StringHelper.isEmpty(phoneError)?"":phoneError %></p>
								</div>
							</div>
							<div class="scell clearfix pb15">
								<div class="sbt">
									<span class="red pr10">*</span>验证码：
								</div>
								<div class="sinfo">
									<input name="verifyCode" type="text" class="stext required isint min-length-6 max-length-6" /> <img
										src="<%=controller.getURI(request, IndexVerify.class)%>?t=p"
										onclick='this.src="<%=controller.getURI(request, IndexVerify.class)%>?t=e&"+Math.random()'
										width="100" height="40" />
									<p tip><%=StringHelper.isEmpty(pvCodeError)?"请输入6位验证码":"" %></p>
									<p errortip class="error_tip"><%=StringHelper.isEmpty(pvCodeError)?"":pvCodeError %></p>
								</div>
							</div>
							<div class="d_btn">
								<input class="btn btn01 sumbitForme" fromname="form2" type="submit" value="提 交" />
							</div>
						</div>
					</form>
					<div class="efont clearfix">若您无法使用上述方法找回，请联系客服<%=configureProvider.getProperty(SystemVariable.SITE_CUSTOMERSERVICE_TEL) %></div>
				</div>
			</div>

		</div>
	</div>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/validation.js"></script>
</body>
</html>