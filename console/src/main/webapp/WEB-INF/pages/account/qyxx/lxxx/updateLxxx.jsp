<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.console.servlets.account.qyxx.UpdateQyxx"%>
<%@page import="com.dimeng.p2p.console.servlets.account.qyxx.dgzh.UpdateDgzh"%>
<%@page import="com.dimeng.p2p.console.servlets.account.qyxx.cwzk.UpdateCwzk"%>
<%@page import="com.dimeng.p2p.console.servlets.account.qyxx.fcxx.ListFcxx"%>
<%@page import="com.dimeng.p2p.console.servlets.account.qyxx.QyList"%>
<%@page import="com.dimeng.p2p.console.servlets.account.qyxx.ccxx.ListCcxx"%>
<%@page import="com.dimeng.p2p.console.servlets.account.qyxx.jscl.UpdateJscl"%>
<%@page import="com.dimeng.p2p.console.servlets.Region"%>
<%@page import="com.dimeng.p2p.console.servlets.account.qyxx.lxxx.UpdateLxxx"%>
<%@page import="com.dimeng.p2p.S61.entities.T6164"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%
		CURRENT_CATEGORY = "YHGL";
			CURRENT_SUB_CATEGORY = "QY";
			T6164 entity = ObjectHelper.convert(
					request.getAttribute("info"), T6164.class);
			
			int shengId=0;
			int shiId=0;
			int xianId=0;
			final int regionId = entity.F02;
			if (regionId % 10000 < 100) {
		            shengId = regionId;
		        } else if (regionId % 100 < 1) {
		            shengId = regionId / 10000 * 10000;
		            shiId = regionId;
		        } else {
		            shengId = regionId / 10000 * 10000;
		            shiId = regionId / 100 * 100;
		            xianId = regionId;
		       }
	%>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="w_main">
		<div class="main clearfix">
			<div class="wrap">
				<div class="r_main">
					<div class="home_main">
						<div class="box box1 mb15">
							<div class="atil">
								<h3>修改企业信息</h3>
							</div>
						</div>
						<div class="newsbox">
							<div class="til clearfix">
								<div class="Menubox">
									<ul>
										<li><a href="<%=controller.getURI(request, UpdateQyxx.class)%>?id=<%StringHelper.filterHTML(out, request.getParameter("id"));%>">企业信息</a></li>
										<li><a href="<%=controller.getURI(request, UpdateJscl.class)%>?id=<%StringHelper.filterHTML(out, request.getParameter("id"));%>">介绍资料</a></li>
										<li><a href="<%=controller.getURI(request, UpdateCwzk.class)%>?id=<%StringHelper.filterHTML(out, request.getParameter("id"));%>">财务状况</a></li>
										<li  class="hover">联系信息</li>
										<li><a href="<%=controller.getURI(request, ListCcxx.class)%>?id=<%StringHelper.filterHTML(out, request.getParameter("id"));%>">车产信息</a></li>
										<li><a href="<%=controller.getURI(request, ListFcxx.class)%>?id=<%StringHelper.filterHTML(out, request.getParameter("id"));%>">房产信息</a></li>
										<%--
										<li><a href="<%=controller.getURI(request, UpdateDgzh.class)%>?id=<%StringHelper.filterHTML(out, request.getParameter("id"));%>">对公账户</a></li>
										 --%>
									</ul>
								</div>
							</div>
							<div class="border p30 Men_bt no_table">
								<input id="shengId" value="<%=shengId%>" type="hidden" /> 
								<input id="shiId" value="<%=shiId%>" type="hidden" /> 
								<input id="xianId" value="<%=xianId%>" type="hidden" />
								<form action="<%=controller.getURI(request, UpdateLxxx.class)%>"
									method="post" class="form1">
									<input type="hidden" id="id" name="id" value="<%=request.getParameter("id")%>">
									<ul class="cell noborder no_wi">
										<li>
											<div class="til">
												<span class="red">*</span>所在区域：
											</div>
											<div class="info">
												<select name="sheng" class="sel01"></select> <select
													name="shi" class="sel01"></select> <select name="xian"
													class="sel01 required"></select>
												<p tip></p>
												<p errortip class="" style="display: none"></p>
											</div>
											<div class="clear"></div>
										</li>
										<li>
											<div class="til">
												<span class="red">*</span>联系地址：
											</div>
											<div class="info">
												<input name="F03" maxlength="40" type="text"
													class="text yhgl_ser required" value="<%StringHelper.filterHTML(out, entity.F03); %>" />
												<p tip></p>
												<p errortip class="" style="display: none"></p>
											</div>
											<div class="clear"></div>
										</li>
										<li>
											<div class="til">
												<span class="red">*</span>企业联系人：
											</div>
											<div class="info">
												<input name="F07" maxlength="20" type="text"
													class="text yhgl_ser required" value="<%StringHelper.filterHTML(out, entity.F07); %>" />
												<p tip></p>
												<p errortip class="" style="display: none"></p>
											</div>
											<div class="clear"></div>
										</li>
										<li>
											<div class="til">
												<span class="red">*</span>联系人电话：
											</div>
											<div class="info">
												<input name="F04" maxlength="13" type="text"
													class="text yhgl_ser required phonenumber" value="<%StringHelper.filterHTML(out, entity.F04); %>" />
												<p tip></p>
												<p errortip class="" style="display: none"></p>
											</div>
											<div class="clear"></div>
										</li>
										<li>
											<div class="til">
												<span class="red">*</span>网站地址：
											</div>
											<div class="info">
												<input name="F05" maxlength="40" type="text"
													class="text yhgl_ser required" value="<%StringHelper.filterHTML(out, entity.F05); %>" />
												<p tip></p>
												<p errortip class="" style="display: none"></p>
											</div>
											<div class="clear"></div>
										</li>
										<li>
											<div class="til">
												<span class="red">*</span>法人联系电话：
											</div>
											<div class="info">
												<input name="F06" maxlength="20" type="text"
													class="text yhgl_ser required" value="<%StringHelper.filterHTML(out, entity.F06); %>" />
												<p tip></p>
												<p errortip class="" style="display: none"></p>
											</div>
											<div class="clear"></div>
										</li>
										<li>
											<div class="info">
												<input type="hidden" name="F01" value="<%=entity.F01%>" />
											</div>
										</li>
										<li>
											<div class="clear"></div>
										</li>
									</ul>
									<div class="tc w220">
										<input type="submit" class="btn4 mr30 sumbitForme" value="保存并继续"
											fromname="form1" /> <input type="button" class="btn4"
											onclick="window.location.href='<%=controller.getURI(request, QyList.class)%>'"
											value="返回" />
									</div>
									<div class="clear"></div>
								</form>
							</div>
							<div class="mb15"></div>
							<div class="box2 clearfix"></div>
						</div>
					</div>
				</div>
			</div>
			<%
				String warringMessage = controller.getPrompt(request, response,
							PromptLevel.ERROR);
					if (!StringHelper.isEmpty(warringMessage)) {
			%>
			<div class="w440 thickbox thickpos" style="margin: -80px 0 0 -220px;"
				id="showDiv">
				<div class="info clearfix">
					<div class="clearfix">
						<span class="fl tips">
							<%
								StringHelper.filterHTML(out, warringMessage);
							%>
						</span>
					</div>
					<div class="dialog_btn">
						<input type="button" name="button2" onclick="$('#showDiv').hide()"
							value="确认" class="btn4 ml50" />
					</div>
				</div>
			</div>
			<%
				}
			%>
			<%@include file="/WEB-INF/include/left.jsp"%>
		</div>
	</div>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
	<script type="text/javascript"
		src="<%=controller.getStaticPath(request)%>/js/validation.js"></script>
	<script type="text/javascript"
		src="<%=controller.getURI(request, Region.class)%>"></script>
</body>
</html>