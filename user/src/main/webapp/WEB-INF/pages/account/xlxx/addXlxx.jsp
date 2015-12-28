<%@page import="com.dimeng.p2p.common.FormToken"%>
<%@page import="com.dimeng.p2p.user.servlets.account.ccxx.Ccxx"%>
<%@page import="com.dimeng.p2p.user.servlets.account.fcxx.Fcxx"%>
<%@page import="com.dimeng.p2p.user.servlets.account.gzxx.Gzxx"%>
<%@page import="com.dimeng.p2p.user.servlets.account.UserBases"%>
<%@page import="com.dimeng.p2p.user.servlets.account.xlxx.AddXlxx"%>
<%@page import="com.dimeng.p2p.account.user.service.UserBaseManage"%>
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
							<li class="hover">个人学历信息</li>
							<li><a href="<%=controller.getURI(request, Gzxx.class) %>">个人工作信息</a></li>
							<li><a href="<%=controller.getURI(request, Fcxx.class) %>">房产信息</a></li>
							<li style="border-right: 1px #d7dfe3 solid;"><a href="<%=controller.getURI(request, Ccxx.class) %>">车产信息</a></li>
						</ul>
					</div>
				</div>
				
				<div class="p30">
					<div class="fl jc_l">&nbsp;</div>
					<div class="jc_z fl">
					<form action="<%=controller.getURI(request, AddXlxx.class) %>" method="post" class="form1">
						<%=FormToken.hidden(serviceSession.getSession()) %>
						<ul>
							<li>
								<div class="til">
									<span class="red">*</span>毕业院校：
								</div>
								<div class="info">
									<input type="text" name="F03"   mtest="/^[a-z\A-Z\u4E00-\u9FA5]+$/i" mtestmsg="请输入中文或英文字符"  value="<%StringHelper.filterHTML(out, request.getParameter("F03"));%>" class="yhgl_ser w200 required max-length-30" />
									<p tip></p>
									<p errortip class="" style="display: none"></p>
								</div>
								<div class="tir"></div>
								<div class="clear"></div>
							</li>
							<li>
								<div class="til">
									<span class="red">*</span>入学年份：
								</div>
								<div class="info">
									<input type="text" name="F04"  mtest="/^[1-9]{1}\d{3}$/" mtestmsg="请输入正确的年份"  value="<%StringHelper.filterHTML(out, request.getParameter("F04"));%>" class="yhgl_ser w200 required isint max-length-30" />年
									<p tip></p>
									<p errortip class="" style="display: none"></p>
								</div>
								<div class="tir"></div>
								<div class="clear"></div>
							</li>
							<li>
								<div class="til">
									<span class="red">*</span>专业：
								</div>
								<div class="info">
									<input type="text" name="F05"  mtest="/^[a-z\A-Z\u4E00-\u9FA5]{3,20}$/i" mtestmsg="请输入3到20位的中文或英文字符"  value="<%StringHelper.filterHTML(out, request.getParameter("F05"));%>" class="yhgl_ser w200 required max-length-30" />
									<p tip></p>
									<p errortip class="" style="display: none"></p>
								</div>
								<div class="tir"></div>
								<div class="clear"></div>
							</li>
							<li>
								<div class="til">
									<span class="red">*</span>在校情况简介：
								</div>
								<div class="info">
									<input type="text" name="F06"  mtest="/^[a-z\A-Z\u4E00-\u9FA5]+$/i" mtestmsg="请输入中文或英文字符"  value="<%StringHelper.filterHTML(out, request.getParameter("F06"));%>" class="yhgl_ser w200 required max-length-30" />
									<p tip></p>
									<p errortip class="" style="display: none"></p>
								</div>
								<div class="tir"></div>
								<div class="clear"></div>
							</li>
							<li>
								<div class="til">
									&nbsp;
								</div>
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
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
	<%@include file="/WEB-INF/include/dialog.jsp"%>
	<script type="text/javascript">
	</script>
	<script type="text/javascript"
		src="<%=controller.getStaticPath(request)%>/js/validation.js"></script>
</body>
</html>