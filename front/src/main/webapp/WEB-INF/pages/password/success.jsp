<%@page import="com.dimeng.p2p.variables.defines.SystemVariable"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><%configureProvider.format(out,SystemVariable.SITE_TITLE);%>-找回密码</title>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
<%@include file="/WEB-INF/include/script.jsp"%>
</head>
<body>
	<%
		String accountId = serviceSession.getSession().getAttribute("PASSWORD_ACCOUNT_ID");
		if(StringHelper.isEmpty(accountId)){
			controller.sendRedirect(request, response, controller.getViewURI(request, com.dimeng.p2p.front.servlets.password.Index.class));
		}
	%>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="contain clearfix">
		<div class="contain_main">
			<div class="login">
				<div class="pub_title">找回密码</div>
				<div class="secret clearfix">
					<div class="f24 tc red">恭喜您，已经成功重置您的密码！</div>
					<div class="secrebd clearfix">
						<div class="d_btn">
							<a href="<%configureProvider.format(out,URLVariable.LOGIN);%>" class="btn btn01">立即登录</a>
						</div>
					</div>
					<div class="efont clearfix">若您无法使用上述方法找回，请联系客服<%configureProvider.format(out,SystemVariable.SITE_CUSTOMERSERVICE_TEL);%></div>
				</div>
			</div>
		</div>
	</div>
	<%@include file="/WEB-INF/include/footer.jsp"%>
</body>
</html>