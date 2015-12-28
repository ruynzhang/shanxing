<%@page import="com.dimeng.p2p.modules.bid.user.service.entity.MonthCreditTotal"%>
<%@page import="com.dimeng.p2p.modules.bid.user.service.entity.NotPayCreditTotal"%>
<%@page import="com.dimeng.p2p.modules.bid.user.service.entity.YearCreditTotal"%>
<%@page import="com.dimeng.p2p.modules.bid.user.service.entity.PayCreditTotal"%>
<%@page import="com.dimeng.p2p.modules.bid.user.service.entity.CreditTotal"%>
<%@page import="com.dimeng.p2p.modules.bid.user.service.JktjManage"%>
<%@page import="java.math.BigDecimal"%>
<%@include file="/WEB-INF/include/authenticatedSession.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title><%configureProvider.format(out,SystemVariable.SITE_NAME); %>_借款管理_借款统计</title>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<%
		JktjManage manage = serviceSession.getService(JktjManage.class);
		CreditTotal creditTotal = manage.getCreditTotal();
		PayCreditTotal payCreditTotal = manage.getPayCreditTotal();
		YearCreditTotal[] yearCreditTotals = manage.getYearCreditTotal();
		NotPayCreditTotal notPayCreditTotal = manage.getNotPayCreditTotal();
		MonthCreditTotal[] monthCreditTotals = manage.getMonthCreditTotal();
		
		CURRENT_CATEGORY = "JKGL";
		CURRENT_SUB_CATEGORY = "JKTJ";
	%>
	<div class="w994 pb5">
		<span class="f16"><a href="<%=controller.getViewURI(request, com.dimeng.p2p.user.servlets.Index.class) %>">我的<%configureProvider.format(out,SystemVariable.SITE_NAME); %></a></span> &gt; <a href="#">借款管理</a>
		&gt; 借款统计
	</div>
	<div class="contain clearfix">
		<div class="user_top"></div>
		<div class="about">
			<%@include file="/WEB-INF/include/menu.jsp"%>
			<div class="container fr">
				<div class="p15">
					<div class="f20 blue mb10">借款统计</div>
					<%
						BigDecimal allTotal = creditTotal.accMoney.add(creditTotal.arrMoney).add(creditTotal.beforeMoney).add(creditTotal.manageMoney);
					%>
					<div class="tj_lsbg f16 mb40">您在<%configureProvider.format(out,SystemVariable.SITE_NAME); %>总计借款 <%=Formater.formatAmount(creditTotal.total) %>元，总计需支付 <%=Formater.formatAmount(creditTotal.totalPay) %>
						元的利息和费用</div>
					<div class="mb40">
						<table width="100%" border="0" cellspacing="0" cellpadding="0"
							class="fl tj_table">
							<tr class="ta_dls">
								<td>借款利息</td>
								<td><%=Formater.formatAmount(creditTotal.accMoney) %></td>
							</tr>
							<tr class="ta_dhs">
								<td>逾期费用</td>
								<td><%=Formater.formatAmount(creditTotal.arrMoney) %></td>
							</tr>
							<%--  
							<tr class="ta_dls">
								<td>借款管理费</td>
								<td><%=Formater.formatAmount(creditTotal.manageMoney) %></td>
							</tr>
							--%>
							<tr class="ta_dhs">
								<td>总计</td>
								<td><%=Formater.formatAmount(allTotal) %></td>
							</tr>
						</table>
						<div class="fr">
						<%if(allTotal.intValue() <=0 ){ %>
							您在<%configureProvider.format(out,SystemVariable.SITE_NAME); %>没有借款
						<%}else{ %>
							<div id="s1_jk" style="min-width: 400px; height: 216px; margin: 0 auto"></div>
						<%} %>
						</div>
						<div class="clear"></div>
					</div>
					<div class="tj_lsbg f16 mb40">您在<%configureProvider.format(out,SystemVariable.SITE_NAME); %>的借款待还总额为 <%=Formater.formatAmount(notPayCreditTotal.notPayTotal) %>元</div>
					<div class="mb40">
						<table width="100%" border="0" cellspacing="0" cellpadding="0"
							class="fl tj_table">
							<tr class="ta_dls">
								<td>待还本金</td>
								<td><%=Formater.formatAmount(notPayCreditTotal.notPayMoney) %></td>
							</tr>
							<tr class="ta_dhs">
								<td>待还利息</td>
								<td><%=Formater.formatAmount(notPayCreditTotal.notPayAccMoney) %></td>
							</tr>
							<tr class="ta_dls">
								<td>待还逾期费用</td>
								<td><%=Formater.formatAmount(notPayCreditTotal.notPayArrMoney) %></td>
							</tr>
							<tr class="ta_dhs">
								<td>总计</td>
								<td><%=Formater.formatAmount(notPayCreditTotal.notPayTotal) %></td>
							</tr>
						</table>
						<div class="fr">
							<%if(notPayCreditTotal.notPayTotal.intValue()<=0){ %>
								您在<%configureProvider.format(out,SystemVariable.SITE_NAME); %>没有借款
							<%}else{ %>
								<div id="s2_jk" style="min-width: 400px; height: 216px; margin: 0 auto"></div>
							<%} %>
						</div>
						<div class="clear"></div>
					</div>
					<div class="tj_lsbg f16 mb40">您在<%configureProvider.format(out,SystemVariable.SITE_NAME); %>的借款已还总额为 <%=Formater.formatAmount(payCreditTotal.payTotalMoney) %> 元</div>
					<div class="mb40">
						<table width="100%" border="0" cellspacing="0" cellpadding="0"
							class="fl tj_table">
							<tr class="ta_dls">
								<td>已还本金</td>
								<td><%=Formater.formatAmount(payCreditTotal.payMoney) %></td>
							</tr>
							<tr class="ta_dhs">
								<td>已还利息</td>
								<td><%=Formater.formatAmount(payCreditTotal.payAccMoney) %></td>
							</tr>
							<tr class="ta_dls">
								<td>已交逾期费用</td>
								<td><%=Formater.formatAmount(payCreditTotal.payArrMoney) %></td>
							</tr>
							<tr class="ta_dhs">
								<td>总计</td>
								<td><%=Formater.formatAmount(payCreditTotal.payTotalMoney) %></td>
							</tr>
						</table>
						<div class="fr">
							<%if(payCreditTotal.payTotalMoney.intValue()<=0){ %>
								您在<%configureProvider.format(out,SystemVariable.SITE_NAME); %>没有借款
							<%}else{ %>
								<div id="s3_jk" style="min-width: 400px; height: 216px; margin: 0 auto"></div>
							<%} %>
						</div>
						<div class="clear"></div>
					</div>
					<%
						BigDecimal yTotal = new BigDecimal(0);
						if(yearCreditTotals!=null && yearCreditTotals.length>0){
							for(YearCreditTotal yearCreditTotal : yearCreditTotals){
								yTotal = yTotal.add(yearCreditTotal.money);
							}
						}
					%>
					<div class="tj_lsbg f16 mb40">最近一年您在<%configureProvider.format(out,SystemVariable.SITE_NAME); %>成功借款 <%=Formater.formatAmount(manage.getYnjk()) %> 元</div>
					<%if(yTotal.intValue() > 0){ int i = 0; %>
					<div class="mb40">
						<table width="100%" border="0" cellspacing="0" cellpadding="0"
							class="fl tj_table">
							<%
								for(YearCreditTotal yearCreditTotal : yearCreditTotals){ 
									i++;
							%>
							<tr class="<%=i%2==0?"ta_dls":"ta_dhs" %>">
								<td><%=yearCreditTotal.year %>年第<%=yearCreditTotal.quarter %>季度</td>
								<td><%=Formater.formatAmount(yearCreditTotal.money) %></td>
							</tr>
							<%} %>
							<tr class="<%=(i+1)%2==0?"ta_dls":"ta_dhs" %>">
								<td>总计</td>
								<td><%=Formater.formatAmount(yTotal) %></td>
							</tr>
						</table>
						<div class="fr">
							<%if(yTotal.intValue() > 0){ %>
							<div id="c1_jk" style="min-width: 410px; height: 400px; margin: 0 auto"></div>
							<%} %>
						</div>
						<div class="clear"></div>
					</div>
					<%}
						BigDecimal mTotal = new BigDecimal(0);
						if(monthCreditTotals!=null && monthCreditTotals.length>0){
							for(MonthCreditTotal monthCreditTotal : monthCreditTotals){
								mTotal = mTotal.add(monthCreditTotal.money);
							}
						}
					%>
					<div class="tj_lsbg f16 mb40">最近六个月您在<%configureProvider.format(out,SystemVariable.SITE_NAME); %>产生的还款总计为 <%=Formater.formatAmount(manage.getLgyjk()) %> 元</div>
					<%if(mTotal.intValue() > 0){ int i = 0; %>
					<div class="mb40">
						<table width="100%" border="0" cellspacing="0" cellpadding="0"
							class="fl tj_table">
							<%
								for(MonthCreditTotal monthCreditTotal : monthCreditTotals){
							%>
							<tr class="<%=i%2==0?"ta_dls":"ta_dhs" %>">
								<td><%=monthCreditTotal.year %>年<%=monthCreditTotal.month %>月</td>
								<td><%=Formater.formatAmount(monthCreditTotal.money) %></td>
							</tr>
							<%} %>
							<tr class="<%=(i+1)%2==0?"ta_dls":"ta_dhs" %>">
								<td>总计</td>
								<td><%=Formater.formatAmount(mTotal) %></td>
							</tr>
						</table>
						<div class="fr">
							<%if(mTotal.intValue() > 0){ %>
								<div id="c2_jk" style="min-width: 410px; height: 400px; margin: 0 auto"></div>
							<%} %>
						</div>
						<div class="clear"></div>
					</div>
					<%} %>
				</div>
			</div>
			<div class="clear"></div>
		</div>
	</div>
	<script type="text/javascript">
		var d1_jk = null;
		var d2_jk = null;
		var d3_jk = null;
		<%if(allTotal.intValue() > 0){%>
			d1_jk = [['借款利息',<%=creditTotal.accMoney%>],['逾期费用',<%=creditTotal.arrMoney%>]];
		<%}%>
		<%if(notPayCreditTotal.notPayTotal.intValue() > 0){%>
			d2_jk = [['待还本金',<%=notPayCreditTotal.notPayMoney%>],['待还利息',<%=notPayCreditTotal.notPayAccMoney%>],['待还逾期费用',<%=notPayCreditTotal.notPayArrMoney%>]];
		<%}%>
		<%if(payCreditTotal.payTotalMoney.intValue() > 0){%>
			d3_jk = [['已还本金',<%=payCreditTotal.payMoney%>],['已还利息',<%=payCreditTotal.payAccMoney%>],['已交逾期费用',<%=payCreditTotal.payArrMoney%>]];
		<%}%>
		var cc1_jk = null;
		var dd1_jk = null;
		<%if(yTotal.intValue() > 0){int i = 0; %>
			cc1_jk = [
			        <%for(YearCreditTotal total : yearCreditTotals){
			        		if(i == 0){
			        			out.print("\'");
			        			out.print(total.year);
			        			out.print("年第");
			        			out.print(total.quarter);
			        			out.print("季度\'");
			        			i++;
			        			continue;
			        		}
			        		out.print(",\'");
		        			out.print(total.year);
		        			out.print("年第");
		        			out.print(total.quarter);
		        			out.print("季度\'");
		        			i++;
			        }i = 0;%>
			];
			dd1_jk = [
			          <%for(YearCreditTotal total : yearCreditTotals){
			        		if(i == 0){
			        			out.print(total.money);
			        			i++;
			        			continue;
			        		}
			        		out.print(",");
			        		out.print(total.money);
			        		i++;
			        }i=0;%>
			];
		<%}%>
		var cc2_jk = null;
		var dd2_jk = null;
		<%if(mTotal.intValue() > 0){int i = 0; %>
			cc2_jk = [
				<%for(MonthCreditTotal total : monthCreditTotals){ 
					if(0 == i){
						out.print("\'");
	        			out.print(total.year);
	        			out.print("年");
	        			out.print(total.month);
	        			out.print("月\'");
	        			i++;
						continue;
					}
					out.print(",\'");
        			out.print(total.year);
        			out.print("年");
        			out.print(total.month);
        			out.print("月\'");
        			i++;
				}i = 0;%>
			];
			dd2_jk = [
				<%for(MonthCreditTotal total : monthCreditTotals){ 
					if(0 == i){
						out.print(total.money);
						i++;
						continue;
					}
					out.print(",");
	        		out.print(total.money);
	        		i++;
				}%>
			];
		<%}%>
	</script>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
	<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/highcharts.js"></script>
	<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/creditStatistics.js"></script>
</body>
</html>