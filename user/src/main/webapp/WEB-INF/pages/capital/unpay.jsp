<%@page import="com.dimeng.p2p.user.servlets.capital.Charge"%>
<%@page import="com.dimeng.p2p.user.servlets.capital.TradingRecord"%>
<%@page import="com.dimeng.p2p.user.servlets.capital.Unpay"%>
<%@page import="com.dimeng.p2p.account.user.service.entity.Order"%>
<%@page import="com.dimeng.p2p.account.user.service.TxManage"%>
<%@page import="com.dimeng.p2p.user.servlets.AbstractUserServlet"%>
<%@include file="/WEB-INF/include/authenticatedSession.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>我的<%configureProvider.format(out,SystemVariable.SITE_NAME);%>_未完成充值记录
</title>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<%
		TxManage manage = serviceSession.getService(TxManage.class);
		final int currentPage = IntegerParser.parse(request.getParameter("paging.current"));
		Paging paging = new Paging(){
			@Override
			public int getSize() {
				return 10;
			}
			
			@Override
			public int getCurrentPage() {
				return currentPage;
			}
		};
		PagingResult<Order> pagingOrder = manage.search(paging);
		Order[] orders = pagingOrder.getItems();
		
		CURRENT_CATEGORY = "ZJGL";
		CURRENT_SUB_CATEGORY = "CZ";
	%>
	<div class="w994 pb5">
		<span class="f16">我的<%=configureProvider.getProperty(SystemVariable.SITE_NAME) %></span> &gt; 资金管理 &gt; 未完成充值记录
	</div>
	<div class="contain clearfix">
		<div class="user_top"></div>
		<div class="about">
			<%@include file="/WEB-INF/include/menu.jsp"%>
			<div class="container fr bor1">
	         <div class="p15">
	       	   <div class="user_lsjt mb20">充值>未完成充值记录</div>
	       	   <table width="100%" border="0" cellspacing="0" cellpadding="0" class="user_table tc">
	       	     <tr class="user_lsbg">
	       	       <td>序号</td>
	       	       <td>订单号</td>
	       	       <td>金额（元）</td>
	       	       <td>时间</td>
	       	       <td>状态</td>
	       	       <td>操作</td>
	   	         </tr>
	   	         <%if(orders != null){ 
	   	        	 int i = 1;
	   	        	 for(Order order : orders){
	   	         %>
	             <tr>
	       	       <td><%=i++ %></td>
	       	       <td><%=order.id %></td>
	       	       <td><%=Formater.formatAmount(order.amount) %></td>
	       	       <td><%=DateTimeParser.format(order.orderTime) %></td>
	       	       <td><%=order.status.getChineseName() %></td>
	       	       <td>
<%-- 		       	       <a target="_blank" onclick="toCharge();" href="<%=configureProvider.format(URLVariable.PAY_INDEX) %>?o=<%=order.id %>" class="blue">去支付</a> --%>
		       	       <a target="_blank" href="<%=configureProvider.format(URLVariable.PAY_CHECK) %>?o=<%=order.id %>" class="blue ml5">去对账</a>
		       	   </td>
	   	         </tr>
	   	         <%}} %>
	   	       </table>
	   	       <form action="<%=controller.getViewURI(request, Unpay.class) %>" method="post">
	   	       <div class="page">
					<%AbstractUserServlet.rendPagingResult(out, pagingOrder); %>
				</div>
				</form>
	         </div>            
	       	 </div>
	       	 <div class="clear"></div>
		</div>
	</div>
	<div id="problem" style="display: none;">
		<div class="popup_bg"></div>
		<div class="dialog w510 thickpos" style="margin:-120px 0 0 -255px;">
		  <div class="dialog_close fr"><a href="javascript:void(0)"></a></div>
		  <div class="con clearfix">
		    <div class="d_perfect fl"></div>
		    <div class="info fr">
		      <p class="f20 gray33">请您在新打开的页上完成付款。</p>
		      <p>付款完成前请不要关闭此窗口。<br/>完成付款后请根据您的情况点击下面的按钮：</p>
		      <p><a href="<%=controller.getViewURI(request, TradingRecord.class) %>" class="btn06 tc f14 fl mr10 mt5" >已完成付款</a>
		      <a href="<%=controller.getViewURI(request, Charge.class) %>#001" class="btn06 tc f14 fl mt5" >付款遇到问题</a></p>
		      <div class="clear"></div>
		      <%--
		      <p class="mt5"><a href="javascript:void(0);" id="otherPay" class="blue">返回选择其他支付方式</a></p>
		       --%> 
		    </div>
		    <div class="clear"></div>
		  </div>
		</div>
	</div>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
	<script type="text/javascript">
	$(function(){
		$("#problem div.dialog_close").click(function(){
			$("#problem").hide();
		});
		$("#problem a.btn06").click(function(){
			$("#problem").hide();
		});
	});
	function toCharge(){
		$("#problem").show();
	}
	</script>
</body>
</html>