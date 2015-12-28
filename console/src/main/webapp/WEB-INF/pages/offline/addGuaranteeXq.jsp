<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.console.servlets.offline.DelDbxx"%>
<%@page import="com.dimeng.p2p.console.servlets.offline.OfflineLoanList"%>
<%@page import="com.dimeng.p2p.console.servlets.offline.ViewAuthentication"%>
<%@page import="com.dimeng.p2p.console.servlets.offline.DetailGuarantee"%>
<%@page import="com.dimeng.p2p.console.servlets.offline.UpdateGuarantee"%>
<%@page import="com.dimeng.p2p.console.servlets.offline.AddGuarantee"%>
<%@page import="com.dimeng.p2p.S62.entities.T6236"%>
<%@page import="com.dimeng.p2p.console.servlets.offline.AddDyw"%>
<%@page import="com.dimeng.p2p.console.servlets.offline.AddEnterpriseXq"%>
<%@page import="com.dimeng.p2p.console.servlets.offline.AddUserInfoXq"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F13"%>
<%@page import="com.dimeng.p2p.S62.entities.T6230"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F11"%>
<%@page import="com.dimeng.p2p.S61.enums.T6110_F06"%>
<%@page import="com.dimeng.p2p.modules.account.console.service.entity.Jg"%>
<%@page import="com.dimeng.p2p.modules.bid.console.service.entity.Dbxx"%>
<%@page import="com.dimeng.p2p.console.servlets.offline.UpdateProject"%>
<%@page import="com.dimeng.p2p.console.servlets.offline.AddGuaranteeXq"%>
<%@page import="com.dimeng.p2p.console.servlets.offline.AddAnnexWz"%>
<%@page import="com.dimeng.p2p.console.servlets.offline.AddAnnexMsk"%>
<%@page import="com.dimeng.p2p.common.enums.LoanType"%>
<%@page import="com.dimeng.p2p.S70.entities.T7029"%>
<%@page import="com.dimeng.p2p.S60.entities.T6215"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%
		CURRENT_CATEGORY = "YWGL";
		CURRENT_SUB_CATEGORY = "XXZQGL";
		int loanId = IntegerParser
				.parse(request.getParameter("loanId"));
		int userId = IntegerParser
				.parse(request.getParameter("userId"));
		T6110_F06 userType=EnumParser.parse(T6110_F06.class, request.getAttribute("userType").toString());
		T6230 t6230=ObjectHelper.convert(request.getAttribute("t6230"), T6230.class);
		Dbxx[] t6236s=ObjectHelper.convertArray(request.getAttribute("t6236s"), Dbxx.class);
	%>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="w_main">
		<div class="main clearfix">
			<div class="wrap">
				<div class="r_main">
					<div class="home_main">
						<div class="box box1 mb15">
							<div class="atil">
								<h3>新增/修改担保信息</h3>
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
										<li><a href="<%=controller.getURI(request, UpdateProject.class)%>?loanId=<%=loanId%>&userId=<%=userId%>">项目信息</a></li>
										<%} %>
										<%
											if(userType==T6110_F06.ZRR)
											{
										%>
										<li><a href="<%=controller.getURI(request, AddUserInfoXq.class)%>?loanId=<%=loanId%>&userId=<%=userId%>">个人信息</a></li>
										<li><a href="<%=controller.getURI(request, ViewAuthentication.class)%>?loanId=<%=loanId%>&userId=<%=userId%>">个人认证信息</a></li>
										<%} %>
										<%
											if(userType==T6110_F06.FZRR)
											{
										%>
										<li><a href="<%=controller.getURI(request, AddEnterpriseXq.class)%>?loanId=<%=loanId%>&userId=<%=userId%>">企业信息</a></li>
										<%} %>
										<%
											if(T6230_F13.S==t6230.F13){
										%>
										<li><a href="<%=controller.getURI(request, AddDyw.class)%>?loanId=<%=loanId%>&userId=<%=userId%>">抵押物信息</a></li>
										<%} %>
										<li class="hover">担保信息</li>
										<li><a href="<%=controller.getURI(request, AddAnnexMsk.class)%>?loanId=<%=loanId%>&userId=<%=userId%>">附件(马赛克)</a></li>
										<li><a href="<%=controller.getURI(request, AddAnnexWz.class)%>?loanId=<%=loanId%>&userId=<%=userId%>">附件(完整版)</a></li>
									</ul>
								</div>
							</div>
							<form action="<%=controller.getURI(request, AddGuaranteeXq.class)%>" method="post" id="form1" class="form1">
							<input type="hidden" name="loanId" value="<%=loanId %>" />
							<input type="hidden" name="userId" value="<%=userId %>" />
								<div class="border p30 Men_bt no_table yw_dl">
									<div class="mb20">
										 <a href="<%=controller.getURI(request, AddGuarantee.class)%>?loanId=<%=loanId%>&userId=<%=userId %>" class="btn4">添加担保信息</a>
										<div class="clear"></div>
									</div>
									<div class="yw_jcxx">
										<table width="100%" border="0" cellspacing="0" cellpadding="3" class="yhgl_table tc">
											<tr class="hsbg">
												<td>序号</td>
												<td>担保方</td>
												<td>是否主担保</td>
												<td>担保情况</td>
												<td>操作</td>
											</tr>
											<%
												if(t6236s!=null)
												{int i=1;
												for(Dbxx t6236:t6236s)
												{	if(t6236==null){continue;}
											%>
											<tr>
												<td><%=i++%></td>
												<td><%StringHelper.filterHTML(out,t6236.F06);%></td>
												<td><%=t6236.F04.getChineseName()%>
												</td>
												<td><%StringHelper.filterHTML(out,t6236.F05);%></td>
												<td><a href="<%=controller.getURI(request, DetailGuarantee.class)%>?id=<%=t6236.F01%>&loanId=<%=loanId%>&userId=<%=userId%>&type=0">查看</a>&nbsp;
												<a href="<%=controller.getURI(request, UpdateGuarantee.class)%>?id=<%=t6236.F01%>&loanId=<%=loanId%>&userId=<%=userId%>">修改</a>
												<a href="<%=controller.getURI(request, DelDbxx.class)%>?loanId=<%=loanId %>&userId=<%=userId %>&id=<%=t6236.F01%>">删除</a>
												</td>
											</tr>
											<%}} %>
										</table>
									</div>
									<div class="tc w350 pt20">
										<input type="submit" class="btn4 mr30 sumbitForme" fromname="form1" value="保存并继续"/>
										<a href="<%=controller.getURI(request, OfflineLoanList.class) %>" class="btn5 tc">取消</a>
									</div>
								</div>
							</form>
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