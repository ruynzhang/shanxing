<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.console.servlets.finance.jgbyj.Tzxyd"%>
<%@page import="com.dimeng.p2p.modules.finance.console.service.entity.Jgfxbyj"%>
<%@page import="com.dimeng.util.Formater"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.AbstractFinanceServlet"%>
<%@page import="com.dimeng.p2p.modules.finance.console.service.entity.Jgxyjl"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<%
		Jgxyjl jgxyjl = ObjectHelper.convert(
				request.getAttribute("jgxyjl"), Jgxyjl.class);
		int id=IntegerParser.parse(request.getParameter("id"));
		Jgfxbyj jgfxbyj = ObjectHelper.convert(request.getAttribute("jgfxbyj"), Jgfxbyj.class);
		if(jgxyjl==null)
		{
			response.sendError(HttpServletResponse.SC_NOT_FOUND);
			return;
		}
%>
<%
	CURRENT_CATEGORY = "CWGL";
		CURRENT_SUB_CATEGORY = "JGFXBYJGL";
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
								<h3>机构信用记录</h3>
							</div>
							<div class="con">
								<div class="clear"></div>
								<ul class="yhxq_li">
									<li>机构名称：<span class="blue"><%StringHelper.filterHTML(out, jgfxbyj.organizationName); %></span>
									</li>
								</ul>
								<ul class="yhxq_li">
									<li>机构信用金额：<span class="blue"><%=Formater.formatAmount(jgfxbyj.organizationCreditAmount) %></span>元
									</li>
								</ul>
								<ul class="yhxq_li">
									<li>机构可用信用总额：<span class="blue"><%=Formater.formatAmount(jgfxbyj.organizationUsableAmount) %></span>元
									</li>
								</ul>
								<ul class="yhxq_li">
									<li>
										<%
											if (dimengSession.isAccessableResource(Tzxyd.class)) {
											%>
											<a href="javascript:void(0)" onclick="showTz()" class="btn3">调整信用额度</a>
											<%}else{ %>
											<span class="btn3 mr10 btn5 tc">调整信用额度</span>
											<%} %> 
									</li>
								</ul>
								<div class="clear"></div>
							</div>
						</div>
						<div class="clear"></div>
						<div class="box box1 mb15">
							<div class="con">
								<table width="100%" border="0" cellspacing="0" cellpadding="0" class="hwi">
									<tr>
										<td width="30%">申请借款（笔）：<%=jgxyjl.sqjkCount %></td>
										<td width="40%">信用额度（元）：<%=Formater.formatAmount(jgfxbyj.organizationCreditAmount) %></td>
										<td width="30%">逾期金额（元）：<%=Formater.formatAmount(jgxyjl.yqjeAmount) %></td>
									</tr>
									<tr>
										<td>成功借款（笔）：<%=jgxyjl.cgjkCount %></td>
										<td>借款总额（元）：<%=Formater.formatAmount(jgxyjl.jkTotalAmount) %></td>
										<td>逾期次数（次）：<%=jgxyjl.yqcsCount %></td>
									</tr>
									<tr>
										<td>还清笔数（笔）：<%=jgxyjl.hqbsCount %></td>
										<td>待还本金（元）：<%=Formater.formatAmount(jgxyjl.dhbjAmount) %></td>
										<td>严重逾期（笔）：<%=jgxyjl.yzyqCount %></td>
									</tr>
								</table>
								<div class="clear"></div>
							</div>
						</div>
						<div class="box2 clearfix"></div>
					</div>
				</div>
			</div>
			<%@include file="/WEB-INF/include/left.jsp"%>
		</div>
	</div>
	<div id="tzDiv" style="display: none;">
		<div class="popup_bg"></div>
		<div class="popup add_information"
			style="width: 380px; margin: -70px 0 0 -225px; height: 200px; z-index: 99999; position: fixed; left: 50%; top: 50%; _position: absolute; _top: expression(200 +((   e =   document.documentElement.scrollTop)?e:document.body.scrollTop)+'px'); z-index: 100000;">
			<div class="til clearfix">
				<h2>调整信用额度</h2>
				<div class="close">
					<a href="javascript:void(0)" class="close">关闭</a>
				</div>
			</div>
			<div class="con">
				<form action="<%=controller.getURI(request, Tzxyd.class)%>" method="post" class="tzForm">
					<input type="hidden" name="id" value="<%=id %>" />
					<table class="jgzjcz_table">
						<tr>
							<td>可用信用额度:</td>
							<td><%=Formater.formatAmount(jgfxbyj.organizationUsableAmount)%></td>
						</tr>
						<tr><td>调整可用信用额度:</td><td>
							<input type="text"  name="ammount" class="yhgl_input required max-length-10" mtest="/^[-\+]?\d+(\.\d+)?$/" mtestmsg="金额格式不正确"/>
							<p tip></p>
							<p errortip class="" style="display: none"></p></td></tr>
						<tr>
							<td colspan="2">
								
									<button type="submit" class="btn3 sumbitForme mr10 ml50" fromname="tzForm">确认</button>
									<button type="button" class="btn5 close">取消</button>
								
							</td>
						</tr>
					</table>
				</form>
			</div>
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
	<script type="text/javascript"
		src="<%=controller.getStaticPath(request)%>/js/validation.js"></script>
	<script type="text/javascript">
	function showTz()
	{
		$("#tzDiv").show();
	}
	$(".close").click(function() {
		$("#tzDiv").hide();
	});
	</script>
</body>
</html>