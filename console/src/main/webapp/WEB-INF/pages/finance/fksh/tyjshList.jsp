<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.console.servlets.finance.fksh.TyjshListExport"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.fksh.NotnewLoanExpe"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.fksh.LoanNewExpemoney"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.fksh.TyjshList"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.fksh.NotLoan"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.fksh.NotLoanExpemoney"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.fksh.LoanExpemoney"%>
<%@page import="com.dimeng.p2p.modules.bid.console.service.entity.ExpemonyShen"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.tyjgl.KldhListExport"%>
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
		PagingResult<ExpemonyShen> result = (PagingResult<ExpemonyShen>) request
				.getAttribute("result");

BigDecimal sum1 = new BigDecimal(0);
BigDecimal sum2 = new BigDecimal(0);
String str1=request.getAttribute("bosummoeny").toString();
if(str1!=null){
	sum1 = new BigDecimal(str1);
}
String str2=request.getAttribute("fosummoney").toString();
if(str2!=null){
	sum2 = new BigDecimal(str2);
}
%>
<%
CURRENT_CATEGORY = "CWGL";
CURRENT_SUB_CATEGORY = "TYJGLNEW";
	%>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="w_main">
		<div class="main clearfix">
			<div class="wrap">
				<div class="r_main">
					<div class="home_main">
						<form action="<%controller.getURI(request,TyjshList.class);%>" method="post" name="form1" id="searchForm">
							<div class="box box1 mb15">
								<div class="atil">
									<h3>体验金管理</h3>
								</div>
								<div class="con">
									<div class="clear"></div>
									<ul class="yhxq_li">
										<li>借款总金额：<span class="blue"><%=Formater.formatAmount(sum1) %></span>
										</li>
									</ul>
									<ul class="yhxq_li">
										<li>放款总金额 ：<span class="blue"><%=Formater.formatAmount(sum2) %></span>
										</li>
									</ul>
									<div class="clear"></div>
								</div>
							</div>
							<div class="box box1 mb15">
								<div class="con">
									<div class="admin_input admin_pb">
             							<div class="table top3">
											<p>
												<span>借款账户：</span>
												<input type="text" name="userName" value="<%StringHelper.filterHTML(out, request.getParameter("userName")); %>" class="yhgl_input" />
											</p>
											<p>
												<span>放款日期：</span>
												<input type="text" readonly="readonly" name="createTimeStart" id="datepicker1" class="yhgl_input date" />至
											    <input type="text" readonly="readonly" name="createTimeEnd" id="datepicker2" class="yhgl_input date" />
											</p>
											<p>
												<span>标的编号：</span>
												<input type="text" name="randNum" value="<%StringHelper.filterHTML(out, request.getParameter("randNum")); %>" class="yhgl_input" />
											</p>
											<P>
												<span>审核结果：</span>
												<select id="nastatus" name="nastatus" class="text yhgl_ser input"  style="width: 80px;">
											        <option value="0">全部</option>
											        <option value="1">已审核</option>
											        <option value="2">未审核</option>
									             </select>
											</P>
											<P>
												<input name="search" type="submit" class="btn2" value="搜索" />
												<%if (dimengSession.isAccessableResource(TyjshListExport.class)) {%>
													<a href="javascript:void(0)" onclick="showExport()" class="btn3 mr10"><span class="ico"></span>导出</a>
												<%}else{ %>
													<span class="btn3 btn5 mr10"><span class="ico"></span>导出</span>
												<%} %> 
											</P>
									<div class="clear"></div>
								</div>
								</div>
								</div>
							</div>
							<table width="100%" border="0" cellspacing="0" cellpadding="3" class="yhgl_table tc">
								<tr class="hsbg">
									<td>序号</td>
									<td>标的编号</td>
									<td>标的名称</td>
									<td>放款日期</td>
									<td>借款账户</td>
									<td>姓名</td>
									<td>借款金额(元)</td>
									<td>借款期限</td>
									<td>预计回款时间</td>
									<td>放款人</td>
									<td>是否审核</td>
									<td>操作</td>
								</tr>
								<%
								
								ExpemonyShen[] items = result.getItems();
										if (items != null) {
											int i=1;
											for (ExpemonyShen excode: items) {
												if (excode == null) {
													continue;
												}
								%>
								<tr class="dhsbg">
									<td><%=i++%></td>
									<td><%=excode.id %></td>
									<td>
									   <%
										StringHelper.filterHTML(out,excode.title);
										%>
									</td>
									<td><%=excode.loantime==null?"":DateTimeParser.format(excode.loantime,"yyyy-MM-dd")%></td>
									<td><%=excode.account_name %></td>
									<td><%=excode.username %></td>
									<td><%=Formater.formatAmount(excode.borrmoney)%></td>
									<td><%=excode.borrterm%></td>
									<td><%=excode.repaymenttime==null?"":DateTimeParser.format(excode.repaymenttime,"yyyy-MM-dd")%></td>
									<td><%=excode.sysname==null?"":excode.sysname%></td>
									<td><%if(excode.lstatus==null) {%>
									                      未审核
									     <%}else{ %>
									                      已审核
									     <%} %>
									</td>
									<td align="center" class="blue">
										<%
											if (dimengSession.isAccessableResource(LoanNewExpemoney.class) && (excode.lstatus==null) && !(excode.estatus.equals("TBZ"))) {
										%>
										<a href="javascript:void(0)" onclick="load('<%=controller.getURI(request, LoanNewExpemoney.class)%>?id=<%=excode.id%>','<%=excode.title%>')">放款</a>
										<%}%>
										  
										
										<%
											if (dimengSession.isAccessableResource(NotnewLoanExpe.class) && (excode.lstatus==null)) {
										%>
										<a href="javascript:void(0)" onclick="notExcemonyLoad('<%=controller.getURI(request, NotnewLoanExpe.class)%>?id=<%=excode.id%>','<%=excode.title%>')">不放款</a>
										<%} %>
									
								</td>
									
									
								</tr>
								<%
									}
										}
								%>
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
		<div id="reasonDiv" style="display: none;">
		<div class="popup_bg"></div>
		<div class="popup add_information"
			style="width: 450px; margin: -70px 0 0 -225px; z-index: 99999; position: fixed; left: 50%; top: 50%; _position: absolute; _top: expression(200 +((   e =   document.documentElement.scrollTop)?e:document.body.scrollTop)+'px'); z-index: 100000;">
			<div class="til clearfix">
				<h2>不放款</h2>
				<div class="close">
					<a href="javascript:void(0)" class="close">关闭</a>
				</div>
			</div>
			<div class="con">
				<form action="<%=controller.getURI(request, NotLoan.class)%>" method="post">
					<input type="hidden" name="id" id="id" />
					
					<table class="jgzjcz_table" align="center">
						<tr>
							<td valign="top"><span>流标说明:</span></td>
							<td><textarea rows="4" cols="40" name="des"></textarea></td>
						</tr>
						<tr >
							<td colspan="2" align="center">
							<div style="width:193px;margin:auto;"><button type="submit" class="btn3 mr10">确认</button>
								<button type="button" class="btn5 close">取消</button></div></td>
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
		<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/txgl/fksh.js"></script>
	<%@include file="/WEB-INF/include/datepicker.jsp"%>
	<script type="text/javascript">
	$("#nastatus option[value="+<%=request.getParameter("nastatus")%>+"]").attr("selected",true);
	function showExport()
	{
		document.getElementById("searchForm").action ="<%=controller.getURI(request, TyjshListExport.class)%>";
		$("#searchForm").submit();
		document.getElementById("searchForm").action ="<%=controller.getURI(request, TyjshList.class)%>";
	}
	$(function() {
		$("#datepicker1").datepicker({inline: true});
	    $('#datepicker1').datepicker('option', {dateFormat:'yy-mm-dd'});
	    $("#datepicker2").datepicker({inline: true});
	    $('#datepicker2').datepicker('option', {dateFormat:'yy-mm-dd'});
	    $("#datepicker1").datepicker("setDate", "<%StringHelper.filterHTML(out, request.getParameter("createTimeStart"));%>");
	    $("#datepicker2").datepicker("setDate", "<%StringHelper.filterHTML(out, request.getParameter("createTimeEnd"));%>");
	});
	</script>
</body>
</html>
