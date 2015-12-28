<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.console.servlets.finance.fksh.TyjAchieveDetailExport"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.fksh.TyjAchieveDetailList"%>
<%@page import="com.dimeng.p2p.modules.bid.console.service.entity.ExpemonyAchieveDetail"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.fksh.TyjAchieveListExport"%>
<%@page import="com.dimeng.p2p.modules.bid.console.service.entity.ExpemonyAchieve"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.fksh.TyjInterestListExport"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.fksh.TyjInterestList"%>
<%@page import="com.dimeng.p2p.modules.bid.console.service.entity.ExpemonyInte"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.fksh.TyjshListExport"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.fksh.TyjshList"%>
<%@page import="com.dimeng.p2p.modules.bid.console.service.entity.ExpemoneyCode"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.czgl.ExportCzgl"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="com.dimeng.p2p.S61.enums.T6110_F06"%>
<%@page import="com.dimeng.p2p.S61.enums.T6131_F07"%>
<%@page import="com.dimeng.p2p.modules.account.console.service.entity.UserRecharge"%>
<%@page import="com.dimeng.p2p.modules.account.console.service.entity.Czgl"%>
<%@page import="com.dimeng.util.Formater"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.AbstractFinanceServlet"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.tyjgl.KldhList"%>
<%@page import="com.dimeng.p2p.console.servlets.AbstractConsoleServlet"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<%
		PagingResult<ExpemonyAchieveDetail> result = (PagingResult<ExpemonyAchieveDetail>) request
				.getAttribute("result");
String user_id =request.getAttribute("user_id").toString();
String createTimeStart =request.getAttribute("createTimeStart").toString();

String createTimeEnd =request.getAttribute("createTimeEnd").toString();
SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
Date befodate=null;
if(createTimeStart!=null && !"".equals(createTimeStart)){
	 befodate=df.parse(createTimeStart);
}
Date enddate=null;
if(createTimeEnd!=null && !"".equals(createTimeEnd)){
	 enddate=df.parse(createTimeEnd);
}
String ass_account =request.getAttribute("ass_account").toString();
String account_name =request.getAttribute("account_name").toString();
String username =request.getAttribute("username").toString();


