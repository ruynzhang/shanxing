<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.console.servlets.account.zhgl.ZhList"%>
<%@page import="com.dimeng.p2p.console.servlets.account.zhgl.AddGr"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%
		CURRENT_CATEGORY = "YHGL";
		CURRENT_SUB_CATEGORY = "ZHGL";
	%>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="w_main">
		<div class="main clearfix">
			<div class="wrap">
				<div class="r_main">
					<div class="home_main">
						<div class="box box1 mb15">
							<div class="atil">
								<h3>添加个人账号</h3>
							</div>
							<div class="con">
								<div class="clear"></div>
								<form action="<%=controller.getURI(request, AddGr.class)%>" method="post" class="form1">
									<ul class="cell xc_jcxx ">
										<li>
											<div class="til">
												<span class="red">*</span>登录账号：
											</div>
											<div class="info">
												<input name="userName" type="text" maxlength="18" mtest="/^[a-z]([\w]{5,17})$/i" mtestmsg="6-18个字符，可使用字母、数字、下划线、需以字母开头" value="<%StringHelper.filterQuoter(out,
														request.getParameter("userName"));%>" class="text yhgl_ser yw_w5"/>
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
												<input type="password" maxlength="20" name="password" class="text yhgl_ser yw_w5 password-a" />
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
												<input type="password" maxlength="20" name="newPassword" class="text yhgl_ser yw_w5 password-b" />
												<p tip></p>
												<p errortip class="" style="display: none"></p>
											</div>
											<div class="clear"></div>
										</li>
									</ul>
									<div class="tc w220 pt20">
										<%
											if (dimengSession.isAccessableResource(AddGr.class)) {
										%>
										<input type="submit" class="btn4 mr30 sumbitForme" fromname="form1" value="确认" />
										<%
											} else {
										%>
										<input type="button" class="disabled" value="确认" />
										<%
											}
										%>
										<input type="button" onclick="location.href='<%=controller.getURI(request, ZhList.class) %>'" class="btn4" value="返回" />
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
	<%
		String warringMessage=controller.getPrompt(request, response, PromptLevel.ERROR);
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