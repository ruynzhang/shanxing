<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.console.servlets.account.jgxx.ViewJgxx"%>
<%@page import="com.dimeng.p2p.console.servlets.account.qyxx.ViewQyxx"%>
<%@page import="com.dimeng.p2p.console.servlets.account.zhgl.UnBlack"%>
<%@page import="com.dimeng.p2p.S61.enums.T6110_F10"%>
<%@page import="com.dimeng.p2p.S61.enums.T6110_F06"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.csgl.hmd.HmdList"%>
<%@page import="com.dimeng.p2p.modules.bid.console.service.entity.BlacklistDetails"%>
<%@page import="com.dimeng.p2p.console.servlets.AbstractConsoleServlet"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.csgl.hmd.Hmdxq"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.csgl.dhklb.DcHmd"%>
<%@page import="com.dimeng.p2p.modules.account.console.service.UserManage"%>
<%@page import="com.dimeng.p2p.modules.bid.console.service.CollectionManage"%>
<%@page import="com.dimeng.p2p.modules.bid.console.service.entity.BlacklistInfo"%>
<%@page import="com.dimeng.util.Formater"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
<%
	CURRENT_CATEGORY="YWGL";
	CURRENT_SUB_CATEGORY="HMD";
	PagingResult<BlacklistInfo> blacklistInfos = (PagingResult<BlacklistInfo>)request.getAttribute("blacklistInfos");
	BlacklistInfo[] blacklistInfoArray = blacklistInfos.getItems();
	CollectionManage collectionManage = serviceSession.getService(CollectionManage.class);
	UserManage userManage = serviceSession.getService(UserManage.class);
