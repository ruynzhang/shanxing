<%@page import="com.dimeng.util.ObjectHelper"%>
<!doctype html>
<html>
   <%
    	Session session = serviceSession.getSession();
    	int userId=session.getAccountId();
    	com.dimeng.p2p.service.UserManage commuserManage = serviceSession.getService(com.dimeng.p2p.service.UserManage.class);
    	boolean flag=commuserManage.isPassPhone(userId);
    	if(flag){
    		controller.sendRedirect(request, response, "/user/index.html");
    		return;
    	}
    	String phone=commuserManage.getT6118_phone(userId);
    	session.setAttribute("register_step1_mobilephone", phone);
    %>
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
<script type="text/javascript">
$(document).ready(function () {
	//$(".Sx_bg").fullscreenBackground();
	$(".sx_err_btn").click(function(){
		$(".sx_popup").css("display","none");
	    $(".sx_overlay").css("display","none");
	})
});
</script>
</head>

<body>
<%@include file="/WEB-INF/include/header3.jsp"%> 
<div class="sx_normal_box sx_user_outline">
    <div class="sx_user_t1"><span>帐户注册</span></div>
    <div class="sx_user_step">
        <ul class="sx_user_reg2">
		  <li class="r_1"><i>1</i>填写帐户信息</li>
          <li class="r_2"><i>2</i>验证帐户信息</li>
          <li class="r_3"><i>3</i>注册成功</li>
        </ul>
        <div class="clear"></div>
    </div>
			<div class="sx_reg_box">
				<div id="register">
					<ul>
                        <li>您的手机号码是:&nbsp;<b><%=phone%></b>&nbsp;&nbsp;&nbsp;&nbsp;点击获取验证码</li>
			            <li>
			                <input name="sendPhoneVerifyCode" id="getVerifyCodeA" type="button" value="获取验证码" onclick="getVerifyCode(this)" class="sx_input4"/> 
                            <input type="text" id="code" name="verifyCode" maxlength="6" style="width:142px;" class="sx_input"/> 
			                
							<div class="f14 sx_showTip" id="phoneVerifyCodeSuccess"><span></span><p></p></div>
			            </li>
                        <li><input type="button" onclick="onSubmit();" value="立即认证" class="sx_pinkBt"/></li>
                        <li class="sx_login_liend"><p> 
            </p></li>
                     </ul>
                   
				</div>
			</div>
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
var wait=180;
function verifyCodeCheck() {
	var val = $(":input[name='verifyCode']").val();
	if (isNull.test(val)) {
		alert("验证码不能为空");
		return false;
	} else if (!/^[0-9]{6}$/.test(val)) {
		alert("您输入的验证码有误");
		return false;
	}
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
		getVerifyCodeA.val("获取验证码");
		wait = 180;
	} else {
		if(!getVerifyCodeA.hasClass("sx_grey")){
			getVerifyCodeA.addClass("sx_grey");
		}
		getVerifyCodeA.attr("disabled", true);
		getVerifyCodeA.val("(" + wait + ")秒重新获取");
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
			alert(data);
			if(data.indexOf("成功")>0){
				location.href="/user/index.html";
			}
		}
	}); 
}
</script>

<!-- 百度 -->
<script>
var _hmt = _hmt || [];
(function() {
  var hm = document.createElement("script");
  hm.src = "//hm.baidu.com/hm.js?6325fde2cae7259da1162ba645d09079";
  var s = document.getElementsByTagName("script")[0]; 
  s.parentNode.insertBefore(hm, s);
})();
</script>

</body>
</html>
