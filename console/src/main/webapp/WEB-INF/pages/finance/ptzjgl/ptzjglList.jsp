<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.util.Formater"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.AbstractFinanceServlet"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.ptzjgl.WithdrawalPtzj"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.ptzjgl.RechargePtzj"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.ptzjgl.ExportPtzjgl"%>
<%@page import="com.dimeng.p2p.common.enums.PlatformFundType"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.ptzjgl.PtzjglList"%>
<%@page import="com.dimeng.p2p.modules.finance.console.service.entity.PtzjglRecord"%>
<%@page import="com.dimeng.p2p.modules.finance.console.service.entity.Ptzjgl"%>
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
	Ptzjgl ptzjgl = ObjectHelper.convert(
				request.getAttribute("ptzjgl"), Ptzjgl.class);
		PagingResult<PtzjglRecord> result = (PagingResult<PtzjglRecord>) request
				.getAttribute("result");
%>
<%
	CURRENT_CATEGORY = "CWGL";
		CURRENT_SUB_CATEGORY = "PTZJGL";
%>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="w_main">
		<div class="main clearfix">
			<div class="wrap">
				<div class="r_main">
					<form action="<%=controller.getURI(request, PtzjglList.class) %>" name="form1" method="post" id="searchForm">
						<div class="home_main">
							<div class="box box1 mb15">
								<div class="atil">
									<h3>平台资金管理</h3>
								</div>
								<div class="con">
									<div class="clear"></div>
									<ul class="yhxq_li">
										<li>账户余额：<span class="blue"><%=Formater.formatAmount(ptzjgl.platformAmount)%></span>元
										</li>
									</ul>
									<ul class="yhxq_li">
										<li>收入总额 ：<span class="blue"><%=Formater.formatAmount(ptzjgl.totalIncome)%></span>元
										</li>
									</ul>
									<ul class="yhxq_li">
										<li>支出总额：<span class="blue"><%=Formater.formatAmount(ptzjgl.totalReplay)%></span>元
										</li>
									</ul>
									<ul class="yhxq_li">
										<li>盈亏 ：<span class="blue"><%=Formater.formatAmount(ptzjgl.profitLoss)%></span>元
										</li>
									</ul>
									<ul class="yhxq_li">
										<li>更新时间 ：<span class="blue"><%=DateTimeParser.format(ptzjgl.updateTime)%></span>
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
											<span>类型明细：</span>
											<select name="type" class="yhgl_sel" >
						                    	<option>全部</option>
						                         <%for(PlatformFundType type:PlatformFundType.values())
						                            {
						                         %>
						                          <option value="<%=type.name()%>" <%if(type.name().equals(request.getParameter("type"))){ %> selected="selected" <%} %>><%=type.getName() %></option>
						                         <%} %>
						                    </select>
						                </p>
						                <p>
											<span>用户名：</span>
											<input type="text" name="userName" class="yhgl_input" value="<%StringHelper.filterHTML(out, request.getParameter("userName")); %>"/>
						                </p>
						                <p>
											<span>时间：</span>
											<input type="text" name="startPayTime" id="datepicker1" readonly="readonly" class="yhgl_input date" value="<%StringHelper.filterHTML(out, request.getParameter("startPayTime")); %>"/>至
											<input type="text" name="endPayTime" id="datepicker2" readonly="readonly" value="<%StringHelper.filterHTML(out, request.getParameter("endPayTime")); %>" class="yhgl_input date" />
										</p>
										<div class="clear"></div>   
                   						<div class="mt10">   
                   							<input name="search" type="submit" class="btn2 mr10" value="搜索" />
                   							<%
											if (dimengSession.isAccessableResource(ExportPtzjgl.class)) {
											%>
											<a href="javascript:void(0)" onclick="showExport()" class="btn3 mr10"><span class="ico"></span>导出</a>
											<%}else{ %>
											<span class="btn3 btn5 mr10"><span class="ico"></span>导出</span>
											<%} %> 
											<%
											if (dimengSession.isAccessableResource(RechargePtzj.class)) {
											%>
											<a href="javascript:void(0)" onclick="showRecharge()" class="btn3 mr10 tc">充值</a>
											<%}else{ %>
											<span class="btn3 mr10 btn5 tc">充值</span>
											<%} %> 
											<%
											if (dimengSession.isAccessableResource(WithdrawalPtzj.class)) {
											%>
											<a href="javascript:void(0)" onclick="showWithdrawal()" class="btn3 mr10 tc">提现</a>
											<%}else{ %>
											<span class="btn3 mr10 btn5 tc">提现</span>
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
									<td>时间</td>
									<td>用户名</td>
									<td>类型明细</td>
									<td>收入</td>
									<td>支出</td>
									<td>结余</td>
									<td>备注</td>
								</tr>
								<%
									PtzjglRecord[] records=result.getItems();
									if(records!=null)
									{
										int i=1;
										for(PtzjglRecord record:records)
										{
											if(record==null)
											{
												continue;
											}
								%>
								<tr class="dhsbg">
									<td><%=i++ %></td>
									<td><%=DateTimeParser.format(record.playTime,"yyyy-MM-dd HH:mm:ss") %></td>
									<td><%if(!StringHelper.isEmpty(record.loginName)){%><%StringHelper.filterHTML(out, record.loginName); %><%}else{ %>--<%} %></td>
									<td><%if(record.type!=null){%><%=record.type.getName() %><%} %></td>
									<td><%=Formater.formatAmount(record.income) %></td>
									<td><%=Formater.formatAmount(record.replay) %></td>
									<td><%=Formater.formatAmount(record.remain) %></td>
									<td title="<%StringHelper.filterHTML(out, record.remark);%>"><%StringHelper.filterHTML(out, StringHelper.truncation(record.remark, 15)); %></td>
								</tr>
								<%}}else{ %>
								<tr><td colspan="7"></td></tr>
								<%} %>
							</table>
							<%AbstractFinanceServlet.rendPagingResult(out, result); %>
							<div class="box2 clearfix"></div>
						</div>
					</form>
				</div>
			</div>
			<%@include file="/WEB-INF/include/left.jsp"%>
		</div>
	</div>
	<div id="rechargeDiv" style="display: none;">
		<div class="popup_bg"></div>
		<div class="popup add_information"
			style="width: 450px; margin: -70px 0 0 -225px;  z-index: 99999; position: fixed; left: 50%; top: 50%; _position: absolute; _top: expression(200 +((   e =   document.documentElement.scrollTop)?e:document.body.scrollTop)+'px'); z-index: 100000;">
			<div class="til clearfix">
				<h2>平台资金充值</h2>
				<div class="close">
					<a href="javascript:void(0)" class="close">关闭</a>
				</div>
			</div>
			<div class="con">
				<form action="<%=controller.getURI(request, RechargePtzj.class)%>" method="post" class="rechargeForm">
					<input type="hidden" name="id" id="id" />
					<table  class="jgzjcz_table">
						<tr><td>充值金额:</td><td><input type="text" id="cz" name="ammount" onblur="czje()" class="yhgl_input required" mtest="/^[-\+]?\d+(\.\d+)?$/" mtestmsg="金额格式不正确"/>
							<p tip></p>
							<p errortip class="" style="display: none"></p></td></tr>
						<tr>
							<td valign="top"><span>描述:</span></td>
							<td><textarea rows="4" cols="40" name="remark" class="max-length-250"></textarea><p tip></p><p errortip class="" style="display: none"></p></td>
						</tr>
						<tr>
							<td colspan="2">
								<div style="width:193px;margin:auto;">
									<button type="submit" class="btn3 mr10 sumbitForme" fromname="rechargeForm">确认</button>
									<button type="button" class="btn5  close">取消</button>
								</div>
							</td>
						</tr>
					</table>
				</form>
			</div>
		</div>
	</div>
	<div id="withdrawalDiv" style="display: none;">
		<div class="popup_bg"></div>
		<div class="popup add_information"
			style="width: 450px; margin: -70px 0 0 -225px;z-index: 99999; position: fixed; left: 50%; top: 50%; _position: absolute; _top: expression(200 +((   e =   document.documentElement.scrollTop)?e:document.body.scrollTop)+'px'); z-index: 100000;">
			<div class="til clearfix">
				<h2>平台资金提现</h2>
				<div class="close">
					<a href="javascript:void(0)" class="close">关闭</a>
				</div>
			</div>
			<div class="con">
				<form action="<%=controller.getURI(request, WithdrawalPtzj.class)%>" method="post" class="withdrawalForm">
					<input type="hidden" name="id" id="id" />
					<table  class="jgzjcz_table">
						<tr><td>提现金额:</td><td>
							<input type="text" id="tx" name="ammount" onblur="txje()" class="yhgl_input required" mtest="/^[-\+]?\d+(\.\d+)?$/" mtestmsg="金额格式不正确"/>
							<p tip></p>
							<p errortip class="" style="display: none"></p></td></tr>
						<tr>
							<td valign="top"><span>描述:</span></td>
							<td><textarea rows="4" cols="40" name="remark" class="max-length-250"></textarea><p tip></p><p errortip class="" style="display: none"></p></td>
						</tr>
						<tr>
							<td colspan="2">
								<div style="width:193px;margin:auto;" >
									<button type="submit" class="btn3 sumbitForme mr10" fromname="withdrawalForm">确认</button>
									<button type="button" class="btn5 close">取消</button>
								</div>
							</td>
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
	<script type="text/javascript"
		src="<%=controller.getStaticPath(request)%>/js/validation.js"></script>
	<%@include file="/WEB-INF/include/datepicker.jsp"%>
	<script type="text/javascript">
		function showRecharge()
		{
			$("#rechargeDiv").show();
		}
		function showWithdrawal()
		{
			$("#withdrawalDiv").show();
		}
		$(".close").click(function() {
			$("#rechargeDiv").hide();
			$("#withdrawalDiv").hide();
		});
		function showExport()
		{
			document.getElementById("searchForm").action ="<%=controller.getURI(request, ExportPtzjgl.class)%>";
			$("#searchForm").submit();
			document.getElementById("searchForm").action ="<%=controller.getURI(request, PtzjglList.class)%>";
		}
		$(function() {
			$("#datepicker1").datepicker({inline: true});
		    $('#datepicker1').datepicker('option', {dateFormat:'yy-mm-dd'});
		    $("#datepicker2").datepicker({inline: true});
		    $('#datepicker2').datepicker('option', {dateFormat:'yy-mm-dd'});
		    $("#datepicker1").datepicker("setDate", "<%StringHelper.filterHTML(out, request.getParameter("startPayTime"));%>");
		    $("#datepicker2").datepicker("setDate", "<%StringHelper.filterHTML(out, request.getParameter("endPayTime"));%>");
		});
		
		function czje(){
			var value = document.getElementById("cz").value;
			var myreg = /^[-\+]?\d+(\.\d+)?$/;
			if(myreg.test(value)){
				var temp = new Number(value).toFixed(2);
				document.getElementById("cz").value = temp;
			}else{
				return false;
			}
		}
		
		function txje(){
			var value = document.getElementById("tx").value;
			var myreg = /^[-\+]?\d+(\.\d+)?$/;
			if(myreg.test(value)){
				var temp = new Number(value).toFixed(2);
				document.getElementById("tx").value = temp;
			}else{
				return false;
			}
		}
	</script>
</body>
</html>