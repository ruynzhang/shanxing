<%@page import="com.dimeng.p2p.modules.bid.user.service.BidManage"%>
<%@page import="com.dimeng.p2p.modules.bid.user.service.entity.Bdxq"%>
<%@page import="java.util.Date"%>
<%@page import="com.dimeng.p2p.modules.bid.user.service.query.BackOffQuery"%>
<%@page import="com.dimeng.p2p.user.servlets.AbstractUserServlet"%>
<%@page import="com.dimeng.p2p.S62.enums.T6252_F09"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F14"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F13"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F11"%>
<%@page import="com.dimeng.p2p.modules.bid.user.service.entity.BackOffList"%>
<%@page import="com.dimeng.p2p.common.enums.QueryType"%>
<%@page import="com.dimeng.p2p.modules.bid.user.service.entity.BackOff"%>
<%@page import="com.dimeng.p2p.modules.bid.user.service.WdzqManage"%>
<%@page import="com.dimeng.p2p.user.servlets.Index"%>
<%@page import="com.dimeng.p2p.user.servlets.financing.wdzq.BackMoney"%>
<%@page import="com.dimeng.p2p.user.servlets.financing.AbstractFinancingServlet"%>
<%@include file="/WEB-INF/include/authenticatedSession.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>我的债权-<%configureProvider.format(out,SystemVariable.SITE_NAME); %></title>
<%@include file="/WEB-INF/include/meta.jsp" %>
<%@include file="/WEB-INF/include/style.jsp" %>
</head>
<%
	CURRENT_CATEGORY = "LCGL";
	CURRENT_SUB_CATEGORY = "SKMX";
	String queryType=request.getParameter("queryType");
	if(StringHelper.isEmpty(queryType)){
		queryType="DS";
	}
%>
<body>
<%@include file="/WEB-INF/include/header.jsp" %>
<div class="contain clearfix">
<div class="user_top"></div>
   <div class="about">
	<%@include file="/WEB-INF/include/menu.jsp"%>
           <div class="w780 fr" style="border:none;">
				
      <form action="<%=controller.getURI(request, BackMoney.class) %>" method="post">
		<div class="mainDiv bor1">
      <!--理财管理 S-->
			<div class="tb-state">
                <span>
                <select name="queryType" id="queryType" class="select-reg">
					<option value="DS" <%if (queryType.equals("DS")){%>selected="selected"<%}%>>待收款明细</option>
					<option value="YS" <%if (queryType.equals("YS")){%>selected="selected"<%}%>>已收款明细</option>
				</select>
                </span>
                <span><input type="text" class="date w100 yhgl_ser w88" id="datepicker1" name="timeStart" /></span>
                <span><input type="text" class="date w100 yhgl_ser w88 ml5" id="datepicker2" name="timeEnd"/></span>
                <input type="submit" id="querybutton" name="" value="查询" class="butStyle editquestion">&nbsp;&nbsp;
			</div>
		</div>
		<div id="funds" class="mainDiv bor1 min400">
			<p class="title1"><b>收款明细</b></p>
				<div class="tb-list">
					<table class="tableOdd">
					
					  <tbody><tr>
						<th>预计到账时间</th>
						<th>项目名称|编号</th>
                        <th>类型明细</th>
                        <th>预期收款额（元）</th>
						<th>借款人</th>
                        <th>详情</th>
					  </tr>
                  <%
                  PagingResult<BackOffList> boList= (PagingResult<BackOffList>)request.getAttribute("boList");
                  BidManage bidManage = serviceSession.getService(BidManage.class);
                  	if(boList != null && boList.getItemCount() >0){
			     		for(BackOffList backOff :boList.getItems()){
			     			if(backOff == null){
			     				continue;
			     			}
			     			Bdxq bdxq =bidManage.get(backOff.jkbId);
                  %>
						 <tr>
							<td><%=TimestampParser.format(backOff.receiveDate,"yyyy-MM-dd")%></td>
							<td><%=bdxq.F03 %>|<%StringHelper.filterHTML(out, backOff.assestsId); %></td>
							<td>回收本息</td>
							<td>￥<%=Formater.formatAmount(backOff.money)%></td>
							<td><%StringHelper.filterHTML(out, backOff.creditor); %></td>
							<td><a class="profitinfo"  href="/user/financing/wdzq/tzxq/<%=backOff.zqid + rewriter.getViewSuffix()%>">详情</a></td>
						</tr>
				    <%}}%>   
					</tbody></table>
				</div>
                <div class="page">
						<%AbstractFinancingServlet.rendPagingResult(out, boList); %>
				</div>
		</div>
		</form>          
                
      </div>
   <div class="clear"></div>
   </div>
</div>
<%@include file="/WEB-INF/include/footer.jsp" %>
<%@include file="/WEB-INF/include/script.jsp" %>
<%@include file="/WEB-INF/include/datepicker.jsp"%>

<script type="text/javascript">
$(function() {
	 $("#datepicker1").datepicker({
			inline: true,
			onSelect : function(selectedDate) {
            $("#datepicker2").datepicker("option", "minDate", selectedDate);  }
		});
   $("#datepicker2").datepicker({inline: true});
   $('#datepicker1').datepicker('option', {dateFormat:'yy-mm-dd'});
   $('#datepicker2').datepicker('option', {dateFormat:'yy-mm-dd'});
   $("#datepicker1").datepicker("setDate", "<%StringHelper.filterHTML(out, request.getParameter("timeStart"));%>");
   $("#datepicker2").datepicker("setDate", "<%StringHelper.filterHTML(out, request.getParameter("timeEnd"));%>");
	$("#datepicker2").datepicker('option', 'minDate',$("#datepicker1").datepicker().val());

});
</script>
</body>
</html>