%>
<%@include file="/WEB-INF/include/header.jsp"%>
<div class="w_main">
  <div class="main clearfix">
    <div class="wrap">
      <div class="r_main">
        <div class="home_main">
          <form id="form1" action="<%=controller.getURI(request, HmdList.class)%>" method="post">
          <div class="box box1 mb15">
          	<div class="atil">
              <h3>黑名单</h3>
            </div>
            <div class="con">
                <div class="admin_input admin_pb">
                    <p>用户名：<input type="text" name="userName" class="yhgl_input" value="<%StringHelper.filterHTML(out, request.getParameter("userName"));%>" /></p>
                    <p>手机：<input type="text" name="msisdn" class="yhgl_input" value="<%StringHelper.filterHTML(out, request.getParameter("msisdn"));%>" /></p>
                    <p>拉黑时间：<input type="text" readonly="readonly" name="createTimeStart" id="datepicker1" class="yhgl_input date" />至<input readonly="readonly" type="text" name="createTimeEnd" id="datepicker2" class="yhgl_input date" /></p>
                    <div class="clear"></div>
                    <div class="mt10">
                    	<input name="input" type="submit" class="btn2 mr10" value="搜索" />
                    	<%if (dimengSession.isAccessableResource(DcHmd.class)) {%>
                    	<input onclick="showExport()" name="input" type="button" class="btn2 mr10" value="导出" />
                    	<%}else{ %>
	                   	<span class="btn3 mr10 btn5"><span class="ico"></span>导出</span>
	                   	<%} %>
                    </div>
                 </div>
              <div class="clear"></div>
            </div>
          </div>
          <div class="newsbox">           
	          <table width="100%" border="0" cellspacing="0" cellpadding="3" class="yhgl_table tc">
	            <tr class="hsbg">
	              <td>序号</td>
	              <td>用户名</td>
	              <td>手机</td>
	              <td>邮箱</td>
	              <td>拉黑时间</td>
	              <td>操作人</td>
	              <td>操作</td>
	            </tr>
	            <%if (blacklistInfoArray != null) {for (int i =0;i<blacklistInfoArray.length;i++){BlacklistInfo blacklistInfo=blacklistInfoArray[i];if (blacklistInfo == null) {continue;}%>
	            <tr class="dhsbg">
	              <td><%=i+1%></td>
	              <td><%StringHelper.filterHTML(out, blacklistInfo.accountName);%></td>
	              <td><%StringHelper.filterHTML(out, blacklistInfo.phone);%></td>
	              <td><%StringHelper.filterHTML(out, blacklistInfo.email); %></td>
	              <td><%=TimestampParser.format(blacklistInfo.F05) %></td>
	             <td><%StringHelper.filterHTML(out, blacklistInfo.lhName);%></td>
	              <td>
	              <%if(T6110_F06.ZRR == blacklistInfo.userType){ %>
	              	<%if (dimengSession.isAccessableResource(com.dimeng.p2p.console.servlets.account.grxx.JbxxView.class)) {%>
	              	<span class="blue"><a href="<%=controller.getURI(request,com.dimeng.p2p.console.servlets.account.grxx.JbxxView.class)%>?userId=<%=blacklistInfo.F02%>&status=1">个人资源</a></span>
	              	<%}else{ %>
                   	<span class="disabled">个人资源</span>
                  	<%} %>
	              <%}else if(T6110_F06.FZRR == blacklistInfo.userType && T6110_F10.F == blacklistInfo.dbf){ %>
	              	<%if (dimengSession.isAccessableResource(com.dimeng.p2p.console.servlets.account.qyxx.jscl.UpdateJscl.class)) {%>
	              	<span class="blue"><a href="<%=controller.getURI(request,ViewQyxx.class)%>?id=<%=blacklistInfo.F02%>&status=1">企业资源</a></span>
	              	<%}else{ %>
                   	<span class="disabled">企业资源</span>
                  	<%} %>
	              <%}else if(T6110_F10.S == blacklistInfo.dbf){ %>
	             	<%if (dimengSession.isAccessableResource(com.dimeng.p2p.console.servlets.account.jgxx.jscl.UpdateJscl.class)) {%>
	              	<span class="blue"><a href="<%=controller.getURI(request,ViewJgxx.class)%>?id=<%=blacklistInfo.F02%>&status=1">机构资源</a></span>
	              	<%}else{ %>
                   	<span class="disabled">机构资源</span>
                  	<%} %>
	              <%} %>
	              <%if (dimengSession.isAccessableResource(Hmdxq.class)) {%>
	              	<span class="blue"><a href="javascript:void(0)" onclick="showLhxq('<%=i %>')">拉黑详情</a></span>
	              <%}else{ %>
                   	<span class="disabled">拉黑详情</span>
                  <%} %>
	              <%if (dimengSession.isAccessableResource(UnBlack.class)) { %>
                       <span class="blue"><a href="<%=controller.getURI(request,UnBlack.class)%>?userId=<%=blacklistInfo.F02%>" class="mr10">取消拉黑</a></span>
                  <%}else{ %>
                       <span class="disabled">取消拉黑</span>
                  <%} %>
	              </td>
	            </tr>
	            <%}} %>
	          </table>
          <%AbstractConsoleServlet.rendPagingResult(out, blacklistInfos);%>		
			<div class="clear"></div>
          </div>
          </form>
          <div class="box2 clearfix"></div>
          
          <%
        	if (blacklistInfoArray != null) {for (int i =0;i<blacklistInfoArray.length;i++){BlacklistInfo blacklistInfo=blacklistInfoArray[i];if (blacklistInfo == null) {continue;}
        	BlacklistDetails entity = collectionManage.findBlacklistDetails(blacklistInfo.F01);
  		%>
  			<div class="wrap" id="qxlh_<%=i%>" style="display: none">
  				<div class="popup_bg"></div>
	            	<form action="<%=controller.getURI(request, UnBlack.class)%>" method="post">
	            		<input type="hidden" name="id" value="<%=blacklistInfo.F01%>"/>
	            		<input type="hidden" name="userId" value="<%=blacklistInfo.F02%>"/>
						<input type="hidden" name="state" value="QXLH"/>
						<input type="hidden" name="blacklistDesc" value=""/>
	                    <div id="sd" class="w440 thickbox thickpos" style="margin:-80px 0 0 -220px;">
					      <div class="tit">
					         <span class="fl pl15">取消拉黑</span>
					         <span class="fr pr15 close" onclick="javascript:document.getElementById('qxlh_<%=i %>').style.display='none';return false;"><a href="javascript:void(0)">关闭</a></span>
					      </div>
					      <div id="js" class="info clearfix">
					        <div class="clearfix">
					            <span class="icon_cw" style="display:none;"></span>
					            <span class="icon_yw" style="display:none;"></span>
					            <span class="icon_cg" style="display:none;"></span>
					            <span class="fl tips"><span class="icon_gt" ></span>要取消拉黑“<span id="a"><%StringHelper.filterHTML(out, entity.userName);%></span>”吗？</span>
					        </div>
					        <input type="submit" value="确定 "  class="btn4 ml50 mt10"/>
					        <input  onclick="document.getElementById('qxlh_<%=i %>').style.display='none'" type="button" value="取消"  class="btn5 ml50 mt10"/>
					      </div>
						</div>
					</form>
	            </div>
			    <div id="lhxq_<%=i %>" style="display: none">
					<div class="popup_bg"></div>
					<div class="w650 thickbox thickpos" style='margin: -220px 0 0 -325px;'>
					<div class="tit">
						<span class="fl pl15">拉黑详情</span><span class="fr pr15 close" onclick="javascript:document.getElementById('lhxq_<%=i %>').style.display='none';return false;"><a href="#">关闭</a></span>
					</div>
					<div class="info clearfix">
						<div class="tc">
							<span class="mr50">用户名：<%StringHelper.filterHTML(out, entity.userName); %></span><span>姓名：<%StringHelper.filterHTML(out, entity.realName); %></span>
						</div>
						<div class="tips_con">
							<div class="bigtit mt10 clearfix">
								<span class="fl">拉黑说明</span>
							</div>
							<div class="tc pt10">
								<span><%StringHelper.filterHTML(out, entity.registrationDesc); %></span>
							</div>
							<div class="dialog_btn">
								<input type="button" class="btn4 fl mr10" value="关闭" onclick="document.getElementById('lhxq_<%=i %>').style.display='none'"/>
							</div>
						</div>
					</div>
				</div>
				</div>
			<%}} %>
        </div>
      </div>
    </div>
 	
	<%@include file="/WEB-INF/include/left.jsp"%>
</div>
</div>

	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
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
		    $("#datepicker1").datepicker("setDate", "<%StringHelper.filterHTML(out, request.getParameter("createTimeStart"));%>");
		    $("#datepicker2").datepicker("setDate", "<%StringHelper.filterHTML(out, request.getParameter("createTimeEnd"));%>");
		    $("#datepicker2").datepicker('option', 'minDate',$("#datepicker1").datepicker().val());
		});

		function showExport()
		{
			document.getElementById("form1").action ="<%=controller.getURI(request, DcHmd.class)%>";
			$("#form1").submit();
			document.getElementById("form1").action ="<%=controller.getURI(request, HmdList.class)%>";
		}
		
		function showLhxq(i)
		{
			$("#lhxq_"+i).show();
		}
		
		function showQxlh(i)
		{
			$("#qxlh_"+i).show();
		}
	</script>
</body>
</html>