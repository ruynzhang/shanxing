<%@page import="com.dimeng.p2p.front.servlets.xszy.Help"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<%@page import="com.dimeng.p2p.front.servlets.Index"%>
<%@page import="com.dimeng.p2p.common.enums.TermType"%>
<%@page import="com.dimeng.p2p.front.servlets.Term"%>
<%@page import="com.dimeng.p2p.front.servlets.Register"%>
<%@page import="com.dimeng.p2p.common.enums.UserType"%>
<%@page import="com.dimeng.p2p.common.enums.UserAccountStatus"%>
<%@page import="com.dimeng.p2p.front.servlets.RegisterVerify"%>
<%@page import="com.dimeng.p2p.front.servlets.CheckNameExists" %>
<%@page import="com.dimeng.p2p.front.servlets.GetPhoneVerifyCode" %>
<%@page import="com.dimeng.p2p.front.servlets.CheckPhoneExists"%>
<%if(dimengSession!=null&&dimengSession.isAuthenticated()){controller.sendRedirect(request, response,configureProvider.format(URLVariable.USER_INDEX));return;} %>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>善行创投</title>
<meta name="description" content="善行创投" />
<meta name="keywords" content="善行创投" />
<meta name="author" content="shanLin" />
<meta name="copyright" content="ShanXing all Right Reserved" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/>
<link rel="shortcut icon" href="favicon.ico"/>
<link href="<%=controller.getStaticPath(request)%>/css/style.css" rel="stylesheet" type="text/css" media="screen">
<link href="<%=controller.getStaticPath(request)%>/css/login.css" rel="stylesheet" type="text/css" media="screen">
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE8"/>
<script src="<%=controller.getStaticPath(request)%>/js/jquery-1.11.0.min.js" type="text/javascript" ></script>


<script type="text/javascript">
$(document).ready(function () {
	//$(".Sx_bg").fullscreenBackground();
	$(".sx_err_btn").click(function(){
		$(".sx_popup").css("display","none");
	    $(".sx_overlay").css("display","none");
	})
});
</script>

<% 
String partId = request.getParameter("partId");

%>
</head>

<body>
<%@include file="/WEB-INF/include/header3.jsp"%>
	<%
		String loginNameExists = ObjectHelper.convert(request.getAttribute("loginNameExists"), String.class);
		String mobileExists = ObjectHelper.convert(request.getAttribute("mobileExists"), String.class);
		String mobile = request.getParameter("mobile");
		String type=request.getParameter("type");
		if(StringHelper.isEmpty(type)){type=UserType.LC.name();}
	%>
<div class="sx_normal_box sx_user_outline">
    <div class="sx_user_t1"><span>帐户注册</span></div>
    <div class="sx_user_step">
        <ul class="sx_user_reg1">
          <li class="r_1"><i>1</i>填写帐户信息</li>
          <li class="r_2"><i>2</i>验证帐户信息</li>
          <li class="r_3"><i>3</i>注册成功</li>
        </ul>
        <div class="clear"></div>
    </div>
    <div class="sx_user_active"></div>
