<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.console.servlets.finance.jgbyj.JgDfsdzqList"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.jgbyj.ExportJgbyj"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.AbstractFinanceServlet"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.jgbyj.YwDetail"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.jgbyj.CreditRecord"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.jgbyj.ByjDetail"%>
<%@page import="com.dimeng.p2p.common.enums.OrganizationType"%>
<%@page import="com.dimeng.util.Formater"%>
<%@page import="com.dimeng.p2p.modules.finance.console.service.entity.Jgfxbyj"%>
<%@page import="com.dimeng.p2p.modules.finance.console.service.entity.JgbyjStatistics"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<%
	JgbyjStatistics statistics = ObjectHelper.convert(request.getAttribute("statistics"), JgbyjStatistics.class);
	PagingResult<Jgfxbyj> result = (PagingResult<Jgfxbyj>) request.getAttribute("result");
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
					<form action="<%controller.getURI(request, JgbyjList.class);%>" name="form1" method="post" id="searchForm">
					<div class="home_main">
						<div class="box box1 mb15">
							<div class="atil">
								<h3>机构风险备用金</h3>
							</div>
							<div class="con">
								<div class="clear"></div>
								<ul class="yhxq_li">
									<li>
										原始风险备用金总额：<span class="blue">										
										<%=Formater.formatAmount(statistics.ysbyjAmount)%>
										</span>元
									</li>
								</ul>
								<ul class="yhxq_li">
									<li>
										风险备用金余额总额：<span class="blue">
										<%=Formater.formatAmount(statistics.byjAmount)%>
										</span>元
									</li>
								</ul>
								<ul class="yhxq_li">
									<li>
										信用额度总额：<span class="blue">
										<%=Formater.formatAmount(statistics.xyAmount)%>
										</span>元
									</li>
								</ul>
								<ul class="yhxq_li">
									<li>
										可用额度总额：<span class="blue">
										<%=Formater.formatAmount(statistics.kyAmount)%>
										</span>元
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
										 	<span>机构名称：</span>
										 	<input type="text" name="name" value="<%StringHelper.filterHTML(out, request.getParameter("name"));%>" class="yhgl_input" />
										</p>
										<p>
											<span>机构类型：</span>
											<select name="type" class="yhgl_sel" >
												<option>全部</option>
													<%for(OrganizationType type:OrganizationType.values())
														{
													%>
														<option value="<%=type.name()%>" <%if(type.name().equals(request.getParameter("type"))) {%> selected="selected" <%}%>><%=type.getName()%></option>
													<%}%>
					                         </select>
										</p>
										<div class="clear"></div>   
                    					<div class="mt10">   
                    						<input name="search" type="submit" class="btn2 mr10" value="搜索" />
                   							<%
											if (dimengSession.isAccessableResource(ExportJgbyj.class)) {
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
								<td>机构名称</td>
								<td>机构类型</td>
								<td>机构信用额度</td>
								<td>机构可用额度</td>
								<td>原始备用金总额</td>
								<td>备用金余额</td>
								<td>操作</td>
							</tr>
								<%
									int i=1;
									Jgfxbyj[] items = result.getItems();
									if (items != null) {
										for (Jgfxbyj item : items) {
											if (item == null) {
												continue;
											}
								%>
								<tr class="dhsbg">
									<td>
										<%=i++%>
									</td>
									<td>
										<%
											StringHelper.filterHTML(out, item.organizationName);
										%>
									</td>
									<td><%
										if(item.type!=null){
									%><%=item.type.getName()%><%
										}
									%></td>
									<td>
									    <%=Formater.formatAmount(item.organizationCreditAmount)%>
									</td>
									<td>
										<span class="red"><%=Formater.formatAmount(item.organizationUsableAmount)%></span>
									</td>
									<td>
										<%=Formater.formatAmount(item.originalReserveAmount)%>
									</td>								
									<td>
									   <%=Formater.formatAmount(item.originalReserveBalance)%>
									</td>
									<td>
									<%
											if (dimengSession.isAccessableResource(ByjDetail.class)) {
											%>
											<a href="<%=controller.getURI(request, ByjDetail.class)%>?id=<%=item.id%>" class="blue">备用明细</a>
											<%}else{ %>
											<span class="gray6">备用明细</span>
											<%} %> 
									&nbsp;&nbsp;
									<%
											if (dimengSession.isAccessableResource(YwDetail.class)) {
											%>
											<a href="<%=controller.getURI(request, YwDetail.class)%>?id=<%=item.id%>" class="blue">业务明细</a>
											<%}else{ %>
											<span class="gray6">业务明细</span>
											<%} %> 
									&nbsp;&nbsp;
									<%
											if (dimengSession.isAccessableResource(CreditRecord.class)) {
											%>
											<a href="<%=controller.getURI(request, CreditRecord.class)%>?id=<%=item.id%>" class="blue">信用记录</a>
											<%}else{ %>
											<span class="gray6">信用记录</span>
											<%} %> 
									&nbsp;&nbsp;
									<%
											if (dimengSession.isAccessableResource(JgDfsdzqList.class)) {
											%>
											<a href="<%=controller.getURI(request, JgDfsdzqList.class)%>?id=<%=item.id %>" class="blue">垫付债权</a>
											<%}else{ %>
											<span class="gray6">垫付债权</span>
											<%} %> 
									</td>
								</tr>
								<%}}else{ %>
								<tr><td colspan="8"></td></tr>
								<%} %>
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
		document.getElementById("searchForm").action ="<%=controller.getURI(request, ExportJgbyj.class)%>";
		$("#searchForm").submit();
		document.getElementById("searchForm").action ="<%=controller.getURI(request, JgbyjList.class)%>";
	}
	</script>
</body>
</html>