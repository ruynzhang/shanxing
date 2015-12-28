<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.console.servlets.bid.tyjgl.SerialdhListExport"%>
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
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<%
		//BigDecimal czze = ObjectHelper.convert(request.getAttribute("czze"),BigDecimal.class);
		//BigDecimal czsxf = ObjectHelper.convert(request.getAttribute("czsxf"),BigDecimal.class);
		PagingResult<ExpemoneyCode> result = (PagingResult<ExpemoneyCode>) request
				.getAttribute("result");
%>
<%
		CURRENT_CATEGORY = "YWGL";
			CURRENT_SUB_CATEGORY = "XHDH";
	%>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="w_main">
		<div class="main clearfix">
			<div class="wrap">
				<div class="r_main">
					<div class="home_main">
						<form action="<%controller.getURI(request, SerialdhList.class);%>" method="post" name="form1" id="searchForm">
							<div class="box box1 mb15">
								<div class="atil">
									<h3>序号兑换</h3>
								</div>
								<div class="con">
									<div class="clear"></div>
									<ul class="yhxq_li">
										<li>兑换人数：<span class="blue"><%=request.getAttribute("expenum") %></span>
										</li>
									</ul>
									<ul class="yhxq_li">
										<li>未兑换人数 ：<span class="blue"><%=request.getAttribute("notexpenum") %></span>
										</li>
									</ul>
									<ul class="yhxq_li">
										<li>兑换总额 ：<span class="blue"><%=request.getAttribute("expesumme") %></span>
										</li>
									</ul>
									<ul class="yhxq_li">
										<li>实名人数 ：<span class="blue"><%=request.getAttribute("relcodename") %></span>
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
												<span>活动序号：</span>
												<input type="text" name="randNum" value="<%StringHelper.filterHTML(out, request.getParameter("randNum")); %>" class="yhgl_input" />
											</p>
											<p>
												<span>兑换时间：</span>
												<input type="text" readonly="readonly" name="createTimeStart" id="datepicker1" class="yhgl_input date" />至
											    <input type="text" readonly="readonly" name="createTimeEnd" id="datepicker2" class="yhgl_input date" />
											</p>
											<p>
												<span>用户账号：</span>
												<input type="text" name="userName" value="<%StringHelper.filterHTML(out, request.getParameter("userName")); %>" class="yhgl_input" />
											</p>
											<P>
												<span>是否兑换：</span>
												<select id="nastatus" name="nastatus" class="text yhgl_ser input"  style="width: 80px;">
											        <option value="0">全部</option>
											        <option value="1">已兑换</option>
											        <option value="2">未兑换</option>
									             </select>
											</P>
											<P>
												<input name="search" type="submit" class="btn2" value="搜索" />
												<%if (dimengSession.isAccessableResource(SerialdhListExport.class)) {%>
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
									<td>活动序号</td>
									<td>用户账号</td>
									<td>真实姓名</td>
									<td>兑换时间</td>
									<td>是否实名认证</td>
								</tr>
								<%
								    ExpemoneyCode[] items = result.getItems();
										if (items != null) {
											int i=1;
											for (ExpemoneyCode excode: items) {
												if (excode == null) {
													continue;
												}
								%>
								<tr class="dhsbg">
									<td><%=i++%></td>
									<td><%=excode.randNum %></td>
									<td>
									   <%
										StringHelper.filterHTML(out,excode.user_name);
										%>
									</td>
									<td><%
											StringHelper.filterHTML(out,excode.relname);
										%></td>
									<td><%=DateTimeParser.format(excode.expiryTime)%></td>
									<td><%if("TG".equals(excode.flag)) {%>
									                    是
									     <%}else{ %>
									                    否 
									     <%} %>
									</td>
									
									
								</tr>
								<%
									}
										}
								%>
							</table>
							<%
							    SerialdhList.rendPagingResult(out, result);
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
		document.getElementById("searchForm").action ="<%=controller.getURI(request, SerialdhListExport.class)%>";
		$("#searchForm").submit();
		document.getElementById("searchForm").action ="<%=controller.getURI(request, SerialdhList.class)%>";
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
