<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.util.Formater"%>
<%@page import="com.dimeng.p2p.common.enums.CreditStatus"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.AbstractFinanceServlet"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.jgbyj.ExportYwDetail"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.jgbyj.YwDetail"%>
<%@page import="com.dimeng.p2p.modules.finance.console.service.entity.JgywRecord"%>
<%@page import="com.dimeng.p2p.modules.finance.console.service.entity.Jgyw"%>
<%@page import="com.dimeng.p2p.modules.finance.console.service.entity.Fksh"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<%@page import="com.dimeng.p2p.modules.finance.console.service.entity.TxglRecord"%>
<%@page import="com.dimeng.p2p.modules.finance.console.service.entity.Txgl"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<%
		Jgyw jgyw = ObjectHelper.convert(request.getAttribute("jgyw"),
				Jgyw.class);
		PagingResult<JgywRecord> result = (PagingResult<JgywRecord>) request
				.getAttribute("result");
%>
<%
	CURRENT_CATEGORY = "CWGL";
		CURRENT_SUB_CATEGORY = "JGFXBYJGL";
%>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="w_main">
		<div class="main clearfix">
			<div class="wrap">
				<div class="r_main">
					<form action="<%=controller.getURI(request, YwDetail.class)%>" name="form1" method="post" id="searchForm">
					<input type="hidden" name="id" value="<%=request.getAttribute("id")%>">
						<div class="home_main">
							<div class="box box1 mb15">
								<div class="atil">
									<h3>机构业务明细</h3>
								</div>
								<div class="con">
									<div class="clear"></div>
									<ul class="yhxq_li">
										<li>机构名称：<span class="blue">
												<%
													StringHelper.filterHTML(out, jgyw.orgName);
												%>
										</span>
										</li>
									</ul>
									<ul class="yhxq_li">
										<li>成功借款总金额：<span class="blue"><%=Formater.formatAmount(jgyw.jkTotalAmount)%></span>元
										</li>
									</ul>
									<ul class="yhxq_li">
										<li>待还本金总额：<span class="blue"><%=Formater.formatAmount(jgyw.dfTotalAmount)%></span>元
										</li>
									</ul>
									<div class="clear"></div>
								</div>
							</div>
							<div class="box box1 mb15">
								<div class="con">
            							<div class="admin_input admin_pb">
											<p>
												<span>借款标题：</span>
												<input type="text" name="title" value="<%StringHelper.filterHTML(out, request.getParameter("title"));%>" class="yhgl_input" />
											</p>
											<p>
												<span>用户名：</span>
												<input type="text" name="account" value="<%StringHelper.filterHTML(out, request.getParameter("account"));%>" class="yhgl_input" />
											</p>
											<p>
												<span>状态：</span>
												<select name="status" class="yhgl_sel" >
													<option>全部</option>
													<%
														for (CreditStatus status : CreditStatus.values()) {
															if(status==null)
															{
																continue;
															}
													%>
													<option value="<%=status.name()%>" <%if (status.name().equals(request.getParameter("status"))) {%> selected="selected" <%}%>><%=status.getName()%></option>
													<%
														}
													%>
												</select>
											</p>
											 <div class="clear"></div>   
                    						<div class="mt10">   
						                    	<input name="search" type="submit" class="btn2 mr10" value="搜索" />
						                   		<%
												if (dimengSession.isAccessableResource(ExportYwDetail.class)) {
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
							<table width="100%" border="0" cellspacing="0" cellpadding="3" class="yhgl_table tc">
								<tr class="hsbg">
									<td>序号</td>
									<td>借款标题</td>
									<td>用户名</td>
									<td>借款金额（元）</td>
									<td>年利率</td>
									<td>期限（月）</td>
									<td>待还本金（元）</td>
									<td>状态</td>
								</tr>
								<%
									int i = 1;
										JgywRecord[] records = result.getItems();
										if (records != null) {
											for (JgywRecord record : records) {
												if (record == null) {
													continue;
												}
								%>
								<tr class="dhsbg">
									<td><%=i++%></td>
									<td>
										<%
											StringHelper.filterHTML(out, record.title);
										%>
									</td>
									<td>
										<%
											StringHelper.filterHTML(out, record.accountName);
										%>
									</td>
									<td><%=Formater.formatAmount(record.loanAmount)%></td>
									<td><%=Formater.formatAmount(record.proportion)%></td>
									<td><%=record.deadline%></td>
									<td><%=Formater.formatAmount(record.dfAmount)%></td>
									<td><%if(record.status!=null){%><%=record.status.getName()%><%} %></td>
								</tr>
								<%
									}
										} else {
								%>
								<tr>
									<td colspan="9"></td>
								</tr>
								<%
									}
								%>
							</table>
							<%
								AbstractFinanceServlet.rendPagingResult(out, result);
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
	<script type="text/javascript">
	function showExport()
	{
		document.getElementById("searchForm").action ="<%=controller.getURI(request, ExportYwDetail.class)%>";
		$("#searchForm").submit();
		document.getElementById("searchForm").action ="<%=controller.getURI(request, YwDetail.class)%>";
	}
	</script>
</body>
</html>