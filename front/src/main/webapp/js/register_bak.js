var checkName = true;
var checkmobile = true;
$(function() {
	showAuto();
	$("input:checkbox[name='iAgree']").click(function() {
		var iAgree = $(this).attr("checked");
		var register = $("#sub-btn");
		if (iAgree) {
			register.addClass("btn01");
			register.removeClass("btn02");
		} else {
			register.removeClass("btn01");
			register.addClass("btn btn02");
		}
	});
});
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
if(tlCodeInput.val()==""){
	tlCodeInput.val("邀请码");
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

function onSubmit()
{
	var iAgree = $("input:checkbox[name='iAgree']").attr("checked");
	if (checkName && checkmobile && iAgree == "checked"
		&& nameCheck() && passwordCheck()
		&& rePasswordCheck()&& verifyCodeCheck()&&codeCheck()) {
		return true;
	}
	return false;
}

function nameCheck() {
	var ipt = $("input[name='accountName']");
	var val = ipt.val();
	var p = ipt.parent().find("p");
	//var loginSuccess = $("#loginSuccess");
	//loginSuccess.removeClass("success_tip");
	p.text("");
	p.text("6-18个字符，可使用字母、数字、下划线，需以字母开头");
	if (isNull.test(val)) {
	//	ipt.val("用户名");
        $("#loginNameError").show();
		p.text("用户名不能为空");
		return false;
	} else if (!loginName.test(val)) {
		$("#loginNameError").hide();
		return false;
	}
	$.post(_nURL, {
		accountName : val
	}, function(data) {
		if (jQuery.trim(data) == 'true') {
			//loginSuccess.removeClass("success_tip");
			$("#loginNameError").show();
			p.text("该用户名已存在，请输入其他用户名");
			checkName = false;
			return false;
		}
	});
	//loginSuccess.addClass("success_tip");
	$("#loginNameError").hide();
	checkName = true;
	return true;
}

function nameFocus(_nvl)
{
	var ipt = $("input[name='accountName']");
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
	var ipt = $("input[name='password']");
	var val = ipt.val();
		if(ipt.val() =='密码' || val == _nvl){
			ipt.val("");
		}
}

function passwordCheck() {
	var ipt = $("input[name='password']");
	var val = ipt.val();
	var p = ipt.parent().find("p");//ipt.parent().find("span");
	//var passwordSuccess = $("#passwordSuccess");
	//passwordSuccess.removeClass("red");
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
	} else if (/\d+/.test(val) && /[A-Za-z]+/.test(val) && /\W+/.test(val)) {
		pstrong.find("span span.strong").addClass("on");
	} else if (/[a-zA-Z]+/.test(val) && /[0-9]+/.test(val)) {
		pstrong.find("span span.medium").addClass("on");
	} else if (/[a-zA-Z]+/.test(val) && /[\W_]/.test(val)) {
		pstrong.find("span span.medium").addClass("on");
	} else if (/[0-9]+/.test(val) && /[\W_]/.test(val)) {
		pstrong.find("span span.medium").addClass("on");
	} else {
		pstrong.find("span span.weak").addClass("on");
	}
	//passwordSuccess.addClass("success_tip");
	$("#password-tip").hide();
	return true;
}
function rePasswordCheck() {
	var ipt = $("input[name='password']");
	var _ipt = $("input[name='newPassword']");
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
	var ipt = $("input[name='verifyCode']");
	var val = ipt.val();
	var verifyCodeSuccess = $("#verifyCodeSuccess");
	verifyCodeSuccess.removeClass("success_tip");
	var p = ipt.parent().find("span");
	p.removeClass();
	p.addClass("gray9");
	p.text("请填写图片中的字符，不区分大小写");
	if (isNull.test(val)) {
		p.addClass("red");
		p.removeClass("gray9");
		p.text("验证码不能为空");
		return false;
	} else if (!/^[0-9]{6}$/.test(val)) {
		p.addClass("red");
		p.removeClass("gray9");
		p.text("您输入的验证码有误");
		return false;
	}
	p.text("");
	verifyCodeSuccess.addClass("success_tip");
	return true;
}
function codeCheck() {
	var ipt = $("input[name='code']");
	var val = ipt.val();
	var codeSuccess = $("#codeSuccess");
	codeSuccess.removeClass("success_tip");
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