<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.S61.enums.T6130_F09"%>
<%@page import="com.dimeng.p2p.modules.account.console.service.entity.UserWithdrawals"%>
<%@page import="com.dimeng.util.Formater"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.txgl.CheckWithdraw"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.txgl.Shtg"%>
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
					<form action="<%=controller.getURI(request, CheckWithdraw.class)%>" method="post" id="form1">
						<input type="hidden" name="id" value="<%=txglRecord.F01%>"> <input type="hidden" name="status" id="status">
						<div class="home_main">
							<div class="box box1 mb15">
								<div class="atil">
									<h3>放款审核</h3>
								</div>
								<div class="con">
									<div class="clear"></div>
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
												<%StringHelper.filterHTML(out, txglRecord.subbranch);%>
											</div>
											<div class="clear"></div>
										</li>
										<li>
											<div class="til">银行卡账号：</div>
											<div class="info">	
												<%StringHelper.filterHTML(out, StringHelper.decode(txglRecord.bankId));%>
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
												<%=Formater.formatDateTime(txglRecord.F08)%>
											</div>
											<div class="clear"></div>
										</li>
										<li>
											<div class="til">审核时间：</div>
											<div class="info">	
												<%=Formater.formatDateTime(txglRecord.F11)%>
											</div>
											<div class="clear"></div>
										</li>
										<li>
											<div class="til">&nbsp;</div>
											<div class="info">	
												<textarea cols="50" rows="6" id="reason" name="check_reason">如不通过需填写具体原因</textarea>
											</div>
											<div class="clear"></div>
										</li>
									</ul>
									<div class="tc pt20" style="width:360px;margin:auto">
										<a href="javascript:void(0)" onclick="check('<%=T6130_F09.YFK.name()%>')" class="btn3 mr10">提现成功</a>
										<a href="javascript:void(0)" onclick="check('<%=T6130_F09.TXSB.name()%>')" class="btn3 mr10">提现失败</a>
										<a href="<%=controller.getURI(request, Shtg.class)%>" class="btn5 mr30">取消</a>
									</div>
									<div class="clear"></div>
								</div>
							</div>
						</div>
					</form>
				</div>
			</div>
			<%@include file="/WEB-INF/include/left.jsp"%>
		</div>
	</div>
	<%
		String warringMessage=controller.getPrompt(request, response, PromptLevel.WARRING);
		if(!StringHelper.isEmpty(warringMessage))
		{
	%>
	<div class="w440 thickbox thickpos" style="margin:-80px 0 0 -220px;" id="showDiv">
      <div class="info clearfix">
        <div class="clearfix">
            <span class="fl tips"><%StringHelper.filterHTML(out, warringMessage); %></span>
        </div>
        <div class="dialog_btn"><input type="button" name="button2" onclick="$('#showDiv').hide()" value="确认"  class="btn4 ml50"/></div> 
      </div>
	</div>
	<%} %>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
	<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/txgl/withdrawals.js"></script>
	<script type="text/javascript">
		reason();
		$("#reason").focus(function() {
			$("#reason").attr("value", "");
			$("#reason").css("color", "");
		});
		$("#reason").blur(function() {
			reason();
		});
		function reason() {
			var reason = $("#reason").val();
			if (reason == "") {
				$("#reason").attr("value", "如不通过需填写具体原因");
				$("#reason").css("color", "gray");
			} else if (reason == '如不通过需填写具体原因') {
				$("#reason").css("color", "gray");
			}
		}
		function check(status) {
			var reason = $("#reason").val();
			$("#status").attr("value", status);
			if (status =='<%=T6130_F09.TXSB%>' && (reason == "" || reason == '如不通过需填写具体原因')) {
				alert("请填写不通过的原因!");
				return;
			} else if (status == '<%=T6130_F09.YFK%>' && reason == '如不通过需填写具体原因') {
				$("#reason").attr("value", "");
			}
			if(reason.length > 100){
				alert("小于输入限制100，当前长度为"+reason.length);
				return;
			}
			$("#form1").submit();
		}
	</script>
</body>
</html>