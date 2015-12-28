<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.console.servlets.bid.jkgl.DetailAuthentication"%>
<%@page import="com.dimeng.p2p.modules.account.console.service.entity.Grxx"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.jkgl.ViewHkRecord"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.jkgl.ViewRecord"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F20"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F11"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F13"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.jkgl.LoanList"%>
<%@page import="com.dimeng.p2p.S62.entities.T6230"%>
<%@page import="com.dimeng.p2p.S61.entities.T6143"%>
<%@page import="com.dimeng.p2p.S61.entities.T6141"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.jkgl.DetailAnnexWz"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.jkgl.DetailAnnexMsk"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.jkgl.ViewGuarantee"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.jkgl.ViewEnterprise"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.jkgl.ViewDyw"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.jkgl.ViewProject"%>
<%@page import="com.dimeng.p2p.common.enums.LoanType"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%
		CURRENT_CATEGORY = "YWGL";
			CURRENT_SUB_CATEGORY = "BDGL";
			int loanId = IntegerParser.parse(request.getParameter("loanId"));
			int userId=IntegerParser.parse(request.getParameter("userId"));
			T6230 t6230 = ObjectHelper.convert(request.getAttribute("t6230"), T6230.class);
			Grxx user=ObjectHelper.convert(request.getAttribute("user"), Grxx.class);
			if(t6230==null)
			{
		response.sendError(HttpServletResponse.SC_NOT_FOUND);
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
								<h3>查看借款信息</h3>
							</div>
						</div>
						<div class="newsbox">
							<div class="til clearfix">
							<a
									href="<%=controller.getURI(request, LoanList.class)%>"
									class="btn4 tc" style="float: right" >返回</a>
								<div class="Menubox">
									<ul>
										<li><a href="<%=controller.getURI(request, ViewProject.class)%>?loanId=<%=loanId%>&userId=<%=userId%>">项目信息</a></li>
										<li class="hover">个人信息</li>
										<li><a href="<%=controller.getURI(request, DetailAuthentication.class)%>?loanId=<%=loanId%>&userId=<%=userId%>">个人认证信息</a></li>
										<%
											if(T6230_F13.S==t6230.F13){
										%>
										<li><a href="<%=controller.getURI(request, ViewDyw.class)%>?loanId=<%=loanId%>&userId=<%=userId%>">抵押物信息</a></li>
										<%} %>
										<%
											if(T6230_F11.S==t6230.F11)
											{
										%>
										<li><a href="<%=controller.getURI(request, ViewGuarantee.class)%>?loanId=<%=loanId%>&userId=<%=userId%>">担保信息</a></li>
										<%} %>
										<li><a href="<%=controller.getURI(request, DetailAnnexMsk.class)%>?loanId=<%=loanId%>&userId=<%=userId%>">附件(马赛克)</a></li>
										<li><a href="<%=controller.getURI(request, DetailAnnexWz.class)%>?loanId=<%=loanId%>&userId=<%=userId%>">附件(完整版)</a></li>
										<%
										if(t6230.F20!=T6230_F20.SQZ&&t6230.F20!=T6230_F20.DSH&&t6230.F20!=T6230_F20.DFB&&t6230.F20!=T6230_F20.YFB)
											{
										%>
										<li><a href="<%=controller.getURI(request, ViewRecord.class)%>?loanId=<%=loanId%>&userId=<%=userId%>">投资记录</a></li>
										<li><a href="<%=controller.getURI(request, ViewHkRecord.class)%>?loanId=<%=loanId%>&userId=<%=userId%>">还款计划</a></li>
										<%} %>
									</ul>
								</div>
							</div>
							<div class="border p30 Men_bt no_table yw_dl">
								<div class="f16">基本信息</div>
								<div class="hsxt"></div>
								<div class="mb20">
									<div class="yw_jcxx">
										<ul class="cell noborder">
											<li>
												<div class="til">
													<span class="red">*</span>真实姓名：
												</div>
												<div class="info">
													<%StringHelper.filterHTML(out, user.name);%>
												</div>
												<div class="clear"></div>
											</li>
											<li>
												<div class="til">
													<span class="red">*</span>身份证号：
												</div><%StringHelper.filterHTML(out, StringHelper.decode(user.sfzh));%>
												<div class="clear"></div>
											</li>
											<li>
												<div class="til">
													<span class="red">*</span>手机：
												</div>
												<div class="info">
													<%StringHelper.filterHTML(out, user.phone);%>
												</div>
												<div class="clear"></div>
											</li>
											<li>
												<div class="til">
													<span class="red">*</span>邮箱：
												</div>
												<div class="info">
													<%StringHelper.filterHTML(out, user.email);%>
												</div>
												<div class="clear"></div>
											</li>
										</ul>
									</div>
									<div class="clear"></div>
								</div>
							</div>
						</div>
						<div class="clear"></div>
					</div>
				</div>
			</div>
			<%@include file="/WEB-INF/include/left.jsp"%>
		</div>
	</div>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
</body>
</html>