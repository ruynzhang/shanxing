<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.modules.systematic.console.service.entity.Constant"%>
<%@page import="com.dimeng.util.filter.HTMLFilter"%>
<%@page import="com.dimeng.p2p.console.servlets.AbstractConsoleServlet"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%
		PagingResult<Constant> result = (PagingResult<Constant>) request
					.getAttribute("result");
	%>
	<%
		CURRENT_CATEGORY = "XTGL";
			CURRENT_SUB_CATEGORY = "PTCLRZ";
	%>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="w_main">
		<div class="main clearfix">
			<div class="wrap">
				<div class="r_main">
					<form action="<%=controller.getURI(request, ConstantLogList.class)%>" method="post">
						<div class="home_main">
							<div class="box box1 mb15">
							<div class="atil">
	              				<h3>平台常量设置</h3>
	           				 </div>
			                  <div class="con">
									 <div class="admin_input">
					                     <p>常量名称：<input type="text" name="name" value="<%StringHelper.filterQuoter(out, request.getParameter("name"));%>" id="textfield" class="yhgl_input" /></p>
					                     <p>KEY值：<input type="text" name="key" value="<%StringHelper.filterQuoter(out, request.getParameter("key"));%>" id="textfield" class="yhgl_input" /></p>
					                     <p>修改时间：<input type="text" name="timeStart" id="datepicker1" readonly="readonly" class="yhgl_input date" value="<%StringHelper.filterQuoter(out,
									request.getParameter("timeStart"));%>" />
					                       <span class="mr5">至</span>
					                       <input type="text" name="timeEnd" id="datepicker2" readonly="readonly" class="yhgl_input date" value="<%StringHelper.filterQuoter(out,
									request.getParameter("timeEnd"));%>" />
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
										<td>常量名称</td>
										<td>KEY值</td>
										<td>修改前值</td>
										<td>修改后值</td>
										<td>修改人</td>
										<td>修改时间</td>
									</tr>
									<%
										Constant[] constants = result.getItems();
											if (constants != null) {
												int i = 1;
												HTMLFilter htmlFilter=new HTMLFilter(out);
												for (Constant constant : constants) {
													if (constant == null) {
														continue;
													}
									%>
									<tr class="dhsbg">
										<td><%=i++%></td>
										<td title="<%StringHelper.filterHTML(out, constant.desc);%>">
										<%StringHelper.truncation(htmlFilter,constant.desc, 20);%>
										</td>
										<td title="<%StringHelper.filterHTML(out, constant.key);%>">
										<%StringHelper.truncation(htmlFilter,constant.key, 20);%>
										</td>
										<td title="<%StringHelper.filterHTML(out, constant.value1);%>">
										<%StringHelper.truncation(htmlFilter,constant.value1, 20);%>
										</td>
										<td title="<%StringHelper.filterHTML(out, constant.value2);%>">
										<%StringHelper.truncation(htmlFilter,constant.value2, 20);%>
										</td>
										<td><%StringHelper.filterHTML(out, constant.name); %></td>
										<td><%=DateTimeParser.format(constant.updateTime) %></td>
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
	    $("#datepicker1").datepicker("setDate", "<%StringHelper.filterHTML(out, request.getParameter("timeStart"));%>");
	    $("#datepicker2").datepicker("setDate", "<%StringHelper.filterHTML(out, request.getParameter("timeEnd"));%>");
	    $("#datepicker2").datepicker('option', 'minDate',$("#datepicker1").datepicker().val());
	});
	</script>
</body>
</html>