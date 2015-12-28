<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.console.servlets.finance.fksh.DetailAuthentication"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.fksh.ViewAuthentication"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.fksh.ViewHkRecord"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.fksh.ViewRecord"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F20"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.fksh.DetailAnnexWz"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.fksh.DetailAnnexMsk"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.fksh.ViewGuarantee"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.fksh.ViewEnterprise"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.fksh.ViewUserInfo"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.fksh.ViewProject"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.fksh.DetailDyw"%>
<%@page import="com.dimeng.p2p.S62.entities.T6234"%>
<%@page import="com.dimeng.p2p.S62.entities.T6214"%>
<%@page import="com.dimeng.p2p.modules.bid.console.service.entity.BidDyw"%>
<%@page import="com.dimeng.p2p.S61.enums.T6110_F06"%>
<%@page import="com.dimeng.p2p.S62.entities.T6230"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F11"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F13"%>
<%@page import="com.dimeng.p2p.S61.entities.T6112"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="com.dimeng.p2p.common.enums.LoanType"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<%@page import="com.dimeng.p2p.S60.entities.T6213"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%
		CURRENT_CATEGORY = "CWGL";
		CURRENT_SUB_CATEGORY = "FKGL";
		int loanId = IntegerParser.parse(request.getParameter("loanId"));
		int userId = IntegerParser.parse(request.getParameter("userId"));
		T6234[] t6234s=ObjectHelper.convertArray(request.getAttribute("t6234s"), T6234.class);
		T6230 t6230 = ObjectHelper.convert(request.getAttribute("t6230"), T6230.class);
		T6110_F06 userType=EnumParser.parse(T6110_F06.class, request.getAttribute("userType").toString());
	%>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="w_main">
		<div class="main clearfix">
			<div class="wrap">
				<div class="r_main">
					<div class="home_main">
						<div class="box box1 mb15">
							<div class="atil">
								<h3>查看抵押物信息</h3>
							</div>
						</div>
						<div class="newsbox">
							<div class="til clearfix">
								<div class="Menubox">
									<ul>
										<%
											if(loanId>0)
											{
										%>
										<li><a href="<%=controller.getURI(request, ViewProject.class)%>?loanId=<%=loanId%>&userId=<%=userId%>">项目信息</a></li>
										<%
											}
										%>
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
										<li class="hover">抵押物信息</li>
										<%
											if(T6230_F11.S==t6230.F11)
																			{
										%>
										<li><a href="<%=controller.getURI(request, ViewGuarantee.class)%>?loanId=<%=loanId%>&userId=<%=userId%>">担保信息</a></li>
										<%
											}
										%>
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
									<div class="yw_jcxx">
										<table width="100%" border="0" cellspacing="0" cellpadding="3" class="yhgl_table tc">
											<tr class="hsbg">
												<td>序号</td>
												<td>抵押物类型ID</td>
												<td>抵押物名称</td>
												<td>操作</td>
											</tr>
											<%
												if(t6234s!=null)
												{int i=1;
												for(T6234 t6234:t6234s)
												{	if(t6234==null){continue;}
											%>
											<tr>
												<td><%=i++%></td>
												<td><%=t6234.F03%></td>
												<td>
													<%
														StringHelper.filterHTML(out, t6234.F04);
													%>
												</td>
												<td><a href="<%=controller.getURI(request, DetailDyw.class)%>?loanId=<%=loanId %>&userId=<%=userId %>&id=<%=t6234.F01%>&type=1">查看</a>&nbsp;
												</td>
											</tr>
											<%}} %>
										</table>
									</div>
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
	<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/validation.js"></script>
	<script type="text/javascript">
		function save() {
			$("#flag").attr("value", "0");
		}
		function saveCon() {
			$("#flag").attr("value", "1");
		}
	</script>
</body>
</html>