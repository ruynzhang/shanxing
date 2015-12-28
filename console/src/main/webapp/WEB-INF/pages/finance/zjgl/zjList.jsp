<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.S61.enums.T6101_F03"%>
<%@page import="com.dimeng.p2p.modules.account.console.service.entity.AmountTotle"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.zjgl.ZjList"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.zjgl.ZJjyList"%>
<%@page import="com.dimeng.util.Formater"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.zjgl.ExportZJgl"%>
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
	AmountTotle amountTotle = ObjectHelper.convert(request.getAttribute("amountTotle"), AmountTotle.class);
%>
	<%
		CURRENT_CATEGORY = "CWGL";
		CURRENT_SUB_CATEGORY = "ZJGL";
	%>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="w_main">
		<div class="main clearfix">
			<div class="wrap">
				<div class="r_main">
					<form action="<%=controller.getURI(request, ZjList.class)%>" method="post" id="searchForm" name="form1">
						<div class="home_main">
									<div class="box box1 mb15">
								<div class="atil">
									<h3>资金管理</h3>
								</div>
								<div class="con">
									<div class="clear"></div>
								<ul class="yhxq_li">
									<li>账户余额总额 ：<span class="blue"><%=Formater.formatAmount(amountTotle.zhyeze)%></span>元
									</li>
								</ul>
								<ul class="yhxq_li">
									<li>冻结金额总额 ：<span class="blue"><%=Formater.formatAmount(amountTotle.djjeze)%></span>元
									</li>
								</ul>
								<ul class="yhxq_li">
									<li>平台总收益 ：<span class="blue"><%=Formater.formatAmount(amountTotle.ptzsy)%></span>元
									</li>
								</ul>
								<ul class="yhxq_li">
									<li>用户总收益 ：<span class="blue"><%=Formater.formatAmount(amountTotle.yhzsy)%></span>元
									</li>
								</ul>
								<ul class="yhxq_li">
									<li>债权资产总额 ：<span class="blue"><%=Formater.formatAmount(amountTotle.zqzcze)%></span>元
									</li>
								</ul>
								<ul class="yhxq_li">
									<li>借款负债总额 ：<span class="blue"><%=Formater.formatAmount(amountTotle.jkfzze)%></span>元
									</li>
								</ul>
								<ul class="yhxq_li">
									<li>更新时间 ：<span class="blue"><%=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date())%></span>
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
												<input type="text" name="loginName" value="<%StringHelper.filterHTML(out, request.getParameter("loginName"));%>" id="serialNumber" class="yhgl_input" />
											</p>
											<p>
												<span>资金账户：</span>
												<input type="text" name="userName" value="<%StringHelper.filterHTML(out, request.getParameter("userName"));%>" id="userName" class="yhgl_input" />
											</p>
											<p>
												<span>用户类型：</span>
												<select name="fundAccountType" class="yhgl_sel" >
													<option value="0">全部</option>
						                           <%
						                           	for(FundAccountType fundAccountType:FundAccountType.values())
						                           				                             	{
						                           %>
						                           <option value="<%=fundAccountType.name()%>" <%if(fundAccountType.name().equals(request.getParameter("fundAccountType"))) {%> selected="selected" <%}%>><%=fundAccountType.getName()%></option>
						                           <%
						                           	}
						                           %>
						                         </select>
											</p>
																						<p>
												<span>资金账户类型：</span>
												<select name="zjzhType" class="yhgl_sel" >
													<option value="0">全部</option>
						                           <%
						                           	for(T6101_F03 zjzhType:T6101_F03.values())
						                           	{
						                           		if(zjzhType==T6101_F03.FXBZJZH)
						                           		{
						                           			continue;
						                           		}
						                           %>
						                           <option value="<%=zjzhType.name()%>" <%if(zjzhType.name().equals(request.getParameter("zjzhType"))) {%> selected="selected" <%}%>><%=zjzhType.getChineseName()%></option>
						                           <%
						                           	}
						                           %>
						                         </select>
											</p>
											<div class="clear"></div>   
                    						<div class="mt10">   
                    							<input name="search" type="submit" class="btn2 mr10" value="搜索" />
                    								<%
                    									if (dimengSession.isAccessableResource(ExportZJgl.class)) 
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
									<td>用户收益(元)</td>
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
									<td><%
										StringHelper.filterHTML(out, record.F04);
									%></td>
									<td><%=record.F03.getChineseName() %></td>
									<td><%
										StringHelper.filterHTML(out, record.F05);
									%></td>
									<td><%StringHelper.filterHTML(out, record.userType);
									%></td>
									<td><%=Formater.formatAmount(record.F06)%></td>
									<%if(T6101_F03.WLZH == record.F03){ %>
										<td><%=Formater.formatAmount(record.yhsy)%></td>
									<%}else{ %>
										<td>-</td>
									<%} %>
									<td><%=DateTimeParser.format(record.F07) %></td>
									<td class="blue">
										<%
											if (dimengSession.isAccessableResource(ZJjyList.class)) {
										%>
											<a href="<%=controller.getURI(request, ZJjyList.class)%>?id=<%=record.F01%>&name=<%=record.F05%>">交易记录</a>
											<%}else{ %>
											<span class="gray6">交易记录</span>
											<%} %> 
									</td>
								</tr>
								<%}}else{ %>
								<tr><td colspan="13"></td></tr>
								<%} %>
							</table>
							<%AbstractConsoleServlet.rendPagingResult(out, fundsViewList); %>
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
			document.getElementById("searchForm").action ="<%=controller.getURI(request, ExportZJgl.class)%>";
			$("#searchForm").submit();
			document.getElementById("searchForm").action ="<%=controller.getURI(request, ZjList.class)%>";
		}
	</script>
</body>
</html>