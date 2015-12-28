<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.console.servlets.finance.dzgl.UserAccount"%>
<%@page import="com.dimeng.p2p.S61.enums.T6110_F10"%>
<%@page import="com.dimeng.p2p.S61.enums.T6110_F06"%>
<%@page import="com.dimeng.p2p.S61.entities.T6110"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.AbstractFinanceServlet"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<%
		CURRENT_CATEGORY = "CWGL";
		CURRENT_SUB_CATEGORY = "YHYECX";
		
		PagingResult<T6110> pagingResult = (PagingResult<T6110>)request.getAttribute("pagingResult");
	%>
	<div class="w_main">
		<div class="main clearfix">
			<div class="wrap">
				<div class="r_main">
					<div class="home_main">
						<form action="<%controller.getURI(request, WithdrawQuery.class);%>" method="post" name="form1" id="searchForm">
							<div class="box box1 mb15">
								<div class="con">
									<div class="admin_input admin_pb">
             							<div class="table top3">
											<P>
												<span>用户名：</span>
												<input type="text" class="yhgl_input" name="userName" value="<%StringHelper.filterQuoter(out, request.getParameter("userName")); %>" />
											</P>
											<P>
												<input name="search" type="submit" class="btn2" value="搜索" />
											</P>
											<p class="red"><%StringHelper.filterHTML(out, (String)request.getAttribute("errorMsg")); %></p>
									<div class="clear"></div>
								</div>
								</div>
								</div>
							</div>
							<table width="100%" border="0" cellspacing="0" cellpadding="3" class="yhgl_table tc">
								<tr class="hsbg">
									<td>用户ID</td>
									<td>登录账号</td>
									<td>用户类型</td>
									<td>是否为担保方</td>
									<td>操作</td>
								</tr>
								<%
									T6110[] items = pagingResult.getItems();
									if(items != null){
										for(T6110 item : items){
								%>
								<tr>
									<td><%=item.F01 %></td>
									<td><%StringHelper.filterHTML(out, item.F02); %></td>
									<td>
										<%
											if(item.F06 == T6110_F06.ZRR){
												out.print("自然人");
											}else{
												out.print("非自然人");
											}
										%>
									</td>
									<td>
										<%
											if(item.F10 == T6110_F10.S){
												out.print("是");
											}else{
												out.print("否");
											}
										%>
									</td>
									<td><a target="_blank" href="<%=controller.getURI(request, UserAccount.class) %>?id=<%=item.F01 %>">余额查询</a> </td>
								</tr>
								<%}} %>
							</table>
							<%
								AbstractFinanceServlet.rendPagingResult(out, pagingResult);
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
</body>
</html>