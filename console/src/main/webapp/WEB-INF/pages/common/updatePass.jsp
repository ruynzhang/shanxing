<%@page import="java.text.DecimalFormat"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="com.dimeng.p2p.variables.defines.SystemVariable"%>
<%@page import="com.dimeng.p2p.console.config.ConsoleConst"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<%@page import="com.dimeng.p2p.console.servlets.common.Index"%>
<%@page import="java.util.Date"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%
		CURRENT_CATEGORY = "SY";
	%>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="w_main">
		<div class="main clearfix">
			<div class="wrap">
				<div class="r_main">
					<div class="home_main">
						<div class="box box1 mb15">
							<div class="atil">
								<h3>修改密码</h3>
							</div>
							<div class="con" style="padding: 30px 0">
								<div class="clear"></div>
							<form action="<%=controller.getURI(request, UpdatePass.class)%>" method="post" class="form1">
								<ul class="cell noborder yw_jcxx">
									<li>
										<div class="til">原密码：</div>
										<div class="infr">
											<input type="password" class="text yhgl_ser yw_w5 required" name="oldPassWord"/>
											<p tip></p>
											<p errortip class="" style="display: none"></p>
										</div>
										<div class="clear"></div>
									</li>
									<li>
										<div class="til">新密码：</div>
										<div class="infr">
											<input type="password" class="text yhgl_ser yw_w5 required password-a" name="newPassWord1"/>
											<p tip></p>
											<p errortip class="" style="display: none"></p>
										</div>
										<div class="clear"></div>
									</li>
									<li>
										<div class="til">重复新密码：</div>
										<div class="infr">
											<input type="password" class="text yhgl_ser yw_w5 required password-b" name="newPassWord2"/>
											<p tip></p>
											<p errortip class="" style="display: none"></p>
										</div>
										<div align="center">
											<font color="red" size="2">
												<%
													StringHelper.filterHTML(out, controller.getPrompt(request,
																response, PromptLevel.ERROR));
												%>
											</font>
										</div>
										<div class="clear"></div>
									</li>
								</ul>
								<div class="tc w220 pt20">
									<input type="submit" class="btn4 mr30 sumbitForme" fromname="form1" value="确认" />
									<input type="button" onclick="location.href='<%=controller.getURI(request, Index.class) %>'" class="btn4" value="返回" />
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
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
	<script type="text/javascript"
		src="<%=controller.getStaticPath(request)%>/js/validation.js"></script>
</body>
</html>