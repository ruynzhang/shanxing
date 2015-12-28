<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.console.servlets.finance.zjgl.XyList"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.zjgl.XYjlList"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.zjgl.XYCredit"%>
<%@page import="com.dimeng.util.Formater"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.zjgl.ExportXYgl"%>
<%@page import="com.dimeng.p2p.console.servlets.AbstractConsoleServlet"%>
<%@page import="com.dimeng.p2p.modules.account.console.service.entity.FundXYAccountType"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="com.dimeng.p2p.modules.account.console.service.entity.FundsXYView"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<%
	PagingResult<FundsXYView> fundsXYViewList =(PagingResult<FundsXYView>)request.getAttribute("fundsXYViewList");
%>
	<%
		CURRENT_CATEGORY = "CWGL";
			CURRENT_SUB_CATEGORY = "XYGL";
	%>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="w_main">
		<div class="main clearfix">
			<div class="wrap">
				<div class="r_main">
					<form action="<%=controller.getURI(request, XyList.class)%>" method="post" id="searchForm" name="form1">
						<div class="home_main">
									<div class="box box1 mb15">
								<div class="atil">
									<h3>信用账户管理</h3>
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
											<div class="clear"></div>   
                    						<div class="mt10">   
                    							<input name="search" type="submit" class="btn2 mr10" value="搜索" />
                    								<%
                    									if (dimengSession.isAccessableResource(ExportXYgl.class)) 
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
									<td>姓名或企业名称</td>
									<td>信用积分</td>
									<td>授信额度(元)</td>
									<td>用户名</td>
									<td>用户类型</td>
									<td>最后更新时间</td>
									<td>操作</td>
								</tr>
								<%
								FundsXYView[] fundsViews =null;
														if(fundsXYViewList!=null){
															fundsViews=fundsXYViewList.getItems();
														}
															if(fundsViews!=null)
															{
																for(int i=0;i<fundsViews.length;i++)
																{
																	FundsXYView record=fundsViews[i];
																	
																	if(record==null)
																	{
																		continue;
																	}
								%>
								<tr class="dhsbg">
									<td><%=i+1%></td>
									<td><%StringHelper.filterHTML(out, record.userName); %></td>
									<td><%=record.F02%></td>
									<td><%=Formater.formatAmount(record.F03)%></td>
									<td><%
										StringHelper.filterHTML(out, record.F05);
									%></td>
									<td><%StringHelper.filterHTML(out, record.userType); %></td>
									<td><%
										if(record.F04!=null){
									%><%=Formater.formatDateTime(record.F04)%><%
										}
									%></td>
									<td class="blue">
										<%
											if (dimengSession.isAccessableResource(XYjlList.class)) {
										%>
											<a href="<%=controller.getURI(request, XYjlList.class)%>?id=<%=record.F01%>">信用记录</a>
											<%}else{ %>
											<span class="gray6">信用记录</span>
											<%} %> 
												<%
											if (dimengSession.isAccessableResource(XYCredit.class)) {
										%>
											<a href="javascript:void(0)" onclick="showxycredit('<%=i+1 %>')" class="mr10">修改信用额度</a>
											<%}else{ %>
											<span class="gray6">修改信用额度</span>
											<%} %> 
									</td>
								</tr>
								<%}}else{ %>
								<tr><td colspan="8"></td></tr>
								<%} %>
							</table>
							<%AbstractConsoleServlet.rendPagingResult(out, fundsXYViewList); %>
							<div class="box2 clearfix"></div>
						</div>
					</form>
						<%
															if(fundsViews!=null)
															{
																for(int i=0;i<fundsViews.length;i++)
																{
																	FundsXYView record=fundsViews[i];
																	if(record==null)
																	{
																		continue;
																	}
								%>
				<div class="wrap" id="xycredit_<%=i+1%>" style="display: none">
	<div class="popup_bg"></div>
							<form action="<%=controller.getURI(request, XYCredit.class)%>" id="xycreditForm_<%=i+1%>" method="post">
			        <input type="hidden" name="userId" value="<%=record.F01%>"/><div id="sd" class="w440 thickbox thickpos" style="margin:-80px 0 0 -220px;">
				        <div class="tit">
				         <span class="fl pl15">修改信用额度</span>
				         <span class="fr pr15 close" onclick="javascript:document.getElementById('xycredit_<%=i+1%>').style.display='none';return false;"><a href="#">关闭</a></span>
				      </div>
				      <div id="js" class="info clearfix">
				      	<div class="clearfix">
				        
				        </div>
				        <div class="cell clearfix mb20">
              				<div class="list01">信用额度：</div>
               			<div class="list02">
		                <input name="userCredit" value="<%=Formater.formatAmount(record.F03)%>" maxlength="20"  type="text" class="text required ">
		               	<p tip></p>
							<p errortip class="" style="display: none"></p>
		                </div>
         			    </div>
         			    <div class="clear"></div>				        
				        <div class="dialog_btn">
				       <a href="javascript:void(0)" onclick="xycredit(<%=i+1%>)" class="btn4 ml50">提交</a>
				        </div> 
				      </div>
					</div>
					</form>
			    </div>
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
		<script type="text/javascript">
		function showExport()
		{
			document.getElementById("searchForm").action ="<%=controller.getURI(request, ExportXYgl.class)%>";
			$("#searchForm").submit();
			document.getElementById("searchForm").action ="<%=controller.getURI(request, XyList.class)%>";
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
	</script>
</body>
</html>