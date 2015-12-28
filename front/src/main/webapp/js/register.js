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
