<%@page import="com.dimeng.p2p.user.servlets.Index"%>
<%@page import="com.dimeng.p2p.modules.bid.user.service.entity.RepayInfo"%>
<%@page import="com.dimeng.p2p.modules.bid.user.service.entity.HkEntity"%>
<%@page import="com.dimeng.p2p.S62.entities.T6231"%>
<%@page import="com.dimeng.p2p.modules.bid.user.service.BidManage"%>
<%@page import="com.dimeng.p2p.modules.bid.user.service.entity.LoanCount"%>
<%@page import="com.dimeng.p2p.modules.bid.user.service.WdjkManage"%>
<%@page import="com.dimeng.framework.service.exception.LogicalException"%>
<%@page import="com.dimeng.framework.service.exception.ParameterException"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.dimeng.p2p.user.servlets.credit.LoanDetail"%>
<%@page import="com.dimeng.p2p.user.servlets.capital.Charge"%>
<%@page import="com.dimeng.p2p.user.servlets.credit.Payment"%>
<%@page import="com.dimeng.p2p.user.servlets.credit.AbstractCreditServlet"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<%@page import="com.dimeng.p2p.user.servlets.credit.PayOff"%>
<%@page import="com.dimeng.p2p.user.servlets.credit.Repaying"%>
<%@page import="com.dimeng.p2p.common.enums.RepayStatus"%>
<%@page import="com.dimeng.p2p.common.enums.CreditStatus"%>
<%@page import="java.text.DecimalFormat"%>
<%@include file="/WEB-INF/include/authenticatedSession.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title><%configureProvider.format(out,SystemVariable.SITE_NAME);%>_借款管理_我的借款</title>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<%
		WdjkManage manage = serviceSession.getService(WdjkManage.class);
		LoanCount loanCount = manage.getMyLoanCount();
		HkEntity[] repayLoans = manage.getHkzJk();
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
						借款总金额<br /> <span class="red"><%=Formater.formatAmount(loanCount.countMoney)%>元</span>
					</p>
				</div>
				<div class="hzcx_st fl"></div>
				<div class="fl">
					<ul class="hzcx_li pl40">
						<li>逾期金额<br><%=Formater.formatAmount(loanCount.overdueMoney)%>元
						</li>
						<li>待还金额<br><%=Formater.formatAmount(loanCount.repayMoney)%>元
						</li>
						<li>近30天应还金额<br><%=Formater.formatAmount(loanCount.newRepayMoney)%>元
						</li>
					</ul>
				</div>
			</div>
            <div class="container fr">
            <div class="mainDiv bor1">
            <!--理财管理 S-->
			  <div class="tb-state">
			  还款状态： <a class="butStyle" avalue="huikuan">还款中</a>
				     <a class="butStyle no" avalue="toubiaozhong" href="/user/credit/payOff.html">已还清</a>
			  </div>
		    </div>
            </div>
            
			<div class="w780 fr">
				<div>
					<div class="newsbox">
						<div class="til clearfix Men_bt">
						</div>
						<%
							if(repayLoans!=null&&repayLoans.length>0){
									for(HkEntity repayLoan : repayLoans){
										if(repayLoan==null){continue;}
								BidManage bidManage = serviceSession.getService(BidManage.class);
								 T6231 t6231 = bidManage.getExtra(repayLoan.F01);
								 BigDecimal yqje= bidManage.getYqje(repayLoan.F01);
						%>
						<div class="bs_bg pt10">
							<div class="border p15">
								<div class="mb10">
									<a href="javascript:void(0)" onclick="showPayment('<%=repayLoan.F01%>')" class="btn01 mb15 fr mr10">还款</a> 
									<span class="f20 pr30 blue">
										<a title="<%StringHelper.filterHTML(out, repayLoan.F03); %>" href="<%=configureProvider.format(URLVariable.FINANCING_SBTZ_XQ)%><%=repayLoan.F01 %><%=rewriter.getViewSuffix() %>">
											<%StringHelper.filterHTML(out, StringHelper.truncation(repayLoan.F03, 15)); %>
										</a>
									</span>
									<a target="_blank" href="<%=controller.getURI(request, com.dimeng.p2p.user.servlets.financing.agreement.Index.class) %>?id=<%=repayLoan.F01 %>" class="blue">查看合同</a>
								</div>
								<table width="100%" border="0" cellspacing="0" cellpadding="0" class="jk_table mb10">
									<tr>
										<td width="18%">借款金额</td>
										<td width="17%"><%=Formater.formatAmount(repayLoan.F05.subtract(repayLoan.F07))%>元</td>
										<td width="14%">年利率</td>
										<td width="14%"><%=Formater.formatRate(repayLoan.F06)%></td>
										<td width="12%">剩余期数</td>
										<td width="10%"><%=t6231.F03%>/<%=t6231.F02%>期</td>
										<td width="15%" align="right"><a href="<%=controller.getViewURI(request, LoanDetail.class)%>?id=<%=repayLoan.F01%>" class="blue">还款详情</a></td>
									</tr>
									<tr>
										<td>下个还款日</td>
										<td><%=DateParser.format(t6231.F06)%></td>
										<td>还款金额</td>
										<td><%=Formater.formatAmount(repayLoan.dqyhje)%>元</td>
										<td>状态</td>
										<td><%
											if(repayLoan.F20 !=null){
										%><%=repayLoan.F20.getChineseName()%><%
											}
										%></td>
										<td>&nbsp;</td>
									</tr>
								</table>
							</div>
						</div>
						<%
							}}else{
						%>
						<div align="center">没有记录</div>
						<%} %>
						<div class="clear"></div>
					</div>
				</div>
			</div>
			
			
			<div class="clear"></div>
		</div>
	</div>
	<%
		if(repayLoans!=null){
		for(HkEntity repayLoan : repayLoans){
		if(repayLoan==null){continue;}
			RepayInfo repayInfo= repayLoan.repayInfo;
			if(repayInfo!=null)
			{
	%>
	<div class="dialog d_error w510 thickpos" style="margin: -100px 0 0 -255px;display: none" id="r<%=repayInfo.loanID%>">
		<div class="dialog_close fr">
			<a href="javascript:void(0)"></a>
		</div>
		<div class="con clearfix">
			<div class="borrowing clearfix">
				<span class="fl"><i class="f20 gray33">当期还款总需:</i> <i class="red"><%=Formater.formatAmount(repayInfo.loanTotalMoney)%></i>元</span> <span class="fr">账户余额：<i class="red"><%=Formater.formatAmount(repayInfo.accountAmount)%>元</i></span>
			</div>
			<form action="<%=controller.getURI(request, Payment.class)%>" method="post">
				<input type="hidden" name="id" value="<%=repayInfo.loanID%>" />
				<input type="hidden" name="number" value="<%=repayInfo.number%>" />
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
					<input type="submit" class="btn btn001" value="确认扣费" onclick="confirmRepay(<%=repayInfo.loanID %>)"/><input type="button" onclick="closeDiv('<%=repayLoan.F01%>')" class="btn btn05 close" value="取 消" />
				</div>
				<div id="confirmLoading_<%=repayInfo.loanID %>" style="color:red; display: none; text-align:center;">
					正在处理，请稍候...
				</div>
			</form>
		</div>
	</div>
	<%
		}
		}
		}
	%>
	<%
		String errorMessage=controller.getPrompt(request, response,PromptLevel.ERROR);
		if(!StringHelper.isEmpty(errorMessage))
		{
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
				<a href="#" class="btn btn001 close">关闭</a>
			</div>
		</div>
	</div>
	<%
		}
	%>
	<%
		String warringMessage=controller.getPrompt(request,response, PromptLevel.WARRING);
		if(!StringHelper.isEmpty(warringMessage))
		{
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
				<a href="#" class="btn btn001 close">关闭</a>
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
			$("#errorDiv").hide();
			$("#warringDiv").hide();
		});
		
	</script>
</body>
</html>