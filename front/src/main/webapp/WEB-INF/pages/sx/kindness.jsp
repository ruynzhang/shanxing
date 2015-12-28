<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.front.servlets.Region"%>
<%@page import="com.dimeng.p2p.S62.entities.T6211"%>
<%@page import="com.dimeng.p2p.modules.bid.front.service.BidWillManage"%>
<%@page import="com.dimeng.p2p.common.enums.IntentionType"%>
<%@page import="com.dimeng.p2p.front.servlets.credit.Dkyx"%>
<%@ taglib uri="http://www.opensymphony.com/oscache" prefix="oscache" %>
<%-- <%@include file="/WEB-INF/include/authenticatedSession.jsp" %> --%>
<html>
<head>
<title><%=configureProvider.getProperty(SystemVariable.SITE_TITLE)%></title>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
<link rel="stylesheet" type="text/css" href="<%=controller.getStaticPath(request)%>/css/inside.css" />
</head>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
<oscache:cache key="sl-p2p-front-kindness" time="21600" scope="application">
<div class="kn_banner">
   <div class="banner"><img src="/images/sx_kindness.jpg" alt="" height="200" /></div>
</div>

<div class="sx_knBox">
   <p>善行创投一直把社会公益作为自己的发展的一部分，为社会上需要帮助的弱势群体伸出援助之手，向社会传递正能量。善林创投坚持“慈善与公益同行”，在不断追求更高发展的同时，将更热心于公益事业，为慈善与公益事业不遗余力，矢志投入更多。所以，在善行创投平台上线之初，我们的善行公益计划也随之启动，我们郑重承诺：每在善行创投平台上成交一笔，我们将以投资人的名义向贫困山区的孩子捐赠一元钱。我们已经完成了第一期的援建重庆市新场小学图书室的公益活动，接下来我们会继续我们的公益事业，也希望大家来加入我们，一起为山区的孩子奉献一份爱心，更多详情请关注善行创投。</p>
   <h1>善行第一期</h1>
   <ul class="kn_piclist">
     <li><img src="/images/sx_kindness01.jpg" alt="" /><div>图书室捐赠现场揭幕仪式</div></li>
     <li class="kn_right"><img src="/images/sx_kindness02.jpg" alt="" /><div>孩子们正在新图书室里阅读</div></li>
     <li><img src="/images/sx_kindness03.jpg" alt="" /><div>善林总裁李志浩先生与孩子们亲切的交谈</div></li>
     <li class="kn_right"><img src="/images/sx_kindness04.jpg" alt="" /><div>孩子们向善林总裁李志浩先生请教问题</div></li>
   </ul>
   <div class="clear"></div>
   <p>2014年10月30日,由深圳市前海善林资产管理有限公司援建的重庆市彭水县新场小学图书室顺利启用！在校长李胜伦和副校长王小军的领导下，家长代表及全校师生组织了新图书室揭牌仪式，善林资产总裁李志浩先生受邀参加本次仪式，同时，彭水县教育基金委员会秘书长李军先生、新场乡人民政府人大主席李永成先生及办公室秘书作为特邀嘉宾亦出席本次仪式，共同见证新场小学“善林图书室”的正式启用。彭水电视台等数家当地权威媒体全程跟踪报道本次活动。</p><br />
   <p>在仪式上，李志浩总裁和李军秘书长分别发表了讲话，表达了对孩子们的关心与期许，与会的政府领导也对善林资产的捐赠举动给予了充分的肯定和认同。</p><br />
   <p>此次的图书室捐赠行动，是善林资产在发展道路上开展的众多公益行动中的一件，长期以来，善林资产在为社会提供金融服务的同时，也在大力发展和支持公益事业，并为此专门成立了自己的公益组织——善行者公会，以实际行动投身到公益慈善事业中，兑现善林资产“创造财富，造福社会”的企业理念。</p><br />
   <div class="sx_kncare"><span>敬请关注:</span>善行创投后期会持续更新我们的公益活动，期待您的加入！</div>
</div>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
</oscache:cache>
</body>
</html>