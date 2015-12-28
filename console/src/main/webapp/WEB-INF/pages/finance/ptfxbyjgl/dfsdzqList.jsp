<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.util.Formater"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.ptfxbyjgl.ExportDfsdzq"%>
<%@page import="com.dimeng.p2p.console.servlets.AbstractConsoleServlet"%>
<%@page import="com.dimeng.p2p.common.enums.RestoreStatus"%>
<%@page import="com.dimeng.p2p.modules.finance.console.service.entity.Dfsdzq"%>
<%@page import="com.dimeng.p2p.modules.finance.console.service.entity.DfsdzqRecord"%>
<%@page import="com.dimeng.p2p.modules.finance.console.service.entity.Fksh"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<%@page import="com.dimeng.p2p.modules.finance.console.service.entity.TxglRecord"%>
<%@page import="com.dimeng.p2p.modules.finance.console.service.entity.Txgl"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
<%@include file="/WEB-INF/include/datepicker.jsp"%>
</head>
<%
		Dfsdzq dfsdzq = ObjectHelper.convert(
				request.getAttribute("dfsdzq"), Dfsdzq.class);
		PagingResult<DfsdzqRecord> result = (PagingResult<DfsdzqRecord>) request.getAttribute("result");
%>
<%
	CURRENT_CATEGORY = "CWGL";
		CURRENT_SUB_CATEGORY = "DFSDZQ";
%>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="w_main">
		<div class="main clearfix">
			<div class="wrap">
				<div class="r_main">
				<form action="<%=controller.getURI(request, DfsdzqList.class) %>" name="form1" method="post" id="searchForm">
					<div class="home_main">
						<div class="box box1 mb15">
							<div class="atil">
								<h3>垫付所得债权</h3>
							</div>
							<div class="con">
								<div class="clear"></div>
								<ul class="yhxq_li">
									<li>
										垫付总金额：<span class="blue"><%=Formater.formatAmount(dfsdzq.paymentAmount) %></span>元
									</li>
								</ul>
								<ul class="yhxq_li">
									<li>
										垫付返还金额：<span class="blue"><%=Formater.formatAmount(dfsdzq.paymentRestore) %></span>元
									</li>
								</ul>
								<ul class="yhxq_li">
									<li>
										待收总金额：<span class="blue"><%=Formater.formatAmount(dfsdzq.restoreAmount) %></span>元
									</li>
								</ul>
								<ul class="yhxq_li">
									<li>
										盈亏 ：<span class="blue"><%=Formater.formatAmount(dfsdzq.profit) %></span>元
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
										<span>债权ID</span>
										<input type="text" name="zqId" value="<%StringHelper.filterHTML(out, request.getParameter("zqId"));%>" class="yhgl_input" />
									</p>
									<p>	
										<span>用户名</span>
										<input type="text" name=loginName value="<%StringHelper.filterHTML(out, request.getParameter("loginName")); %>" class="yhgl_input" />
									</p>
									<p>	
										<span>垫付时间：</span>
										<input type="text" name="startPaymentTime" id="datepicker1" readonly="readonly" value="<%StringHelper.filterHTML(out, request.getParameter("startRechargeTime")); %>" class="yhgl_input date" />至
				                        <input type="text" name="endPaymentTime" id="datepicker2" readonly="readonly" value="<%StringHelper.filterHTML(out, request.getParameter("endRechargeTime")); %>" class="yhgl_input date" />
									</p>
									<p>
										<span>状态</span>：
										<select name="status" class="yhgl_sel" >
						                 	<option>请选择</option>
						                     <%for(RestoreStatus status:RestoreStatus.values())
						                        {
						                     %>
						                       <option value="<%=status.name()%>" <%if(status.name().equals(request.getParameter("status"))){%> selected="selected" <%} %>><%=status.getName()%></option>
						                     <%}%>
						                 </select>
									<div class="clear"></div>   
                    				<div class="mt10">   
                    					<input name="search" type="submit" class="btn2 mr10" value="搜索" />
                  					    <%
										if (dimengSession.isAccessableResource(ExportDfsdzq.class)) {
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
								<td>垫付时间</td>
								<td>垫付金额</td>
								<td>债权ID</td>
								<td>用户名</td>
								<td>垫付返还金额</td>
								<td>剩余期限</td>
								<td>待收金额</td>
								<td>下一个还款日</td>
								<td>状态</td>
							</tr>
							<%
								DfsdzqRecord[] records=result.getItems();
									if(records!=null)
									{
										int i=1;
										for(DfsdzqRecord record:records)
										{
											if(record==null)
											{
												continue;
											}
							%>
							<tr class="dhsbg">
								<td><%=i++ %></td>
								<td><%=DateTimeParser.format(record.paymentTime,"yyyy-MM-dd HH:mm") %></td>
								<td><%=Formater.formatAmount(record.paymentAmount) %></td>
								<td><%=record.id %></td>
								<td><%StringHelper.filterHTML(out,record.loginName); %></td>
								<td><%=Formater.formatAmount(record.paymentRestore) %></td>
								<td><%=record.residueDeadLine %>/<%=record.day %></td>
								<td><%=Formater.formatAmount(record.restoreAmount) %></td>
								<td><%=DateParser.format(record.nextRestoreTime) %></td>
								<td><%if(record.status!=null){ %> <%=record.status.getName()%><% }%></td>
							</tr>
							<%}}else{ %>
								<tr><td colspan="11"></td></tr>
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
	<%@include file="/WEB-INF/include/datepicker.jsp"%>
	<script type="text/javascript">
	function showExport()
	{
		document.getElementById("searchForm").action ="<%=controller.getURI(request, ExportDfsdzq.class)%>";
		$("#searchForm").submit();
		document.getElementById("searchForm").action ="<%=controller.getURI(request, DfsdzqList.class)%>";
	}
	$(function() {
		$("#datepicker1").datepicker({inline: true});
	    $('#datepicker1').datepicker('option', {dateFormat:'yy-mm-dd'});
	    $("#datepicker2").datepicker({inline: true});
	    $('#datepicker2').datepicker('option', {dateFormat:'yy-mm-dd'});
	    $("#datepicker1").datepicker("setDate", "<%StringHelper.filterHTML(out, request.getParameter("startPaymentTime"));%>");
	    $("#datepicker2").datepicker("setDate", "<%StringHelper.filterHTML(out, request.getParameter("endPaymentTime"));%>");
	});
	</script>
</body>
</html>