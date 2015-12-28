<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.util.filter.TextAreaFilter"%>
<%@page import="com.dimeng.p2p.console.servlets.system.constant.UpdateConstant"%>
<%@page import="com.dimeng.framework.config.entity.VariableBean"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
<%@include file="/WEB-INF/include/kindeditor.jsp" %>
</head>
<body>
	<%
		VariableBean variable = ObjectHelper.convert(request.getAttribute("variableBean"),VariableBean.class);
		if(variable==null)
		{
			response.sendError(HttpServletResponse.SC_NOT_FOUND);
			return;
		}
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
					<div class="home_main">
						<div class="box box1 mb15">
						<div class="atil">
	              				<h3>平台常量设置</h3>
	           				 </div>
							<div class="con">
								<div class="clear"></div>
								<form action="<%=controller.getURI(request, UpdateConstant.class)%>" method="post" class="form1">
									<input type="hidden" name="key" value="<%=variable.getKey()%>">
									<ul class="cell noborder yw_jcxx">
										<li>
											<div class="til">
												<span class="red">*</span> 常量名称：<br />
											</div>
											<div class="info orange"><%StringHelper.filterHTML(out, variable.getDescription());%></div>
											<div class="clear"></div>
										</li>
										<li>
											<div class="til">常量值：</div>
											<div class="info orange">
											<textarea rows="24" cols="80" class="border" name="value" class="required" ><%new TextAreaFilter(out).append(variable.getValue());%></textarea>
											<p tip></p>
											<p errortip class="" style="display: none"></p>
											</div>
											<div class="clear"></div>
										</li>
									</ul>
									<div class="tc w220 pt20">
										<input type="submit" class="btn4 mr30 sumbitForme" fromname="form1" value="保存" /><input type="button" onclick="location.href='<%=controller.getURI(request, ConstantList.class) %>'" class="btn5" value="取消" />
									</div>
									<div class="clear"></div>
								</form>
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