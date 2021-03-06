<%@page import="com.dimeng.p2p.S62.entities.T6231"%>
<%@page import="com.dimeng.p2p.modules.bid.user.service.entity.Bdxq"%>
<%@page import="com.dimeng.p2p.modules.bid.user.service.BidManage"%>
<%@page import="com.dimeng.p2p.modules.bid.user.service.entity.InSellFinacing"%>
<%@page import="com.dimeng.p2p.user.servlets.bid.Sbtz"%>
<%@page import="com.dimeng.p2p.user.servlets.Index"%>
<%@include file="/WEB-INF/include/authenticatedSession.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>债权转让-<%configureProvider.format(out,SystemVariable.SITE_NAME); %></title>
<%@include file="/WEB-INF/include/meta.jsp" %>
<%@include file="/WEB-INF/include/style.jsp" %>
</head>
<%
	CURRENT_CATEGORY = "LCGL";
	CURRENT_SUB_CATEGORY = "ZQZR";
%>
<body>
<%@include file="/WEB-INF/include/header.jsp" %>
<div class="contain clearfix">
<div class="user_top"></div>
   <div class="about">
     <%@include file="/WEB-INF/include/menu.jsp"%>
	<%@include file="/WEB-INF/include/zqzr/header.jsp"%>
	<div class="container fr">
          <div class="mainDiv bor1">
          <!--理财管理 S-->
	  <div class="tb-state">
	  债权状态： <a class="butStyle no" avalue="huikuan" href="/user/financing/zqzr/zqzrz.html">转让中</a>
		     <a class="butStyle no" avalue="toubiaozhong" href="/user/financing/zqzr/zqkzc.html">可转出</a>
		     <a class="butStyle no" avalue="yiwancheng" href="/user/financing/zqzr/zqyzc.html">已转出</a>
		     <a class="butStyle " avalue="toubiaoshibai">已转入</a>
	  </div>
    </div>
</div> 
     <div class="w780 fr">       
     <form action="<%=controller.getViewURI(request, Zqyzr.class)%>"method="post">
      <div id="funds" class="mainDiv min400">
			<p class="title1"><b>我的转让</b></p>
				<div class="tb-list">
					
					<table class="tableOdd">
					  <tbody>
					  <tr>
						<th width="20%">投资项目</th>
						<th width="15%">年利率</th>
                        <th width="15%">借款期限</th>
                        <th width="15%">转入价格</th>
						<th width="20%">转入时间</th>
						<th width="15%">转入盈亏</th>
					  </tr>
					   <%
                       BidManage bidManage = serviceSession.getService(BidManage.class);
                       PagingResult<InSellFinacing> isfList= service.getInSellFinacing(paging);	
                       int i=1;
                       if(isfList != null && isfList.getItemCount() >0){
				     		for(InSellFinacing isf :isfList.getItems()){
				     			if(isf == null){
				     				continue;
				     			}
                      		     			Bdxq bdxq =bidManage.get(isf.jkbId); 	
                      		     			T6231 t6231 =bidManage.getExtra(isf.jkbId);
                      %>
                      <tr>
						<td><a target="_blank" class="blue" href="<%configureProvider.format(out, URLVariable.FINANCING_SBTZ_XQ); %><%=isf.jkbId + rewriter.getViewSuffix()%>"><%=bdxq.F03 %></a></td>
						<td><%=Formater.formatRate(bdxq.F06) %></td>
                        <td><%=bdxq.F09>0?bdxq.F09+"个月":t6231.F22+"天" %></td>
                        <td>￥<%=Formater.formatAmount(isf.F05) %></td>
						<td><%=Formater.formatDate(isf.F07)%></td>
						<td>￥<%=Formater.formatAmount(isf.F08) %></td>
					  </tr>
					  <%}}%>
					</tbody>
					</table>
				</div>
				<div class="page">
						<%AbstractFinancingServlet.rendPagingResult(out, isfList); %>
				</div>
		</div>   
		</form>         
       	 </div><div class="clear"></div>
   </div>
</div>
<%@include file="/WEB-INF/include/footer.jsp" %>
<%@include file="/WEB-INF/include/script.jsp" %>
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/zqzr.js"></script>

</body>
</html>