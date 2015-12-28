<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.console.servlets.finance.zjgl.ByZjList"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.zjgl.ByZJjyList"%>
<%@page import="com.dimeng.util.Formater"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.zjgl.ExportBYZJgl"%>
<%@page import="com.dimeng.p2p.console.servlets.AbstractConsoleServlet"%>
<%@page import="com.dimeng.p2p.common.enums.FundAccountType"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="com.dimeng.p2p.modules.account.console.service.entity.FundsView"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<%
	PagingResult<FundsView> fundsViewList =(PagingResult<FundsView>)request.getAttribute("fundsViewList");
%>
<%
	CURRENT_CATEGORY = "CWGL";
	CURRENT_SUB_CATEGORY = "BYZJGL";
%>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="w_main">
		<div class="main clearfix">
			<div class="wrap">
				<div class="r_main">
					<form action="<%=controller.getURI(request, ByZjList.class)%>" method="post" id="searchForm" name="form1">
						<div class="home_main">
							<div class="box box1 mb15">
								<div class="atil">
									<h3>备用资金管理</h3>
								</div>
								<div class="con"></div>
							</div>
							<div class="box box1 mb15">
								<div class="con">
									<div class="admin_input admin_pb">
										<div class="table">
											<p>
												<span>用户名：</span> <input type="text" name="loginName" value="<%StringHelper.filterHTML(out, request.getParameter("loginName"));%>" id="serialNumber" class="yhgl_input" />
											</p>
											<p>
												<span>资金账户：</span> <input type="text" name="userName" value="<%StringHelper.filterHTML(out, request.getParameter("userName"));%>" id="userName" class="yhgl_input" />
											</p>
											<p>
												<span>用户类型：</span>
												<select name="fundAccountType" class="yhgl_sel" >
													<option value="0">全部</option>
						                           <%
						                           	for(FundAccountType fundAccountType:FundAccountType.values())
						                           {
						                           		if(fundAccountType==FundAccountType.PT)
						                           		{
						                           			continue;
						                           		}
						                           %>
						                           <option value="<%=fundAccountType.name()%>" <%if(fundAccountType.name().equals(request.getParameter("fundAccountType"))) {%> selected="selected" <%}%>><%=fundAccountType.getName()%></option>
						                           <%
						                           	}
						                           %>
						                         </select>
											</p>
											<div class="clear"></div>
											<div class="mt10">
												<input name="search" type="submit" class="btn2 mr10" value="搜索" />
												<%
													if (dimengSession.isAccessableResource(ExportBYZJgl.class)) 
												                    								                    									{
												%>
												<a href="javascript:void(0)" onclick="showExport()" class="btn3 mr10"><span class="ico"></span>导出</a>
												<%
													}else{
												%>
												<span class="btn3 btn5 mr10"><span class="ico"></span>导出</span>
												<%
													}
												%>
											</div>
											<div class="clear"></div>
										</div>
									</div>
								</div>
							</div>
							<table width="100%" border="0" cellspacing="0" cellpadding="3" class="yhgl_table tc">
								<tr class="hsbg">
									<td>序号</td>
									<td>资金账户</td>
									<td>资金账户类型</td>
									<td>用户名</td>
									<td>用户类型</td>
									<td>账户余额(元)</td>
									<td>最后更新时间</td>
									<td>操作</td>
								</tr>
								<%
									FundsView[] fundsViews =null;
																				if(fundsViewList!=null){
																					fundsViews=fundsViewList.getItems();
																				}
																					if(fundsViews!=null)
																					{
																						int i=1;
																						for(FundsView record:fundsViews)
																						{
																							if(record==null)
																							{
																								continue;
																							}
								%>
								<tr class="dhsbg">
									<td><%=i++%></td>
									<td>
										<%
											StringHelper.filterHTML(out, record.F04);
										%>
									</td>
									<td><%=record.F03.getChineseName() %>
									</td>
									<td><%
										StringHelper.filterHTML(out, record.F05);
									%>
									</td>
									<td><%StringHelper.filterHTML(out, record.userType);
									%>
									</td>
									<td><%=Formater.formatAmount(record.F06)%></td>
									<td><%=DateTimeParser.format(record.F07) %></td>
									<td class="blue">
										<%
											if (dimengSession.isAccessableResource(ByZJjyList.class)) {
										%> <a href="<%=controller.getURI(request, ByZJjyList.class)%>?id=<%=record.F01%>">备用明细</a> <%}else{%> 
										<span class="gray6">备用明细</span> <%} %>
									</td>
								</tr>
								<%
									}}else{
								%>
								<tr>
									<td colspan="13"></td>
								</tr>
								<%
									}
								%>
							</table>
							<%
								AbstractConsoleServlet.rendPagingResult(out, fundsViewList);
							%>
							<div class="box2 clearfix"></div>
						</div>
					</form>
				</div>
			</div>
			<%@include file="/WEB-INF/include/left.jsp"%>
		</div>
	</div>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
	<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/validation.js"></script>
	<script type="text/javascript">
		function showExport()
		{
			document.getElementById("searchForm").action ="<%=controller.getURI(request, ExportBYZJgl.class)%>";
			$("#searchForm").submit();
			document.getElementById("searchForm").action ="<%=controller.getURI(request, ByZjList.class)%>";
		}
		function showRecharge(accountId)
		{
			$("#accountId").attr("value",accountId);
			$("#rechargeDiv").show();
		}
	</script>
</body>
</html>