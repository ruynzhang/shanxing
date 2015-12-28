<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.common.enums.ActivityStatus"%>
<%@page import="com.dimeng.p2p.console.servlets.spread.hdgl.ExportHdgl"%>
<%@page import="com.dimeng.p2p.console.servlets.spread.hdgl.AddHdgl"%>
<%@page import="com.dimeng.p2p.console.servlets.spread.hdgl.SearchCyr"%>
<%@page import="com.dimeng.p2p.console.servlets.spread.hdgl.updateHdgl"%>
<%@page import="com.dimeng.p2p.console.servlets.spread.hdgl.SearchHdxq"%>
<%@page import="com.dimeng.p2p.S63.enums.T6320_F14"%>
<%@page
	import="com.dimeng.p2p.modules.spread.console.service.entity.ActivityList"%>
<%@page
	import="com.dimeng.p2p.modules.spread.console.service.entity.ActivityTotalInfo"%>
<%@page import="com.dimeng.p2p.console.servlets.spread.hdgl.SearchHdgl"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%
	CURRENT_CATEGORY = "TGGL";
	CURRENT_SUB_CATEGORY = "HDGL";
	PagingResult<ActivityList> result = ObjectHelper.convert(request.getAttribute("result"), PagingResult.class);
	ActivityTotalInfo totalInfo = ObjectHelper.convert(request.getAttribute("totalInfo"), ActivityTotalInfo.class);
