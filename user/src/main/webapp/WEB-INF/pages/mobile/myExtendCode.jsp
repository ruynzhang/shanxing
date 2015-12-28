<!DOCTYPE html>
<%@page import="com.dimeng.p2p.account.user.service.SpreadManage"%>
<html lang="en">
<head>
    <title>善行创投</title>
    <%@include file="/WEB-INF/pages/mobile/meta.jsp" %>
    <%@include file="/WEB-INF/pages/mobile/style.jsp" %>
    <%@include file="/WEB-INF/pages/mobile/javascript.jsp" %>
    <link href="/mobile/css/mobile.css" rel="stylesheet" type="text/css" media="screen"/>
<script type="text/javascript" src="/user/js/qrcode.min.js"></script>
</head>
<body class="sx_aboutbg" style="background:#e6eef1;">
<%
if(dimengSession==null || !dimengSession.isAuthenticated()){
	controller.redirectLogin(request, response,"/user/mobile/login.html");
	return;
}
CURRENT_CATEGORY="WEALTH";
SpreadManage manage= serviceSession.getService(SpreadManage.class);
String code=manage.getMyyqNo();
String siteDomain = configureProvider.format(SystemVariable.SITE_DOMAIN);
%>
<!---top--->
<%@include file="/WEB-INF/pages/mobile/header.jsp"%>
<div id="sx_m_main">
   <div class="sx_app_biz_box">
      <h1>成功邀请好友投资，可获返利奖励！</h1>
      <h2>1、这是您的专属推广码，请您邀请的好友在注册时输入：</h2>
      <p class="sx_app_biz_ma sx_app_f18"><%=code%></p>
      <div id="qrcode" class="sx_app_biz_pic"></div><br />
      <h2>2、这是您的专用邀请链接，请通过 QQ或邮箱 发送给好友：</h2>
      <div class="sx_app_biz_textlink"><p id="content" >我在善行创投投资已获得了很高的收益，你也快来试试吧！<textarea readonly="readonly" style="width: 100%" rows="2">http://<%=siteDomain%>/pay/slaward.html?code=<%=code%></textarea></p></div> 
   </div>
</div>
<!---footer-->
<%@include file="/WEB-INF/pages/mobile/footer.jsp"%>
<!--end footer-->
<script type="text/javascript">
var linkUrl = "http://www.myshanxing.com/pay/slaward.html?code=<%=code%>";
new QRCode("qrcode", {text: linkUrl, width: 150, height: 150});
var shareData = {
  title: '善行创投',
  desc: '我在善行创投投资已获得了很高的收益，你也快来试试吧！，注册立送50元，善行创投-安全家庭理财进行中',
  link: linkUrl,
  imgUrl: 'http://www.myshanxing.com/images/shareIcon.png'
};
</script>
<%@include file="/WEB-INF/include/weixinShare.jsp" %>
</body>
</html>
