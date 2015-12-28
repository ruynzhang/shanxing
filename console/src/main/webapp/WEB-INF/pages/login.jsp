<%@page import="com.dimeng.p2p.variables.defines.SystemVariable"%>
<%@page import="com.dimeng.p2p.console.servlets.LoginVerify"%>
<%@page import="com.dimeng.p2p.console.servlets.Login"%>
<%@page import="com.dimeng.p2p.console.servlets.common.Index"%>
<%
	if (dimengSession != null && dimengSession.isAuthenticated()) {
		controller.sendRedirect(request, response, controller.getURI(request, Index.class));
		return;
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body style="background:#04529d">
	<div class="login">
	    <div class="cos_logo"><img src="<%=fileStore.getURL(configureProvider.getProperty(SystemVariable.HTDLLOGO))%>" width="220" height="50"></div>
		<div class="con">
		<form action="<%=controller.getURI(request, Login.class) %>" method="post" onsubmit="return onSubmit()">
			<div class="cell clearfix mb20">
				<div class="title">用户名：</div>
				<div class="info"><input name="username" value="<%StringHelper.filterHTML(out, request.getParameter("username")); %>" type="text" class="text" onblur="accountCheck();"/></div>
			</div>
			<div class="cell clearfix mb20">
				<div class="title">密码：</div>
				<div class="info"><input name="password" type="password" class="text text2" onblur="passwordCheck();"/></div>
				<div class="clear"></div>
			</div>
			<div class="cell clearfix mb10">			
				<div class="title">验证码：</div>
				<div class="info yz_l"><input name="verifyCode" maxlength="<%=systemDefine.getVerifyCodeLength() %>" type="text"  class="code" onblur="verifyCheck();"/>
				</div>
				<div class="login_yzm">
					<img src="<%=controller.getURI(request, LoginVerify.class) %>" alt="验证码" title="点击刷新" width="95" height="31" onclick='this.src="<%=controller.getURI(request, LoginVerify.class) %>?"+Math.random()' style="cursor: pointer;" />
				</div>
			 </div>
			 <p style="height:25px;" class="ml100">
			 	<%String errorMessage = controller.getPrompt(request,response,PromptLevel.ERROR);%>
				<font color="red" size="2" id="error"><%StringHelper.filterHTML(out, errorMessage);%></font>
			 </p>
			<div>
				<input name="login" type="submit" class="btn1" value="登 录" />
			</div>
			</form>
		</div>
	</div>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
	<script type="text/javascript">
		var verify = /^\d{<%=systemDefine.getVerifyCodeLength() %>}$/;
		var isNull = /^[\s]{0,}$/;
		var loginName = /^[a-z]([\w]*)$/i;
		function accountCheck() {
			var val = $("input[name='username']").val();
			var p = $("#error");
			if(isNull.test(val)){
				p.html("用户名不能为空");
				return false;
			}
			return true;
		}
		function passwordCheck() {
			var val = $("input[name='password']").val();
			var p = $("#error");
			if (isNull.test(val)) {
				p.html("密码不能为空");
				return false;
			}
			return true;
		}
		function verifyCheck() {
			var val = $("input[name='verifyCode']").val();
			var p = $("#error");
			if (isNull.test(val)) {
				p.html("验证码不能为空");
				return false;
			} else if (!verify.test(val)) {
				p.html("您输入的验证码有误");
				return false;
			}
			return true;
		}
		function onSubmit() {
			return accountCheck() && passwordCheck() && verifyCheck();
		}
	</script>
</body>
</html>
