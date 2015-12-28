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
<form action="<%=configureProvider.format(URLVariable.REGISTER_STEP_2_SUBMIT) %>" method="post" onsubmit="return phoneVerifyCodeCheck()">	
			<div class="sx_reg_box">
				<div id="register">
					<ul>
					<%String mobilephone = serviceSession.getSession().getAttribute("register_step1_mobilephone"); %>
                        <li>您的手机号码是:&nbsp;<b><%=mobilephone == null ? "" : mobilephone%></b>&nbsp;&nbsp;&nbsp;&nbsp;点击获取验证码</li>
			            <li>
			            	<input type="hidden" name="mobilephone" value="<%=mobilephone == null ? "" : mobilephone%>"/>
			                <input name="sendPhoneVerifyCode" type="button" value="获取验证码" onclick="getVerifyCode(this)" class="sx_input4"/> 
                            <input type="text" name="phoneVerifyCode" maxlength="6" value="<%StringHelper.filterQuoter(out, request.getParameter("phoneVerifyCode"));%>" style="width:142px;" onblur="phoneVerifyCodeCheck()" class="sx_input"/> 
			                
							<div class="f14 sx_showTip" id="phoneVerifyCodeSuccess"><span></span><p></p></div>
			            </li>
                        <li><input type="submit" value="下一步" class="sx_pinkBt"/></li>
                        <li class="sx_login_liend"><p> 
            	<input name="iAgree" type="checkbox" id="iAgree" class="m_cb" checked="checked"/>
            	<span class="f14 ml5">我同意<a target="_blank" href="<%=controller.getPagingItemURI(request, Term.class, TermType.ZCXY.name())%>" class="black">《<%configureProvider.format(out, SystemVariable.SITE_NAME);%>平台协议》</a></span>
            </p></li>
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

<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/register.js"></script>
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
