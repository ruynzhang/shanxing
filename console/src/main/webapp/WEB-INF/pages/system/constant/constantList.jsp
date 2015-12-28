<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.util.filter.HTMLFilter"%>
<%@page import="com.dimeng.framework.config.entity.VariableType"%>
<%@page import="com.dimeng.p2p.console.servlets.AbstractConsoleServlet"%>
<%@page import="com.dimeng.p2p.console.servlets.system.constant.ConstantList"%>
<%@page import="com.dimeng.p2p.console.servlets.system.constant.UpdateConstant"%>
<%@page import="com.dimeng.framework.config.entity.VariableBean"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%
		PagingResult<VariableBean> result = (PagingResult<VariableBean>) request
					.getAttribute("result");
		String type = request.getParameter("type");
	%>
	<%
		CURRENT_CATEGORY = "XTGL";
			CURRENT_SUB_CATEGORY = "PTCLSZ";
	%>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="w_main">
		<div class="main clearfix">
			<div class="wrap">
				<div class="r_main">
					<form action="<%=controller.getURI(request, ConstantList.class)%>" method="post">
						<div class="home_main">
							<div class="box box1 mb15">
							<div class="atil">
	              				<h3>平台常量设置</h3>
	           				 </div>
			                  <div class="con">
									 <div class="admin_input">
					                     <p>常量名称：<input type="text" name="des" value="<%StringHelper.filterQuoter(out, request.getParameter("des"));%>" id="textfield" class="yhgl_input" /></p>
					                     <p>KEY值：<input type="text" name="key" value="<%StringHelper.filterQuoter(out, request.getParameter("key"));%>" id="textfield" class="yhgl_input" /></p>
					                     <p>常量类型：
					                     	<select name="type" class="yhgl_sel">
					                     	<option value="">全部</option>
					                     	<%VariableType[] variableTypes = resourceProvider.getVariableTypes(); %>
					                     	<%if(variableTypes!=null)for(VariableType variableType:variableTypes){%>
					                     	<option value="<%=variableType.getId() %>" <%=variableType.getId().equals(type)?"selected=\"selected\"":"" %>><%=variableType.getName() %></option>
					                     	<%}%>
					                     	</select>
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
										<td>常量值</td>
										<td>操作</td>
									</tr>
									<%
										VariableBean[] variables = result.getItems();
											if (variables != null) {
												int i = 1;
												HTMLFilter htmlFilter=new HTMLFilter(out);
												for (VariableBean variable : variables) {
													if (variable == null) {
														continue;
													}
									%>
									<tr class="dhsbg">
										<td><%=i++%></td>
										<td title="<%StringHelper.filterHTML(out, variable.getDescription());%>">
										<%StringHelper.truncation(htmlFilter,  variable.getDescription(), 20);%>
										</td>
										<td title="<%StringHelper.filterHTML(out, variable.getKey());%>">
										<%StringHelper.truncation(htmlFilter,  variable.getKey(), 20);%>
										</td>
										<td title="<%StringHelper.filterHTML(out, variable.getValue());%>">
										<%StringHelper.truncation(htmlFilter,  variable.getValue(), 50);%>
										</td>
										<td><span>
										<%
											if(dimengSession.isAccessableResource(UpdateConstant.class))
											{
										%>
										<a href="<%=controller.getURI(request,UpdateConstant.class)%>?key=<%=variable.getKey() %>" class="mr10 blue">修改</a>
										<%}else{ %>
										<span class="disabled">修改</span>
										<%} %>
										</span></td>
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
</body>
</html>