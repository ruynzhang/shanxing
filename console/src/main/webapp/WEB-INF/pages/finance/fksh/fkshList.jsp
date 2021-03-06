<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.console.servlets.finance.fksh.ViewSurprise"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.fksh.SurpriseLoan"%>
<%@page import="com.dimeng.p2p.S62.enums.SURPRISE_STATUS"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F20"%>
<%@page import="com.dimeng.p2p.S62.enums.T6231_F21"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.fksh.ViewProject"%>
<%@page import="com.dimeng.p2p.modules.bid.console.service.entity.Fksh"%>
<%@page import="com.dimeng.util.Formater"%>
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
	PagingResult<Fksh> result = (PagingResult<Fksh>) request.getAttribute("result");
%>
<%
		CURRENT_CATEGORY = "CWGL";
			CURRENT_SUB_CATEGORY = "FKGL";
	%>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="w_main">
		<div class="main clearfix">
			<div class="wrap">
				<div class="r_main">
					<form action="<%=controller.getURI(request, FkshList.class)%>" name="form1" method="post" id="searchForm">
					<div class="home_main">
						<div class="box box1 mb15">
							<div class="atil">
								<h3>放款审核</h3>
							</div>
							<div class="con">
								<div class="admin_input admin_pb">
             						<div class="table">	
										<p>
											<span>借款ID：</span>
											<input type="text" name="zqId" value="<%StringHelper.filterHTML(out, request.getParameter("zqId")); %>" id="textfield4" class="yhgl_input" />
										</p>
										<P>	
											<span>借款账户：</span>
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
                   							<%if (dimengSession.isAccessableResource(CjRecordList.class)) {%>
											<a href="<%=controller.getURI(request, CjRecordList.class)%>" class="btn3 mr10 tc">成交记录</a>
											<%}else{ %>
											<span class="btn3 mr10 btn5 tc">成交记录</span>
											<%} %>
                   						</div>               
								<div class="clear"></div>
							</div>
							</div>
							</div>
						</div>
						<table width="100%" border="0" cellspacing="0" cellpadding="3" class="yhgl_table">
							<tr class="hsbg">
								<td><input type="checkbox" id="checkAll" /></td>
								<td align="center">序号</td>
								<td align="center">借款ID</td>
								<td align="center">借款标题</td>
								<td align="center">借款账户</td>
								<td align="center">借款金额(元)</td>
								<td align="center">投标金额(元)</td>
								<td align="center">年利率</td>
								<td align="center">期限</td>
								<td align="center">满标时间</td>
								<td align="center">操作</td>
							</tr>
							<%
								Fksh[] fkshs = result.getItems();
									if (fkshs != null) {
										int i = 1;
										for (Fksh fksh : fkshs) {
											if (fksh == null) {
												continue;
											}
							%>
							<tr class="dhsbg">
								<td><input type="checkbox" class="checkId" name="id" value="<%=fksh.F01%>" /></td>
								<td align="center"><%=i++%></td>
								<td align="center"><%=fksh.F25%></td>
								<td title="<%StringHelper.filterHTML(out, fksh.F03);%>">
                   					<%StringHelper.filterHTML(out, StringHelper.truncation(fksh.F03, 10));%>
								</td>
								<td align="center">
									<%
										StringHelper.filterHTML(out, fksh.userName);
									%>
								</td>
								<td align="center">
									<%=Formater.formatAmount(fksh.F05)%>
								</td>
								<td align="center">
									<%=Formater.formatAmount(fksh.F05.subtract(fksh.F07))%>
								</td>
								<td align="center">
									<%=Formater.formatRate(fksh.F06)%>
								</td>
								<%-- <td align="center"><%=fksh.days%>个月</td> --%>
								<td align="center">
									<%if(T6231_F21.S == fksh.t6231_F21){out.print(fksh.limitDays); %>天
									<%} else {out.print(fksh.days); %>个月<%} %>
								</td>
								<td align="center"><%=DateTimeParser.format(fksh.mbTime,"yyyy-MM-dd HH:mm")%></td>
								<td align="center" class="blue">
								<%
											if (dimengSession.isAccessableResource(ViewProject.class)) {
										%>
										<a href="<%=controller.getURI(request, ViewProject.class)%>?loanId=<%=fksh.F01 %>&userId=<%=fksh.F02 %>" class="blue">查看</a>
										<%}else{ %>
										<span class="gray6">查看</span>
										<%} %>
										<%
											if (dimengSession.isAccessableResource(Loan.class) && fksh.bStatus == T6230_F20.DFK) {
										%>
										<a href="javascript:void(0)" onclick="load('<%=controller.getURI(request, Loan.class)%>?id=<%=fksh.F01%>','<%=fksh.F03%>')">放款</a>
										<%}else{ %>
										<span class="gray6">放款</span>
										<%} %>
										<%
											if (dimengSession.isAccessableResource(NotLoan.class) && fksh.bStatus == T6230_F20.DFK) {
										%>
										<a href="javascript:void(0)" onclick="notLoad('<%=fksh.F01%>')">不放款</a>
										<%}else{ %>
										<span class=gray6>不放款</span>
										<%} %>		
										
										<%
											if (dimengSession.isAccessableResource(ViewSurprise.class) && fksh.bStatus == T6230_F20.HKZ && fksh.surpriseStatus == SURPRISE_STATUS.YPZ) {
										%>
										<a href="<%=controller.getURI(request, ViewSurprise.class)%>?id=<%=fksh.F01%>">查看惊喜奖</a>
										<%}else{ %>
										<span class=gray6>查看惊喜奖</span>
										<%} %>
										
								</td>
							</tr>
							<%
								}
									}else{
							%>
							<tr><td colspan="11"></td></tr>
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
	<div id="reasonDiv" style="display: none;">
		<div class="popup_bg"></div>
		<div class="popup add_information"
			style="width: 450px; margin: -70px 0 0 -225px; z-index: 99999; position: fixed; left: 50%; top: 50%; _position: absolute; _top: expression(200 +((   e =   document.documentElement.scrollTop)?e:document.body.scrollTop)+'px'); z-index: 100000;">
			<div class="til clearfix">
				<h2>不放款</h2>
				<div class="close">
					<a href="javascript:void(0)" class="close">关闭</a>
				</div>
			</div>
			<div class="con">
				<form action="<%=controller.getURI(request, NotLoan.class)%>" method="post">
					<input type="hidden" name="id" id="id" />
					
					<table class="jgzjcz_table" align="center">
						<tr>
							<td valign="top"><span>流标说明:</span></td>
							<td><textarea rows="4" cols="40" name="des"></textarea></td>
						</tr>
						<tr >
							<td colspan="2" align="center">
							<div style="width:193px;margin:auto;"><button type="submit" class="btn3 mr10">确认</button>
								<button type="button" class="btn5 close">取消</button></div></td>
						</tr>
					</table>
				</form>
			</div>
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
	</script>
</body>
</html>