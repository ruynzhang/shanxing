<%@page import="com.dimeng.p2p.user.servlets.LoginVerify"%>
<%@page import="com.dimeng.p2p.user.servlets.Login"%>
<%@page import="com.dimeng.p2p.variables.defines.SystemVariable"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="com.dimeng.util.StringHelper"%>
<%
	if (dimengSession != null && dimengSession.isAuthenticated()) {
		controller.sendRedirect(request, response, configureProvider.format(URLVariable.USER_INDEX));
		return;
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%configureProvider.format(out,SystemVariable.SITE_NAME);%> - 用户登录</title>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
<!--登录banner-->
<div class="zc_banner">
	<div class="w1002">
    	<div class="clearfix"><a href="<%configureProvider.format(out,URLVariable.LOGIN);%>" class="an01 ml200 mr20">登录</a><a href="<%configureProvider.format(out,URLVariable.REGISTER);%>" class="an01 mr20">注册</a><a href="<%configureProvider.format(out,URLVariable.INDEX);%>" class="an02">返回首页</a></div>
    	<div class="zc_jt"></div>
    </div>
</div>
<!--登录banner-->

<!--登录-->
<form action="<%=controller.getURI(request, Login.class)%>" method="post" onsubmit="return onSubmit();">
					<input type="hidden" name="_z" value="<%StringHelper.filterHTML(out, request.getParameter("_z"));%>" />
<div class="w1002">
    <div class="registration ml200 clearfix mt20 mb30">
    
        <div class="re_left">
        <%{String errorMessage = controller.getPrompt(request,response,PromptLevel.ERROR);if (!StringHelper.isEmpty(errorMessage)) {%>
						<div class="allerror clear">
							<img alt="<%configureProvider.format(out,SystemVariable.SITE_NAME);%>" src="<%=controller.getStaticPath(request)%>/images/popup_error.gif" /><%StringHelper.filterHTML(out, errorMessage);%>
						</div>
		<%}}%>
        	<p>
        	<%
									String _accountName = null;
									Cookie[] _cookies = request.getCookies();
									if (_cookies != null) {
										for (Cookie cookie : _cookies) {
											if (cookie == null) {continue;}
											if ("ACCOUNT_NAME".equals(cookie.getName())) {_accountName = URLDecoder.decode(cookie.getValue(),resourceProvider.getCharset());
											}
										}
									}
			%>
               <input name="accountName" type="text"  value="用户名" class="inp" value="<%StringHelper.filterHTML(out, _accountName);%>" onblur="accountCheck();" maxlength="18"/>
                <span class="f12">6-18个字符，可使用字母、数字，需字母开头</span>
               
            </p>
            <p>
                <input name="showPwd" id="showPwd" type="text" class="inp" value="密码 "  maxlength="20"/>
                <input name="password" type="password" class="inp" value="密码" onblur="passwordCheck();"  maxlength="20" style="display: none;"/>
                <span class="f12">6-20个字符，区分大小写</span>
            </p>
            <p>
            	<input name="verifyCode" type="text" value="验证码" maxlength="<%=systemDefine.getVerifyCodeLength() %>" class="inp" onblur="verifyCheck();" style="width:100px;"/>
            	<span>
						<img alt="验证码" id="_verifyImg" src="<%=controller.getURI(request, LoginVerify.class)%>" alt="验证码" title="点击刷新" width="80" height="42" onclick="this.src='<%=controller.getURI(request, LoginVerify.class)%>?'+Math.random()" style="cursor: pointer;" />
						<a href="javascript:void(0)" onclick="$('#_verifyImg').attr('src','<%=controller.getURI(request, LoginVerify.class)%>?'+Math.random())" class="blue ml10 blue_line">换一张</a>
				</span>
            </p>
            <p id="verifyError">&nbsp;</p>
            <p><input type="submit" class="re_sign mt10" value="登录" /></p>
            <p class="mt5">
            <input name="remember" type="checkbox" value="1" class="mr10" <%=StringHelper.isEmpty(_accountName) ? "": "checked=\"checked\""%> />
            <span class="blue_ls ml5">记住用户名</span>  
            <a href="<%configureProvider.format(out, URLVariable.GET_PASSWORD);%>" class="fr blue">忘记密码</a>
            </p>
            
        </div>
        <!-- 
        <div class="re_center">或</div>
        <div class="re_right">
        	<p class="mb20">使用社交账号登录</p>
            <a href="#" class="web_btn"></a>
            <a href="#" class="qq_btn"></a>
        </div>
         -->
    </div>
</div>
</form>
<!--登录-->
	
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
	<script type="text/javascript">
	var isNull = /^[\s]{0,}$/;
	var verify = /^\d{<%=systemDefine.getVerifyCodeLength() %>}$/;
	var loginName = /^[a-z]([\w]*)$/i;
	var nameInput= $(":input[name='accountName']");
	var pwdInput=$(":input[name='password']");
	var sPwdInput=$(":input[name='showPwd']");
	var codeInput= $(":input[name='verifyCode']");
	$(":input").css({color:"#aaa"});
	sPwdInput.focus(function(){
		if($.trim(this.value)=="密码"){
			sPwdInput.hide(); 
			pwdInput.show().focus(); 
			pwdInput.val("");
			pwdInput.css({color:"#333"});
		}
	});
	pwdInput.blur(function(){
		if(!this.value){
			pwdInput.hide();
			sPwdInput.show();
		};
	});
	nameInput.click(function(){
		if(this.value=="用户名"){
			this.value='';
		    $(this).css({color:"#333"});
		}
	}).blur(function(){
		if(!this.value){
			this.value = '用户名';
			 $(this).css({color:"#aaa"});
			};
	});
	codeInput.click(function(){
		if(this.value=="验证码"){
			this.value='';
			 $(this).css({color:"#333"});
		}
	}).blur(function(){
		if(!this.value){
			this.value = '验证码';
			 $(this).css({color:"#aaa"});
			};
	});
	
	function accountCheck() {
		var val = $("input[name='accountName']").val();
		var p = $("input[name='accountName']").parent().find("span");
		p.html("&nbsp;");
		p.removeClass("red");
		if (isNull.test(val)) {
			p.html("用户名不能为空");
			p.addClass("red");
			return false;
		}
		return true;
	}
	function passwordCheck() {
		var val = $("input[name='password']").val();
		var p = $("input[name='password']").parent().find("span");
		p.html("&nbsp;");
		p.removeClass("red");
		if (isNull.test(val)) {
			p.html("密码不能为空");
			p.addClass("red");
			return false;
		}
		return true;
	}
	function verifyCheck() {
		var val = $("input[name='verifyCode']").val();
		var p = $("#verifyError");
		p.html("&nbsp;");
		p.removeClass("red");
		if (isNull.test(val)) {
			p.html("验证码不能为空");
			p.addClass("red");
			return false;
		} else if (!verify.test(val)) {
			p.html("您输入的验证码有误");
			p.addClass("red");
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
