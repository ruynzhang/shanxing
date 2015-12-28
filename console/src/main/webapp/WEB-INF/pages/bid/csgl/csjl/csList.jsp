<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.S61.enums.T6110_F10"%>
<%@page import="com.dimeng.p2p.S61.enums.T6110_F06"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.jgbyj.CreditRecord"%>
<%@page import="com.dimeng.p2p.console.servlets.AbstractConsoleServlet"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.csgl.csjl.Csxq"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.jkgl.ViewUserInfo"%>
<%@page import="com.dimeng.p2p.S71.enums.T7152_F04"%>
<%@page import="com.dimeng.p2p.S71.entities.T7152"%>
<%@page import="com.dimeng.p2p.modules.account.console.service.UserManage"%>
<%@page import="com.dimeng.p2p.modules.bid.console.service.CollectionManage"%>
<%@page import="com.dimeng.p2p.modules.bid.console.service.entity.CollectionRecordInfo"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%
		CURRENT_CATEGORY="YWGL";
		CURRENT_SUB_CATEGORY="CSJL";
		PagingResult<CollectionRecordInfo> collectionRecordInfos = (PagingResult<CollectionRecordInfo>)request.getAttribute("collectionRecords");
		CollectionRecordInfo[] collectionRecordInfoArray = collectionRecordInfos.getItems();
		CollectionManage collectionManage = serviceSession.getService(CollectionManage.class);
		UserManage userManage = serviceSession.getService(UserManage.class);
	%>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="w_main">
		<div class="main clearfix">
			<div class="wrap">
				<div class="r_main">
					<div class="home_main">
						<div class="box box1 mb15">
							<div class="atil">
								<h3>催收记录</h3>
							</div>
						</div>
						<form id="form1" action="<%=controller.getURI(request, CsList.class)%>" method="post">
							<div class="box box1 mb15">
								<div class="con">
									<div class="admin_input admin_pb">
										<p>
											借款者：<input type="text" name="userName" class="yhgl_input" value="<%StringHelper.filterHTML(out, request.getParameter("userName"));%>" />
										</p>
										<p>
											催款方式： <select name="type" class="yhgl_sel">
												<option value="">全部</option>
												<%
													for (T7152_F04 collectionType : T7152_F04.values()) {
												%>
												<option value="<%=collectionType.name()%>" <%if (collectionType.name().equals(request.getParameter("type"))) {%> selected="selected" <%}%>><%=collectionType.getChineseName()%></option>
												<%
													}
												%>
											</select>
										</p>
										<p>
											时间：<input readonly="readonly" type="text" name="createTimeStart" id="datepicker1" class="yhgl_input date" />至<input readonly="readonly" type="text" name="createTimeEnd" id="datepicker2"
												class="yhgl_input date" />
										</p>
										<p>
											<input name="input" type="submit" class="btn2" value="搜索" />
										</p>
									</div>
									<div class="clear"></div>
								</div>
							</div>
							<div class="newsbox">
								<table width="100%" border="0" cellspacing="0" cellpadding="3" class="yhgl_table tc">
									<tr class="hsbg">
										<td>序号</td>
										<td>借款ID</td>
										<td>借款者</td>
										<td>催收方式</td>
										<td>催收人</td>
										<td>催收时间</td>
										<td>结果概要</td>
										<td>操作</td>
									</tr>
									<%
										if (collectionRecordInfoArray != null) {for (int i =0;i<collectionRecordInfoArray.length;i++){CollectionRecordInfo collectionRecordInfo=collectionRecordInfoArray[i];if (collectionRecordInfo == null) {continue;}
									%>
									<tr class="dhsbg">
										<td><%=i+1%></td>
										<td><%=collectionRecordInfo.F02%></td>
										<td>
											<%
												StringHelper.filterHTML(out, collectionRecordInfo.userName);
											%>
										</td>
										<td><%=collectionRecordInfo.F04.getChineseName()%></td>
										<td>
											<%
												StringHelper.filterHTML(out, collectionRecordInfo.F05);
											%>
										</td>
										<td><%=TimestampParser.format(collectionRecordInfo.F08,"yyyy-MM-dd")%></td>
										<td title="<%StringHelper.filterHTML(out, collectionRecordInfo.F06);%>">
											<%
												StringHelper.filterHTML(out, StringHelper.truncation(collectionRecordInfo.F06, 35));
											%>
										</td>
										<td>
											<%if(T6110_F06.ZRR == collectionRecordInfo.userType){ %>
								              	<%if (dimengSession.isAccessableResource(com.dimeng.p2p.console.servlets.account.grxx.JbxxView.class)) {%>
								              	<span class="blue"><a href="<%=controller.getURI(request,com.dimeng.p2p.console.servlets.account.grxx.JbxxView.class)%>?userId=<%=collectionRecordInfo.F03%>&status=1">个人资源</a></span>
								              	<%}else{ %>
							                   	<span class="disabled">个人资源</span>
							                  	<%} %>
								              <%}else if(T6110_F06.FZRR == collectionRecordInfo.userType && T6110_F10.F == collectionRecordInfo.dbf){ %>
								              	<%if (dimengSession.isAccessableResource(com.dimeng.p2p.console.servlets.account.qyxx.jscl.UpdateJscl.class)) {%>
								              	<span class="blue"><a href="<%=controller.getURI(request,com.dimeng.p2p.console.servlets.account.qyxx.jscl.UpdateJscl.class)%>?id=<%=collectionRecordInfo.F03%>&status=1">企业资源</a></span>
								              	<%}else{ %>
							                   	<span class="disabled">企业资源</span>
							                  	<%} %>
								              <%}else if(T6110_F10.S == collectionRecordInfo.dbf){ %>
								             	<%if (dimengSession.isAccessableResource(com.dimeng.p2p.console.servlets.account.jgxx.jscl.UpdateJscl.class)) {%>
								              	<span class="blue"><a href="<%=controller.getURI(request,com.dimeng.p2p.console.servlets.account.jgxx.jscl.UpdateJscl.class)%>?id=<%=collectionRecordInfo.F03%>&status=1">机构资源</a></span>
								              	<%}else{ %>
							                   	<span class="disabled">机构资源</span>
							                  	<%} %>
								            <%} %>
											<%
											 	if (dimengSession.isAccessableResource(Csxq.class)) {
											 %>
												<span class="blue"><a href="javascript:void(0)" onclick="showCsxq('<%=i%>')">催款详情</a></span> <%
											 	}else{
											 %> <span class="disabled">催款详情</span> <%
											 	}
											 %>
										</td>
									</tr>
									<%
										}}
									%>
								</table>
								<%
									AbstractConsoleServlet.rendPagingResult(out, collectionRecordInfos);
								%>
								<div class="clear"></div>
							</div>
						</form>
					</div>
				</div>
			</div>
			<%@include file="/WEB-INF/include/left.jsp"%>
			
			<div class="box2 clearfix"></div>
          <%
          	if (collectionRecordInfoArray != null) {for (int i =0;i<collectionRecordInfoArray.length;i++){CollectionRecordInfo collectionRecordInfo=collectionRecordInfoArray[i];if (collectionRecordInfo == null) {continue;}
                              CollectionRecordInfo entity = collectionManage.findCollectionRecord(collectionRecordInfo.F01);
          %>
	      <div id="csxq_<%=i%>" style="display: none">
	      	<div class="popup_bg"></div>
	        <div class="w440 thickbox thickpos" style="margin:-200px 0 0 -220px;">
			    <div class="tit">
			    	<span class="fl pl15">催收详情</span>
			        <span class="fr pr15 close" onclick="javascript:document.getElementById('csxq_<%=i%>').style.display='none';return false;"><a href="#">关闭</a></span>
			    </div>
			    <div class="info clearfix">
			        <div class="clearfix">
			          <div class="cell clearfix">
			               <div class="list01">用户名：</div>
			               <div class="list02"><%
			               	StringHelper.filterHTML(out, entity.userName);
			               %></div>
			          </div>
			          <div class="cell clearfix">
			               <div class="list01">借款ID：</div>
			               <div class="list02"><%=entity.F02%></div>
			          </div>
			          <div class="cell clearfix">
			               <div class="list01">催收方式：</div>
			               <div class="list02"><%=entity.F04.getChineseName()%></div>
			          </div>
			          <div class="cell clearfix">
			               <div class="list01">催收人：</div>
			               <div class="list02"><%
			               	StringHelper.filterHTML(out, entity.F05);
			               %></div>
			          </div>
			          <div class="cell clearfix">
			               <div class="list01">催收时间：</div>
			               <div class="list02"><%=TimestampParser.format(entity.F08,"yyyy-MM-dd")%></div>
			          </div>
			          <div class="cell clearfix">
			               <div class="list01">结果概要：</div>
			               <div class="list02"><%
			               	StringHelper.filterHTML(out, entity.F06);
			               %></div>
			          </div>
			        </div>  
			        <div class="dialog_btn">
			        <input type="submit" onclick="document.getElementById('csxq_<%=i%>').style.display='none'" name="button2" id="button2" value="关闭"  class="btn4 ml50"/>
			        </div> 
			       
			      </div>
				</div>
			</div>
			 <%}} %>
		</div>
	</div>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
	<%@include file="/WEB-INF/include/datepicker.jsp"%>
	<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/validation.js"></script>
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
		    $("#datepicker1").datepicker("setDate", "<%StringHelper.filterHTML(out, request.getParameter("createTimeStart"));%>");
		    $("#datepicker2").datepicker("setDate", "<%StringHelper.filterHTML(out, request.getParameter("createTimeEnd"));%>");
		    $("#datepicker2").datepicker('option', 'minDate',$("#datepicker1").datepicker().val());
		});

		function showCsxq(id) {
			$("#csxq_" + id).show();
		}

		function showLh(i) {
			if (confirm("此账号无逾期情况，请慎重操作！")) {
				$("#lh_" + i).show();
			}
		}

		function showYzyqLh(i) {
			if (confirm("此账号有严重逾期情况，是否拉黑！")) {
				$("#lh_" + i).show();
			}
		}
	</script>
</body>
</html>