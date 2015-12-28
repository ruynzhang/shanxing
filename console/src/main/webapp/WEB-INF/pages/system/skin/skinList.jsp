<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.util.ObjectHelper"%>
<%@page import="com.dimeng.p2p.console.servlets.system.skin.DelSkin"%>
<%@page import="com.dimeng.p2p.console.servlets.system.skin.UpdateSkin"%>
<%@page import="com.dimeng.p2p.console.servlets.system.skin.DelBatchSkin"%>
<%@page import="com.dimeng.p2p.console.servlets.system.skin.AddSkin"%>
<%@page import="com.dimeng.p2p.modules.systematic.console.service.entity.Skin"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%
		Skin[] skins =ObjectHelper.convertArray(request.getAttribute("skins"), Skin.class);
	%>
	<%
		CURRENT_CATEGORY = "XTGL";
			CURRENT_SUB_CATEGORY = "QTPFSZ";
	%>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="w_main">
		<div class="main clearfix">
			<div class="wrap">
				<div class="r_main">
					<form action="<%=controller.getURI(request, SysUserList.class)%>" method="post">
						<div class="home_main">
							<div class="box box1 mb15">
							<div class="atil">
	              				<h3>前台皮肤设置</h3>
	           				 </div>
								<div class="con">
									<table width="100%" border="0" cellspacing="0" cellpadding="0">
										<tr>
											<td height="40">
											<%
											if (dimengSession.isAccessableResource(AddSkin.class)) {
											%> 
											 <a href="<%=controller.getURI(request, AddSkin.class)%>" class="btn3 mr10"><span class="ico1"></span>添加</a>
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
										<td>皮肤主题</td>
										<td>皮肤位置</td>
										<td>皮肤图片</td>
										<td>管理员</td>
										<td>创建时间</td>
										<td>修改时间</td>
										<td>操作</td>
									</tr>
									<%
											if (skins != null) {
												int i = 1;
												for (Skin skin : skins) {
													if (skin == null) {
														continue;
													}
									%>
									<tr class="dhsbg">
										<td><%=i++%></td>
										<td>
											<%
												StringHelper.filterHTML(out, skin.themeName);
											%>
										</td>
										<td>
											<%
												if(skin.location!=null){StringHelper.filterHTML(out, skin.location.getName());}
											%>
										</td>
										<td><img alt="" src="<%=skin.pic%>" width="250" height="100">
										</td>
										<td>
											<%
												StringHelper.filterHTML(out, skin.name);
											%>
										</td>
										<td><%=DateTimeParser.format(skin.createTime)%></td>
										<td><%=DateTimeParser.format(skin.lastUpdateTime)%></td>
										<td><span>
										<%
											if (dimengSession.isAccessableResource(DelSkin.class)) {
										%>
										<a href="<%=controller.getURI(request, DelSkin.class)%>?id=<%=skin.id%>" class="mr10 blue">删除</a>
										<%}else{ %>
										<a href="javascript:void(0)" class="diabled">删除</a>
										<%} %>
										<%
											if (dimengSession.isAccessableResource(UpdateSkin.class)) {
										%>
										<a href="<%=controller.getURI(request, UpdateSkin.class)%>?id=<%=skin.id%>" class="mr10 blue">修改</a>
										<%
											}else{
										%>
										<span class="diabled">修改</span>
										<%} %>
										</span></td>
										<%
											}
												}
										%>
									
								</table>
							</div>
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