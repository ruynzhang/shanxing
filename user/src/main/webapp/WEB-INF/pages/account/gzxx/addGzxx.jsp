<%@page import="com.dimeng.p2p.user.servlets.account.ccxx.Ccxx"%>
<%@page import="com.dimeng.p2p.user.servlets.account.fcxx.Fcxx"%>
<%@page import="com.dimeng.p2p.user.servlets.account.xlxx.Xlxx"%>
<%@page import="com.dimeng.p2p.user.servlets.account.UserBases"%>
<%@page import="com.dimeng.p2p.S61.enums.T6143_F03"%>
<%@page import="com.dimeng.p2p.user.servlets.account.gzxx.AddGzxx"%>
<%@page import="com.dimeng.p2p.user.servlets.Region"%>
<%@page import="com.dimeng.p2p.common.FormToken"%>
<%@include file="/WEB-INF/include/authenticatedSession.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title><%=configureProvider.getProperty(SystemVariable.SITE_NAME)%></title>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<%
		CURRENT_CATEGORY = "ZHGL";
			CURRENT_SUB_CATEGORY = "GRJCXX";
	%>
	<div class="w994 pb5">
		<span class="f16"><a href="#">我的<%
			configureProvider.format(out,SystemVariable.SITE_NAME);
		%></a></span> &gt; <a href="#">账户管理</a> &gt;个人基础信息
	</div>
	<div class="contain clearfix">
		<div class="user_top"></div>
		<div class="about">
			<%@include file="/WEB-INF/include/menu.jsp"%>
			<div class="container fr">

				<div class="til clearfix Men_bt">
					<div class="Menubox">
						<ul>
							<li><a href="<%=controller.getURI(request, UserBases.class) %>">个人基本信息</a></li>
							<li><a href="<%=controller.getURI(request, Xlxx.class) %>">个人学历信息</a></li>
							<li  class="hover">个人工作信息</li>
							<li><a href="<%=controller.getURI(request, Fcxx.class) %>">房产信息</a></li>
							<li style="border-right: 1px #d7dfe3 solid;"><a href="<%=controller.getURI(request, Ccxx.class) %>">车产信息</a></li>
						</ul>
					</div>
				</div>

				<div class="p30">
					<div class="fl jc_l">&nbsp;</div>
					<div class="jc_z fl">
						<form action="<%=controller.getURI(request, AddGzxx.class)%>" class="form1"
							method="post">
							<%=FormToken.hidden(serviceSession.getSession()) %>
							<ul>
								<li>
									<div class="til">
										<span class="red">*</span>工作状态：
									</div>
									<div class="info">
										<select name="F03" class="yhgl_ser">
											<%for(T6143_F03 t : T6143_F03.values()){ %>
												<option value="<%=t.name()%>" <%if(t.name().equals(request.getParameter("F03"))) %>  selected="selected" <%; %>><%=t.getChineseName() %></option>
											<%} %>
										</select>
									</div>
									<div class="tir"></div>
									<div class="clear"></div>
								</li>
								<li>
									<div class="til">
										<span class="red">*</span>单位名称：
									</div>
									<div class="info">
										<input type="text" name="F04" maxlength="30"
											value="<%StringHelper.filterHTML(out, request.getParameter("F04"));%>"
											class="yhgl_ser w200 required max-length-30" />
										<p tip></p>
										<p errortip class="" style="display: none"></p>
									</div>
									<div class="tir"></div>
									<div class="clear"></div>
								</li>
								<li>
									<div class="til">
										<span class="red">*</span>职位：
									</div>
									<div class="info">
										<input type="text" name="F05" maxlength="30"
											value="<%StringHelper.filterHTML(out, request.getParameter("F05"));%>"
											class="yhgl_ser w200 required max-length-30" />
										<p tip></p>
										<p errortip class="" style="display: none"></p>	
									</div>
									<div class="tir"></div>
									<div class="clear"></div>
								</li>
								<li>
									<div class="til">
										<span class="red">*</span>工作邮箱：
									</div>
									<div class="info">
										<input type="text" name="F06" maxlength="50"
											value="<%StringHelper.filterHTML(out, request.getParameter("F06"));%>"
											class="yhgl_ser w200 required e-mail max-length-50" />
										<p tip></p>
										<p errortip class="" style="display: none"></p>
									</div>
									<div class="tir"></div>
									<div class="clear"></div>
								</li>
								<li>
									<div class="til">
										<span class="red">*</span>工作城市：
									</div>
									<div class="info">
											<select name="sheng" class="yhgl_ser"></select> <select
											name="shi" class="yhgl_ser"></select> <select name="xian"
											class="yhgl_ser required"></select>
										<p tip></p>
										<p errortip class="" style="display: none"></p>
									</div>
									<div class="tir"></div>
									<div class="clear"></div>
								</li>
								<li>
									<div class="til">
										<span class="red">*</span>工作地址：
									</div>
									<div class="info">
										<input type="text" name="F08" maxlength="45"
											value="<%StringHelper.filterHTML(out, request.getParameter("F08"));%>"
											class="yhgl_ser w200 required max-length-45" />
										<p tip></p>
										<p errortip class="" style="display: none"></p>
									</div>
									<div class="tir"></div>
									<div class="clear"></div>
								</li>
								<li>
									<div class="til">
										<span class="red">*</span>公司类别：
									</div>
									<div class="info">
										<input type="text" name="F09" maxlength="20"
											value="<%StringHelper.filterHTML(out, request.getParameter("F09"));%>"
											class="yhgl_ser w200 required max-length-20" />
										<p tip></p>
										<p errortip class="" style="display: none"></p>
									</div>
									<div class="tir"></div>
									<div class="clear"></div>
								</li>
								<li>
									<div class="til">
										<span class="red">*</span>公司行业：
									</div>
									<div class="info">
										<input type="text" name="F10" maxlength="30"
											value="<%StringHelper.filterHTML(out, request.getParameter("F10"));%>"
											class="yhgl_ser w200 required max-length-30" />
										<p tip></p>
										<p errortip class="" style="display: none"></p>
									</div>
									<div class="tir"></div>
									<div class="clear"></div>
								</li>
								<li>
									<div class="til">
										<span class="red">*</span>公司规模：
									</div>
									<div class="info">
										<input type="text" name="F11" maxlength="19"
											value="<%StringHelper.filterHTML(out, request.getParameter("F11"));%>"
											class="yhgl_ser w200 required isint max-length-19" />人
										<p tip></p>
										<p errortip class="" style="display: none"></p>
									</div>
									<div class="tir"></div>
									<div class="clear"></div>
								</li>
								<li>
									<div class="til">&nbsp;</div>
									<div class="info">
										<input type="submit" class="btn01 sumbitForme" fromname="form1" value="提交">
									</div>
									<div class="tir"></div>
									<div class="clear"></div>
								</li>
							</ul>
						</form>
					</div>

				</div>

			</div>
			<div class="clear"></div>
		</div>
	</div>
	<div class="clear"></div>

	<script type="text/javascript">
		
	</script>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
	<%@include file="/WEB-INF/include/dialog.jsp"%>
	<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/validation.js"></script>
	<script type="text/javascript" src="<%=controller.getURI(request, Region.class)%>"></script>
</body>
</html>