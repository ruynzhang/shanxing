<%@page import="com.dimeng.p2p.user.servlets.credit.PaymentOne"%>
<%@page import="com.dimeng.p2p.modules.bid.user.service.entity.RepayInfo"%>
<%@page import="com.dimeng.p2p.modules.bid.user.service.entity.RepayLoanDetail"%>
<%@page import="com.dimeng.p2p.modules.bid.user.service.WdjkManage"%>
<%@page import="com.dimeng.p2p.user.servlets.credit.Repaying"%>
<%@page import="com.dimeng.p2p.user.servlets.capital.Charge"%>
<%@page import="com.dimeng.p2p.user.servlets.credit.LoanDetail"%>
<%@page import="com.dimeng.p2p.user.servlets.credit.AbstractCreditServlet"%>
<%@page import="com.dimeng.p2p.common.enums.PaymentStatus"%>
<%@page import="com.dimeng.p2p.user.servlets.credit.Payment"%>
<%@page import="com.dimeng.p2p.common.enums.RepayStatus"%>
<%@include file="/WEB-INF/include/authenticatedSession.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title><%
	configureProvider.format(out, SystemVariable.SITE_NAME);
%>
</title>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<%
		WdjkManage creditManage = serviceSession.getService(WdjkManage.class);
		int id=IntegerParser.parse(request.getParameter("id"));
		final int currentPage = IntegerParser.parse(request.getParameter("paging.current"));
		Paging paging = new Paging() {
		public int getCurrentPage() {
			return currentPage;
		}

		public int getSize() {
			return 10;
		}
			};
		 	RepayLoanDetail[] details=creditManage.getRepayLoanDetail(id);
			CURRENT_CATEGORY = "JKGL";
			CURRENT_SUB_CATEGORY = "JKSQCX";
	%>
	<div class="clear"></div>
	<div class="contain clearfix">
		<div class="user_top"></div>
		<div class="about">
			<%@include file="/WEB-INF/include/menu.jsp"%>
			<form action="<%=controller.getViewURI(request, LoanDetail.class)%>?id=<%=id%>" method="post">
			<div class="container fr">
				<div class="p15">
					<div class="user_lsjt mb20">还款详情<span style="font-size: 12px;float: right"><a href="<%=controller.getViewURI(request, Repaying.class)%>" class="blue">返回列表</a></span></div>
					<table width="100%" border="0" cellspacing="0" cellpadding="0" class="user_table tc">
						<tr class="user_lsbg">
							<td>期数</td>
							<td>金额</td>
							<td>还款日期</td>
							<td>状态</td>
							<td>&nbsp;</td>
						</tr>
						 <%
						 	if(details!=null && details.length>0){
						 		        		for(RepayLoanDetail detail : details){
						 		        			if(detail==null){continue;}
						 %>
				        <tr>
				          <td>第<%=detail.F06%>期</td>
				          <td><i><%=Formater.formatAmount(detail.F07)%></i></td>
				          <td><%=DateParser.format(detail.F08)%></td>
				          <td><%=detail.paymentStatus==null?"":detail.paymentStatus.getName()%></td>
				          <td><%
				          	if(detail.paymentStatus==PaymentStatus.WH||PaymentStatus.YQ==detail.paymentStatus||PaymentStatus.YZYQ==detail.paymentStatus){
				          %> 
				          <a href="javascript:void(0)" class="blue" onclick="showPayment('<%=detail.F01%>')">还款</a> <%
						 	}
						 %></td>
				        </tr>
				        <%
				        	}}else{
				        %>
				        <tr><td colspan="8">没有记录</td></tr>
				        <%
				        	}
				        %>
					</table>
				</div>
			</div>
			</form>
			<div class="clear"></div>
		</div>
	</div>
	<%
		if(details!=null && details.length>0){
			for(RepayLoanDetail detail : details){
		if(detail==null){continue;}
		RepayInfo repayInfo=detail.repayInfo;
		if(repayInfo!=null)
		{
	%>
	<div class="dialog d_error w510 thickpos" style="margin: -100px 0 0 -255px;display: none" id="r<%=detail.F01%>">
		<div class="dialog_close fr">
			<a href="javascript:void(0)"></a>
		</div>
		<div class="con clearfix">
			<div class="borrowing clearfix">
				<span class="fl"><i class="f20 gray33">当期还款总需:</i> <i class="red"><%=Formater.formatAmount(repayInfo.loanTotalMoney)%></i>元</span> <span class="fr">账户余额：<i class="red"><%=Formater.formatAmount(repayInfo.accountAmount)%>元</i></span>
			</div>
			<form action="<%=controller.getURI(request, PaymentOne.class)%>" method="post">
				<input type="hidden" name="id" value="<%=detail.F02%>" />
				<input type="hidden" name="number" value="<%=detail.F06%>" />
				<div class="borrowing clearfix">
					<p>其中</p>
					<table width="100%" border="0" cellspacing="0" class="tc">
						<tr>
							<td>当期应还本息</td>
							<td>逾期金额</td>
						</tr>
						<tr>
							<td><i class="red"><%=Formater.formatAmount(repayInfo.loanMustMoney)%></i></td>
							<td><i class="red"><%=Formater.formatAmount(repayInfo.loanArrMoney)%></i></td>
						</tr>
					</table>
				</div>
				<div class="clear"></div>
				<div id="confirmBtn_<%=repayInfo.loanID %>" class="dialog_btn">
					<input type="submit" class="btn btn001" value="确认扣费" onclick="confirmRepay(<%=repayInfo.loanID %>)"/><input type="button" onclick="closeDiv(<%=detail.F01%>)" class="btn btn05 close" value="取 消" />
				</div>
				<div id="confirmLoading_<%=repayInfo.loanID %>" style="color:red; display: none; text-align:center;">
					正在处理，请稍候...
				</div>
			</form>
		</div>
	</div>
	<%
		}}}
	%>
	<%
		String errorMessage = controller.getPrompt(request, response,
			PromptLevel.ERROR);
			if (!StringHelper.isEmpty(errorMessage)) {
	%>
	<div class="dialog w510 thickpos" style="margin: -80px 0 0 -255px;" id="errorDiv">
		<div class="dialog_close fr">
			<a href="#"></a>
		</div>
		<div class="con clearfix">
			<div class="d_error fl"></div>
			<div class="info fr">
				<p class="f20 gray33">
					<%
						StringHelper.filterHTML(out, errorMessage);
					%>
				</p>
			</div>
			<div class="clear"></div>
			<div class="dialog_btn">
				<a href="javascript:void(0);" class="btn btn001 close">关闭</a>
			</div>
		</div>
	</div>
	<%
		}
	%>
	<%
		String warringMessage = controller.getPrompt(request, response,
			PromptLevel.WARRING);
			if (!StringHelper.isEmpty(warringMessage)) {
	%>
	<div class="dialog w510 thickpos" style="margin: -80px 0 0 -255px;" id="warringDiv">
		<div class="dialog_close fr">
			<a href="#"></a>
		</div>
		<div class="con clearfix">
			<div class="d_perfect fl"></div>
			<div class="info fr">
				<p class="f20 gray33"><%
					if("余额不足".equals(warringMessage)){
				%>您的账户不足以本次还款，请<a href='<%=controller.getURI(request, Charge.class)%>'>充值</a>
				<%}else{%><%StringHelper.filterHTML(out,warringMessage);%><%} %></p>
			</div>
			<div class="clear"></div>
			<div class="dialog_btn">
				<a href="javascript:void(0);" class="btn btn001 close">关闭</a>
			</div>
		</div>
		<%
			}
		%>
	</div>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
	<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/repaying.js"></script>
	<script type="text/javascript">
		function showPayment(id) {
			$("#r"+id).show();
		}
		function closeDiv(id)
		{
			$("#r"+id).hide();
		}
		function confirmRepay(id) {
			$("#confirmBtn_" + id).hide();
			$("#confirmLoading_" + id).show();
		}
		$(".close").click(function() {
			$("#paymentDiv").hide();
			$("#errorDiv").hide();
			$("#warringDiv").hide();
		});
	</script>
</body>
</html>