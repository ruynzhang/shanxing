<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.framework.http.entity.RoleBean"%>
<%@page import="com.dimeng.p2p.common.enums.SysAccountStatus"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<%@page import="com.dimeng.p2p.console.servlets.system.sys.AddSysUser"%>
<%@page import="com.dimeng.p2p.console.servlets.system.sys.UpdateSysUser"%>
<%@page import="com.dimeng.p2p.modules.systematic.console.service.entity.SysUser"%>
<%@page import="com.dimeng.p2p.console.servlets.system.sys.SysUserList"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%
		SysUser sysUser = ObjectHelper.convert(
					request.getAttribute("sysUser"), SysUser.class);
			RoleBean[] roleBeans = ObjectHelper.convertArray(
					request.getAttribute("roles"), RoleBean.class);
			if (sysUser == null) {
				response.sendError(HttpServletResponse.SC_NOT_FOUND);
				return;
			}
	%>
	<%
		CURRENT_CATEGORY = "XTGL";
			CURRENT_SUB_CATEGORY = "GLYGL";
	%>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="w_main">
		<div class="main clearfix">
			<div class="wrap">
				<div class="r_main">
					<div class="home_main">
						<div class="box box1 mb15">
							<div class="atil">
								<h3>修改管理员</h3>
							</div>
							<div class="con">
								<div class="clear"></div>
								<form action="<%=controller.getURI(request, UpdateSysUser.class)%>" method="post" class="form1">
									<input type="hidden" value="<%=sysUser.id %>" name="id">
									<ul class="cell xc_jcxx ">
										<li>
											<div class="til">
												<span class="red">*</span>登录账号：
											</div>
											<div class="info">
												<%StringHelper.filterQuoter(out, sysUser.accountName);%>
											</div>
											<div class="clear"></div>
										</li>
										<li>
											<div class="til">
												<span class="red">*</span>真实姓名：
											</div>
											<div class="info">
												<input name="name" maxlength="15" type="text" maxlength="15" class="text yhgl_ser yw_w5 required" value="<%StringHelper.filterQuoter(out, sysUser.name);%>" />
												<p tip></p>
												<p errortip class="" style="display: none"></p>
											</div>
											<div class="clear"></div>
										</li>
										<li>
											<div class="til">
												<span class="red">*</span>密码：
											</div>
											<div class="info">
												<input type="password" name="password" maxlength="16" class="text yhgl_ser yw_w5 cpassword-a" />
												<p tip></p>
												<p errortip class="" style="display: none"></p>
											</div>
											<div class="clear"></div>
										</li>
										<li>
											<div class="til">
												<span class="red">*</span>确认密码：
											</div>
											<div class="info">
												<input type="password" name="newPassword" maxlength="16" class="text yhgl_ser yw_w5 cpassword-b" />
												<p tip></p>
												<p errortip class="" style="display: none"></p>
											</div>
											<div class="clear"></div>
										</li>
										<li>
											<div class="til">
												<span class="red">*</span>用户角色：
											</div>
											<div class="info orange">
												<select name="roleId" class="yhgl_sel">
													<%
														if(roleBeans!=null)
														{
														for (RoleBean roleBean : roleBeans) {
																if (roleBean == null) {
																	continue;
																}
													%>
													<option value="<%=roleBean.getRoleId()%>" <%if (roleBean.getRoleId() == sysUser.roleId) {%> selected="selected" <%}%>>
														<%
															StringHelper.filterHTML(out, roleBean.getName());
														%>
													</option>
													<%
														}
														}
													%>
												</select>
											</div>
											<div class="clear"></div>
										</li>
										<li>
											<div class="til">
												<span class="red">*</span>用户状态：
											</div>
											<div class="info orange">
												<select name="status" class="yhgl_sel">
													<option value="QY" <%if (SysAccountStatus.QY.equals(sysUser.status)) {%> selected="selected" <%}%>>启用</option>
													<option value="TY" <%if (SysAccountStatus.TY.equals(sysUser.status)) {%> selected="selected" <%}%>>锁定</option>
												</select>
											</div>
											<div class="clear"></div>
										</li>
									</ul>
									<div class="tc w220 pt20">
										<%
											if (dimengSession.isAccessableResource(UpdateSysUser.class)) {
										%>
										<input type="submit" class="btn4 mr30 sumbitForme" fromname="form1" value="确认" />
										<%
											} else {
										%>
										<input type="button" class="disabled" value="确认" />
										<%
											}
										%>
										<input type="button" onclick="location.href='<%=controller.getURI(request, SysUserList.class) %>'" class="btn4" value="返回" />
									</div>
									<div class="clear"></div>
								</form>
								<div class="clear"></div>
							</div>
						</div>
						<div class="box2 clearfix"></div>
					</div>
				</div>
			</div>
			<%@include file="/WEB-INF/include/left.jsp"%>
		</div>
	</div>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
	<script type="text/javascript"
		src="<%=controller.getStaticPath(request)%>/js/validation.js"></script>
</body>
</html>