<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.framework.http.entity.RoleBean"%>
<%@page import="com.dimeng.framework.http.entity.RightBean"%>
<%@page import="com.dimeng.framework.config.entity.ModuleBean"%>
<%@page import="com.dimeng.p2p.console.servlets.system.role.SetRight"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%
		ModuleBean[] moduleBeans = ObjectHelper.convertArray(
				request.getAttribute("moduleBeans"), ModuleBean.class);
			String rights=ObjectHelper.convert(request.getAttribute("rights"), String.class);
			RoleBean roleBean=ObjectHelper.convert(request.getAttribute("roleBean"), RoleBean.class);
			int roleId=IntegerParser.parse(request.getAttribute("roleId"));
			if(roleBean==null)
			{
				response.sendError(HttpServletResponse.SC_NOT_FOUND);
				return;
			}
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
								<h3>修改用户组</h3>
							</div>
							<div class="con" style="padding: 30px 0">
								<div class="clear"></div>
								<form action="<%=controller.getURI(request, SetRight.class)%>" method="post" id="form1">
									<input type="hidden" value="<%=roleId%>" name="roleId"/>
									<ul class="cell xc_jcxx ">
										<li>
											<div class="til">
												<span class="red">*</span>用户组名称：
											</div>
											<div class="info">
												<input name="name" type="text" class="text yhgl_ser yw_w5" value="<%StringHelper.filterHTML(out, roleBean.getName()); %>" readonly="readonly"/>
											</div>
											<div class="clear"></div>
										</li>
										<li>
											<div class="til">
												用户组描述：
											</div>
											<div class="info">
												<textarea name="des" id="textarea2" cols="45" rows="5" class="border fl mr10 yw_w5" readonly="readonly"><%StringHelper.filterHTML(out, roleBean.getDescription()); %></textarea>
											</div>
											<div class="clear"></div>
										</li>
									</ul>
									<%int moduleIdx=0; int j=0;%>
									<div class="bg_bs">
										用户组权限：<span>
										<input type="radio" name="_radio<%=moduleIdx %>" id="_<%=j %>" onclick="selectAll('_module<%=moduleIdx%>')"/><label class="mr15 ml5" for="_<%=j++ %>">全选</label>
										<input type="radio" name="_radio<%=moduleIdx %>" id="_<%=j %>" onclick="unselectAll('_module<%=moduleIdx%>')"/><label class="mr15 ml5" for="_<%=j++ %>">全不选</label>
										<input type="radio" name="_radio<%=moduleIdx %>" id="_<%=j %>" onclick="revertAll('_module<%=moduleIdx%>')"/><label class="ml5" for="_<%=j++ %>">反选</label>
										</span>
									</div>
									<div class="p15-30 xt_li" id="_module<%=moduleIdx++%>">
										<%if (moduleBeans != null) {for (ModuleBean moduleBean : moduleBeans) {if (moduleBean == null) {continue;}%>
										<div class="clear"></div>
										<div class="hsxt"></div>
										<div class="fB mb10">
										<%=moduleIdx%>.<%StringHelper.filterHTML(out, moduleBean.getName());%>
										<span>
										<input type="radio" name="_radio<%=moduleIdx %>" id="_<%=j %>" onclick="selectAll('_module<%=moduleIdx%>')"/><label class="mr15 ml5" for="_<%=j++ %>">全选</label>
										<input type="radio" name="_radio<%=moduleIdx %>" id="_<%=j %>" onclick="unselectAll('_module<%=moduleIdx%>')"/><label class="mr15 ml5" for="_<%=j++ %>">全不选</label>
										<input type="radio" name="_radio<%=moduleIdx %>" id="_<%=j %>" onclick="revertAll('_module<%=moduleIdx%>')"/><label class="ml5" for="_<%=j++ %>">反选</label>
										</span>
										<ul id="_module<%=moduleIdx++%>">
											<%if (moduleBean.getRightBeans() != null) {for (RightBean rightBean : moduleBean.getRightBeans()) {if (rightBean == null||rightBean.isMenu()) {continue;}%>
											<li>
												<input id="_<%=j %>" name="rightIds" type="checkbox" value="<%=rightBean.getId()%>" <%if(!StringHelper.isEmpty(rights)&&rights.contains(rightBean.getId())){ %> checked="checked" <%} %> class="mr5 rightId" />
												<label for="_<%=j++ %>"><%StringHelper.filterHTML(out,rightBean.getName());%></label>
											</li>
											<%}}%>
										</ul>
										</div>
										<%}}%>
										<div class="clear"></div>
									</div>
									<div class="tc w220 pt20">
										<%
											if (dimengSession.isAccessableResource(SetRight.class)) {
										%> 
										<input type="button" class="btn4 mr30" onclick="check()" value="确认" />						
										<%}else{ %>
										<input type="button" class="disabled" value="确认" />
										<%} %>
										<input type="button" onclick="location.href='<%=controller.getURI(request, RoleList.class) %>'" class="btn5" value="取消" />
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
	<script type="text/javascript">
	function selectAll(id){
		var inputs = document.getElementById(id).getElementsByTagName("input");
		for( var i=0;i<inputs.length;i++){
			var input = inputs[i];
			if(input.type!='checkbox'){continue;}
			input.checked=true;
		}
	}
	function unselectAll(id){
		var inputs = document.getElementById(id).getElementsByTagName("input");
		for( var i=0;i<inputs.length;i++){
			var input = inputs[i];
			if(input.type!='checkbox'){continue;}
			input.checked=false;
		}
	}
	function revertAll(id){
		var inputs = document.getElementById(id).getElementsByTagName("input");
		for( var i=0;i<inputs.length;i++){
			var input = inputs[i];
			if(input.type!='checkbox'){continue;}
			input.checked=!input.checked;
		}
	}
	function check()
	{
		var checked=false;
		var checkBoxs = $(".rightId");
		for (var i = 0; i <= checkBoxs.length - 1; i++) {
			if ($(checkBoxs[i]).attr("checked") == "checked") {
				checked=true;
				break;
			}
		}
		if (!checked) {
			alert("请选择需要设置的权限.");
			return;
		}
		$("#form1").submit();
	}
	</script>
</body>
</html>