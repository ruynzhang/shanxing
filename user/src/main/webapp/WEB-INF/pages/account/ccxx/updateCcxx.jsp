<%@page import="com.dimeng.p2p.user.servlets.account.fcxx.Fcxx"%>
<%@page import="com.dimeng.p2p.user.servlets.account.gzxx.Gzxx"%>
<%@page import="com.dimeng.p2p.user.servlets.account.xlxx.Xlxx"%>
<%@page import="com.dimeng.p2p.user.servlets.account.UserBases"%>
<%@page import="com.dimeng.p2p.user.servlets.account.ccxx.UpdateCcxx"%>
<%@page import="com.dimeng.p2p.S61.entities.T6113"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
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
		T6113 t	= ObjectHelper.convert(request.getAttribute("t"), T6113.class);
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
							<li><a href="<%=controller.getURI(request, Gzxx.class) %>">个人工作信息</a></li>
							<li><a href="<%=controller.getURI(request, Fcxx.class) %>">房产信息</a></li>
							<li  class="hover">车产信息</li>
						</ul>
					</div>
				</div>

				<div class="p30">
					<div class="fl jc_l">&nbsp;</div>
					<div class="jc_z fl">
					<form action="<%=controller.getURI(request, UpdateCcxx.class) %>" class="form1" method="post">
						<input type="hidden" name="F01" value="<%=t.F01%>"/>
						<ul>
							<li>
								<div class="til">
									<span class="red">*</span>汽车品牌：
								</div>
								<div class="info">
									<input type="text" name="F03" value="<%StringHelper.filterHTML(out, t.F03);%>" class="yhgl_ser w200 required max-length-30" />
									<p tip></p>
									<p errortip class="" style="display: none"></p>
								</div>
								<div class="tir"></div>
								<div class="clear"></div>
							</li>
							<li>
								<div class="til">
									<span class="red">*</span>车牌号码：
								</div>
								<div class="info">
									<input type="text" name="F04" value="<%=t.F04%>" class="yhgl_ser w200 required max-length-20" />
									<p tip></p>
									<p errortip class="" style="display: none"></p>
								</div>
								<div class="tir"></div>
								<div class="clear"></div>
							</li>
							<li>
								<div class="til">
									<span class="red">*</span>购车年份：
								</div>
								<div class="info">
									<input type="text" name="F05" value="<%=t.F05%>" class="yhgl_ser w200 required isint max-length-5" />年
									<p tip></p>
									<p errortip class="" style="display: none"></p>
								</div>
								<div class="tir"></div>
								<div class="clear"></div>
							</li>
							<li>
								<div class="til">
									<span class="red">*</span>购买价格(元)：
								</div>
								<div class="info">
									<input type="text" name="F06" value="<%=t.F06%>" class="yhgl_ser w200" maxlength="9" mtest="/^((([1-9][0-9]*)|0)|((([1-9][0-9]*)|0)\.[0-9]{1,2}))$/" mtestmsg="必须为数字格式(且是两位小数)"/>
									<p tip></p>
									<p errortip class="" style="display: none"></p>
								</div>
								<div class="tir"></div>
								<div class="clear"></div>
							</li>
								<li>
								<div class="til">
									<span class="red">*</span>评估价格(元)：
								</div>
								<div class="info">
									<input type="text" name="F07" value="<%=t.F07%>" class="yhgl_ser w200" maxlength="9" mtest="/^((([1-9][0-9]*)|0)|((([1-9][0-9]*)|0)\.[0-9]{1,2}))$/" mtestmsg="必须为数字格式(且是两位小数)" />
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

	<script type="text/javascript">
		
	</script>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
	<%@include file="/WEB-INF/include/dialog.jsp"%>
	<script type="text/javascript"
		src="<%=controller.getStaticPath(request)%>/js/validation.js"></script>
</body>
</html>