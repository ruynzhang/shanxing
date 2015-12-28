<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.framework.http.entity.RoleBean"%>
<%@page import="com.dimeng.p2p.console.servlets.system.role.AddRole"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<%@page import="com.dimeng.p2p.console.servlets.system.sys.AddSysUser"%>
<%@page import="com.dimeng.p2p.console.servlets.system.sys.UpdateSysUser"%>
<%@page import="com.dimeng.p2p.modules.systematic.console.service.entity.SysUser"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%
		RoleBean[] roleBeans = ObjectHelper.convertArray(
					request.getAttribute("roles"), RoleBean.class);
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
					<div class="home_main">
						<div class="box box1 mb15">
							<div class="atil">
								<h3>添加用户组</h3>
							</div>
							<div class="con" style="padding: 30px 0">
								<div class="clear"></div>
								<form action="<%=controller.getURI(request, AddRole.class)%>" method="post" class="form1">
									<ul class="cell yw_jcxx ">
										<li>
											<div class="til">
												<span class="red">*</span>用户组名称：
											</div>
											<div class="info">
												<input name="name" type="text" class="text yhgl_ser yw_w5 required" maxlength="15"/>
												<p tip></p>
												<p errortip class="" style="display: none"></p>
											</div>
											<div class="clear"></div>
										</li>
										<li>
											<div class="til">
												用户组描述：
											</div>
											<div class="info">
												<textarea name="des" id="des" cols="45" rows="5" class="border fl mr10 yw_w5" maxlength="200"></textarea>
												<p id="errordes">&nbsp;</p>
											</div>
											<div class="clear"></div>
										</li>
									</ul>
									<div class="tc w220 pt20">
												<%
													if (dimengSession.isAccessableResource(AddRole.class)) {
												%>
												<input type="submit" class="btn4 mr30 sumbitForme" fromname="form1" value="确认" />
												<%} else {%>
												<input type="button" class="disabled" value="确认" />
												<%} %>
												<%
													if (dimengSession.isAccessableResource(RoleList.class)) {
												%>
												<input type="button" onclick="location.href='<%=controller.getURI(request, RoleList.class) %>'" class="btn5" value="取消" />
												<%} else {%>
												<input type="button" class="disabled" value="取消" />
												<%} %>
												<div class="clear"></div>
									</div>
									
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
			<%@include file="/WEB-INF/include/left.jsp"%>
		</div>
	</div>
	<%
		String warringMessage=controller.getPrompt(request, response, PromptLevel.WARRING);
		if(!StringHelper.isEmpty(warringMessage))
		{
	%>
	<div class="w440 thickbox thickpos" style="margin:-80px 0 0 -220px;" id="showDiv">
      <div class="info clearfix">
        <div class="clearfix">
            <span class="fl tips"><%StringHelper.filterHTML(out, warringMessage); %></span>
        </div>
        <div class="dialog_btn"><input type="button" name="button2" onclick="$('#showDiv').hide()" value="确认"  class="btn4 ml50"/></div> 
      </div>
	</div>
	<%} %>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
	<script type="text/javascript"
		src="<%=controller.getStaticPath(request)%>/js/validation.js"></script>
</body>
</html>