<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.modules.base.console.service.entity.KhghEntity"%>
<%@page import="com.dimeng.p2p.S71.enums.T7166_F07"%>
<%@page import="com.dimeng.p2p.console.servlets.spread.khgh.ChangeStatus"%>
<%@page import="com.dimeng.p2p.console.servlets.spread.khgh.Update"%>
<%@page import="com.dimeng.p2p.console.servlets.spread.khgh.Add"%>
<%@page import="com.dimeng.p2p.console.servlets.spread.khgh.Search"%>
<%@page import="com.dimeng.p2p.console.servlets.spread.khgh.View"%>
<%@page import="com.dimeng.p2p.console.servlets.AbstractConsoleServlet"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%
		PagingResult<KhghEntity> result = (PagingResult<KhghEntity>) request.getAttribute("result");
		CURRENT_CATEGORY = "XTGL";
		CURRENT_SUB_CATEGORY = "KHGH";
	%>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="w_main">
		<div class="main clearfix">
			<div class="wrap">
				<div class="r_main">
					<form action="<%=controller.getURI(request, Search.class)%>" method="post">
						<div class="home_main">
							<div class="box box1 mb15">
							<div class="atil">
	              				<h3>客户关怀</h3>
	           				</div>
	           				<div class="con clearfix">
								<%if (dimengSession.isAccessableResource(Add.class)) {%>
								<a href="<%=controller.getViewURI(request, Add.class)%>"
									class="btn3 mr10"><span class="ico3"></span>新建</a>
								<%} %>
							</div>
						</div>
						
						<div>
								<table width="100%" border="0" cellspacing="0" cellpadding="3" class="yhgl_table tc">
									<tr class="hsbg">
										<td>序号</td>
										<td>关怀类型</td>
										<td>关怀形式</td>
										<td>关怀标题</td>
										<td>发送时间</td>
										<td>状态</td>
										<td>创建人</td>
										<td>创建时间</td>
										<td>操作</td>
									</tr>
									<% KhghEntity[] t7166s = result.getItems();
									   if (t7166s != null && t7166s.length > 0) {
									   int i = 1;
									   for (KhghEntity t7166 : t7166s) {
									   	if (t7166 == null) {continue;}
									%>
									<tr class="dhsbg">
										<td><%=i++ %></td>
										<td title="<%StringHelper.filterHTML(out, t7166.F03.getChineseName());%>">
											<%StringHelper.filterHTML(out, t7166.F03.getChineseName());%>
										</td>
										<td><%StringHelper.filterHTML(out, t7166.F04.getChineseName());%></td>
										<td title="<%StringHelper.filterHTML(out, t7166.F05); %>">
											<%StringHelper.truncation(out, t7166.F05, 15); %>
										</td>
										<td><%=SQLDateParser.format(t7166.F09) %></td>
										<td><%=t7166.F07.getChineseName() %></td>
										<td><%StringHelper.filterHTML(out, t7166.T7110_F02);%></td>
										<td><%=DateTimeParser.format(t7166.F10) %></td>
										<td>
											<span>
												<%if(dimengSession.isAccessableResource(View.class)) { %>
												<a href="<%=controller.getURI(request, View.class)%>?id=<%=t7166.F01 %>" class="mr10 blue">查看</a>
												<%} else{ %><span>查看</span><%} %>
											</span>
											<span>
												<%if(dimengSession.isAccessableResource(Update.class)) { %>
												<a href="<%=controller.getURI(request, Update.class)%>?id=<%=t7166.F01 %>" class="mr10 blue">修改</a>
												<%} else{ %><span>修改</span><%} %>
											</span>
											<span>
											<%if(dimengSession.isAccessableResource(ChangeStatus.class)) { %>
												<a href="<%=controller.getURI(request, ChangeStatus.class)%>?id=<%=t7166.F01 %>&status=<%if(t7166.F07 == T7166_F07.TY){ StringHelper.filterHTML(out, T7166_F07.QY.name());}else{ StringHelper.filterHTML(out, T7166_F07.TY.name());} %>" class="mr10 blue"><%if(t7166.F07 == T7166_F07.TY){ StringHelper.filterHTML(out, T7166_F07.QY.getChineseName());}else{ StringHelper.filterHTML(out, T7166_F07.TY.getChineseName());} %></a>
												<%} else{ %><span><%if(t7166.F07 == T7166_F07.TY){ StringHelper.filterHTML(out, T7166_F07.QY.getChineseName());}else{ StringHelper.filterHTML(out, T7166_F07.TY.getChineseName());} %></span><%} %>
											</span>
										</td>
										<%}} %>
								</table>
							</div>
							<% AbstractConsoleServlet.rendPagingResult(out, result); %>
				</div>
			</form>
			</div>
		</div>
			<%@include file="/WEB-INF/include/left.jsp"%>
		</div>
	</div>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
</body>
</html>