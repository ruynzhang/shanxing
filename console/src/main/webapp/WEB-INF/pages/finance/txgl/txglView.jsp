<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.S61.enums.T6130_F09"%>
<%@page import="com.dimeng.p2p.S61.enums.T6131_F07"%>
<%@page import="com.dimeng.p2p.modules.account.console.service.entity.Bank"%>
<%@page import="com.dimeng.p2p.modules.account.console.service.entity.UserWithdrawals"%>
<%@page import="com.dimeng.util.Formater"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.txgl.Txsb"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.AbstractFinanceServlet"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.txgl.ExportTxgl"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.txgl.Check"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<%
		UserWithdrawals txglRecord = ObjectHelper.convert(
				request.getAttribute("txglRecord"), UserWithdrawals.class);
		Bank[] banks = ObjectHelper.convertArray(
				request.getAttribute("banks"), Bank.class);
		if(txglRecord==null)
		{
			response.sendError(HttpServletResponse.SC_NOT_FOUND);
			return;
		}
%>
<%
		CURRENT_CATEGORY = "CWGL";
			CURRENT_SUB_CATEGORY = "TXGL";
	%>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="w_main">
		<div class="main clearfix">
			<div class="wrap">
				<div class="r_main">
					<div class="home_main">
						<div class="box box1 mb15">
							<div class="atil">
								<h3>审核原因</h3>
							</div>
							<div class="con">
								<div class="clear"></div>
								<form>
									<ul class="cell noborder yw_jcxx">
													<li>
											<div class="til">流水号：</div>
											<div class="info"><%=txglRecord.F01%></div>
											<div class="clear"></div>
										</li>
										<li>
											<div class="til">用户名：</div>
											<div class="info">
											<%StringHelper.filterHTML(out, txglRecord.userName);%>
											</div>
											<div class="clear"></div>
										</li>
										<li>
											<div class="til">真实姓名：</div>
											<div class="info">	
												<%StringHelper.filterHTML(out, txglRecord.realName);%>
											</div>
											<div class="clear"></div>
										</li>
										<li>
											<div class="til">提现银行：</div>
											<div class="info">	
												<%StringHelper.filterHTML(out, txglRecord.extractionBank);%>
											</div>
											<div class="clear"></div>
										</li>
										<li>
											<div class="til">开户地：</div>
											<div class="info">	
												<%StringHelper.filterHTML(out, txglRecord.location);%>
											</div>
											<div class="clear"></div>
										</li>
										<li>
											<div class="til">所在支行：</div>
											<div class="info">	
												<%
													StringHelper.filterHTML(out, txglRecord.subbranch);
												%>
											</div>
											<div class="clear"></div>
										</li>
										<li>
											<div class="til">银行卡账号：</div>
											<div class="info">	
												<%
													StringHelper.filterHTML(out, StringHelper.decode(txglRecord.bankId));
												%>
											</div>
											<div class="clear"></div>
										</li>
										<li>
											<div class="til">提现金额：</div>
											<div class="info">	
												<%=Formater.formatAmount(txglRecord.F04)%>元
											</div>
											<div class="clear"></div>
										</li>
										<li>
											<div class="til">手续费：</div>
											<div class="info">	
												<%=Formater.formatAmount(txglRecord.F07)%>元
											</div>
											<div class="clear"></div>
										</li>
										<li>
											<div class="til">申请时间：</div>
											<div class="info">	
												<%=DateTimeParser.format(txglRecord.F08,"yyyy-MM-dd HH:mm")%>
											</div>
											<div class="clear"></div>
										</li>
										<li>
											<div class="til">审核时间：</div>
											<div class="info">	
												<%=DateTimeParser.format(txglRecord.F11,"yyyy-MM-dd HH:mm")%>
											</div>
											<div class="clear"></div>
										</li>
										<li>
											<div class="til">审核人：</div>
											<div class="info">	
												<%StringHelper.filterHTML(out, txglRecord.shName);%>
											</div>
											<div class="clear"></div>
										</li>
										<li>
											<div class="til">审核意见：</div>
											<div class="info">	
											<%
												StringHelper.filterHTML(out, txglRecord.F12);
											%>
											</div>
											<div class="clear"></div>
										</li>
										<li>
											<div class="til">放款时间：</div>
											<div class="info">	
											<%=DateTimeParser.format(txglRecord.F14,"yyyy-MM-dd HH:mm")%>
											</div>
											<div class="clear"></div>
										</li>
										<li>
											<div class="til">放款人：</div>
											<div class="info">	
											<%
												StringHelper.filterHTML(out, txglRecord.txName);
											%>
											</div>
											<div class="clear"></div>
										</li>
										<li>
											<div class="til">放款意见：</div>
											<div class="info">	
											<%
												StringHelper.filterHTML(out, txglRecord.F15);
											%>
											</div>
											<div class="clear"></div>
										</li>
									</ul>
									<div class="tc w220 pt20">
										<%if(txglRecord.F09==T6130_F09.TXSB){ %>
										<a href="<%=controller.getURI(request, Txsb.class)%>" class="btn3">关闭</a>
										<%} %>
									</div>
									<div class="clear"></div>
								</form>
								<div class="clear"></div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<%@include file="/WEB-INF/include/left.jsp"%>
		</div>
	</div>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
	<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/txgl/withdrawals.js"></script>
</body>
</html>