<%@page import="com.dimeng.p2p.user.servlets.Loginclub"%>
<%@page import="com.dimeng.p2p.user.servlets.LoginVerify"%>
<%@page import="com.dimeng.p2p.user.servlets.Login"%>
<%@page import="com.dimeng.p2p.variables.defines.SystemVariable"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="com.dimeng.util.StringHelper"%>
<%
/**if (dimengSession != null && dimengSession.isAuthenticated()) {
	controller.sendRedirect(request, response, configureProvider.format(URLVariable.USER_INDEX));
	return;
}**/
String slhurl="";
if(request.getParameter("slhurl")==null || ("").equals(request.getParameter("slhurl")) ){
	slhurl="http://www.myshanxing.com/user/loginclub.html";
}else{
	slhurl=URLDecoder.decode(request.getParameter("slhurl"));
}
  
  
%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>善行创投</title>
<meta name="description" content="善行创投" />
<meta name="keywords" content="善行创投" />
<meta name="author" content="shanLin" />
<meta name="copyright" content="ShanXing all Right Reserved" />
<link rel="shortcut icon" href="favicon.ico"/>
<link href="<%=controller.getStaticPath(request)%>/css/style.css" rel="stylesheet" type="text/css" media="screen">
<link href="<%=controller.getStaticPath(request)%>/css/login.css" rel="stylesheet" type="text/css" media="screen">
<!--[if lt IE 9]>
  <link href="<%=controller.getStaticPath(request)%>/css/ie8.css" rel="stylesheet">
<![endif]-->

<script src="<%=controller.getStaticPath(request)%>/js/jquery-1.11.0.min.js" type="text/javascript" ></script>
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/public.js"></script>
<script type="text/javascript">
        $(document).ready(function () {
			//$(".Sx_bg").fullscreenBackground();
			$(".sx_err_btn").click(function(){
				$(".sx_popup").css("display","none");
			    $(".sx_overlay").css("display","none");
			})
        });
	$(function(){
	document.onkeydown = function(e){ 
	    var ev = document.all ? window.event : e;
	    if(ev.keyCode==13) {
	    	return onSubmit();
	     }
	}
	});  
    </script>
</head>

<body>


<form action="<%=controller.getURI(request, Loginclub.class)%>" method="post" onsubmit="return onSubmit();">	
<input type="hidden" name="slhurl" id ="slhurl" value="<%=slhurl%>"/>
			<div class="sx_reg_box">
				<div id="logon" >
					<ul>
						<li>	
							<input type="hidden" name="_z" value="<%StringHelper.filterHTML(out, request.getParameter("_z"));%>" />
								<%
									String _accountName = request.getParameter("accountName");
									Cookie[] _cookies = request.getCookies();
									if (_cookies != null) {
										for (Cookie cookie : _cookies) {
											if (cookie == null) {continue;}
											if ("ACCOUNT_NAME".equals(cookie.getName())) {_accountName = URLDecoder.decode(cookie.getValue(),resourceProvider.getCharset());
											}
										}
									}
									%>
							<input type="text" id="accountName" name="accountName"  maxlength="18"  onblur="nameCheck()" class="sx_input" value="<%StringHelper.filterHTML(out, _accountName);%>" />
							<div class="f14 sx_showTip" id="loginNameError"><span></span><p></p></div>
						</li>
						<li>
			   <input type="hidden" name="_a" value="no"/>
                     	   <input type="text" name="showPwd" id="showPwd" value="密码" class="sx_input" >
                     	   <input  name="password" type="password" class="sx_input" onblur="passwordCheck()" maxlength="20"  value="密码" style="display: none;"/>
                      	   <div class="f14 sx_showTip" id="password-tip"><span></span><p></p></div>
                        </li>
                         <li>
                         <input type="text" name="verifyCode" onblur="verifyCodeCheck()" maxlength="6" value="验证码" class="sx_input2">
                         <div class="sx_cof_img"><input class="sx_input3" onclick="$('#_verifyImg').attr('src','<%=controller.getURI(request, LoginVerify.class)%>')"></input>
                         <img  id="_verifyImg" src="<%=controller.getURI(request, LoginVerify.class)%>" onclick="this.src='<%=controller.getURI(request, LoginVerify.class)%>?'+Math.random()"  style="cursor: pointer;" id="verify-img" />   
                      	 </div>
                      	  <div class="f14 sx_showTip" id="verifyCodeSuccess"><span></span><p></p></div>
                        </li>
                         <li id="ac_li" style="display: none;"><input  name="activityCode" id="activityCode" type="text" class="sx_input2" maxlength="10"  placeholder="内测码" value="<%StringHelper.filterQuoter(out, request.getParameter("activityCode"));%>"/></li>
                         <li id="ac_li_t" style="display: none;" class="sx_ch sx_pt">活动内测期间内部员工专用</li>
                        <li class="sx_pt"><input type="submit" value="登&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;录" class="sx_pinkBt"/></li>
                        <li class="sx_login_liend"><span class="sx_fl"> <input name="remember" type="checkbox" value="1" class="mr10" <%=StringHelper.isEmpty(_accountName) ? "": "checked=\"checked\""%> />&nbsp;记住我</span><span class="sx_fr"><a target="_blank" href="<%configureProvider.format(out, URLVariable.GET_PASSWORD);%>">忘记密码?</a></span></li>
					</ul>
				</div>
				
				<div id="register" class="hide" >
                   
				</div>
		</form>
