<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.math.BigDecimal"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.fksh.ViewProject"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.fksh.SxbaoLoan"%>
<%@page import="com.dimeng.p2p.console.servlets.AbstractConsoleServlet"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.fksh.SxbaofkList"%>
<%@page import="com.dimeng.p2p.S62.entities.SxbaoFksh"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<%
	PagingResult<SxbaoFksh> result = (PagingResult<SxbaoFksh>) request.getAttribute("result");
%>
<%
		CURRENT_CATEGORY = "CWGL";
		CURRENT_SUB_CATEGORY = "SXBAOFKGL";
%>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="w_main">
		<div class="main clearfix">
			<div class="wrap">
				<div class="r_main">
					<form action="<%=controller.getURI(request, SxbaofkList.class)%>" name="form1" method="post" id="searchForm">
					<div class="home_main">
						<div class="box box1 mb15">
							<div class="atil">
								<h3>善行宝放款审核</h3>
							</div>
						</div>
						<table width="100%" border="0" cellspacing="0" cellpadding="3" class="yhgl_table">
							<tr class="hsbg">
								<td align="center">序号</td>
								<td align="center">借款ID</td>
								<td align="center">借款标题</td>
								<td align="center">借款账户</td>
								<td align="center">投资金额(元)</td>
								<td align="center">年利率</td>
								<td align="center">期限</td>
								<td align="center">还款方式</td>
								<td align="center">发布时间</td>
								<td align="center">操作</td>
							</tr>
							<%
							SxbaoFksh[] fkshs = result.getItems();
									if (fkshs != null) {
										int i = 1;
										for (SxbaoFksh fksh : fkshs) {
											if (fksh == null) {
												continue;
											}
							%>
							<tr class="dhsbg">
								<td align="center"><%=i++%></td>
								<td align="center"><%=fksh.bid%></td>
								<td title="<%StringHelper.filterHTML(out, fksh.title);%>">
                   					<%StringHelper.filterHTML(out, fksh.title);%>
								</td>
								<td align="center">
									<%
										StringHelper.filterHTML(out, fksh.loanerName);
									%>
								</td>
								<td align="center">
									<%=Formater.formatAmount(fksh.investAmount)%>
								</td>
								<td align="center">
									<%=Formater.formatRate(fksh.rate)%>
								</td>
								<td align="center">
									<%=fksh.loanPeriod%>个月
								</td>
								<td align="center">
									<%=fksh.mode.getChineseName()%>
								</td>
								<td align="center"><%=DateTimeParser.format(fksh.publishTime,"yyyy-MM-dd HH:mm")%></td>
								<td align="center" class="blue">
									<%
									if (dimengSession.isAccessableResource(ViewProject.class)) {
									%>
									<a href="<%=controller.getURI(request, ViewProject.class)%>?loanId=<%=fksh.bid%>&userId=<%=fksh.loaner%>&url=<%=controller.getURI(request, SxbaofkList.class)%>" class="blue">查看</a>
									<%}else{ %>
									<span class="gray6">查看</span>
									<%} %>
									<%
									if (fksh.investAmount.compareTo(BigDecimal.ZERO) > 0 && dimengSession.isAccessableResource(SxbaoLoan.class)) {
									%>
									<a href="javascript:void(0)" onclick="load('<%=controller.getURI(request, SxbaoLoan.class)%>?id=<%=fksh.bid%>','<%=fksh.title%>')">放款</a>
									<%}else{ %>
									<span class="gray6">放款</span>
									<%} %>
									<!-- <a href="javascript:void(0)" onclick="notLoad('<%=fksh.bid%>')">不放款</a> -->
								</td>
							</tr>
							<%
								}
									}else{
							%>
							<tr><td colspan="11"></td></tr>
							<%} %>
						</table>
						<%
							AbstractConsoleServlet.rendPagingResult(out, result);
						%>
						<div class="box2 clearfix"></div>
					</div>
					</form>
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
				<form action="" method="post">
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
	<script type="text/javascript">
		function load(url,title)
		{
			if (!window.confirm("是否确认要对“"+title+"”善行宝执行放款？")) {
				return;
			}
			location.href=url;
		}
		function notLoad(id)
		{
			$("#id").attr("value", id);
			$("#reasonDiv").show();
		}
		$(".close").click(function() {
			$("#reasonDiv").hide();
		});
	
		function notExcemonyLoad(url,title)
		{
			if (!window.confirm("是否确认要对“"+title+"”借款执行不放款操作？")) {
				return;
			}
			location.href=url;
		};
	</script>
</body>
</html>