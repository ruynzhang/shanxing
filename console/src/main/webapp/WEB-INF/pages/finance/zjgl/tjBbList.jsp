<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.console.servlets.finance.zjgl.TjBbList"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.zjgl.TjBbList"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.zjgl.XYjlList"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.zjgl.XYCredit"%>
<%@page import="com.dimeng.util.Formater"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.zjgl.ExportDzd"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.zjgl.ExportTjBb"%>
<%@page import="com.dimeng.p2p.console.servlets.AbstractConsoleServlet"%>
<%@page import="com.dimeng.p2p.modules.account.console.service.entity.FundXYAccountType"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="com.dimeng.p2p.modules.account.console.service.entity.FundsTjBbView"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<%
	PagingResult<FundsTjBbView> fundsTjBbList =(PagingResult<FundsTjBbView>)request.getAttribute("fundsTjBbList");
%>
	<%
		CURRENT_CATEGORY = "CWGL";
			CURRENT_SUB_CATEGORY = "TJBBLIST";
	%>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="w_main">
		<div class="main clearfix">
			<div class="wrap">
				<div class="r_main">
					<form action="<%=controller.getURI(request, TjBbList.class)%>" method="post" id="searchForm" name="form1">
						<div class="home_main">
									<div class="box box1 mb15">
								<div class="atil">
									<h3>统计报表</h3>
								</div>
								<div class="con">
								
								</div>
							</div>
							<div class="box box1 mb15">
								<div class="con">
									<div class="admin_input admin_pb">
           								<div class="table">	
											<p>
												<span>用户名：</span>
												<input type="text" name="loginName" value="<%StringHelper.filterHTML(out, request.getParameter("loginName"));%>" id="loginName" class="yhgl_input" />
											</p>
											<p>
												<span>用户类型：</span>
												<select name="fundAccountType" class="yhgl_sel" id="fundAccountType" >
													<option value="0">全部</option>
						                           <%
						                           	for(FundXYAccountType fundAccountType:FundXYAccountType.values())
						                           				                             	{
						                           %>
						                           <option value="<%=fundAccountType.name()%>" <%if(fundAccountType.name().equals(request.getParameter("fundAccountType"))) {%> selected="selected" <%}%>><%=fundAccountType.getName()%></option>
						                           <%
						                           	}
						                           %>
						                         </select>
											</p>
											<p>
												<span>日期段：</span>
												<input type="text" readonly="readonly" name="startTime" id="datepicker1" class="yhgl_input date" />至
											    <input type="text" readonly="readonly" name="endTime" id="datepicker2" class="yhgl_input date" />
											</p>
											<div class="clear"></div>   
                    						<div class="mt10">   
                    							<input name="search" type="submit" class="btn2 mr10" value="搜索" />
                    								<%
                    									if (dimengSession.isAccessableResource(ExportTjBb.class)) 
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
									<td>用户Id</td>
									<td>资金账号</td>
									<td>账户名称</td>
									<td>姓名</td>
									<td>用户类型</td>
									<td>充值金额(元)</td>
									<td>充值手续费(元)</td>
									<td>提现金额(元)</td>
									<td>提现手续费(元)</td>
									<td>用户收益(元)</td>
									<td>账户余额(元)</td>
									<td>冻结账户余额(元)</td>
									<td>操作</td>
								</tr>
								<%
								FundsTjBbView[] fundsViews =null;
														if(fundsTjBbList!=null){
															fundsViews=fundsTjBbList.getItems();
														}
															if(fundsViews!=null)
															{
																for(int i=0;i<fundsViews.length;i++)
																{
																	FundsTjBbView record=fundsViews[i];
																	
																	if(record==null)
																	{
																		continue;
																	}
								%>
								<tr class="dhsbg">
									<td><%=i+1%></td>
									<td><%=record.userId%></td>
									<td><%=record.zjAccount%></td>
									<td><%=record.accountName%></td>
									<td><%=record.realName%></td>
									<td><%=record.userType%></td>
									<td><%=record.czJine%></td>
									<td><%=record.czSxf%></td>
									<td><%=record.txJine%></td>
									<td><%=record.txSxf%></td>
									<td><%=record.userSy%></td>
									<td><%=record.accountYe%></td>
									<td><%=record.djAccountYe%></td>
									<td class="blue">
										<%
											if (dimengSession.isAccessableResource(ExportDzd.class)) {
										%> <a href="javascript:clickDzd('<%=controller.getURI(request, ExportDzd.class)%>?id=<%=record.zjId%>');">对账单</a> <%}else{%> 
										<span class="gray6">对账单</span> <%} %>
									</td>
								</tr>
								<%}}else{ %>
								<tr><td colspan="8"></td></tr>
								<%} %>
							</table>
							<%AbstractConsoleServlet.rendPagingResult(out, fundsTjBbList); %>
							<div class="box2 clearfix"></div>
						</div>
					</form>
						<%
															if(fundsViews!=null)
															{
																for(int i=0;i<fundsViews.length;i++)
																{
																	FundsTjBbView record=fundsViews[i];
																	if(record==null)
																	{
																		continue;
																	}
								%>
				
			    <%}} %>
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
			document.getElementById("searchForm").action ="<%=controller.getURI(request, ExportTjBb.class)%>";
			$("#searchForm").submit();
			document.getElementById("searchForm").action ="<%=controller.getURI(request, TjBbList.class)%>";
		}
		function showxycredit(i)
		{
			$("#xycredit_"+i).show();
			return;
		}
		function xycredit(i)
		{
			var fundAccountType=$("#fundAccountType").val();
			var loginName=$("#loginName").val();
			$("#xycreditForm_"+i).append('<input name="fundAccountType" type="hidden" value="'+fundAccountType+'">').append('<input name="loginName" type="hidden" value="'+loginName+'">');
			
			$("#xycreditForm_"+i).submit();
			return;
		}
		$(function() {
			$("#datepicker1").datepicker({inline: true});
		    $('#datepicker1').datepicker('option', {dateFormat:'yy-mm-dd'});
		    $("#datepicker2").datepicker({inline: true});
		    $('#datepicker2').datepicker('option', {dateFormat:'yy-mm-dd'});
		    $("#datepicker1").datepicker("setDate", "<%StringHelper.filterHTML(out, request.getParameter("startTime"));%>");
		    $("#datepicker2").datepicker("setDate", "<%StringHelper.filterHTML(out, request.getParameter("endTime"));%>");
		});
		
		// 点击对账单
		function clickDzd(url) {
			var endTime = $("#datepicker2").val();
			var startTime = $("#datepicker1").val();
			
			// 若有选择日期->比较开始日期是否超过了结束日期
			if(!reg_NULL(startTime)&&!reg_NULL(endTime)) {
				var endDate = getDateByStr(endTime);
				var startDate = getDateByStr(startTime);
				if(startDate>endDate) {
					alert("开始日期不能大于结束日期");
					return false;
				}
			}
			
			url = url+"&startTime="+startTime+"&endTime="+endTime;
			window.open(url);
		}
		
		// 是否为空
		function reg_NULL(str) {
			if (str == undefined || str == "" || str.length == 0) {
				return true;
			}
			return false;
		}
		
		// 获取日期
		function getDateByStr(str){
			if(!reg_NULL(str)){
				if(str.indexOf("-")!=-1){
					str = str.replaceAll("-", "/");
				}
				var date = new Date(Date.parse(str));
				return date;
			}
		}
		// 构造replaceAll函数使得其他地方可以直接引用(String.prototype加上的意思是可以str.replaceAll(par1,par2)这两调用)
		String.prototype.replaceAll = function(s1, s2) {
			var r = new RegExp(s1.replace(/([\(\)\[\]\{\}\^\$\+\-\*\?\.\"\'\|\/\\])/g, "\\$1"), "ig");
			return this.replace(r, s2);
		}
	</script>
</body>
</html>