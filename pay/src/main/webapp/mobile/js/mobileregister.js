var checkName = true;
var checkmobile = true;
var isNull = /^[\s]{0,}$/;
var loginName = /^[a-z]([\w]{5,17})$/i;
function onSubmit()
{
	
	if (nameCheck() && passwordCheck()
		&& rePasswordCheck()&& mobilephoneCheck()&&phoneVerifyCodeCheck()) {
		return true;
	}
	return false;
}
function nameCheck() {
	var ipt = $(":input[name='accountName']");
	var val = ipt.val();
	if (isNull.test(val)) {
		alert("用户名不能为空");
		checkName = false;
		return false;
	} else if (!loginName.test(val)) {
		alert("6-18个字符，可使用字母、数字、下划线，需以字母开头");
		checkName = false;
		return false;
	}
	$.post(_nURL, {
		accountName : val
	}, function(data) {
		if (jQuery.trim(data) == 'true') {
			alert("该用户名已存在，请输入其他用户名");
			checkName = false;
			return false;
		}
	});
	checkName = true;
	return true;
}

function passwordCheck() {
	var ipt = $("input[name='password']");
	var val = ipt.val();
	if (isNull.test(val)) {
		alert("密码不能为空");
		return false;
	} else if (val.length < 6 || val.length > 20) {
		alert("密码长度不能超过20个字符或少于6个字符");
		return false;
	}
	return true;
}
function rePasswordCheck() {
	var ipt = $("input[name='password']");
	var _ipt = $("input[name='newPassword']");
	var val = _ipt.val();
	if (isNull.test(ipt.val())) {
		alert("请先输入密码");
		return false;
	} else if (isNull.test(val)) {
		alert("确认密码不能为空");
		return false;
	} else if (val != ipt.val()) {
		alert("您两次输入的密码不一致");
		return false;
	}
	return true;
}

/** 手机号码校验*/
function mobilephoneCheck(){
	var ipt = $(":input[name='phone']");
	var phoneVal = ipt.val();
	if (isNull.test(phoneVal)) {
		alert("手机号码不能为空");
		checkmobile = false;
		return false;
	} else if (!/^(13|15|18|14|17)[0-9]{9}$/.test(phoneVal)) {
		alert("您输入的手机号码有误");
		checkmobile = false;
		return false;
	}
//	$.post(checkPhoneExistsURL, {
//		mobilephone : phoneVal
//	}, function(data) {
//		if (jQuery.trim(data) == 'true') {
//			alert("该手机号码已存在，请输入其他手机号码");
//			checkmobile = false;
//			return false;
//		}
//	});
	checkmobile = true;
	return true;
}
/** 手机验证码校验*/
function phoneVerifyCodeCheck() {
	var ipt = $(":input[name='verifyCode']");
	var val = ipt.val();
	if (isNull.test(val)) {
		alert("短信验证码不能为空");
		return false;
	} else if (!/^[0-9]{6}$/.test(val)) {
		alert("您输入的验证码有误");
		return false;
	}
	return true;
}

var wait = 60;
//发送时间的样式
function sendclick(evn){
	var $evn = $(evn);
	if (wait == 0) {
		evn.removeAttribute("disabled");
		$evn.removeClass("sx_grey");
		evn.value="获取验证码";
		wait = 60;
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