<form action="<%=configureProvider.format(URLVariable.REGISTER_SUBMIT) %>" method="post" onsubmit="return onSubmit()">	
			<div class="sx_reg_box">
				<div id="register">
					<ul>
						<li>
						<%if (!StringHelper.isEmpty(loginNameExists)) {%>
						<input type="text" id="accountName" name="accountName" value="<%StringHelper.filterQuoter(out, request.getParameter("accountName"));%>" maxlength="18"  onblur="nameCheck()" class="sx_input">
						<div class="f14 sx_showTip" id="loginNameError"><span></span><p><%StringHelper.filterHTML(out, loginNameExists);%></p></div>
						<%} else {%>
						<input type="text" id="accountName" name="accountName" value="<%StringHelper.filterQuoter(out, request.getParameter("accountName"));%>" maxlength="18"  onblur="nameCheck()" class="sx_input">
						<div class="f14 sx_showTip" id="loginNameError"><span></span><p></p></div>
						<%}%>
						</li>
						<li>
                         <input name="showPwd" id="showPwd" type="text" class="sx_input" value="密码" maxlength="20"/>
                         <input  name="password" type="password" class="sx_input" onblur="passwordCheck()" maxlength="20" value="<%StringHelper.filterQuoter(out, request.getParameter("password"));%>" style="display: none;"/>
                        <div class="f14 sx_showTip" id="password-tip"><span></span><p>6~20个字符，区分大小写</p></div>
                        </li>
                        <li>
                        <input name="showNewPwd" id="showNewPwd" type="text" class="sx_input" value="再次输入密码" maxlength="20"/>
                        <input name="newPassword" type="password" maxlength="20" class="sx_input" onblur="rePasswordCheck()" value="<%StringHelper.filterQuoter(out, request.getParameter("newPassword"));%>" style="display: none;"/> 
                        <div class="f14 sx_showTip" id="newPasswordSuccess"><span></span><p></p></div>
                        </li>
                        <li class="sx_pt"><input name="code" type="text" class="sx_input" value="<%StringHelper.filterQuoter(out, request.getParameter("code"));%>"  maxlength="11" onblur="codeCheck()"/>
                       <div class="f14 sx_showTip" id="inviteTip"><span></span><p></p></div>
                        </li>
                        <li class="sx_ch sx_pt">有则填写&nbsp;&nbsp;<div class="sx_tip_box"><a href="javascript:void();" class="sx_blueBt">什么是邀请码？</a><div class="sx_tip_info" style="top:-54px; right:-158px; width:400px;">注册时输入好友发送的邀请码，注册成功即可获得平台赠送的奖励，<br />同时可享有后续的交易优惠。<span></span></div></div></li>
                        <li>
			            	<input type="text" name="mobilephone" value="<%StringHelper.filterQuoter(out, request.getParameter("mobilephone"));%>" maxlength="11" onblur="mobilephoneCheck()" class="sx_input"/>
							<div class="f14 sx_showTip" id="phoneSuccess"><span></span><p></p></div>
			            </li>
                        <li><input type="text" name="verifyCode" type="text" onblur="verifyCodeCheck()" maxlength="6" class="sx_input2" value="<%StringHelper.filterQuoter(out, request.getParameter("verifyCode"));%>">
                       <div class="sx_cof_img">
                       <button class="sx_input3" onclick="anotherImg('<%=controller.getURI(request, RegisterVerify.class)%>?'+Math.random())"></button>
                       <img src="<%=controller.getURI(request, RegisterVerify.class)%>" onclick='this.src="<%=controller.getURI(request, RegisterVerify.class)%>?"+Math.random()' style="cursor: pointer;" id="verify-img" />   
                       </div>
                        <div class="f14 sx_showTip" id="verifyCodeSuccess"><span></span><p></p></div>
                        </li>
                        <input type="hidden" name="partId" value="<%StringHelper.filterQuoter(out, request.getParameter("partId")==null?partId:request.getParameter("partId"));%>"/>
                        <li><input type="submit" value="下一步" class="sx_pinkBt"/></li>
                        <li class="sx_login_liend"><p> 
            	<input name="iAgree" type="checkbox" id="iAgree" class="m_cb" checked="checked"/>
            	<span class="f14 ml5">我同意<a target="_blank" href="<%=controller.getPagingItemURI(request, Term.class, TermType.ZCXY.name())%>" class="black">《<%configureProvider.format(out, SystemVariable.SITE_NAME);%>平台协议》</a></span>
            </p></li>
                  <div class="warning_tips"> <span>您的信息通过SSL加密保护，数据传输安全</span> </div>
                     </ul> 
                   
				</div>
			</div>

  </form>
</div>

