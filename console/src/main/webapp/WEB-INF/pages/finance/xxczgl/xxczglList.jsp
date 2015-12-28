<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.console.servlets.finance.xxczgl.ExportXxczgl"%>
<%@page import="com.dimeng.p2p.S71.enums.T7150_F05"%>
<%@page import="com.dimeng.p2p.modules.account.console.service.entity.OfflineChargeRecord"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.xxczgl.Xxczqx"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.xxczgl.Xxczshtg"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.xxczgl.AddXxcz"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.AbstractFinanceServlet"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<%
	CURRENT_CATEGORY = "CWGL";
	CURRENT_SUB_CATEGORY = "XXCZGL";
	PagingResult<OfflineChargeRecord> result = (PagingResult<OfflineChargeRecord>) request.getAttribute("result");
%>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="w_main">
		<div class="main clearfix">
			<div class="wrap">
				<div class="r_main">
					<div class="home_main">
						<form action="<%controller.getURI(request, XxczglList.class);%>" method="post" name="form1" id="searchForm">
							<div class="box box1 mb15">
								<div class="atil">
									<h3>线下充值管理</h3>
								</div>
							</div>
							<div class="box box1 mb15">
								<div class="con">
									<div class="admin_input admin_pb">
             							<div class="table top3">
											<p>
												<span>账号：</span>
												<input type="text" name="account" value="<%StringHelper.filterHTML(out, request.getParameter("account"));%>" class="yhgl_input" />
											</p>
											<P>
												<span>充值时间：</span>
												<input type="text" name="startTime" id="datepicker1" readonly="readonly" class="yhgl_input date" />至
												<input type="text" name="endTime" id="datepicker2" readonly="readonly" class="yhgl_input date" />
											</P>
											<P>
												<span>充值状态：</span>
												<select name="status" class="yhgl_sel" >
													<option>全部</option>
													<%for (T7150_F05 status : T7150_F05.values()) {%>
													<option value="<%=status.name()%>" <%if (status.name().equals(request.getParameter("status"))){%> selected="selected" <%}%>><%=status.getChineseName()%></option>
													<%}%>
												</select>
											</P>
											<div class="clear"></div>
											<div class="mt10">
												<input name="search" type="submit" class="btn2 mr10" value="搜索" />			
					                          	<%
								                          		if (dimengSession.isAccessableResource(AddXxcz.class)) {
								                          	%>
						                    		<a href="javascript:void(0)" name="input" onclick="window.location.href='<%=controller.getURI(request, AddXxcz.class)%>'" class="btn3 "><span class="ico1"></span>新增</a>
						                    	<%
						                    		}else{
						                    	%>
						                    		<span class="btn3 mr10 btn5"><span class="ico1"></span>新增</span>
						                    	<%
						                    		}
						                    	%>
						                    	<%
						                    		if (dimengSession.isAccessableResource(ExportXxczgl.class)) {
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
									<td>账号</td>
									<td>时间</td>
									<td>操作人</td>
									<td>状态</td>
									<td>金额(元)</td>
									<td>备注</td>
									<td>操作</td>
								</tr>
								<%
									OfflineChargeRecord[] items = result.getItems();
									if (items != null) {
										int i=1;
										for (OfflineChargeRecord item : items) {if (item == null) {continue;}
								%>
								<tr class="dhsbg">
									<td><%=i++%></td>
									<td><%StringHelper.filterHTML(out, item.F12);%></td>
									<td><%=Formater.formatDateTime(item.F07)%></td>
									<td><%StringHelper.filterHTML(out, item.F13);%></td>
									<td>
										<%if(item.F05!=null){%><%StringHelper.filterHTML(out,item.F05.getChineseName());%><%}%>
									</td>
									<td><%=Formater.formatAmount(item.F04)%></td>
									<td title="<%StringHelper.filterHTML(out,item.F08);%>"><%StringHelper.filterHTML(out,StringHelper.truncation(item.F08, 15));%></td>
									<td>
										<%if(item.F05 == T7150_F05.DSH){ %>
											<%if (dimengSession.isAccessableResource(Xxczshtg.class)) {%>
				                          	<span class="blue"><a href="<%=controller.getURI(request,Xxczshtg.class)%>?id=<%=item.F01%>" onclick="return onConfirmTg()" class="mr10">审核通过</a></span>
				                          	<%}%>
				                          	<%if (dimengSession.isAccessableResource(Xxczqx.class)) {%>
				                          	<span class="blue"><a href="<%=controller.getURI(request,Xxczqx.class)%>?id=<%=item.F01%>" onclick="return onConfirmBtg()" class="mr10">审核不通过</a></span>
				                          	<%}%>
			                          	<%}%>
									</td>
								</tr>
								<%}}%>
							</table>
							<%
								AbstractFinanceServlet.rendPagingResult(out, result);
							%>
							<div class="box2 clearfix"></div>
						</form>
					</div>
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
	<%@include file="/WEB-INF/include/datepicker.jsp"%>
	<script type="text/javascript">
	function showExport()
	{
		document.getElementById("searchForm").action ="<%=controller.getURI(request, ExportXxczgl.class)%>";
		$("#searchForm").submit();
		document.getElementById("searchForm").action ="<%=controller.getURI(request, XxczglList.class)%>";
	}
	$(function() {
		$("#datepicker1").datepicker({inline: true});
	    $('#datepicker1').datepicker('option', {dateFormat:'yy-mm-dd'});
	    $("#datepicker2").datepicker({inline: true});
	    $('#datepicker2').datepicker('option', {dateFormat:'yy-mm-dd'});
	    $("#datepicker1").datepicker("setDate", "<%StringHelper.filterHTML(out, request.getParameter("startTime"));%>");
	    $("#datepicker2").datepicker("setDate", "<%StringHelper.filterHTML(out, request.getParameter("endTime"));%>");
	});
	function onConfirmTg()
	{
		if(window.confirm("你确定要审核通过吗?"))
		{
			return true;
		}else
		{
			return false;	
		}
	}
	function onConfirmBtg()
	{
		if(window.confirm("你确定要审核不通过吗?"))
		{
			return true;
		}else
		{
			return false;	
		}
	}
	</script>
</body>
</html>
