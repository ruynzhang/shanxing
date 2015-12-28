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
        <ul class="sx_user_reg3">
          <li class="r_1"><i>1</i>填写帐户信息</li>
          <li class="r_2"><i>2</i>验证帐户信息</li>
          <li class="r_3"><i>3</i>注册成功</li>
        </ul>
        <div class="clear"></div>
    </div>
    <div class="sx_user_success">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="13%" align="right"><img src="<%=controller.getStaticPath(request)%>/images/right.png" alt="" /></td>
    <td width="87%"><div class="success_word"><%=request.getParameter("accountName") == null? "" : request.getParameter("accountName")%>，恭喜您注册成功！</div></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><div><a href="<%configureProvider.format(out,URLVariable.USER_INDEX);%>" class="sx_pinkBt2">进入我的帐户</a></div></td>
  </tr>
</table>
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
   <a key ="564570e9efbfb05d87e1fa4d"  logo_size="124x47"  logo_type="realname"  href="http://www.anquan.org"><script src="http://static.anquan.org/static/outer/js/aq_auth.js"></script></a>
   </p>
   <div class="sx_copyright_right">
   <p>备案号：粤ICP备14042804号-2</p>
   <p>善行创投&nbsp;|&nbsp;来善行&nbsp;&nbsp;获收益© 2014 ShanLin All Rights Reserved </p>
   </div>
   </div>
<div class="Sx_bg" style="background:#e5493e;"></div>
<img src="<%=controller.getStaticPath(request)%>/images/login_bg.jpg" width="1920" height="1155" style="display:none;"/>
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

<script>
!function(w,d,e){ 
var _orderno="<%=request.getParameter("accountName")%>";  //替换此处!;
var b=location.href,c=d.referrer,f,s,g=d.cookie,h=g.match(/(^|;)\s*ipycookie=([^;]*)/),i=g.match(/(^|;)\s*ipysession=([^;]*)/);if (w.parent!=w){f=b;b=c;c=f;};u='//stats.ipinyou.com/cvt?a='+e('Vc.vB.pBiedqM2ajjdiPBaU78Ve0')+'&c='+e(h?h[2]:'')+'&s='+e(i?i[2].match(/jump\%3D(\d+)/)[1]:'')+'&u='+e(b)+'&r='+e(c)+'&rd='+(new Date()).getTime()+'&OrderNo='+e(_orderno)+'&e=';
function _(){if(!d.body){setTimeout(_(),100);}else{s= d.createElement('script');s.src = u;d.body.insertBefore(s,d.body.firstChild);}}_();
}(window,document,encodeURIComponent);
</script>
<script type="text/javascript">
$(document).ready(function() { 
    function jump(count) { 
        window.setTimeout(function(){ 
            count--; 
            if(count > 0) { 
                $('#num').attr('innerHTML', count); 
                jump(count); 
            } else { 
                location.href="<%configureProvider.format(out,URLVariable.USER_INDEX);%>"; 
            } 
        }, 1000); 
    } 
    jump(3); 
}); 
</script>

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

</body>
</html>
