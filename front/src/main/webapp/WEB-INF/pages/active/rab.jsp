<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.front.servlets.Region"%>
<%@page import="com.dimeng.p2p.S62.entities.T6211"%>
<%@page import="com.dimeng.p2p.modules.bid.front.service.BidWillManage"%>
<%@page import="com.dimeng.p2p.common.enums.IntentionType"%>
<%@page import="com.dimeng.p2p.front.servlets.credit.Dkyx"%>
<%@page  import="com.dimeng.p2p.account.front.service.UserManage"%>
<%@page import="com.dimeng.p2p.S61.entities.Rewarduser"%>
<%@page import="java.util.List"%>
<%-- <%@include file="/WEB-INF/include/authenticatedSession.jsp" %> --%>
<html>
<head>
<title><%=configureProvider.getProperty(SystemVariable.SITE_TITLE)%></title>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
<link rel="stylesheet" type="text/css" href="<%=controller.getStaticPath(request)%>/css/inside.css" />
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/jquery-1.11.0.min.js"></script>
</head>
<body>
	<%@include file="/WEB-INF/include/header3.jsp"%>
    <div class="sx_m_block3">
       <br />
       <h2 class="sx_orange f24">龟兔赛跑之<span class="f36">年化收益</span></h2>
       <p class="sx_font1 sx_text2">龟：1%-3 % <br />兔：8%-15%</p>
       <div><p class="sx_img"><img src="/images/m_sx1.jpg" alt="" /></p><br /></div>
       <div style="background:#acc5db;"><p class="sx_img"><img src="/images/m_sx2.jpg" alt="" /></p></div>
       <div><p class="sx_img"><img src="/images/m_sx3.jpg" alt="" /></p></div>
       <div><p class="sx_img"><img src="/images/m_sx4.jpg" alt="" /></p></div>
       <div style="background:#fff;"><p class="sx_img" style="margin-bottom:20px;"><img src="/images/m_sx5.jpg" alt="" /></p></div>
       <div><p class="sx_img"><img src="/images/m_sx6.jpg" alt="" /></p></div>
    </div>
    <div class="sx_m_block4" id="sx_reg">
        <div class="sx_m_person3"></div>
        <ul>
          <li class="sx_login_liend"><input type="button" value="注&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;册" class="sx_orangeBt" onclick="location.href='https://www.myshanxing.com/register.html'"/></li>
      </ul>
      <div class="clear"></div>
    </div>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
</body>
