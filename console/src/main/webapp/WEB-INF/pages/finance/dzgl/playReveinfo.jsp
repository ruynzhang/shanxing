<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.FeeCode"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.dzgl.PlayReveinfoExport"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.dzgl.PlayReveinfo"%>
<%@page import="com.dimeng.p2p.modules.bid.console.service.entity.PlayReveentity"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="com.dimeng.util.Formater"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.AbstractFinanceServlet"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<%@page import="com.dimeng.p2p.console.servlets.AbstractConsoleServlet"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<%
		PagingResult<PlayReveentity> result = (PagingResult<PlayReveentity>) request
				.getAttribute("result");
%>
<%
CURRENT_CATEGORY = "CWGL";
CURRENT_SUB_CATEGORY = "PLAYREVEINFO";
	%>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="w_main">
		<div class="main clearfix">
			<div class="wrap">
				<div class="r_main">
					<div class="home_main">
						<form action="<%controller.getURI(request,PlayReveinfo.class);%>" method="post" name="form1" id="searchForm">
							<div class="box box1 mb15">
							    <div class="atil">
									<h3>平台收益明细</h3>
								</div>
								<div class="con">
									<div class="admin_input admin_pb">
             							<div class="table top3">
             							    <p>
												<span>用户名：</span>
												<input type="text" name="randNum" value="<%StringHelper.filterHTML(out, request.getParameter("randNum")); %>" class="yhgl_input" />
											</p>
											<p>
												<span>姓名：</span>
												<input type="text" name="userName" value="<%StringHelper.filterHTML(out, request.getParameter("userName")); %>" class="yhgl_input" />
											</p>
											<p>
												<span>业务发生时间：</span>
												<input type="text" readonly="readonly" name="createTimeStart" id="datepicker1" class="yhgl_input date" />至
											    <input type="text" readonly="readonly" name="createTimeEnd" id="datepicker2" class="yhgl_input date" />
											</p>
											
											<P>
												<input name="search" type="submit" class="btn2" value="搜索" />
												<%if (dimengSession.isAccessableResource(PlayReveinfoExport.class)) {%>
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
									<td>资金账号</td>
									<td>用户名</td>
									<td>姓名</td>
									<td>用户类型</td>
									<td>收益类型</td>
									<td>公司收益(元)</td>
									<td>业务发生时间</td>
								</tr>
								<%
								
								PlayReveentity[] items = result.getItems();
										if (items != null) {
											int i=1;
											for (PlayReveentity excode: items) {
												if (excode == null) {
													continue;
												}
								%>
								<tr class="dhsbg">
									<td><%=i++%></td>
									<td><%=excode.ass_acount %></td>
									<td><%=excode.login_account %></td>
									<td><%=excode.username==null?"":excode.username %></td>
									<td><%=excode.stype.equals("ZRR")?"个人":"" %></td>
									<td><%=FeeCode.getChineseName(Integer.valueOf(excode.inttype))%></td>
									<td><%=Formater.formatAmount(excode.inmoney)%></td>
									<td><%=excode.gettime==null?"":DateTimeParser.format(excode.gettime,"yyyy-MM-dd HH:mm:ss")%></td>
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
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
	<%@include file="/WEB-INF/include/datepicker.jsp"%>
	<script type="text/javascript">
	$("#nastatus option[value="+<%=request.getParameter("nastatus")%>+"]").attr("selected",true);
	function showExport()
	{
		document.getElementById("searchForm").action ="<%=controller.getURI(request, PlayReveinfoExport.class)%>";
		$("#searchForm").submit();
		document.getElementById("searchForm").action ="<%=controller.getURI(request, PlayReveinfo.class)%>";
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
