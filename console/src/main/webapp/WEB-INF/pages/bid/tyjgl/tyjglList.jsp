<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.console.servlets.bid.tyjgl.BidTyjZf"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.tyjgl.PreReleaseTyj"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.tyjgl.AddProjectTyj"%>
<%@page import="com.dimeng.p2p.common.enums.Tyjbdinfo_status"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<%@page import="com.dimeng.p2p.common.Expemonyinfo"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.tyjgl.ViewProjectTyj"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.tyjgl.ReleaseTyj"%>
<%@page import="com.dimeng.p2p.common.enums.CreditStatus"%>
<%@page import="com.dimeng.util.Formater"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.tyjgl.AddAnnexMsk"%>
<%@page import="com.dimeng.p2p.console.servlets.AbstractConsoleServlet"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%
		CURRENT_CATEGORY="YWGL";
		CURRENT_SUB_CATEGORY="TYJGL";
		PagingResult<Expemonyinfo> result = ObjectHelper.convert(request.getAttribute("result"), PagingResult.class);
		Expemonyinfo[] loans = result.getItems();
		String createTimeStart=request.getParameter("createTimeStart");
		String createTimeEnd=request.getParameter("createTimeEnd");
	%>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="w_main">
		<div class="main clearfix">
			<div class="wrap">
				<div class="r_main">
					<form action="<%=controller.getURI(request, TyjglList.class)%>" method="post">
					<div class="home_main">
						<div class="box box1 mb15">
							<div class="atil">
								<h3>体验金管理</h3>
							</div>
							<div class="con">
									<div class="admin_input admin_pb">
										<p>
											借款标题： <input type="text" name="title" class="yhgl_input" value="<%StringHelper.filterHTML(out, request.getParameter("title"));%>"/>
										</p>
										<p>
											处理时间：
											<input type="text" readonly="readonly" name="createTimeStart" id="datepicker1" class="yhgl_input date" />至
											<input type="text" readonly="readonly" name="createTimeEnd" id="datepicker2" class="yhgl_input date" />
										</p>
										<p>
											借款账户： <input type="text" name="name" class="yhgl_input" value="<%StringHelper.filterHTML(out, request.getParameter("name"));%>"/>
										</p>
										<p>
											状态： 
											<select name="status" class="yhgl_sel">
											<option>全部</option>
											<%
												for (Tyjbdinfo_status status : Tyjbdinfo_status.values()) {
											%>
											<option value="<%=status.name()%>" <%if (status.name().equals(request.getParameter("status"))) {%> selected="selected" <%}%>><%=status.getChineseName()%></option>
											<%
												}
											%>
											</select>
										</p>
										<div class="clear"></div>
									</div>
									<div class="mt10">
										<input name="input" type="submit" class="btn2 fl mr10" value="搜索" />
										<a href="<%=controller.getURI(request, AddProjectTyj.class)%>" class="btn3"><span class="ico1"></span>新增</a>
									</div>
									<div class="clear"></div>
							</div>
						</div>
						<div>
							<table width="100%" border="0" cellspacing="0" cellpadding="3" class="yhgl_table tc">
								<tr class="hsbg">
									<td>序号</td>
									<td>借款标题</td>
									<td>借款账户</td>
									<td>借款金额</td>
									<td>投标金额</td>
									<td>年利率</td>
									<td>期限</td>
									<td>处理时间</td>
									<td>还款方式</td>
									<!-- <td>资金用途</td> -->
									<td>状态</td>
									<td>操作</td>
								</tr>
								<%
									if(loans!=null){
															int i=1;
															for(Expemonyinfo loan:loans){
								%>
								<tr>
									<td><%=i++ %></td>
									<td title="<%StringHelper.filterHTML(out, loan.title); %>"><%StringHelper.filterHTML(out,StringHelper.truncation(loan.title, 15) ); %></td>
									<td><%StringHelper.filterHTML(out, loan.account_name); %></td>
									<td><%=Formater.formatAmount(loan.borrmoney) %></td>
									<td><%=Formater.formatAmount(loan.invetstment) %></td>
									<td><%=Formater.formatAmount(loan.borrint) %>%</td>
									<td>
										<%out.print(loan.borrterm); %>天
									</td>
									<td><%=DateTimeParser.format(loan.processtime) %></td>
									<td>利息到期一次还清</td>
									<td><% StringHelper.filterHTML(out, loan.estatus.getChineseName()); %></td>
									<td class="blue">
										<span class="blue">
										    <a href="<%=controller.getURI(request, AddAnnexMsk.class) %>?loanId=<%=loan.id %>&userId=<%=loan.F02 %>" class="yhgl_a1">附件</a></span>
										    <a href="<%=controller.getURI(request, ViewProjectTyj.class) %>?loanId=<%=loan.id %>&userId=<%=loan.F02 %>" class="yhgl_a1">查看</a></span>
										    <%if(loan.estatus==Tyjbdinfo_status.DFB){ %>
											<a href="javascript:void(0)" onclick="fbBid('<%=loan.title %>','<%=controller.getURI(request, ReleaseTyj.class) %>?loanId=<%=loan.id%>')" class="mr5">发布</a>
											<a href="javascript:void(0)" class="mr5" onclick="showYfbDiv('<%=loan.id%>')">预发布</a>
									        	<a href="<%=controller.getURI(request, BidTyjZf.class) %>?loanId=<%=loan.id%>" onclick="return showZf('<%=loan.title %>')" class="mr5">作废</a>
									     	<%}else{ %>
									     	 &nbsp;<span class="disabled">发布</span>&nbsp;
									     	 <span class="disabled">预发布</span>&nbsp;
									     	 <span class="disabled">作废</span>
									     	<%} %>
									</td>
								</tr>
								<%}}else{ %>
									<tr><td align="center" colspan="11"></td></tr>
								<%} %>
							</table>
						</div>
						<%
							AbstractConsoleServlet.rendPagingResult(out, result);
						%>
						<div class="clear"></div>
					</div>
					</form>
				</div>
			</div>
			<%@include file="/WEB-INF/include/left.jsp"%>
	</div>
	</div>
	<div class="w440 thickbox thickpos" id="yfbDiv" style="margin:-100px 0 0 -220px;display: none;">
		<div class="tit"><span class="fr pr15 close" onclick="javascript:document.getElementById('yfbDiv').style.display='none';return false;"><a href="javascript:void(0);" >关闭</a></span> </div>
			<form action="<%=controller.getURI(request, PreReleaseTyj.class) %>" method="post" class="form1">
			  	<input type="hidden" name="loanId" id="loanId"/>
			    <div class="info clearfix">
			      <div class="mb10">
			        <div id="u303">
			          <p><i class="red">*</i>发布时间：</p>
			          <input type="text" class="text yhgl_ser date required" readonly="readonly" id="datepicker3" name="releaseTime"/>
			       	  <p tip></p>
					  <p errortip class="" style="display: none"></p>
			        </div>
			      </div>
			      <div class="clear"></div>
			      <div class="dialog_btn">
			      <input type="submit" id="button2" value="预发布"  class="btn4 fl mr10 sumbitForme" fromname="form1"/>
			      <input type="button" onclick="javascript:document.getElementById('yfbDiv').style.display='none';return false;" value="取消" class="btn5 fl"/>
			      </div>      
			    </div>
		   </form>
	</div>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
	<%@include file="/WEB-INF/include/jquery.jsp" %>
	<%@include file="/WEB-INF/include/datepicker.jsp"%>
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
	<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/jquery-ui-1.10.4/js/time.js"></script>
	<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/validation.js"></script>
	<script type="text/javascript">
	$(function() {
	    $('#datepicker1').datepicker('option', {dateFormat:'yy-mm-dd'});
	    $('#datepicker1').datepicker({
	    	inline: true,
	    	onSelect: function(selectedDate) {
	    		$("#datepicker2").datepicker("option", "minDate", selectedDate);  
	    	}
	    });	
	    $('#datepicker2').datepicker('option', {dateFormat:'yy-mm-dd'});
	    $('#datepicker2').datepicker({inline: true});	
	   	<%
	   		if(!StringHelper.isEmpty(createTimeStart))
	   		{
	   	%>
	   	$("#datepicker1").val("<%StringHelper.filterHTML(out, request.getParameter("createTimeStart"));%>");
	   	<%}%>
	   	<%
   		if(!StringHelper.isEmpty(createTimeEnd))
   		{
   		%>
	    $("#datepicker2").val("<%StringHelper.filterHTML(out, request.getParameter("createTimeEnd"));%>");
	    <%}%>
	    $('#datepicker3').datetimepicker({
			timeFormat: 'HH:mm:ss',
			dateFormat:'yy-mm-dd'
		});
	    //$("#datepicker3").datepicker({inline: true});
	   // $('#datepicker3').datepicker('option', {dateFormat:'yy-mm-dd'});
	});
		function showYfbDiv(loanId)
		{
			$("#loanId").attr("value",loanId);
			$("#yfbDiv").show();
		}
		
		function fbBid(title,url){
			if(confirm("您需要现在立即发布“"+title+"”标？")){
				location.href=url;
			}else{
				return;
			}
		}
		
		function showZf(title)
		{
			if(confirm("您确定要作废“"+title+"”标?"))
			{
				return true;	
			}else{
				return false;
			}
		}
	</script>
</body>
</html>