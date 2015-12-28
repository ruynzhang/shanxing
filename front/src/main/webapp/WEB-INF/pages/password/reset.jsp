<%@page import="com.dimeng.p2p.front.servlets.password.Reset"%>
<%@page import="com.dimeng.p2p.variables.defines.SystemVariable"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title><%configureProvider.format(out,SystemVariable.SITE_TITLE);%>-找回密码</title>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<%
		String accountId = serviceSession.getSession().getAttribute("PASSWORD_ACCOUNT_ID");
		if(StringHelper.isEmpty(accountId)){
			controller.sendRedirect(request, response, controller.getViewURI(request, com.dimeng.p2p.front.servlets.password.Index.class));
		}
		String error = controller.getPrompt(request, response, PromptLevel.ERROR);
				
	%>
	<div class="contain clearfix">
		<div class="contain_main">
			<div class="login">
				<div class="pub_title">找回密码</div>
				<div class="secret clearfix">
					<div class="f24 tc">重置密码</div>
					<form action="<%=controller.getURI(request, Reset.class) %>" class="form1" method="post">
						<div class="secrebd mt30 ml30 f14 clearfix">
							<div class="scell clearfix pb15">
								<div class="sbt">
									<span class="red pr10">*</span>校验码：
								</div>
								<div class="sinfo">
									<input name="code" type="text" class="stext fl required isint min-length-6 max-length-6" /> 
									<p class="clear"></p>
									<p tip><%=StringHelper.isEmpty(error)?"请输入6位校验码":"" %></p>
									<p errortip class="error_tip"><%=StringHelper.isEmpty(error)?"":error %></p>
									<span class="fl"></span>
								</div>
							</div>
							<div class="scell clearfix pb15">
								<div class="sbt">
									<span class="red pr10">*</span>新密码：
								</div>
								<div class="sinfo">
									<input name="password" type="password" class="stext required password-a min-length-6 max-length-20" />
									<p tip>请输入6-20个字符，区分大小写</p>
									<p errortip class="" style="display: none"></p>
								</div>
							</div>
							<div class="scell clearfix pb15">
								<div class="sbt">
									<span class="red pr10">*</span>确认密码：
								</div>
								<div class="sinfo">
									<input name="repassword" type="password" class="stext required password-b min-length-6 max-length-20" />
									<p tip>请再次输入密码</p>
									<p errortip class="" style="display: none"></p>
								</div>
							</div>
							<div class="d_btn">
								<input class="btn btn01 sumbitForme" type="submit" fromname="form1" value="提 交" />
							</div>
							<div class="efont clearfix">若您无法使用上述方法找回，请联系客服<%=configureProvider.getProperty(SystemVariable.SITE_CUSTOMERSERVICE_TEL)  %></div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<%@include file="/WEB-INF/include/script.jsp"%>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<script type="text/javascript"
		src="<%=controller.getStaticPath(request)%>/js/validation.js"></script>
</body>
</html>