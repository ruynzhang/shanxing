var wait =3;
var checkName = true;
var isNull = /^[\s]{0,}$/;
var loginName = /^[a-z]([\w]{5,17})$/i;

$(document).ready(function(){
	$("#xieyi").bind("click", function(){
		if($("#xieyi").prop("checked")==true){
			$("#regaction").removeAttr("disabled");
			$("#regaction").attr("style","background:#EF3F3F");
		}else{
			$("#regaction").attr("disabled","disabled");
			$("#regaction").attr("style","background:gray;border: gray solid 2px;"); 
		}
	});
});

//判断用户名
function nameCheck() {
	var val = $(":input[name='accountName']").val();
	if (isNull.test(val)) {
		$("#unameErr").html("用户名不能为空");
		checkName = false;
		return false;
	} else if (!loginName.test(val)) {
		//p.text("6-18个字符，可使用字母、数字、下划线，需以字母开头");
		$("#unameErr").html("6-18个字符，可使用字母、数字、下划线，需以字母开头");
		checkName = false;
		return false;
	}
	$.post(_nURL, {
		accountName : val
	}, function(data) {
		if (jQuery.trim(data) == 'true') {
			$("#unameErr").html("该用户名已存在，请输入其他用户名");
			checkName = false;
			return false;
		}
	});
	$("#unameErr").html("");
	checkName = true;
	return true;
}
//判断手机号码
var checkmobile = true;
function mobilephoneCheck(){
	var phoneVal = $(":input[name='mobilephone']").val();
	if (isNull.test(phoneVal)) {
		$("#phoneErr").html("手机号码不能为空");
		checkmobile = false;
		return false;
	} else if (!/^(13|15|18|14|17)[0-9]{9}$/.test(phoneVal)) {
		$("#phoneErr").html("您输入的手机号码有误");
		checkmobile = false;
		return false;
	}
	$.post(checkPhoneExistsURL, {
		mobilephone : phoneVal
	}, function(data) {
		if (jQuery.trim(data) == 'true') {
			$("#phoneErr").html("该手机号码已存在，请输入其他手机号码");
			checkmobile = false;
			return false;
		}
	});
	$("#phoneErr").html("");
	checkmobile = true;
	return true;
}

//判断密码
function passwordCheck() {
	var val = $(":input[name='password']").val();
	if (isNull.test(val)) {
		$("#upwdErr").html("密码不能为空");
		return false;
	} else if (val.length < 6 || val.length > 20) {
		$("#upwdErr").html("密码不能小于6位，大于20位");
		return false;
	}
	$("#upwdErr").html("");
	return true;
}

//邀请码
var codeVal=/^[A-Za-z0-9]{0,20}$/;
function codeCheck() {
	var val = $(":input[name='code']").val();
    if(val==""){
    	$("#remCodeErr").html("");
    	 return true;
    }
	if (!codeVal.test(val)) {
		$("#remCodeErr").html("您输入的邀请码格式不正确");
		return false;
	}
	$("#remCodeErr").html("");
	return true;
}

//图片验证码
function verifyCodeCheck() {
	var val = $(":input[name='verifyCode']").val();
	if (isNull.test(val)) {
		$("#codeErr").html("验证码不能为空");
		return false;
	} else if (!/^[0-9]{6}$/.test(val)) {
		$("#codeErr").html("您输入的验证码有误");
		return false;
	}
	$("#codeErr").html("");
	return true;
}

/** 获取手机验证码*/
function getVerifyCode(evn){
	var ipt = $(":input[name='mobilephone']");
	var phoneVal = ipt.val();
	
	if(phoneVal==undefined||phoneVal==""){
		phoneVal = $.trim($("#bkMobilePhone").val());
	}
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
	sendclick();
	//phoneSuccess.hide();
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

//马上注册
function doReg(){
	if (mobilephoneCheck() && passwordCheck()&&codeCheck()&& verifyCodeCheck()) {
		$.ajax({ 
    		type : "POST",
    		url : "/pay/registerAjaxTwo.htm",
    		dataType:"text",
    		data : {
    			accountName : $(":input[name='accountName']").val(),
    			mobilephone : $(":input[name='mobilephone']").val(),
    			password : $(":input[name='password']").val(),
    			code : $(":input[name='code']").val(),
    			partId : $(":input[name='partId']").val(),
    			verifyCode : $(":input[name='verifyCode']").val()
    		}, 
    		success :function(data) {
    		   data = eval("("+data+")");
 			   var num = data.num;
 			   if(num==0){
 				   alert(data.msg);
 			   }else if (num==1) {
 				   var phone_val=$(":input[name='mobilephone']").val();
				 $("#regiid").html("<p class=\"down\" style=\"text-align: left\"><b style=\"font-size: 15px;\">您的登录名为："+data.name+"</b></p>" +
						"<input type=\"hidden\" id=\"bkMobilePhone\" name=\"bkMobilePhone\"/><div class=\"code\"><div class=\"input\">" +
						"<span style=\"font-size:12px\">手机验证码</span>" +
						" <input id=\"valCode\" name=\"phoneVerifyCode\"  maxlength=\"6\" placeholder=\"输入验证码\" value=\"\" type=\"text\" class=\"tit_input\" ></div>" +
						"<button id=\"getVerifyCodeA\" onclick=\"javascript:getVerifyCode(this);\" >获取验证码</button>" +
						"</div>"+
						"<button class=\"ljzc\" style=\"cursor:pointer;\" id=\"regaction\" onclick=\"doReg2()\">立即验证</button>"+
						"<p class=\"down\">下载客户端享受指尖投资的乐趣</p>"+
						"<div class=\"download\"><a href=\"/android/myshanxing.apk\"><button class=\"apk\">安卓下载</button></a>"+
				    	"<a href=\"https://itunes.apple.com/cn/app/shan-xing-chuang-tou/id979122379\"><button class=\"app\">苹果下载</button></a></div>");
		   	    }
 			   $("#bkMobilePhone").val(phone_val);
    		}
		});
	}
}

//手机验证码输入后提交
function doReg2(){
	$.post("/pay/partRegisterStepTwo.htm",{
		phoneVerifyCode : $(":input[name='phoneVerifyCode']").val()	
	}, function(data) {
		 data = eval("("+data+")");
		   var num = data.num;
		   if(num==0){
				   alert(data.msg);
		   }else if (num==1) {
			   location.href = "/user/mobile/myWealth.htm";
		   }
	});
}