<%@page import="com.dimeng.p2p.modules.bid.user.service.entity.HkEntity"%>
<%@page import="com.dimeng.p2p.S62.entities.T6231"%>
<%@page import="com.dimeng.p2p.modules.bid.user.service.BidManage"%>
<%@page import="com.dimeng.p2p.modules.bid.user.service.entity.LoanCount"%>
<%@page import="com.dimeng.p2p.modules.bid.user.service.WdjkManage"%>
<%@page import="com.dimeng.p2p.user.servlets.financing.agreement.Index"%>
<%@page import="com.dimeng.p2p.user.servlets.credit.Repaying"%>
<%@page import="com.dimeng.p2p.user.servlets.credit.PayOff"%>
<%@page import="java.text.DecimalFormat"%>
<%@include file="/WEB-INF/include/authenticatedSession.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title><%configureProvider.format(out,SystemVariable.SITE_NAME); %>_借款管理_我的借款</title>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<%
	WdjkManage manage = serviceSession.getService(WdjkManage.class);
	LoanCount loanCount = manage.getMyLoanCount();
	HkEntity[] settleLoans = manage.getYhqJk();
	
	CURRENT_CATEGORY = "JKGL";
	CURRENT_SUB_CATEGORY = "JKSQCX";
	%>
	<div class="clear"></div>
	<div class="contain clearfix">
		<div class="user_top"></div>
		<div class="about">
			<%@include file="/WEB-INF/include/menu.jsp"%>
			<div class="container fr mb15">
				<div class="user_bgls fl f20">
					<p class="mt40 ml40">
						借款总金额<br /> <span class="red"><%=Formater.formatAmount(loanCount.countMoney) %>元</span>
					</p>
				</div>
				<div class="hzcx_st fl"></div>
				<div class="fl">
					<ul class="hzcx_li pl40">
						<li>逾期金额<br><%=Formater.formatAmount(loanCount.overdueMoney) %>元
						</li>
						<li>待还金额<br><%=Formater.formatAmount(loanCount.repayMoney) %>元
						</li>
						<li>近30天应还金额<br><%=Formater.formatAmount(loanCount.newRepayMoney) %>元
						</li>
					</ul>
				</div>
			</div>
			<div class="container fr">
            <div class="mainDiv bor1">
            <!--理财管理 S-->
			  <div class="tb-state">
			  还款状态： <a class="butStyle no" avalue="huikuan" href="/user/credit/repaying.html">还款中</a>
				     <a class="butStyle " avalue="toubiaozhong">已还清</a>
			  </div>
		    </div>
            </div>
            <div class="w780 fr">       
      <div id="funds" class="mainDiv min400">
			<p class="title1"><b>已还清列表</b></p>
				<div class="tb-list">
					
					<table class="tableOdd">
					  <tbody>
					  <tr>
						<th width="20%">借款标题</th>
						<th width="15%">借款金额</th>
                        <th width="15%">年利率</th>
                        <th width="15%">期限</th>
						<th width="20%">还款总额</th>
						<th width="15%">还清日期</th>
					  </tr>
					   <%
									BidManage bidManage = serviceSession.getService(BidManage.class);
									if(settleLoans!=null){ 
									for(HkEntity settleLoan : settleLoans){
										if(settleLoan == null){
											continue;
										}
										T6231 t6231 =  bidManage.getExtra(settleLoan.F01);
									%>
                      <tr>
						<td><a target="_blank" class="blue" href="<%=configureProvider.format(URLVariable.FINANCING_SBTZ_XQ)%><%=settleLoan.F01 %><%=rewriter.getViewSuffix() %>"><%StringHelper.filterHTML(out, settleLoan.F03); %></a></td>
						<td><%=Formater.formatAmount(settleLoan.F05.subtract(settleLoan.F07))%></td>
						<td><%=Formater.formatRate(settleLoan.F06) %></td>
                        <td><%=settleLoan.F09 %>个月</td>
                        <td>￥<%=Formater.formatAmount(settleLoan.hkTotle) %></td>
						<td><%=DateParser.format(t6231.F13) %></td>
					  </tr>
					  <%}}%>
					</tbody>
					</table>
				</div>
				<div class="page">
				</div>
		</div>   
       	 </div>
			<div class="clear"></div>
		</div>
	</div>
	<div class="clear"></div>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
</body>
</html>