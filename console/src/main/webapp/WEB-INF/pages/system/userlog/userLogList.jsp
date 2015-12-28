<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.console.servlets.system.userlog.UserLogList"%>
<%@page import="com.dimeng.p2p.modules.systematic.console.service.entity.UserLog"%>
<%@page import="com.dimeng.p2p.modules.systematic.console.service.entity.SysLog"%>
<%@page import="com.dimeng.p2p.console.servlets.AbstractConsoleServlet"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%
		PagingResult<UserLog> result = (PagingResult<UserLog>) request
					.getAttribute("result");
	%>
	<%
		CURRENT_CATEGORY = "XTGL";
			CURRENT_SUB_CATEGORY = "QTDLRZ";
	%>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="w_main">
		<div class="main clearfix">
			<div class="wrap">
				<div class="r_main">
					<form action="<%=controller.getURI(request, UserLogList.class)%>" method="post">
						<div class="home_main">
							<div class="box box1 mb15">
							<div class="atil">
	              				<h3>前台登录日志</h3>
	           				 </div>
			                  <div class="con">
									 <div class="admin_input">
					                     <p>用户名：<input type="text" name="accountName" value="<%StringHelper.filterQuoter(out,
						request.getParameter("accountName"));%>" id="textfield" class="yhgl_input" /></p>
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
										<td>用户名</td>
										<td>操作时间</td>
										<td>登录IP</td>
										<td>操作类型</td>
										<td>操作描述</td>
									</tr>
									<%
										UserLog[] userlogs = result.getItems();
											if (userlogs != null) {
												int i = 1;
												for (UserLog userLog : userlogs) {
													if (userLog == null) {
														continue;
													}
									%>
									<tr class="dhsbg">
										<td><%=i++%></td>
										<td>
											<%
												StringHelper.filterHTML(out, userLog.accountName);
											%>
										</td>
										<td><%=DateTimeParser.format(userLog.F03)%></td>
										<td>
											<%
												StringHelper.filterHTML(out, userLog.F06);
											%>
										</td>
										<td><%StringHelper.filterHTML(out, userLog.F04); %></td>
										<td>
											<%
												StringHelper.filterHTML(out,
																	userLog.F05);
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