<style>
.sx_hpic img{
width:98px;
height:37px;
}
</style>
<div class="sx_copyright sx_user_copy">
   <p class="sx_hpic"><a href="http://www.itrust.org.cn/yz/pjwx.asp?wm=1094395305"  target="_blank" rel="nofollow" title="中国信用企业" class="sx_hpic_cof1"><span></span></a>
   <a href="https://cert.ebs.gov.cn/8d1ea2b3-dc1a-4127-bfb4-a627184d73ee"  target="_blank" rel="nofollow" title="深圳工商主体认证信息" class="sx_hpic_cof2"><span></span></a>
   <a href="https://search.szfw.org/cert/l/CX20141225006180006283"  target="_blank" rel="nofollow" title="诚信网站" class="sx_hpic_cof4"><span></span></a>
   <a href="https://trustsealinfo.verisign.com/splash?form_file=fdf/splash.fdf&dn=www.myshanxing.com&lang=zh_cn"  target="_blank" rel="nofollow" title="VeriSign加密服务" class="sx_hpic_cof5"><span></span></a>
   <a key ="564570e9efbfb05d87e1fa4d"  logo_size="124x47"  logo_type="realname"  href="http://www.anquan.org"><script src="https://static.anquan.org/static/outer/js/aq_auth.js"></script></a>
   </p>
   <div class="sx_copyright_right">
   <p>备案号：粤ICP备14042804号-2</p>
   <p>善行创投&nbsp;|&nbsp;来善行&nbsp;&nbsp;获收益© 2014 ShanLin All Rights Reserved </p>
   </div>
   </div>
<div class="Sx_bg" style="background:#e5493e;"></div>
<img src="<%=controller.getStaticPath(request)%>/images/login_bg.jpg" width="1920" height="1155" style="display:none;"/>
<script type="text/javascript">
	var _nURL='<%=controller.getURI(request, CheckNameExists.class)%>';
	var getVerifyCodeURL='<%=controller.getURI(request, GetPhoneVerifyCode.class)%>';
	var checkPhoneExistsURL='<%=controller.getURI(request, CheckPhoneExists.class)%>';
</script>

<div class="sx_overlay" style="display: none;"></div>
<div class="sx_popup" style="display: none;">
   <div class="sx_err_title"><p>错误</p></div>
   <P class="sx_err_tip"></P>
   <p><a href="#" class="sx_err_btn">确定</a></p>
</div>

<%{String errorMessage = controller.getPrompt(request,response,PromptLevel.ERROR);if (!StringHelper.isEmpty(errorMessage)) {%>
<div class="sx_overlay" style="display: block;"></div>
<div class="sx_popup" style="display: block;">
   <div class="sx_err_title"><p>错误</p></div>
   <P class="sx_err_tip"><%StringHelper.filterHTML(out, errorMessage);%></P>
   <p><a href="#" class="sx_err_btn">确定</a></p>
</div>
<%}}%>

