<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.S61.enums.T6120_F05"%>
<%@page import="com.dimeng.p2p.modules.account.console.service.entity.Rzxx"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.jkgl.LoanList"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.jkgl.DetailAuthent"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F20"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.jkgl.AddAnnexWz"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.jkgl.AddAnnexMsk"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.jkgl.AddGuaranteeXq"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F11"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F13"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.jkgl.AddDyw"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.jkgl.AddEnterpriseXq"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.jkgl.AddUserInfoXq"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.jkgl.UpdateProject"%>
<%@page import="com.dimeng.p2p.S62.entities.T6230"%>
<%@page import="com.dimeng.p2p.S61.enums.T6110_F06"%>
<%@page import="com.dimeng.p2p.common.enums.LoanType"%>
<%@page import="com.dimeng.p2p.S60.enums.T6216_F05"%>
<%@page import="com.dimeng.p2p.S60.enums.T6216_F03"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%
		CURRENT_CATEGORY="YWGL";
		CURRENT_SUB_CATEGORY="BDGL";
		Rzxx[] authentications =ObjectHelper.convertArray(request.getAttribute("authentications"), Rzxx.class);
		T6110_F06 userType=EnumParser.parse(T6110_F06.class, request.getAttribute("userType").toString());
		T6230 t6230=ObjectHelper.convert(request.getAttribute("t6230"), T6230.class);
		int loanId=IntegerParser.parse(request.getParameter("loanId"));
		int userId=IntegerParser.parse(request.getParameter("userId"));
	%>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="w_main">
		<div class="main clearfix">
			<div class="wrap">
				<div class="r_main">
					<div class="home_main">
						<div class="box box1 mb15">
							<div class="atil">
								<h3>查看认证信息</h3>
							</div>
						</div>
						<div class="newsbox">
							<div class="til clearfix">
							<a href="<%=controller.getURI(request, LoanList.class)%>"
									class="btn4 tc" style="float: right" >返回</a>
								<div class="Menubox">
									<ul>
										<li><a href="<%=controller.getURI(request, UpdateProject.class)%>?loanId=<%=loanId%>&userId=<%=userId%>">项目信息</a></li>
										<%
											if(userType==T6110_F06.ZRR)
																			{
										%>
										<li><a href="<%=controller.getURI(request, AddUserInfoXq.class)%>?loanId=<%=loanId%>&userId=<%=userId%>">个人信息</a></li>
										<%
											}
										%>
										<li class="hover">个人认证信息</li>
										<%
											if(userType==T6110_F06.FZRR)
																			{
										%>
										<li><a href="<%=controller.getURI(request, AddEnterpriseXq.class)%>?loanId=<%=loanId%>&userId=<%=userId%>">企业信息</a></li>
										<%
											}
										%>
										<%
											if(T6230_F13.S==t6230.F13){
										%>
										<li><a href="<%=controller.getURI(request, AddDyw.class)%>?loanId=<%=loanId%>&userId=<%=userId%>">抵押物信息</a></li>
										<%} %>
										<%
											if(T6230_F11.S==t6230.F11)
											{
										%>
										<li><a href="<%=controller.getURI(request, AddGuaranteeXq.class)%>?loanId=<%=loanId%>&userId=<%=userId%>">担保信息</a></li>
										<%} %>
										<li><a href="<%=controller.getURI(request, AddAnnexMsk.class)%>?loanId=<%=loanId%>&userId=<%=userId%>">附件(马赛克)</a></li>
										<li><a href="<%=controller.getURI(request, AddAnnexWz.class)%>?loanId=<%=loanId%>&userId=<%=userId%>">附件(完整版)</a></li>
									</ul>
								</div>
							</div>
							<div class="border p30 Men_bt no_table">
								<div class="mb20">
									<div class="yw_jcxx">
										<table width="100%" border="0" cellspacing="0" cellpadding="3" class="yhgl_table tc">
											<tr class="hsbg">
												<td>序号</td>
												<td>认证项目</td>
												<td>状态</td>
												<td>认证时间</td>
												<td>操作</td>
											</tr>
											<%
												if(authentications!=null)
												{int i=1;
												for(Rzxx entity:authentications)
												{	if(entity==null){continue;}
											%>
											<tr>
												<td><%=i++%></td>
												<td>
													<%
														StringHelper.filterHTML(out, entity.lxmc);
													%>
												</td>
												<td><%=entity.status.getChineseName()%></td>
												<td><%=DateTimeParser.format(entity.time)%></td>
												<%if(entity.status != T6120_F05.WYZ){ %>
												<td><a href="<%=controller.getURI(request, DetailAuthent.class)%>?id=<%=entity.yxjlID%>" target="_blank">查看</a></td>
												<%}else{ %>
												<td></td>
												<%} %>
											</tr>
											<%}} %>
										</table>
									</div>
								</div>
								<div class="clear"></div>
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