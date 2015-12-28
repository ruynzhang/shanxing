<!DOCTYPE html>
<html lang="en">
<head>
    <title>善行创投</title>
	<%@include file="/WEB-INF/pages/mobile/meta.jsp" %>
    <%@include file="/WEB-INF/pages/mobile/style.jsp" %>
    <%@include file="/WEB-INF/pages/mobile/javascript.jsp" %>
    <%
    	Session session = serviceSession.getSession();
    	int userId=session.getAccountId();
    	com.dimeng.p2p.service.UserManage commuserManage = serviceSession.getService(com.dimeng.p2p.service.UserManage.class);
    	String phone=commuserManage.getT6118_phone(userId);
    	session.setAttribute("register_step1_mobilephone", phone);
    %>
</head>
<style>
.sx_grey {background:#949494 !important; color:#e2e2e2 !important; border:#949494 !important;}
</style>
<body>
<!---top--->
<%@include file="/WEB-INF/pages/mobile/header.jsp"%>
<!--login-->
<div class="wx_login_box">
    	<div class="sx_pinkColor" style="display: none;" id="msg"></div>
	    <div class="get_code">您的手机号码是：<b><%=phone%></b><span>点击获取验证码</span></div>

	<div class="wx_login_check_code input_box">
	<input type="text" name="phoneVerifyCode" maxlength="6" placeholder="请输入验证码" value="" onblur="phoneVerifyCodeCheck()" class="icon_mb input_text">
	<input type="hidden" name="mobilephone" value="">
	<span class="vcode mb_code get_Ver_code"><button  id="getVerifyCodeA" onclick="javascript:getVerifyCode(this);" >获取验证码</button></span>
	</div>
        <a onclick="onSubmit();" href="javascript:;;" tabindex="4" class="btn_wap wx_btn_orange"> 立即验证 </a>
</div>
<script type="text/javascript">
var isNull = /^[\s]{0,}$/;
var wait=180;
function verifyCodeCheck() {
	var val = $(":input[name='verifyCode']").val();
	if (isNull.test(val)) {
		$("#msg").html("验证码不能为空");
		$("#msg").show();
		return false;
	} else if (!/^[0-9]{6}$/.test(val)) {
		$("#msg").html("您输入的验证码有误");
		$("#msg").show();
		return false;
	}
	$("#msg").hide();
	return true;
}

/** 获取手机验证码*/
function getVerifyCode(evn){
	$.ajax({
		type:"post",
		dataType:"json",
		url:"/getPhoneVerifyCode.htm",
		data:{"mobilephone":<%=phone%>},
		success:function (data){
			if(data){
				//$(".sx_overlay").show();
			   // $(".sx_popup .sx_err_tip").html(data.msg);
			   // $(".sx_popup").css("display","block");
			}
		},
	});
	sendclick();
}

//获取验证码
function sendclick(){
	var getVerifyCodeA = $("#getVerifyCodeA");
	if (wait == 0) {
		getVerifyCodeA.removeAttr("disabled");
		getVerifyCodeA.removeClass("sx_grey");
		getVerifyCodeA.text("获取验证码");
		wait = 180;
	} else {
		if(!getVerifyCodeA.hasClass("sx_grey")){
			getVerifyCodeA.addClass("sx_grey");
		}
		getVerifyCodeA.attr("disabled", true);
		getVerifyCodeA.text("(" + wait + ")秒重新获取");
		wait--;
		setTimeout(function() {
			sendclick();
		},
		1000);
	}
}

onSubmit=function(){
	$.ajax({
		type : "POST",
		url : "/user/mobile/ajaxBindPhone.htm",
		data : {"binphpne":<%=phone%>,"bphoneCode":$("#code").val()},
		success : function(data){
			$("#msg").html(data);
			$("#msg").show();
			if(data.indexOf("成功")>0){
				location.href="/user/mobile/user.htm";
			}
		}
	}); 
}
</script>
</body>
</html>