<!-- 百度统计 -->
<script>
var _hmt = _hmt || [];
(function() {
  var hm = document.createElement("script");
  hm.src = "//hm.baidu.com/hm.js?6325fde2cae7259da1162ba645d09079";
  var s = document.getElementsByTagName("script")[0]; 
  s.parentNode.insertBefore(hm, s);
})();
</script>
<script>
    var checkName = true;
    var checkmobile = true;
    var wait = 180;
    var isNull = /^[\s]{0,}$/;
    var loginName = /^[a-z]([\w]{5,17})$/i;
    var codeVal=/^[A-Za-z0-9]{0,20}$/;

    var nameInput= $(":input[name='accountName']:visible");
    var pwdInput=$(":input[name='password']");
    var sPwdInput=$(":input[name='showPwd']");
    var newPwdInput=$(":input[name='newPassword']");
    var sNewPwdInput=$(":input[name='showNewPwd']");
    var tlCodeInput=$(":input[name='code']");
    var codeInput= $(":input[name='verifyCode']");
    var mobilephoneInput = $(":input[name='mobilephone']");
    var phoneVerifyCodeInput = $(":input[name='phoneVerifyCode']");

    if(nameInput.val()==""){
    nameInput.val("用户名");
    }
    if(pwdInput.val()==""){
    pwdInput.val("密码");
    }
    if(newPwdInput.val()==""){
    newPwdInput.val("再次输入密码");
    }
    if(tlCodeInput.val()==""){
    tlCodeInput.val("邀请码");
    }
    if(codeInput.val()==""){
    codeInput.val("验证码");
    }
    if(mobilephoneInput.val()==""){
    mobilephoneInput.val("手机号码");
    }
    if(phoneVerifyCodeInput.val()==""){
    phoneVerifyCodeInput.val("短信验证码");
    }


    nameInput.click(function(){
    if($(this).val()=="用户名"){
    $(this).val("");
    $(this).css({color:"#333"});
    }
    }).blur(function(){
    if($(this).val()==""){
    $(this).val("用户名");
    $(this).css({color:"#aaa"});
    };
    });
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
    sNewPwdInput.focus(function(){
    if(this.value=="再次输入密码"){
    sNewPwdInput.hide();
    newPwdInput.show().focus();
    newPwdInput.val("");
    newPwdInput.css({color:"#333"});
    }
    });
    newPwdInput.blur(function(){
    if(!this.value){
    newPwdInput.hide();
    sNewPwdInput.show();
    };
    });
    tlCodeInput.click(function(){
    if(this.value=="邀请码"){
    this.value='';
    $(this).css({color:"#333"});
    }
    }).blur(function(){
    if(!this.value){
    this.value = '邀请码';
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
    mobilephoneInput.click(function(){
    if(this.value=="手机号码"){
    this.value='';
    $(this).css({color:"#333"});
    }
    }).blur(function(){
    if(!this.value){
    this.value = '手机号码';
    $(this).css({color:"#aaa"});
    };
    });
    phoneVerifyCodeInput.click(function(){
    if(this.value=="短信验证码"){
    this.value='';
    $(this).css({color:"#333"});
    }
    }).blur(function(){
    if(!this.value){
    this.value = '短信验证码';
    $(this).css({color:"#aaa"});
    };
    });
    function onSubmit()
    {
    if (nameCheck() && passwordCheck()
    && rePasswordCheck()&&codeCheck()&& mobilephoneCheck() && verifyCodeCheck()) {
    return true;
    }
    return false;
    }
    function nameCheck() {
    var ipt = $(":input[name='accountName']");
    var val = ipt.val();
    var p = ipt.parent().find("p");
    if (isNull.test(val)) {
    //	ipt.val("用户名");
    p.text("用户名不能为空");
    $("#loginNameError").show();
    return false;
    } else if (!loginName.test(val)) {
    p.text("6-18个字符，可使用字母、数字、下划线，需以字母开头");
    $("#loginNameError").show();
    return false;
    }
    $.post(_nURL, {
    accountName : val
    }, function(data) {
    if (jQuery.trim(data) == 'true') {
    $("#loginNameError").show();
    p.text("该用户名已存在，请输入其他用户名");
    checkName = false;
    return false;
    }
    });
    $("#loginNameError").hide();
    checkName = true;
    return true;
    }

    function nameFocus(_nvl)
    {
    var ipt = $(":input[name='accountName']");
    var val = ipt.val();
    //if (isNull.test(ipt.val())) {
    //	ipt.val("用户名");
    //}else{
    if(val =='用户名' || val == _nvl){
    ipt.val("");
    }
    //}
    }

    function pwdFocus(_nvl)
    {
    var ipt = $(":input[name='password']");
    var val = ipt.val();
    if(ipt.val() =='密码' || val == _nvl){
    ipt.val("");
    }
    }

    function passwordCheck() {
    var ipt = $(":input[name='password']");
    var val = ipt.val();
    var p = ipt.parent().find("p");//ipt.parent().find("span");
    p.text("");
    p.text("6~20个字符，区分大小写");
    if (isNull.test(val)) {
    $("#password-tip").show();
    p.text("密码不能为空");
    return false;
    } else if (val.length < 6 || val.length > 20) {
    $("#password-tip").show();
    p.text("密码不能小于6位，大于20位");
    return false;
    }
    $("#password-tip").hide();
    return true;
    }
    function rePasswordCheck() {
    var ipt = $(":input[name='password']");
    var _ipt = $(":input[name='newPassword']");
    var val = _ipt.val();
    var newPasswordSuccess = $("#newPasswordSuccess");
    var p = _ipt.parent().find("p");
    p.text("请再次输入密码");
    if (isNull.test(ipt.val())) {
    $("#newPasswordSuccess").show();
    p.text("请先输入密码");
    return false;
    } else if (isNull.test(val)) {
    $("#newPasswordSuccess").show();
    p.text("确认密码不能为空");
    return false;
    } else if (val != ipt.val()) {
    $("#newPasswordSuccess").show();
    p.text("您两次输入的密码不一致");
    return false;
    }
    p.text("");
    $("#newPasswordSuccess").hide();
    return true;
    }

    function verifyCodeCheck() {
    var ipt = $(":input[name='verifyCode']");
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

    function codeCheck() {
    var ipt = $(":input[name='code']");
    var val = ipt.val();
    var codeSuccess = $("#codeSuccess");
    var p = ipt.parent().find("p");
    p.text("");
    if(val=="邀请码"){
    ipt.val("");
    return true;
    }
    if (!codeVal.test(val)) {
    $("#inviteTip").show();
    p.text("您输入的邀请码格式不正确");
    return false;
    }
    if(val!='')
    {
    $("#inviteTip").hide();
    }
    return true;
    }
    function anotherImg(contextPath) {
    $("#verify-img").attr("src", contextPath);
    }

    function showAuto() {
    var checked = $("#type2").attr("checked");
    if (checked) {
    $("#autoPayDiv").show();
    } else {
    $("#autoPayDiv").hide();
    }
    }

    /** 手机号码校验*/
    function mobilephoneCheck(){
    var ipt = $(":input[name='mobilephone']");
    var phoneVal = ipt.val();
    var phoneSuccess = $("#phoneSuccess");
    var sendBtn = $(":input[name='sendPhoneVerifyCode']");
    var p = ipt.parent().find("p");
    if (isNull.test(phoneVal)) {
    phoneSuccess.show();
    //		sendBtn.hide();
    p.text("手机号码不能为空");
    checkmobile = false;
    return false;
    } else if (!/^(13|15|18|14|17)[0-9]{9}$/.test(phoneVal)) {
    phoneSuccess.show();
    //		sendBtn.hide();
    p.text("您输入的手机号码有误");
    checkmobile = false;
    return false;
    }
    $.post(checkPhoneExistsURL, {
    mobilephone : phoneVal
    }, function(data) {
    if (jQuery.trim(data) == 'true') {
    phoneSuccess.show();
    //			sendBtn.hide();
    p.text("该手机号码已存在，请输入其他手机号码");
    checkmobile = false;
    return false;
    }
    });
    phoneSuccess.hide();
    //	sendBtn.show();
    checkmobile = true;
    return true;
    }

    /** 获取手机验证码*/
    function getVerifyCode(evn){
    var ipt = $(":input[name='mobilephone']");
    var phoneVal = ipt.val();
    //var p = ipt.parent().find("p");
    //var phoneSuccess = $("#phoneSuccess");
    if (isNull.test(phoneVal)) {
    //phoneSuccess.show();
    //p.text("手机号码不能为空");
    return false;
    } else if (!/^(13|15|18|14|17)[0-9]{9}$/.test(phoneVal)) {
    //phoneSuccess.show();
    //p.text("您输入的手机号码有误");
    return false;
    }
    $.ajax({
    type:"post",
    dataType:"json",
    url:getVerifyCodeURL,
    data:{"mobilephone":phoneVal},
    success:function (data){
    if(data){
    $(".sx_overlay").show();
    $(".sx_popup .sx_err_tip").html(data.msg);
    $(".sx_popup").css("display","block");
    }
    },
    });
    sendclick(evn);
    phoneSuccess.hide();
    }
    /** 手机验证码校验*/
    function phoneVerifyCodeCheck() {
    var ipt = $(":input[name='phoneVerifyCode']");
    var val = ipt.val();
    var phoneVerifyCodeSuccess = $("#phoneVerifyCodeSuccess");
    var p = ipt.parent().find("p");
    p.text("请填写短信验证码");
    if (isNull.test(val)) {
    phoneVerifyCodeSuccess.show();
    p.text("短信验证码不能为空");
    return false;
    } else if (!/^[0-9]{6}$/.test(val)) {
    phoneVerifyCodeSuccess.show();
    p.text("您输入的验证码有误");
    return false;
    }
    phoneVerifyCodeSuccess.hide();
    return true;
    }

    function sendclick(evn){
    var $evn = $(evn);
    if (wait == 0) {
    evn.removeAttribute("disabled");
    $evn.removeClass("sx_grey");
    evn.value="获取验证码";
    wait = 180;
    } else {
    if(!$evn.hasClass("sx_grey")){
    $evn.addClass("sx_grey");
    }
    evn.setAttribute("disabled", true);
    evn.value="(" + wait + ")秒重新获取";
    wait--;
    setTimeout(function() {
    sendclick(evn);
    },
    1000);
    }
    }

    </script>
 </body>
</html>
