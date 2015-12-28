<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.console.servlets.system.operlog.OperLogList"%>
<%@page import="com.dimeng.p2p.modules.systematic.console.service.entity.OperLog"%>
<%@page import="com.dimeng.p2p.console.servlets.AbstractConsoleServlet"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>

</head>
<body>
	<%
		PagingResult<OperLog> result = (PagingResult<OperLog>) request.getAttribute("result");
	%>
	<%
		CURRENT_CATEGORY = "XTGL";
			CURRENT_SUB_CATEGORY = "HTCZRZ";
	%>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="w_main">
		<div class="main clearfix">
			<div class="wrap">
				<div class="r_main">
					<form action="<%=controller.getURI(request, OperLogList.class)%>" method="post">
						
					
		                   
						<div class="home_main">
							<div class="box box1 mb15">
							<div class="atil">
	              				<h3>后台操作日志</h3>
	           				 </div>
			                  <div class="con">
									 <div class="admin_input">
					                     <p>管理员：<input type="text" name="name" value="<%StringHelper.filterQuoter(out,
									request.getParameter("name"));%>" id="textfield" class="yhgl_input" /></p>
					                     <p>时间：<input type="text" name="createTimeStart" id="datepicker1" readonly="readonly" class="yhgl_input date" value="<%StringHelper.filterQuoter(out,
									request.getParameter("createTimeStart"));%>" />
					                       <span class="mr5">至</span>
					                       <input type="text" name="createTimeEnd" id="datepicker2" readonly="readonly" class="yhgl_input date" value="<%StringHelper.filterQuoter(out,
									request.getParameter("createTimeEnd"));%>" />
					                     </p>
					                     <p><button type="submit" class="btn2 fl mr10">查找</button></p>
					                     <div class="clear"></div>
					                   </div>
					            </div>
			                 </div>
			                    
							<div>
								<table width="100%" border="0" cellspacing="0" cellpadding="3" class="yhgl_table tc">
									<tr class="hsbg">
										<td>序号</td>
										<td>管理员</td>
										<td>操作时间</td>
										<td>访问IP</td>
										<td>操作类型</td>
										<td>操作描述</td>
									</tr>
									<%
										OperLog[] operLogs = result.getItems();
											if (operLogs != null) {
												int i = 1;
												for (OperLog operLog : operLogs) {
													if (operLog == null) {
														continue;
													}
									%>
									<tr class="dhsbg">
										<td><%=i++%></td>
										<td>
											<%
												StringHelper.filterHTML(out, operLog.name);
											%>
										</td>
										<td><%=DateTimeParser.format(operLog.F03)%></td>
										<td>
											<%
												StringHelper.filterHTML(out, operLog.F06);
											%>
										</td>
										<td>
											<%
												StringHelper.filterHTML(out, operLog.F04);
											%>
										</td>
										<td>
											<%
												StringHelper.filterHTML(out, operLog.F05);
											%>
										</td>
										<%
											}
												}
										%>
									
								</table>
							</div>
							<%
								AbstractConsoleServlet.rendPagingResult(out, result);
							%>
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
	$(function() {
		$("#datepicker1").datepicker({inline: true,
			onSelect : function(selectedDate) {
	            $("#datepicker2").datepicker("option", "minDate", selectedDate); 
	        }
		});
	    $('#datepicker1').datepicker('option', {dateFormat:'yy-mm-dd'});
	    $("#datepicker2").datepicker({inline: true});
	    $('#datepicker2').datepicker('option', {dateFormat:'yy-mm-dd'});
	    $("#datepicker1").datepicker("setDate", "<%StringHelper.filterHTML(out, request.getParameter("createTimeStart"));%>");
	    $("#datepicker2").datepicker("setDate", "<%StringHelper.filterHTML(out, request.getParameter("createTimeEnd"));%>");
	    $("#datepicker2").datepicker('option', 'minDate',$("#datepicker1").datepicker().val());
	});
	</script>
</body>
</html>