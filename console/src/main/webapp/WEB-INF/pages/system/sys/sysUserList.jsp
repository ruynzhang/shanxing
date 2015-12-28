<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.framework.http.entity.RoleBean"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<%@page import="com.dimeng.p2p.common.enums.SysAccountStatus"%>
<%@page import="com.dimeng.p2p.console.servlets.system.sys.AddSysUser"%>
<%@page import="com.dimeng.p2p.console.servlets.system.sys.UpdateSysUser"%>
<%@page import="com.dimeng.p2p.modules.systematic.console.service.entity.SysUser"%>
<%@page import="com.dimeng.p2p.console.servlets.system.sys.SysUserList"%>
<%@page import="com.dimeng.p2p.console.servlets.AbstractConsoleServlet"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%
		PagingResult<SysUser> result = (PagingResult<SysUser>) request.getAttribute("result");
		RoleBean[] roleBeans = ObjectHelper.convertArray(
			request.getAttribute("roles"), RoleBean.class);
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
					<form action="<%=controller.getURI(request, SysUserList.class)%>" method="post" name="form1">
						<div class="home_main">
						<div class="box box1 mb15">
            			<div class="atil">
              			<h3>管理员管理</h3>
           				 </div>
								<div class="con">
									 <div class="admin_input admin_pb">
           									<div class="table">
           									<p>
												<span>账号:</span>
												<input type="text" name="accountName" value="<%StringHelper.filterQuoter(out,request.getParameter("accountName"));%>" id="textfield" class="yhgl_input mr5" />
											</p>
											<p>
												<span>姓名：</span>
												<input type="text" name="name" value="<%StringHelper.filterQuoter(out, request.getParameter("name"));%>" id="textfield7" class="yhgl_input mr5" />
											</p>
											<p>
												<span>最后登录时间：</span>
												<input type="text" name="createTimeStart" id="datepicker1" readonly="readonly" class="yhgl_input mr5 date" value="<%StringHelper.filterHTML(out,request.getParameter("createTimeStart"));%>" />至
												<input type="text" name="createTimeEnd" id="datepicker2" readonly="readonly" class="yhgl_input mr5 date" value="<%StringHelper.filterHTML(out,request.getParameter("createTimeEnd"));%>" />
											</p>
											<p>
												<span>用户组：</span>
												<select name="roleId" class="yhgl_sel" >
													<option value="0">--全部--</option>
														<%
															if(roleBeans!=null)
															{
															for (RoleBean roleBean : roleBeans) {
																	if (roleBean == null) {
																		continue;
																	}
														%>
														<option value="<%=roleBean.getRoleId()%>" <%if (roleBean.getRoleId() == IntegerParser.parse(request.getParameter("roleId"))) {%> selected="selected" <%}%>>
															<%
																StringHelper.filterHTML(out, roleBean.getName());
															%>
														</option>
														<%
															}}
														%>
													</select>
											</p>
											<p>
												<span>用户状态：</span>
												<select name="status" class="yhgl_sel" >
														<option value="">--全部--</option>
														<%
															for(SysAccountStatus status:SysAccountStatus.values())
															{
														%>
															<option value="<%=status.name() %>" <%if (status.name().equals(request.getParameter("status"))) {%> selected="selected" <%}%>><%=status.getName() %></option>
														<%} %>
												</select>
											</p>
											 <div class="clear"></div>   
						                    <div class="mt10">   
						                    	<button type="submit" class="btn2  mr10">查找</button>
						                   		<%
													if (dimengSession.isAccessableResource(AddSysUser.class)) {
												%> 
												<a href="<%=controller.getURI(request, AddSysUser.class)%>" class="btn3 mr10"><span class="ico3"></span>添加</a>
												<%
													}else
													{
												%>
												<span class="btn3 mr10 btn5"><span class="ico1"></span>添加</span>
												<%} %>
						                   </div>   
						                    <div class="clear"></div>               
								</div>
								</div>
								</div>
							</div>
							<div>
								<table width="100%" border="0" cellspacing="0" cellpadding="3" class="yhgl_table tc">
									<tr class="hsbg">
										<td>序号</td>
										<td>登录账号</td>
										<td>真实姓名</td>
										<td>角色</td>
										<td>用户状态</td>
										<td>创建时间</td>
										<td>最后登录时间</td>
										<td>最后登录ip</td>
										<td>操作</td>
									</tr>
									<%
										SysUser[] sysUsers = result.getItems();
											if (sysUsers != null) {
												int i = 1;
												for (SysUser sysUser : sysUsers) {
													if (sysUser == null) {
														continue;
													}
									%>
									<tr class="dhsbg">
										<td><%=i++%></td>
										<td>
											<%
												StringHelper.filterHTML(out, sysUser.accountName);
											%>
										</td>
										<td>
											<%
												StringHelper.filterHTML(out, sysUser.name);
											%>
										</td>
										<td><%StringHelper.filterHTML(out, sysUser.roleName); %></td>
										<td>
											<%
												StringHelper.filterHTML(out, sysUser.status.getName());
											%>
										</td>
										<td><%=DateTimeParser.format(sysUser.createTime)%></td>
										<td><%=DateTimeParser.format(sysUser.lastTime)%></td>
										<td>
											<%
												StringHelper.filterHTML(out, sysUser.lastIp);
											%>
										</td>
										<td><span>
											<%
												if (dimengSession.isAccessableResource(UpdateSysUser.class)) {
											%><a href="<%=controller.getURI(request,
								               UpdateSysUser.class)%>?id=<%=sysUser.id%>" class="mr10 blue">修改</a>
								              <%}else{ %>
								              <span class="disabled">修改</span>
								               <%} %>
								               
								              </span>
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