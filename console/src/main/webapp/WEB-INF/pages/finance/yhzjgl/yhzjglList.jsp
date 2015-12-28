<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.console.servlets.finance.yhzjgl.YhjyjlList"%>
<%@page import="com.dimeng.util.Formater"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.AbstractFinanceServlet"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.yhzjgl.ExportYhzjgl"%>
<%@page import="com.dimeng.p2p.console.servlets.AbstractConsoleServlet"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.yhzjgl.YhzjglList"%>
<%@page import="com.dimeng.p2p.common.enums.UserType"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="com.dimeng.p2p.modules.finance.console.service.entity.YhzjglRecord"%>
<%@page import="com.dimeng.p2p.modules.finance.console.service.entity.Yhzjgl"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<%
	Yhzjgl yhzjgl=ObjectHelper.convert(request.getAttribute("yhzjgl"), Yhzjgl.class);
	PagingResult<YhzjglRecord> result=(PagingResult<YhzjglRecord>)request.getAttribute("result");
%>
	<%
		CURRENT_CATEGORY = "CWGL";
			CURRENT_SUB_CATEGORY = "YHZJGL";
	%>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="w_main">
		<div class="main clearfix">
			<div class="wrap">
				<div class="r_main">
					<form action="<%=controller.getURI(request, YhzjglList.class) %>" method="post" id="searchForm" name="form1">
						<div class="home_main">
							<div class="box box1 mb15">
								<div class="atil">
									<h3>用户资金管理</h3>
								</div>
								<div class="con">
									<div class="clear"></div>
									<ul class="yhxq_li">
										<li>
											可用金额总额：<span class="blue"><%=Formater.formatAmount(yhzjgl.usableAmount) %></span>元
										</li>
									</ul>
									<ul class="yhxq_li">
										<li>
											冻结金额总额 ：<span class="blue"><%=Formater.formatAmount(yhzjgl.djAmount) %></span>元
										</li>
									</ul>
									<ul class="yhxq_li">
										<li>
											账户余额总额：<span class="blue"><%=Formater.formatAmount(yhzjgl.userBalance) %></span>元
										</li>
									</ul>
									<ul class="yhxq_li">
										<li>
											用户总收益 ：<span class="blue"><%=Formater.formatAmount(yhzjgl.userIncome) %></span>元
										</li>
									</ul>
									<ul class="yhxq_li">
										<li>
											债权资产总额：<span class="blue"><%=Formater.formatAmount(yhzjgl.zqzcAmount) %></span>元
										</li>
									</ul>
									<%-- <ul class="yhxq_li">
										<li>
											优选理财资产总额：<span class="blue"><%=Formater.formatAmount(yhzjgl.yxlcAmount) %></span>元
										</li>
									</ul> --%>
									<ul class="yhxq_li">
										<li>
											借款负债总额 ：<span class="blue"><%=Formater.formatAmount(yhzjgl.jkfzAmount) %></span>元
										</li>
									</ul>
									<ul class="yhxq_li">
										<li>更新时间 ：<span class="blue"><%=DateTimeParser.format(yhzjgl.updateTime)%></span>
										</li>
									</ul>
									<div class="clear"></div>
								</div>
							</div>
							<div class="box box1 mb15">
								<div class="con">
									<div class="admin_input admin_pb">
           								<div class="table">	
											<p>
												<span>用户名：</span>
												<input type="text" name="loginName" value="<%StringHelper.filterHTML(out, request.getParameter("loginName")); %>" id="serialNumber" class="yhgl_input" />
											</p>
											<p>
												<span>姓名：</span>
												<input type="text" name="userName" value="<%StringHelper.filterHTML(out, request.getParameter("userName")); %>" id="userName" class="yhgl_input" />
											</p>
											<p>
												<span>用户类型：</span>
												<select name="userType" class="yhgl_sel" >
						                          <option>全部</option>
						                           <%for(UserType userType:UserType.values())
						                             	{
						                            %>
						                           <option value="<%=userType.name()%>" <%if(userType.name().equals(request.getParameter("userType"))) {%> selected="selected" <%} %>><%=userType.getName() %></option>
						                           <%} %>
						                         </select>
											</p>
											<div class="clear"></div>   
                    						<div class="mt10">   
                    							<input name="search" type="submit" class="btn2 mr10" value="搜索" />
                    								<%if (dimengSession.isAccessableResource(ExportYhzjgl.class)) 
                    									{
													%>
												<a href="javascript:void(0)" onclick="showExport()" class="btn3 mr10"><span class="ico"></span>导出</a>
												<%}else{ %>
												<span class="btn3 btn5 mr10"><span class="ico"></span>导出</span>
												<%} %> 
                   					</div>               
									<div class="clear"></div>
								</div>
								</div>
								</div>
							</div>
							<table width="100%" border="0" cellspacing="0" cellpadding="3" class="yhgl_table tc">
								<tr class="hsbg">
									<td>序号</td>
									<td>用户ID</td>
									<td>用户名</td>
									<td>真实姓名</td>
									<td>用户类型</td>
									<td>可用金额</td>
									<td>冻结金额</td>
									<td>账户余额</td>
									<td>债权资产</td>
									<!-- <td>优选理财资产</td> -->
									<td>借款负债</td>
									<td>用户总收益</td>
									<td>操作</td>
								</tr>
								<%
									YhzjglRecord[] yhzjglRecords=result.getItems();
									if(yhzjglRecords!=null)
									{
										int i=1;
										for(YhzjglRecord record:yhzjglRecords)
										{
											if(record==null)
											{
												continue;
											}
								%>
								<tr class="dhsbg">
									<td><%=i++ %></td>
									<td><%=record.id %></td>
									<td><%StringHelper.filterHTML(out, record.loginName); %></td>
									<td><%StringHelper.filterHTML(out, record.userName); %></td>
									<td><%if(record.userType!=null){
										StringHelper.filterHTML(out, record.userType.getName());
									}%></td>
									<td><%if(record.usableAmount!=null){%><%=Formater.formatAmount(record.usableAmount) %><%} %></td>
									<td><%if(record.blockAmount!=null){%><%=Formater.formatAmount(record.blockAmount) %><%} %></td>
									<td><%if(record.userBalance!=null){%><%=Formater.formatAmount(record.userBalance) %><%} %></td>
									<td><%if(record.zqAmount!=null){%><%=Formater.formatAmount(record.zqAmount) %><%} %></td>
									<%-- <td><%if(record.yxlcAmount!=null){%><%=Formater.formatAmount(record.yxlcAmount) %><%} %></td> --%>
									<td><%if(record.jkhzAmount!=null){%><%=Formater.formatAmount(record.jkhzAmount) %><%} %></td>
									<td><%if(record.userIncome!=null){%><%=Formater.formatAmount(record.userIncome) %><%} %></td>
									<td class="blue">
										<%
											if (dimengSession.isAccessableResource(YhjyjlList.class)) {
											%>
											<a href="<%=controller.getURI(request, YhjyjlList.class)%>?id=<%=record.id%>">交易记录</a>
											<%}else{ %>
											<span class="gray6">交易记录</span>
											<%} %> 
									</td>
								</tr>
								<%}}else{ %>
								<tr><td colspan="13"></td></tr>
								<%} %>
							</table>
							<%AbstractConsoleServlet.rendPagingResult(out, result); %>
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
		<script type="text/javascript">
		function showExport()
		{
			document.getElementById("searchForm").action ="<%=controller.getURI(request, ExportYhzjgl.class)%>";
			$("#searchForm").submit();
			document.getElementById("searchForm").action ="<%=controller.getURI(request, YhzjglList.class)%>";
		}
	</script>
</body>
</html>