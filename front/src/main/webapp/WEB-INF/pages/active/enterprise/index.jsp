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
   <div class="sx_activebox2">
    <div class="sx_act_head2"></div>
    <div class="sx_act_item" style="height:184px;"><img src="/images/enterprise_02.jpg" alt="" /></div>
    <div class="sx_act_contentbox">
       <div class="sx_act_tab">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <thead>
          <tr>
            <td>标的</td>
            <td>发布日期</td>
            <td>投标情况</td>
            <td>标的详情</td>
          </tr>
          </thead>
          <tbody>
          <tr>
            <td><b>国企优质借款首期</b></td>
            <td>12月24日14:00</td>
            <td>发标遭疯抢满标仅用39秒</td>
            <td><a href="http://www.myshanxing.com/financing/sbtz/bdxq/55.html" class="redlink" target="_blank">查看详情</a></td>
          </tr>
          <tr>
            <td><b>国企优质借款第二期</b></td>
            <td>12月25日10:00</td>
            <td>20万的标的眨个眼的功夫就又满标</td>
            <td><a href="http://www.myshanxing.com/financing/sbtz/bdxq/57.html" class="redlink" target="_blank">查看详情</a></td>
          </tr>
          <tr>
            <td><b>国企优质借款第三期</b></td>
            <td>12月25日14:00</td>
            <td>优质好标频频遭秒</td>
            <td><a href="http://www.myshanxing.com/financing/sbtz/bdxq/59.html" class="redlink" target="_blank">查看详情</a></td>
          </tr>
          <tr>
            <td colspan="4">......敬请期待</td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
    <div class="sx_act_item"><img src="/images/enterprise_03.jpg" alt="" /></div><br /><br />
</div>
<div class="overlay"></div>
  <div class="sx_popup">
   <P class="sx_err_tip"></P>
   <p><a href="###" class="sx_err_btn">确定</a></p>
  </div>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
</body>