BigDecimal sum1 = new BigDecimal(0);
BigDecimal sum2 = new BigDecimal(0);
BigDecimal sum3 = new BigDecimal(0);
BigDecimal sum4 = new BigDecimal(0);
String str1=request.getAttribute("sumtyj").toString();
if(str1!=null){
	sum1 = new BigDecimal(str1);
}
String str2=request.getAttribute("invemoney").toString();
if(str2!=null){
	sum2 = new BigDecimal(str2);
}
String str3=request.getAttribute("noinvemoney").toString();
if(str3!=null){
	sum3 = new BigDecimal(str3);
}
String str4=request.getAttribute("inveint").toString();
if(str4!=null){
	sum4 = new BigDecimal(str4);
}
%>
<%
CURRENT_CATEGORY = "CWGL";
CURRENT_SUB_CATEGORY = "TYJACHIEVENEW";
	%>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="w_main">
		<div class="main clearfix">
			<div class="wrap">
				<div class="r_main">
					<div class="home_main">
						<form action="<%controller.getURI(request,TyjAchieveDetailList.class);%>" method="post" name="form1" id="searchForm">
						   <input type="hidden" id="user_id" name="user_id" value="<%=user_id%>"/>
						    <input type="hidden" id="ass_account" name="ass_account" value="<%=ass_account%>"/>
						     <input type="hidden" id="account_name" name="account_name" value="<%=account_name%>"/>
						      <input type="hidden" id="username" name="username" value="<%=username%>"/>
						       <input type="hidden" id="sumtyj" name="sumtyj" value="<%=str1%>"/>
						        <input type="hidden" id="invemoney" name="invemoney" value="<%=str2%>"/>
						         <input type="hidden" id="noinvemoney" name="noinvemoney" value="<%=str3%>"/>
						          <input type="hidden" id="inveint" name="inveint" value="<%=str4%>"/>
						           <input type="hidden" id="createTimeStart" name="createTimeStart" value="<%=createTimeStart%>"/>
						            <input type="hidden" id="createTimeEnd" name="createTimeEnd" value="<%=createTimeEnd%>"/>
							<div class="box box1 mb15">
								<div class="atil">
									<h3>体验金对账单</h3>
								</div>
								<div class="con">
									<div class="clear"></div>
									<ul class="yhxq_li">
										<li>账单日期：<span class="blue"><%=befodate==null?"":DateTimeParser.format(befodate,"yyyy-MM-dd") %>&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;&nbsp;<%=enddate==null?"":DateTimeParser.format(enddate,"yyyy-MM-dd") %></span>
										</li>
									</ul>
									<ul class="yhxq_li">
										<li>用户名：<span class="blue"><%=account_name %></span>
										</li>
									</ul>
									<ul class="yhxq_li">
										<li>账号：<span class="blue"><%=ass_account %></span>
										</li>
									</ul>
									<ul class="yhxq_li">
										<li>姓名：<span class="blue"><%=username==null || "null".equals(username)?"":username %></span>
										</li>
									</ul>
									<ul class="yhxq_li">
										<li>获得体验金总金额：<span class="blue"><%=Formater.formatAmount(sum1) %></span>
										</li>
									</ul>
									<ul class="yhxq_li">
										<li>已使用体验金总数：<span class="blue"><%=Formater.formatAmount(sum2) %></span>
										</li>
									</ul>
									<ul class="yhxq_li">
										<li>未使用体验金总数：<span class="blue"><%=Formater.formatAmount(sum3) %></span>
										</li>
									</ul>
									<ul class="yhxq_li">
										<li>利息收入：<span class="blue"><%=Formater.formatAmount(sum4) %></span>
										</li>
									</ul>
									<div class="clear"></div>
								</div>
							</div>
							<div class="box box1 mb15">
								<div class="con">
									<div class="admin_input admin_pb">
             							<div class="table top3">
											<P>
												<a href="javascript:void(0)" onclick="showExport()" class="btn3 mr10"><span class="ico"></span>导出</a>
											</P>
									<div class="clear"></div>
								</div>
								</div>
								</div>
							</div>
							<table width="100%" border="0" cellspacing="0" cellpadding="3" class="yhgl_table tc">
								<tr class="hsbg">
									<td>序号</td>
									<td>日期</td>
									<td>项目</td>
									<td>明细</td>
									<td>收入</td>
									<td>支出</td>
									<td>利息收入</td>
								</tr>
								<%
								
								ExpemonyAchieveDetail[] items = result.getItems();
								  BigDecimal couny1 = new BigDecimal(0);
								  BigDecimal couny2 = new BigDecimal(0);
								  BigDecimal couny3 = new BigDecimal(0);
										if (items != null) {
											int i=1;
											for (ExpemonyAchieveDetail excode: items) {
												if (excode == null) {
													continue;
												}
								%>
								<tr class="dhsbg">
									<td><%=i++%></td>
									<td><%=excode.expiryTime==null?"":DateTimeParser.format(excode.expiryTime,"yyyy-MM-dd") %></td>
									<td><%=excode.eqpro %></td>
									<td><%=excode.typename %></td>
									<%if(excode.eqpro!=null && excode.eqpro.equals("获得体验金")){
										couny1=couny1.add(excode.eqmoney);
										%>
									     <td><%=Formater.formatAmount(excode.eqmoney)%></td>
									      <td></td>
									      <td></td>
									<%}else if(excode.eqpro!=null && excode.eqpro.equals("使用体验金")){ 
										couny2=couny2.add(excode.eqmoney);
									%>
									      <td></td>
									      <td><%=Formater.formatAmount(excode.eqmoney)%></td>
									      <td></td>
									<%}else if(excode.eqpro!=null && excode.eqpro.equals("利息收入")){
										couny3=couny3.add(excode.eqmoney);
									%>
									      <td></td>
									      <td></td>
									      <td><%=Formater.formatAmount(excode.eqmoney)%></td>
									<%} %>
								</tr>
								<%
									}
										}
								%>
							  <tr class="dhsbg">
							       <td></td>
							       <td></td>
							       <td>合计</td>
							       <td></td>
							       <td><%=Formater.formatAmount(couny1)%></td>
							       <td><%=Formater.formatAmount(couny2)%></td>
							       <td><%=Formater.formatAmount(couny3)%></td>
							  </tr>
							</table>
							<%
							    AbstractConsoleServlet.rendPagingResult(out, result);
							%>
							<div class="box2 clearfix"></div>
						</form>
					</div>
				</div>
			</div>
			<%@include file="/WEB-INF/include/left.jsp"%>
		</div>
	</div>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
	<%@include file="/WEB-INF/include/datepicker.jsp"%>
	<script type="text/javascript">
	function showExport()
	{
		document.getElementById("searchForm").action ="<%=controller.getURI(request, TyjAchieveDetailExport.class)%>";
		$("#searchForm").submit();
		document.getElementById("searchForm").action ="<%=controller.getURI(request, TyjAchieveDetailList.class)%>";
	}
  </script>
</body>
</html>