</div>


<script type="text/javascript">
var ac_url="http://192.168.3.123:8080/isLogin.htm";
	var isNull = /^[\s]{0,}$/;
	var loginName = /^[a-z]([\w]*)$/i;
	var nameInput= $(":input[name='accountName']:visible");
	var pwdInput=$(":input[name='password']");
	var sPwdInput=$(":input[name='showPwd']");
	var codeInput= $(":input[name='verifyCode']");
	var activityCode=$(":input[name='activityCode']");
	activityCode.click(function(){
		if(this.value=="内测码"){
			this.value='';
			 $(this).css({color:"#333"});
		}
	}).blur(function(){
		if(!this.value){
			this.value = '内测码';
			 $(this).css({color:"#aaa"});
			};
	});
	if(nameInput.val()==""){
	nameInput.val("用户名/手机号码/邮箱");
    }
	sPwdInput.focus(function(){
		if(this.value=="密码"){
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
	if($(this).val()=="用户名/手机号码/邮箱"){
		$(this).val("");
	    $(this).css({color:"#333"});
	}
}).blur(function(){
	if($(this).val()==""){
		$(this).val("用户名/手机号码/邮箱");
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
	function nameCheck() {
		var ipt = $("input[name='accountName']");
		var val = ipt.val();
		var p = ipt.parent().find("p");
		p.text("");
		if (isNull.test(val)) {
			p.html("用户名不能为空");
			$("#loginNameError").show();
			return false;
		}
		$("#loginNameError").hide();
		code();
		return true;
	}
	function passwordCheck() {
		var ipt = $("input[name='password']");
		var val = ipt.val();
		var p = ipt.parent().find("p");
		p.text("");
		if (isNull.test(val) || val=="密码") {
			$("#password-tip").show();
			p.text("请输入您的密码");
			return false;
		}
		$("#password-tip").hide();
		return true;
	}
	function verifyCodeCheck() {
		var ipt = $("input[name='verifyCode']");
		var val = ipt.val();
		var p = ipt.parent().find("p");
		p.text("请填写图片中的字符，不区分大小写");
		if (isNull.test(val)) {
			$("#verifyCodeSuccess").show();
			p.text("验证码不能为空");
			return false;
		} else if (!/^[0-9]{6}$/.test(val)) {
			$("#verifyCodeSuccess").show();
			p.text("您输入的验证码有误");
			return false;
		}
		p.text("");
		$("#verifyCodeSuccess").hide();
		return true;
	}
	

	function onSubmit(){
		return nameCheck() && passwordCheck() && verifyCodeCheck();
	}
	</script>
<%{String errorMessage = controller.getPrompt(request,response,PromptLevel.ERROR);if (!StringHelper.isEmpty(errorMessage)) {%>
<div class="sx_overlay" style="display: block;"></div>
<div class="sx_popup" style="display: block;">
   <div class="sx_err_title"><p>错误</p></div>
   <P class="sx_err_tip"><%StringHelper.filterHTML(out, errorMessage);%></P>
   <p><a href="#" class="sx_err_btn">确定</a></p>
</div>
<%}}%>
</body>
</html>
