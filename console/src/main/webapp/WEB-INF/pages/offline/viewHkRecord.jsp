<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.console.servlets.offline.OfflineLoanList"%>
<%@page import="com.dimeng.p2p.console.servlets.offline.DetailAuthentication"%>
<%@page import="com.dimeng.p2p.console.servlets.offline.ViewRecord"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F20"%>
<%@page import="com.dimeng.p2p.modules.bid.console.service.entity.Hkjllb"%>
<%@page import="com.dimeng.p2p.console.servlets.offline.DetailAnnexMsk"%>
<%@page import="com.dimeng.p2p.modules.bid.console.service.entity.TbRecord"%>
<%@page import="com.dimeng.p2p.S62.entities.T6250"%>
<%@page import="com.dimeng.p2p.modules.bid.console.service.entity.MskAnnex"%>
<%@page import="com.dimeng.p2p.S62.entities.T6232"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F13"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F11"%>
<%@page import="com.dimeng.p2p.console.servlets.offline.ViewAnnexWz"%>
<%@page import="com.dimeng.p2p.S62.entities.T6230"%>
<%@page import="com.dimeng.p2p.S61.enums.T6110_F06"%>
<%@page import="com.dimeng.p2p.console.servlets.offline.ViewAnnexMsk"%>
<%@page import="com.dimeng.p2p.console.servlets.offline.DetailAnnexWz"%>
<%@page import="com.dimeng.p2p.console.servlets.offline.ViewGuarantee"%>
<%@page import="com.dimeng.p2p.console.servlets.offline.ViewEnterprise"%>
<%@page import="com.dimeng.p2p.console.servlets.offline.ViewDyw"%>
<%@page import="com.dimeng.p2p.console.servlets.offline.ViewUserInfo"%>
<%@page import="com.dimeng.p2p.console.servlets.offline.ViewProject"%>
<%@page import="com.dimeng.p2p.common.enums.LoanType"%>
<%@page import="com.dimeng.p2p.S60.enums.T6216_F05"%>
<%@page import="com.dimeng.p2p.console.servlets.offline.DelAnnexMsk"%>
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
		CURRENT_SUB_CATEGORY="XXZQGL";
		Hkjllb[] hkjllbs =ObjectHelper.convertArray(request.getAttribute("hkjllbs"), Hkjllb.class);
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
								<h3>查看还款计划</h3>
							</div>
						</div>
						<div class="newsbox">
							<div class="til clearfix">
							<a href="<%=controller.getURI(request, OfflineLoanList.class)%>"
									class="btn4 tc" style="float: right" >返回</a>
								<div class="Menubox">
									<ul>
										<li><a href="<%=controller.getURI(request, ViewProject.class)%>?loanId=<%=loanId%>&userId=<%=userId%>">项目信息</a></li>
										<%
											if(userType==T6110_F06.ZRR)
																			{
										%>
										<li><a href="<%=controller.getURI(request, ViewUserInfo.class)%>?loanId=<%=loanId%>&userId=<%=userId%>">个人信息</a></li>
										<li><a href="<%=controller.getURI(request, DetailAuthentication.class)%>?loanId=<%=loanId%>&userId=<%=userId%>">个人认证信息</a></li>
										<%
											}
										%>
										<%
											if(userType==T6110_F06.FZRR)
																			{
										%>
										<li><a href="<%=controller.getURI(request, ViewEnterprise.class)%>?loanId=<%=loanId%>&userId=<%=userId%>">企业信息</a></li>
										<%
											}
										%>
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
										<%} %>
										<li class="hover">还款计划</li>
									</ul>
								</div>
							</div>
							<div class="border p30 Men_bt no_table">
								<div class="mb20">
									<div class="yw_jcxx">
										<table width="100%" border="0" cellspacing="0" cellpadding="3" class="yhgl_table tc">
											<tr class="hsbg">
												<td>合约还款日期</td>
												<td>状态</td>
												<td>科目</td>
												<td>金额</td>
												<td>实际还款日期</td>
											</tr>
											<%
												if(hkjllbs!=null)
												{int i=1;
												for(Hkjllb hkjllb:hkjllbs)
												{	if(hkjllb==null){continue;}
											%>
											<tr>
												<td><%=DateParser.format(hkjllb.F02) %></td>
												<td>
													<%=hkjllb.F03.getChineseName()
													%>
												</td>
												<td><%StringHelper.filterHTML(out, hkjllb.F05);%></td>
												<td><%=Formater.formatAmount(hkjllb.F01)%></td>
												<td><%=DateParser.format(hkjllb.F04)%></td>
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