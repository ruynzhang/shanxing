
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.S62.enums.T6230_F13"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.fksh.ExportCjRecord"%>
<%@page import="com.dimeng.p2p.modules.bid.console.service.entity.CjRecord"%>
<%@page import="com.dimeng.util.Formater"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="com.dimeng.p2p.console.servlets.AbstractConsoleServlet"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.fksh.CjRecordList"%>
<%@page import="com.dimeng.p2p.S62.enums.T6231_F21"%>
<%@page import="com.dimeng.p2p.S62.entities.T6230"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<%
	PagingResult<CjRecord> result = (PagingResult<CjRecord>) request.getAttribute("result");
	BigDecimal totalAmount=ObjectHelper.convert(request.getAttribute("totalAmount"), BigDecimal.class);
	BigDecimal totalFkAmount=ObjectHelper.convert(request.getAttribute("totalFkAmount"), BigDecimal.class);
%>
<%
	CURRENT_CATEGORY = "CWGL";
	CURRENT_SUB_CATEGORY = "FKGL";
%>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="w_main">
		<div class="main clearfix">
			<div class="wrap">
				<div class="r_main">
					<form action="<%=controller.getURI(request, CjRecordList.class)%>" name="form1" method="post" id="searchForm">
						<div class="home_main">
							<div class="box box1 mb15">
								<div class="atil">
									<h3>成交记录</h3>
								</div>
								<div class="con">
									<div class="clear"></div>
									<ul class="yhxq_li">
										<li>借款总金额：<span class="blue"><%=Formater.formatAmount(totalAmount)%></span>元
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										放款总金额：<span class="blue"><%=Formater.formatAmount(totalFkAmount)%></span>元
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
											<span>借款账号:</span>
											<input type="text" name="loanName" value="<%StringHelper.filterHTML(out, request.getParameter("loanName"));%>" class="yhgl_input" />
										</p>
									<p>
										<span>放款时间：</span>
										<input type="text" id="datepicker1" name="startTime" readonly="readonly" class="yhgl_input date" value="<%StringHelper.filterHTML(out, request.getParameter("startTime"));%>" />至
										<input type="text" name="endTime" id="datepicker2" readonly="readonly" value="<%StringHelper.filterHTML(out, request.getParameter("endTime"));%>" class="yhgl_input date" />
									</p>
									<div class="clear"></div>
									<div class="mt10">   
                    					<input name="search" type="submit" class="btn2 mr10" value="查找" />
                   						<%if (dimengSession.isAccessableResource(ExportCjRecord.class)) {%>
											<a href="javascript:void(0)" onclick="showExport()" class="btn3 mr10"><span class="ico"></span>导出</a>
										<%}else{ %>
											<span class="btn3 btn5 mr10"><span class="ico"></span>导出</span>
										<%} %> 
                   					</div>               	
								<div class="clear"></div>
								</div>
								</div>
								</div>
							</div>
							<table width="100%" border="0" cellspacing="0" cellpadding="3" class="yhgl_table tc">
								<tr class="hsbg">
									<td>序号</td>
									<td>放款时间</td>
									<td>借款账户</td>
									<td>借款ID</td>
									<td>借款金额(元)</td>
									<td>投标金额(元)</td>
									<td>借款期限</td>
									<td>放款人</td>
								</tr>
								<%
									CjRecord[] records=result.getItems();
										if(records!=null)
										{
											int i=1;
											for(CjRecord record:records)
											{
												if(record==null)
												{
													continue;
												}
								%>
								<tr class="dhsbg">
									<td><%=i++%></td>
									<td><%=DateTimeParser.format(record.fkTime,"yyyy-MM-dd HH:mm")%></td>
									<td><%StringHelper.filterHTML(out,record.accountName);%></td>
									<td><%=record.F25%></td>
									<td><%=record.isSxbao == T6230_F13.F?Formater.formatAmount(record.F05):record.F03%></td>
									<td><%=Formater.formatAmount(record.F05.subtract(record.F07))%></td>
									<td>
										<% if(record.F28.F21 == T6231_F21.F){ %>
											<%=record.days%>个月
										<%}else{ %>
											<%=record.F28.F22 %>天
										<%} %>
									
									</td>
									<td><%StringHelper.filterHTML(out, record.fkName); %></td>
								</tr>
								<%
									}}else{
								%>
								<tr>
									<td colspan="9"></td>
								</tr>
								<%
									}
								%>
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
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
	<%@include file="/WEB-INF/include/datepicker.jsp"%>
	<script type="text/javascript">
		function showExport()
		{
			document.getElementById("searchForm").action ="<%=controller.getURI(request, ExportCjRecord.class)%>";
			$("#searchForm").submit();
			document.getElementById("searchForm").action ="<%=controller.getURI(request, CjRecordList.class)%>";
		}
		$(function() {
			$("#datepicker1").datepicker({inline: true});
		    $('#datepicker1').datepicker('option', {dateFormat:'yy-mm-dd'});
		    $("#datepicker2").datepicker({inline: true});
		    $('#datepicker2').datepicker('option', {dateFormat:'yy-mm-dd'});
		    $("#datepicker1").datepicker("setDate", "<%StringHelper.filterHTML(out, request.getParameter("startTime"));%>");
		    $("#datepicker2").datepicker("setDate", "<%StringHelper.filterHTML(out, request.getParameter("endTime"));%>");
		});
	</script>
</body>
</html>