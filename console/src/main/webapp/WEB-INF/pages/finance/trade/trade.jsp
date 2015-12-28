<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.console.servlets.finance.trade.TradeUtils"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.trade.UpdTrade"%>
<%@page import="com.dimeng.p2p.modules.account.console.service.entity.TradeVo"%>
<%@page import="com.dimeng.p2p.modules.account.console.service.entity.UserWithdrawals"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.trade.Trade"%>
<%@page import="com.dimeng.p2p.S61.enums.T6130_F09"%>
<%@page import="com.dimeng.util.Formater"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.AbstractFinanceServlet"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>

<style type="text/css">
	.yhgl_inputtext{ background:#fff; border:1px #d7dfe3 solid; height:23px; line-height:23px; width:175px;}
	.input {margin-left: 5px;} 
</style>
</head>
<%
CURRENT_CATEGORY = "CWGL";
CURRENT_SUB_CATEGORY = "TRADELIST";
TradeVo vo=(TradeVo)request.getAttribute("tradeVo");
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
								<h3>转账管理</h3>
							</div> 
						<div class="con">
							<div class="admin_input admin_pb">
							<form action="<%=controller.getURI(request, UpdTrade.class)%>" method="post" class="form1" id="form1"  onsubmit="return onSumbit();">
								<ul class="cell noborder no_wi">
			                    <li>
			                        <div class="til">支出用户名：</div>
			                        <div class="info">
			                      		平台账户
			                        </div>
			                        <div class="clear"></div>
			                    </li>
			                    <li>
			                        <div class="til">剩余金额：</div>
			                        <div class="info input" id="outAmount"><%=Formater.formatAmount(vo.outAmount)%>元</div>
			                        <div class="clear"></div>
			                    </li>
			                      <li>
			                        <div class="til">收入用户名：</div>
			                        <div class="info">
										<input type="text" class="text yhgl_ser input"  id="inName" name="inName"/>
									</div>
			                        <div class="clear"></div>
			                    </li>
			                   <li>
								<div class="til">
									<span class="red">*</span>转账金额：
								</div>
								<div class="info">
									<input type="text" class="text yhgl_ser input"  id="t_amount" name="t_amount"/>
									<span>&nbsp;保留2位小数</span>
								</div>
									<div class="clear"></div>
								</li>
								<li>
			                        <div class="til">备注：</div>
			                        <div class="info">
										<input type="text" class="text yhgl_ser input"  id="remark" name="remark"/>
									</div>
			                        <div class="clear"></div>
			                    </li>
								<li>
									<div class="til">
										操作：
									</div>
									<div class="info"> 
									 <input id="post_url" type="hidden" value="<%=controller.getURI(request, Trade.class)%>"/> 
									 <input type="submit" class="btn4 input" value="转账"/><a href="<%=controller.getURI(request, TradeList.class)%>" class="btn3 mr10" style="margin-left: 10px;"><span style="margin-left: 25px;">返回</span></a> 
									</div>
			                        <div class="clear"></div>
			                    </li>
			                    </ul>
			                    </form>      
							</div>
						</div>
						<div>
						</div> 
						</div>
					</div>
				</div>
			</div>
	<%
		String warringMessage=controller.getPrompt(request, response, PromptLevel.ERROR);
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
			<%@include file="/WEB-INF/include/left.jsp"%>
		</div>
	</div>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
	<script type="text/javascript">
	 var reg = /^\d*(\d|(\.[0-9]{1}|\.[0-9]{2}))$/;     
	 function checkAmout(){
			var val=$("#t_amount").val();
			if(!val.match(reg)){
				alert("请正确输入转账的金额!");
				return;
			}
			return true;
	 }
	function onSumbit(){
		if(checkAmout()){
			return true;
		}
		return false;
	}
	</script>
</body>
</html>