<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.console.servlets.system.role.DelRole"%>
<%@page import="com.dimeng.p2p.console.servlets.system.role.UpdateRole"%>
<%@page import="com.dimeng.framework.http.entity.RoleBean"%>
<%@page import="com.dimeng.p2p.console.servlets.system.role.SetMenu"%>
<%@page import="com.dimeng.p2p.console.servlets.system.role.SetRight"%>
<%@page import="com.dimeng.p2p.console.servlets.system.role.AddRole"%>
<%@page import="com.dimeng.p2p.common.enums.SysAccountStatus"%>
<%@page import="com.dimeng.p2p.console.servlets.system.sys.AddSysUser"%>
<%@page import="com.dimeng.p2p.console.servlets.system.sys.UpdateSysUser"%>
<%@page import="com.dimeng.p2p.modules.systematic.console.service.entity.SysUser"%>
<%@page import="com.dimeng.p2p.console.servlets.AbstractConsoleServlet"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%
		PagingResult<RoleBean> result = (PagingResult<RoleBean>) request.getAttribute("result");
	%>
	<%
		CURRENT_CATEGORY = "XTGL";
		CURRENT_SUB_CATEGORY = "YHZGL";
	%>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="w_main">
		<div class="main clearfix">
			<div class="wrap">
				<div class="r_main">
					<form action="<%=controller.getURI(request, RoleList.class)%>" method="post">
					<input type="hidden" name="roleId" id="roleId" value="">
						<div class="home_main">
							<div class="box box1 mb15">
							 <div class="atil">
	              				<h3>用户组管理</h3>
	           				 </div>
								<div class="con">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td height="40">
												<%
													if (dimengSession.isAccessableResource(AddRole.class)) {
												%> 
												 <a href="<%=controller.getURI(request, AddRole.class)%>" class="btn3 mr10"><span class="ico1"></span>添加</a>
												<%} else {%>
												 <span class="btn3 mr10 btn5"><span class="ico1"></span>添加</span>
												<%} %>
											</td>
										</tr>
									</table>
								</div>
							</div>
							<div>
								<table width="100%" border="0" cellspacing="0" cellpadding="3" class="yhgl_table tc">
									<tr class="hsbg">
										<td>序号</td>
										<td>组名称</td>
										<td>组描述</td>
										<td>操作</td>
									</tr>
									<%
										RoleBean[] roleBeans = result.getItems();
											if (roleBeans != null) {
												int i = 1;
											for (RoleBean roleBean : roleBeans) {
												if (roleBean == null) {
													continue;
												}
									%>
									<tr class="dhsbg">
										<td><%=i++%></td>
										<td title="<%StringHelper.filterHTML(out, roleBean.getName());%>">
											<%
												StringHelper.filterHTML(out, StringHelper.truncation(roleBean.getName(), 15));
											%>
										</td>
										<td title="<%StringHelper.filterHTML(out, roleBean.getDescription());%>">
											<%
												StringHelper.filterHTML(out, StringHelper.truncation(roleBean.getDescription(), 15));
											%>
										</td>
										<td><span>
										<%
											if (dimengSession.isAccessableResource(SetMenu.class)) {
										%> 
										<a href="<%=controller.getURI(request, SetMenu.class)%>?roleId=<%=roleBean.getRoleId() %>" class="mr10 blue">菜单设定</a>
										<%}else{ %>
										<span class="disabled">菜单设定</span>
										<%} %>
										<%
											if (dimengSession.isAccessableResource(SetRight.class)) {
										%> 
										<a href="<%=controller.getURI(request, SetRight.class)%>?roleId=<%=roleBean.getRoleId() %>" class="mr10 blue">权限设定</a>
										<%}else{ %>
										<span class="disabled">权限设定</span>
										<%} %>
										<%
											if (dimengSession.isAccessableResource(UpdateRole.class)) {
										%> 
										<a href="<%=controller.getURI(request, UpdateRole.class)%>?roleId=<%=roleBean.getRoleId() %>" class="mr10 blue">修改</a>
										<%}else{ %>
										<span class="disabled">修改</span>
										<%} %>
										
										<%
										if (dimengSession.isAccessableResource(DelRole.class)) {
										%> 
										<a style="cursor: pointer;" onclick="del('<%=roleBean.getName() %>','<%=roleBean.getRoleId() %>')" class="mr10 blue">删除</a>
										<%}else{ %>
										<span class="disabled">删除</span>
										<%} %>
										
										</span></td>					
										<%
											}}
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

<div id="info"></div>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
	<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/dialog.js"></script>
<script type="text/javascript">

	function del(name,roleId){
		if(confirm("删除后无法恢复，确定要删除“"+name+"”这个用户组？")){
			location.href="<%=controller.getURI(request, DelRole.class)%>?roleId="+roleId;
		}else{
			return;
		}
	}

</script>

	<%
		String message = controller.getPrompt(request, response , PromptLevel.INFO);
			if (!StringHelper.isEmpty(message)) {
	%>
	<script type="text/javascript">
		alert("<%=message%>");
	</script>
	<%
		}
	%>
	
	<%
		String errorMessage = controller.getPrompt(request, response , PromptLevel.ERROR);
			if (!StringHelper.isEmpty(errorMessage)) {
				
	%>
	<script type="text/javascript">
		alert("<%=errorMessage%>");
	</script>
	<%
		}
	%>
	
	<%
		String warnMessage = controller.getPrompt(request, response , PromptLevel.WARRING);
			if (!StringHelper.isEmpty(warnMessage)) {
	%>
	<script type="text/javascript">
		alert("<%=warnMessage%>");
	</script>
	<%
		}
	%>
	
</body>
</html>