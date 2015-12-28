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