%>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="w_main">
		<div class="main clearfix">
			<div class="wrap">
				<form action="<%=controller.getURI(request, SearchHdgl.class)%>"
					method="post">
					<div class="r_main">
						<div class="home_main">
							<div class="box box1 mb15">
								<div class="atil">
									<h3>活动管理</h3>
								</div>
								<div class="con">
									<div class="clear"></div>
									<ul class="yhxq_li">
										<li>总费用：<span class="blue"><%=totalInfo.totalMoney%></span>元
										</li>
									</ul>
									<ul class="yhxq_li">
										<li>总受益人数：<span class="blue"><%=totalInfo.totalPerson%></span>人
										</li>
									</ul>
									<div class="clear"></div>
								</div>
							</div>
							<div class="box box1 mb15">
								<div class="con">
									<div class="admin_input admin_pb">
										<div class="table">
											<p>
												<span>活动主题：</span> <input type="text" name="title"
													id="textfield" class="yhgl_input"
													value="<%StringHelper.filterHTML(out, request.getParameter("title"));%>" />
											</p>
											<p>
												<span>开始时间：</span> <input type="text" name="startTime"
													readonly="readonly" id="datepicker1"
													class="yhgl_input date"
													value="<%StringHelper.filterHTML(out, request.getParameter("startTime"));%>" />
												至 <input type="text" name="endTime" readonly="readonly"
													id="datepicker2" class="yhgl_input date"
													value="<%StringHelper.filterHTML(out, request.getParameter("endTime"));%>" />
											</p>
											<p>
												<span>状态:</span> <select name="status" class="yhgl_sel">
													<%String status = request.getParameter("status"); %>
													<option>全部</option>
													<% 
                    			for(ActivityStatus s :ActivityStatus.values()){
                    		%>
													<option value="<%=s %>"
														<%if(! StringHelper.isEmpty(status) && status.equals(s.name())){ %>
														selected="selected" <%} %>><%=s.getName() %></option>
													<%
                    			}
                    		%>
												</select>
											</p>
											<div class="clear"></div>
											<div class="mt10">
												<input name="" type="submit" class="btn2 mr10" value="搜索"
													style="cursor: pointer;" />
												<%if (dimengSession.isAccessableResource(ExportHdgl.class)) {%>
												<a onclick="exportHdgl()" style="cursor: pointer;"
													class="btn3 mr10"><span class="ico"></span>导出</a>
												<%}else{ %>
												<span class="btn3 btn5 mr10"><span class="ico"></span>导出</span>
												<%} %>
												<%if (dimengSession.isAccessableResource(AddHdgl.class)) {%>
												<a href="<%=controller.getURI(request, AddHdgl.class)%>"
													class="btn3 mr10"><span class="ico3"></span>新建</a>
												<%}else{ %>
												<span class="btn3 btn5 mr10"><span class="ico3"></span>新建</span>
												<%} %>
											</div>
											<div class="clear"></div>
										</div>
									</div>
								</div>
							</div>
							<table width="100%" border="0" cellspacing="0" cellpadding="3"
								class="yhgl_table tc">
								<tr class="hsbg">
									<td>序号</td>
									<td>活动名称</td>
									<td>开始时间/结束时间</td>
									<td>优惠券生效时间/失效时间</td>
									<td>发放数量</td>
									<td>金额（元）</td>
									<td>最低充值金额</td>
									<td>最低投资金额</td>
									<td>最低推广人数</td>
									<td>创建人</td>
									<td>剩余数量</td>
									<td>操作</td>
								</tr>
								<% 
			  ActivityList[] lists = result.getItems(); 
	            if(lists != null ){
	            	int index = 1;
	            	for(ActivityList list : lists){
	            		
            %>
								<tr class="dhsbg">
									<td><%=index++ %></td>
									<td>
										<%StringHelper.filterHTML(out, list.F02); %>
									</td>
									<td><%=DateTimeParser.format(list.F03) %><br /><%=DateTimeParser.format(list.F04) %></td>
									<td><%=DateParser.format(list.F05) %><br /><%=DateParser.format(list.F06) %></td>
									<td><%=list.F07 %></td>
									<td><%=list.F08 %></td>
									<td><%=list.F11 %></td>
									<td><%=list.F13 %></td>
									<td><%=list.F16 %></td>
									<td>
										<%StringHelper.filterHTML(out, list.F17); %>
									</td>
									<td><%=list.F18 %></td>
									<td class="blue">
										<%if (dimengSession.isAccessableResource(SearchHdxq.class)) {%>
										<a
										href="<%=controller.getURI(request, SearchHdxq.class) %>?id=<%=list.F01 %>">详情</a>
										<%}else{ %> <span class="gray6">详情</span> <%} %> <%if(list.F14.equals(T6320_F14.XJ) || list.F14.equals(T6320_F14.SX)){ %>
										<%if (dimengSession.isAccessableResource(updateHdgl.class)) {%>
										<a
										href="<%=controller.getURI(request, updateHdgl.class) %>?id=<%=list.F01 %>">修改</a>
										<%}else{ %> <span class="gray6">修改</span> <%} %> <% } else{%> <span
										class="gray6">修改</span> <%} %> <%if (dimengSession.isAccessableResource(SearchCyr.class)) {%>
										<a
										href="<%=controller.getURI(request, SearchCyr.class) %>?id=<%=list.F01 %>">参与人</a>
										<%}else{ %> <span class="gray6">参与人</span> <%} %>
									</td>
								</tr>
								<%}}%>
							</table>
							<div class="box2 clearfix"></div>
							<% 
        	 SearchHdgl.rendPagingResult(out, result);
          %>
						</div>
					</div>
				</form>
			</div>
			<%@include file="/WEB-INF/include/left.jsp"%>
		</div>
	</div>

	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
	<%@include file="/WEB-INF/include/datepicker.jsp"%>
	<script type="text/javascript">
	$(function() {
		$("#datepicker1").datepicker({inline: true});
	    $('#datepicker1').datepicker('option', {dateFormat:'yy-mm-dd'});
	    $("#datepicker2").datepicker({inline: true});
	    $('#datepicker2').datepicker('option', {dateFormat:'yy-mm-dd'});
	    $("#datepicker1").datepicker("setDate", "<%StringHelper.filterHTML(out, request.getParameter("startTime"));%>");
	    $("#datepicker2").datepicker("setDate", "<%StringHelper.filterHTML(out, request.getParameter("endTime"));%>");
	});
	</script>
	<script type="text/javascript">
		function exportHdgl(){
			var del_url = '<%=controller.getURI(request, ExportHdgl.class) %>';
	   		var form = document.forms[0];
			form.action = del_url;
			form.submit();
			form.action = '<%=controller.getURI(request, SearchHdgl.class) %>';
		}
   	
</script>
</body>
</html>