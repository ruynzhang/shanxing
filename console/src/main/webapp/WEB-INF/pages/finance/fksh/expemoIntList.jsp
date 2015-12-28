<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.console.servlets.finance.fksh.ExpemointExport"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.fksh.SurpriseLoan"%>
<%@page import="com.dimeng.p2p.S62.enums.SURPRISE_STATUS"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F20"%>
<%@page import="com.dimeng.p2p.S62.enums.T6231_F21"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.fksh.ViewProject"%>
<%@page import="com.dimeng.p2p.modules.bid.console.service.entity.Fksh"%>
<%@page import="com.dimeng.util.Formater"%>
<%@page import="com.dimeng.p2p.common.ExpemonintBean"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.fksh.CjRecordList"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.fksh.BatchFksh"%>
<%@page import="com.dimeng.p2p.console.servlets.AbstractConsoleServlet"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.fksh.NotLoan"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.fksh.Loan"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<%
	PagingResult<ExpemonintBean> result = (PagingResult<ExpemonintBean>) request.getAttribute("result");
%>
<%
		CURRENT_CATEGORY = "CWGL";
			CURRENT_SUB_CATEGORY = "TYLX";
	%>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="w_main">
		<div class="main clearfix">
			<div class="wrap">
				<div class="r_main">
					<form action="<%=controller.getURI(request, ExpemoIntList.class)%>" name="form1" method="post" id="searchForm">
					<div class="home_main">
						<div class="box box1 mb15">
							<div class="atil">
								<h3>体验利息</h3>
							</div>
							<div class="con">
								<div class="admin_input admin_pb">
             						<div class="table">	
										<p>
											<span>账号：</span>
											<input type="text" name="zqId" value="<%StringHelper.filterHTML(out, request.getParameter("zqId")); %>" id="textfield4" class="yhgl_input" />
										</p>
										<P>	
											<span>姓名：</span>
											<input type="text" name="account" value="<%StringHelper.filterHTML(out, request.getParameter("account")); %>" id="textfield4" class="yhgl_input" />
										</P>
										<P>
											<span>满标时间：</span>
											<input type="text" name="startExpireDatetime" readonly="readonly" value="<%StringHelper.filterHTML(out, request.getParameter("startExpireDatetime")); %>" id="datepicker1" class="yhgl_input date" />至
											<input type="text" name="endExpireDatetime" readonly="readonly" value="<%StringHelper.filterHTML(out, request.getParameter("endExpireDatetime")); %>" id="datepicker2" class="yhgl_input date" />
										</P>
										<div class="clear"></div>   
                    					<div class="mt10">   
                    						<input name="search" type="submit" class="btn2 mr10" value="搜索" />
                   						<%
                   							if (dimengSession.isAccessableResource(ExpemointExport.class)) {
                   						%>
									         <a href="javascript:void(0)" onclick="showExport();" class="btn3 mr10" style="margin-left: 10px;"><span class="ico"></span>导出</a> 
	                          		   <%}else{%>
									        <span class="btn3 btn5 mr10" style="margin-top: -0px;margin-left: 10px;"><span class="ico"></span>导出</span>
									   <%}%>
                   						</div>               
								<div class="clear"></div>
							</div>
							</div>
							</div>
						</div>
						<table width="100%" border="0" cellspacing="0" cellpadding="3" class="yhgl_table">
							<tr class="hsbg">
								<td align="center">序号</td>
								<td align="center">账号</td>
								<td align="center">姓名</td>
								<td align="center">贷款编号</td>
								<td align="center">标的名称</td>
								<td align="center">出借日期</td>
								<td align="center">投资期限</td>
								<td align="center">标的金额</td>
								<td align="center">投资金额</td>
								<td align="center">利息</td>
								<td align="center">回款日期</td>
							</tr>
							<%
							ExpemonintBean[] enbes = result.getItems();
									if (enbes != null) {
										int i = 1;
										for (ExpemonintBean enbe : enbes) {
											if (enbe == null) {
												continue;
											}
							%>
							<tr class="dhsbg">
								<td align="center"><%=i++%></td>
								<td align="center"><%=enbe.F01%></td>
								<td align="center"><%=enbe.F02%></td>
								<td align="center"><%=enbe.id%></td>			
								<td align="center">
                   					<%StringHelper.filterHTML(out, StringHelper.truncation(enbe.title, 10));%>
								</td>
								<td align="center">
								<%=DateTimeParser.format(enbe.invetime,"yyyy-MM-dd HH:mm")%>
								</td>
								<td align="center"><%=enbe.borrterm%>天</td>	
								<td align="center">
									<%=Formater.formatAmount(enbe.borrmoney)%>元
								</td>
								<td align="center">
									<%=Formater.formatAmount(enbe.invemoney)%>元
								</td>
								<td align="center">
									<%=Formater.formatAmount(enbe.inveint)%>元
								</td>
								<td align="center">
								<%=DateTimeParser.format(enbe.hcrepalytime,"yyyy-MM-dd HH:mm")%>
								</td>
								
								
							</tr>
							<%
								}
									}else{
							%>
							<tr><td colspan="12"></td></tr>
							<%} %>
						</table>
						<%
							AbstractConsoleServlet.rendPagingResult(out, result);
						%>
						<div class="box2 clearfix"></div>
					</div>
					</form>
				</div>
			</div>
			<%@include file="/WEB-INF/include/left.jsp"%>
		</div>
	</div>
	<%
		String warringMessage=controller.getPrompt(request, response, PromptLevel.WARRING);
		if(!StringHelper.isEmpty(warringMessage))
		{
	%>
	<div class="w440 thickbox thickpos" style="margin:-80px 0 0 -220px;" id="showDiv">
      <div class="info clearfix">
        <div class="clearfix">
            <span class="fl tips"><%StringHelper.filterHTML(out, warringMessage); %></span>
        </div>
        <div class="dialog_btn"><input type="button" name="button2" onclick="$('#showDiv').hide()" value="确认"  class="btn4 ml50"/></div> 
      </div>
	</div>
	<%} %>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
	<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/txgl/fksh.js"></script>
	<%@include file="/WEB-INF/include/datepicker.jsp"%>
	<script type="text/javascript">
	$(function() {
		$("#datepicker1").datepicker({inline: true,
			onSelect : function(selectedDate) {
	            $("#datepicker2").datepicker("option", "minDate", selectedDate); 
	        }
		});
	    $('#datepicker1').datepicker('option', {dateFormat:'yy-mm-dd'});
	    $("#datepicker2").datepicker({inline: true});
	    $('#datepicker2').datepicker('option', {dateFormat:'yy-mm-dd'});
	    $("#datepicker1").datepicker("setDate", "<%StringHelper.filterHTML(out, request.getParameter("startExpireDatetime"));%>");
	    $("#datepicker2").datepicker("setDate", "<%StringHelper.filterHTML(out, request.getParameter("endExpireDatetime"));%>");
	    $("#datepicker2").datepicker('option', 'minDate',$("#datepicker1").datepicker().val());
	});
	
	function showExport()
	{
		document.getElementById("searchForm").action ="<%=controller.getURI(request, ExpemointExport.class)%>";
		$("#searchForm").submit();
		document.getElementById("searchForm").action ="<%=controller.getURI(request, ExpemoIntList.class)%>";
	}
	</script>
</body>
</html>