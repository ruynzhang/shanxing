<%@page import="com.dimeng.p2p.modules.bid.user.service.entity.UnpayEarnings"%>
<%@page import="com.dimeng.p2p.modules.bid.user.service.entity.FinancingTotal"%>
<%@page import="com.dimeng.p2p.modules.bid.user.service.entity.EarnFinancingTotal"%>
<%@page import="com.dimeng.p2p.modules.bid.user.service.entity.AccountBalance"%>
<%@page import="com.dimeng.p2p.modules.bid.user.service.LctjManage"%>
<%@page import="com.dimeng.p2p.user.servlets.Index"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="com.dimeng.p2p.user.servlets.financing.FinancingStatistics"%>
<%@include file="/WEB-INF/include/authenticatedSession.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title><%configureProvider.format(out, SystemVariable.SITE_NAME);%>_理财管理_理财统计</title>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<%
		LctjManage manage = serviceSession.getService(LctjManage.class);
		AccountBalance aBalance = manage.getAccountBalance();
		EarnFinancingTotal earnFinancingTotal =  manage.getEarnFinancingTotal();
		FinancingTotal financingTotal = manage.getFinancingTotal();
		UnpayEarnings unpayEarnings = manage.getUnpayEarnings();
		
		CURRENT_CATEGORY = "LCGL";
		CURRENT_SUB_CATEGORY = "LCTJ";
	%>
	<div class="w994 pb5">
		<span class="f16"><a href="<%=controller.getViewURI(request, Index.class) %>">我的<%=configureProvider.getProperty(SystemVariable.SITE_NAME) %></a></span> &gt; 理财管理
		&gt; 理财统计
	</div>
	<div class="contain clearfix">
		<div class="user_top"></div>
		<div class="about">
			<%@include file="/WEB-INF/include/menu.jsp"%>
			<div class="container fr">
				<div class="p15">
					<div class="f20 blue mb10">理财统计</div>
					<div class="tj_lsbg f16 mb40">您通过<%configureProvider.format(out,SystemVariable.SITE_NAME); %>平台已赚取<%=Formater.formatAmount(earnFinancingTotal.total) %>元</div>
					<div class="mb40">
						<table width="100%" border="0" cellspacing="0" cellpadding="0"
							class="fl tj_table">
							<%--
							<tr class="ta_dls">
								<td>优选理财计划收益</td>
								<td><%=Formater.formatAmount(earnFinancingTotal.plan) %></td>
							</tr>
							 --%>
							<tr class="ta_dhs">
								<td colspan="2"><table width="100%" border="0"
										cellspacing="0" cellpadding="0" class="tj_bg">
										<tr>
											<td width="32%" rowspan="4">债权收益</td>
											<td width="46%">已赚利息</td>
											<td width="22%"><%=Formater.formatAmount(earnFinancingTotal.interest) %></td>
										</tr>
										<tr>
											<td>已赚罚息</td>
											<td><%=Formater.formatAmount(earnFinancingTotal.penalty)%></td>
										</tr>
										<tr>
											<td>债权转让盈亏</td>
											<td><%=Formater.formatAmount(earnFinancingTotal.transfer) %></td>
										</tr>
									</table></td>
							</tr>
							<tr class="ta_dls">
								<td>总计</td>
								<td><%=Formater.formatAmount(earnFinancingTotal.total)%></td>
							</tr>
						</table>
						<div class="fr">
							<div id="c1_lc" style="min-width: 400px; height: 216px; margin: 0 auto"></div>
						</div>
						<div class="clear"></div>
					</div>
					<div class="tj_lsbg f16 mb40">您通过<%configureProvider.format(out,SystemVariable.SITE_NAME); %>平台总计投资 <%=Formater.formatAmount(financingTotal.total) %>元</div>
					<div class="mb40">
						<table width="100%" border="0" cellspacing="0" cellpadding="0"
							class="fl tj_table">
							<%-- 
							<tr class="ta_dls">
								<td width="205">优选理财计划</td>
								<td width="110"><%=Formater.formatAmount(financingTotal.plan) %></td>
							</tr>
							--%>
							<tr class="ta_dhs">
								<td colspan="2"><table width="100%" border="0"
										cellspacing="0" cellpadding="0" class="tj_bg">
										<tr>
											<td width="29%" rowspan="3">债权</td>
											<td width="35%">信用认证标</td>
											<td width="36%"><%=Formater.formatAmount(financingTotal.credit) %></td>
										</tr>
										<tr>
											<td>机构担保标</td>
											<td><%=Formater.formatAmount(financingTotal.warrant) %></td>
										</tr>
										<tr>
											<td>实地认证标</td>
											<td><%=Formater.formatAmount(financingTotal.certification) %></td>
										</tr>
									</table></td>
							</tr>
							<tr class="ta_dls">
								<td>总计</td>
								<td><%=Formater.formatAmount(financingTotal.total) %></td>
							</tr>
						</table>
						<div class="fr">
							<%if(financingTotal.total.floatValue()>0){ %>
								<div id="s1_lc" style="min-width: 400px; height: 216px; margin: 0 auto"></div>
							<%}else{ %>
								您在<%=configureProvider.getProperty(SystemVariable.SITE_NAME)%>没有投资
							<%} %>
						</div>
						<div class="clear"></div>
					</div>
					<div class="tj_lsbg f16 mb40">您当前在<%configureProvider.format(out,SystemVariable.SITE_NAME); %>的理财账户资产为<%=Formater.formatAmount(aBalance.total) %>元</div>
					<div class="mb40">
						<table width="100%" border="0" cellspacing="0" cellpadding="0"
							class="fl tj_table">
							<%--
							<tr class="ta_dls">
								<td width="205">优选理财计划</td>
								<td width="110"><%=Formater.formatAmount(aBalance.plan) %></td>
							</tr>
							 --%>
							<tr class="ta_dhs">
								<td colspan="2"><table width="100%" border="0"
										cellspacing="0" cellpadding="0" class="tj_bg">
										<tr>
											<td width="29%" rowspan="3">债权</td>
											<td width="35%">信用认证标</td>
											<td width="36%"><%=Formater.formatAmount(aBalance.credit) %></td>
										</tr>
										<tr>
											<td>机构担保标</td>
											<td><%=Formater.formatAmount(aBalance.warrant) %></td>
										</tr>
										<tr>
											<td>实地认证标</td>
											<td><%=Formater.formatAmount(aBalance.certification) %></td>
										</tr>
									</table></td>
							</tr>
							<tr class="ta_dls">
								<td>总计</td>
								<td><%=Formater.formatAmount(aBalance.total) %></td>
							</tr>
						</table>
						<div class="fr">
							<%if(aBalance.total.floatValue()>0){ %>
								<div id="s2_lc" style="min-width: 400px; height: 216px; margin: 0 auto"></div>
							<%}else{ %>
								您在<%=configureProvider.getProperty(SystemVariable.SITE_NAME)%>没有投资
							<%} %>
						</div>
						<div class="clear"></div>
					</div>
					<div class="tj_lsbg f16 mb40">您当前在<%configureProvider.format(out,SystemVariable.SITE_NAME); %>投资的债权待收收益为<%=Formater.formatAmount(unpayEarnings.total) %>元</div>
					<div class="mb40">
						<table width="100%" border="0" cellspacing="0" cellpadding="0"
							class="fl tj_table">
							<tr class="ta_dls">
								<td>信用认证标</td>
								<td><%=Formater.formatAmount(unpayEarnings.credit) %></td>
							</tr>
							<tr class="ta_dhs">
								<td>机构担保标</td>
								<td><%=Formater.formatAmount(unpayEarnings.warrant) %></td>
							</tr>
							<tr class="ta_dls">
								<td>实地认证标</td>
								<td><%=Formater.formatAmount(unpayEarnings.certification) %></td>
							</tr>
							<tr class="ta_dhs">
								<td>总计</td>
								<td><%=Formater.formatAmount(unpayEarnings.total) %></td>
							</tr>
						</table>
						<div class="fr">
						<%if(unpayEarnings.total.floatValue()>0){ %>
							<div id="s3_lc" style="min-width: 400px; height: 216px; margin: 0 auto"></div>
						<%}else{ %>
							您在<%=configureProvider.getProperty(SystemVariable.SITE_NAME)%>没有投资
						<%} %>
						</div>
						<div class="clear"></div>
					</div>
				</div>
			</div>
			<div class="clear"></div>
		</div>
	</div>
	<script type="text/javascript">
	<%--  d1_lc = [<%=financingTotal.credit %>,<%=financingTotal.warrant %>,<%=financingTotal.certification %>]; --%>
	var dd1_lc = [<%=earnFinancingTotal.interest%>,<%=earnFinancingTotal.penalty%>,<%=earnFinancingTotal.transfer%>];
	var d1_lc = null;
	<%if(financingTotal.total.floatValue()>0){%>
		d1_lc = [['信用认证标',<%=financingTotal.credit %>],['机构担保标',<%=financingTotal.warrant %>],['实地认证标',<%=financingTotal.certification %>]];
	<%}%>
	var d2_lc = null;
	<%if(aBalance.total.floatValue()>0){%>
		d2_lc = [['信用认证标',<%=aBalance.credit %>],['机构担保标',<%=aBalance.warrant %>],['实地认证标',<%=aBalance.certification %>]];
	<%}%>
	
	var d3_lc = null;
	<%if(unpayEarnings.total.floatValue()>0){%>
		d3_lc = [['信用认证标',<%=unpayEarnings.credit %>],['机构担保标',<%=unpayEarnings.warrant %>],['实地认证标',<%=unpayEarnings.certification %>]];
	
	<%}%>
	//d3_lc = [['信用认证标',100],['机构担保标',110],['实地认证标',120]];
	</script>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
	<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/highcharts.js"></script>
	<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/financingStatistics.js"></script>
</body>
</html>