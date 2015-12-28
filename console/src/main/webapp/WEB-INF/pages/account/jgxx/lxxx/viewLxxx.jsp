<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.console.servlets.account.jgxx.ViewJgxx"%>
<%@page import="com.dimeng.p2p.console.servlets.account.jgxx.lxxx.ViewLxxx"%>
<%@page import="com.dimeng.p2p.console.servlets.account.jgxx.fcxx.ViewListFcxx"%>
<%@page import="com.dimeng.p2p.console.servlets.account.jgxx.ccxx.ViewListCcxx"%>
<%@page import="com.dimeng.p2p.console.servlets.account.jgxx.cwzk.ViewCwzk"%>
<%@page import="com.dimeng.p2p.console.servlets.account.jgxx.jscl.ViewJscl"%>
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
			CURRENT_SUB_CATEGORY = "JG";
			T6164 entity = ObjectHelper.convert(
					request.getAttribute("info"), T6164.class);
			
	%>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="w_main">
		<div class="main clearfix">
			<div class="wrap">
				<div class="r_main">
					<div class="home_main">
						<div class="box box1 mb15">
							<div class="atil">
								<h3>机构信息</h3>
							</div>
						</div>
						<div class="newsbox">
							<div class="til clearfix">
								<div class="Menubox">
									<ul>
										<li><a href="<%=controller.getURI(request, ViewJgxx.class)%>?id=<%StringHelper.filterHTML(out, request.getParameter("id"));%>">机构信息</a></li>
										<li><a href="<%=controller.getURI(request, ViewJscl.class)%>?id=<%StringHelper.filterHTML(out, request.getParameter("id"));%>">介绍资料</a></li>
										<li><a href="<%=controller.getURI(request, ViewCwzk.class)%>?id=<%StringHelper.filterHTML(out, request.getParameter("id"));%>">财务状况</a></li>
										<li  class="hover">联系信息</li>
										<li><a href="<%=controller.getURI(request, ViewListCcxx.class)%>?id=<%StringHelper.filterHTML(out, request.getParameter("id"));%>">车产信息</a></li>
										<li><a href="<%=controller.getURI(request, ViewListFcxx.class)%>?id=<%StringHelper.filterHTML(out, request.getParameter("id"));%>">房产信息</a></li>
									</ul>
								</div>
							</div>
							<div class="border p30 Men_bt no_table">
								<form action="<%=controller.getURI(request, ViewLxxx.class)%>"
									method="post" class="form1">
									<input type="hidden" id="id" name="id" value="<%=request.getParameter("id")%>">
									<ul class="cell noborder no_wi">
										<li>
											<div class="til">
												<span class="red">*</span>所在区域：
											</div>
											<div class="info">
												<%StringHelper.filterHTML(out, String.valueOf(request.getAttribute("region")));%>
											</div>
											<div class="clear"></div>
										</li>
										<li>
											<div class="til">
												<span class="red">*</span>联系地址：
											</div>
											<div class="info">
												<%StringHelper.filterHTML(out, entity.F03); %>
											</div>
											<div class="clear"></div>
										</li>
										<li>
											<div class="til">
												<span class="red">*</span>企业联系人：
											</div>
											<div class="info">
												<%StringHelper.filterHTML(out, entity.F07); %>
											</div>
											<div class="clear"></div>
										</li>
										<li>
											<div class="til">
												<span class="red">*</span>联系人电话：
											</div>
											<div class="info">
												<%StringHelper.filterHTML(out, entity.F04); %>
											</div>
											<div class="clear"></div>
										</li>
										<li>
											<div class="til">
												<span class="red">*</span>网站地址：
											</div>
											<div class="info">
												<%StringHelper.filterHTML(out, entity.F05); %>
											</div>
											<div class="clear"></div>
										</li>
										<li>
											<div class="til">
												<span class="red">*</span>法人联系电话：
											</div>
											<div class="info">
												<%StringHelper.filterHTML(out, entity.F06); %>
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
										<input type="button" class="btn4"
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
</body>
</html>