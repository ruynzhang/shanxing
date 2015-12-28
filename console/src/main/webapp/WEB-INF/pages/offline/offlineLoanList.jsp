<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.console.servlets.offline.OfflineLineZf"%>
<%@page import="com.dimeng.p2p.console.servlets.offline.OfflineLoanList"%>
<%@page import="com.dimeng.p2p.console.servlets.offline.PreRelease"%>
<%@page import="com.dimeng.p2p.S62.entities.T6211"%>
<%@page import="com.dimeng.p2p.console.servlets.offline.AddProjectXq"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F20"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<%@page import="com.dimeng.p2p.modules.bid.console.service.entity.Bid"%>
<%@page import="com.dimeng.p2p.console.servlets.offline.UpdateProject"%>
<%@page import="com.dimeng.p2p.console.servlets.offline.ViewProject"%>
<%@page import="com.dimeng.p2p.S60.enums.T6036_F18"%>
<%@page import="com.dimeng.p2p.console.servlets.offline.Release"%>
<%@page import="com.dimeng.p2p.S60.enums.T6036_F20"%>
<%@page import="com.dimeng.p2p.console.servlets.offline.Check"%>
<%@page import="com.dimeng.p2p.common.enums.CreditStatus"%>
<%@page import="com.dimeng.p2p.common.enums.LoanType"%>
<%@page import="com.dimeng.util.Formater"%>
<%@page import="com.dimeng.p2p.console.servlets.AbstractConsoleServlet"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%
			CURRENT_CATEGORY="YWGL";
			CURRENT_SUB_CATEGORY="XXZQGL";
			PagingResult<Bid> result = ObjectHelper.convert(request.getAttribute("result"), PagingResult.class);
			Bid[] loans = result.getItems();
			T6211[] t6211s=ObjectHelper.convertArray(request.getAttribute("t6211s"), T6211.class);
			String createTimeStart=request.getParameter("createTimeStart");
			String createTimeEnd=request.getParameter("createTimeEnd");
	%>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="w_main">
		<div class="main clearfix">
			<div class="wrap">
				<div class="r_main">
					<form action="<%=controller.getURI(request, OfflineLoanList.class)%>" method="post">
					<div class="home_main">
						<div class="box box1 mb15">
							<div class="atil">
								<h3>线下债权转让管理</h3>
							</div>
							<div class="con">
									<div class="admin_input admin_pb">
										<p>
											借款标题： <input type="text" name="title" class="yhgl_input" value="<%StringHelper.filterHTML(out, request.getParameter("title"));%>"/>
										</p>
										<p>
											债权类型：
											<select id="select" class="yhgl_sel" name="type">
														<option value="0">全部</option>
														<%int type = IntegerParser.parse(request.getParameter("type")); %>
															<%
																if(t6211s!=null){
																for(T6211 t6211:t6211s)
																{
																	if(t6211==null)
																	{
																		continue;
																	}
															%>
															<option value="<%=t6211.F01 %>" <%if(type==t6211.F01){ %>selected="selected"<%} %>><%StringHelper.filterHTML(out, t6211.F02); %></option>
															<%}} %>
														</select>
										</p>
										<p>
											处理时间：
											<input type="text" readonly="readonly" name="createTimeStart" id="datepicker1" class="yhgl_input date" />至
											<input type="text" readonly="readonly" name="createTimeEnd" id="datepicker2" class="yhgl_input date" />
										</p>
										<p>
											债务人： <input type="text" name="name" class="yhgl_input" value="<%StringHelper.filterHTML(out, request.getParameter("name"));%>"/>
										</p>
										<p>
											状态： 
											<select name="status" class="yhgl_sel">
											<option>全部</option>
											<%
						                    for (T6230_F20 status : T6230_F20.values()) {
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
										<a href="<%=controller.getURI(request, AddProjectXq.class) %>" class="btn3"><span class="ico1"></span>新增</a>
									</div>
									<div class="clear"></div>
							</div>
						</div>
						<div>
							<table width="100%" border="0" cellspacing="0" cellpadding="3" class="yhgl_table tc">
								<tr class="hsbg">
									<td>序号</td>
									<td>借款标题</td>
									<td>债务人</td>
									<td>金额</td>
									<td>年利率</td>
									<td>期限</td>
									<td>创建时间</td>
									<td>还款方式</td>
									<!-- <td>资金用途</td> -->
									<td>状态</td>
									<td>操作</td>
								</tr>
								<%
								if(loans!=null){
									int i=1;
									for(Bid loan:loans){
								%>
								<tr>
									<td><%=i++ %></td>
									<td title="<%StringHelper.filterHTML(out, loan.F03); %>"><%StringHelper.filterHTML(out,StringHelper.truncation(loan.F03, 15) ); %></td>
									<td><%StringHelper.filterHTML(out, loan.F37); %></td>
									<td><%=loan.F05 %></td>
									<td><%=Formater.formatRate(loan.F06) %></td>
									<td><%=loan.F09 %>个月</td>
									<td><%=DateTimeParser.format(loan.F24) %></td>
									<td><%StringHelper.filterHTML(out, loan.F10.getChineseName()); %></td>
									<%-- <td><%StringHelper.filterHTML(out, loan.F30); %></td> --%>
									<td><%StringHelper.filterHTML(out, loan.F20.getChineseName()); %></td>
									<td class="blue">
										<span class="blue"><a href="<%=controller.getURI(request, ViewProject.class) %>?loanId=<%=loan.F01 %>&userId=<%=loan.F02 %>" class="yhgl_a1">查看</a></span>
										<%
											if(loan.F20==T6230_F20.SQZ&&dimengSession.isAccessableResource(UpdateProject.class))
											{
										%>
										<a href="<%=controller.getURI(request, UpdateProject.class) %>?loanId=<%=loan.F01 %>&userId=<%=loan.F02 %>" class="mr5">修改</a>
										<%}else{ %>
										<span class="disabled">修改</span>
										<%} %>
										<%
											if(loan.F20==T6230_F20.DSH&&dimengSession.isAccessableResource(ViewProject.class))
											{
										%>
										<a href="<%=controller.getURI(request, ViewProject.class) %>?loanId=<%=loan.F01 %>&userId=<%=loan.F02 %>" class="mr5">审核</a>
										<%}else{ %>
										<span class="disabled">审核</span>
										<%} %>
										<%
											if(loan.F20==T6230_F20.DFB&&dimengSession.isAccessableResource(Release.class))
											{ %>
											
											<a href="javascript:void(0)" onclick="fbBid('<%=loan.F03 %>','<%=controller.getURI(request, Release.class) %>?loanId=<%=loan.F01%>')" class="mr5">发布</a>
											<a href="javascript:void(0)" class="mr5" onclick="showYfbDiv('<%=loan.F01%>')">预发布</a>
										<%}else{%>
										<span class="disabled">发布</span>
										<span class="disabled">预发布</span>
										<%} %>
										<%
											if(dimengSession.isAccessableResource(OfflineLineZf.class)&&(loan.F20==T6230_F20.SQZ||loan.F20==T6230_F20.DSH))
											{
										%>
										<a href="<%=controller.getURI(request, OfflineLineZf.class) %>?loanId=<%=loan.F01 %>" onclick="return showZf('<%=loan.F03 %>')" class="mr5">作废</a>
										<%}else{%>
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
			<form action="<%=controller.getURI(request, PreRelease.class) %>" method="post" class="form1">
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
			$("#datepicker1").datepicker({inline: true});
		    $('#datepicker1').datepicker('option', {dateFormat:'yy-mm-dd'});
		    $("#datepicker2").datepicker({inline: true});
		    $('#datepicker2').datepicker('option', {dateFormat:'yy-mm-dd'});
		    <%
	   		if(!StringHelper.isEmpty(createTimeStart))
	   		{
		   	%>
		   	$("#datepicker1").datepicker("setDate", "<%StringHelper.filterHTML(out, request.getParameter("createTimeStart"));%>");
		   	<%}%>
		   	<%
	   		if(!StringHelper.isEmpty(createTimeEnd))
	   		{
	   		%>
		    $("#datepicker2").datepicker("setDate", "<%StringHelper.filterHTML(out, request.getParameter("createTimeEnd"));%>");
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