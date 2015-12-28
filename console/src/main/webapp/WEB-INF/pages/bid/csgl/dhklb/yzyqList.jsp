<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.console.servlets.account.zhgl.Black"%>
<%@page import="com.dimeng.p2p.S61.enums.T6110_F10"%>
<%@page import="com.dimeng.p2p.S61.enums.T6110_F06"%>
<%@page import="com.dimeng.p2p.S71.entities.T7152"%>
<%@page import="com.dimeng.p2p.S61.enums.T6110_F07"%>
<%@page import="com.dimeng.p2p.modules.account.console.service.UserManage"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.csgl.dhklb.Cscl"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.csgl.dhklb.YqList"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.csgl.dhklb.YzyqList"%>
<%@page import="com.dimeng.util.Formater"%>
<%@page import="com.dimeng.p2p.modules.bid.console.service.entity.StayRefundInfo"%>
<%@page import="com.dimeng.p2p.modules.bid.console.service.CollectionManage"%>
<%@page import="com.dimeng.p2p.console.servlets.AbstractConsoleServlet"%>
<%@page import="com.dimeng.p2p.modules.bid.console.service.entity.Less30"%>
<%@page import="com.dimeng.p2p.modules.bid.console.service.entity.StayRefundGather"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
<%
	CURRENT_CATEGORY="YWGL";
	CURRENT_SUB_CATEGORY="DHKLB";
	StayRefundGather stayRefundGather = (StayRefundGather)request.getAttribute("stayRefundGather");
	PagingResult<Less30> greater30s = (PagingResult<Less30>)request.getAttribute("greater30s");
	Less30[] greater30Array = greater30s.getItems();
	UserManage userManage = serviceSession.getService(UserManage.class);
	CollectionManage collectionManage = serviceSession.getService(CollectionManage.class);
%>
<%@include file="/WEB-INF/include/header.jsp"%>
<div class="w_main">
  <div class="main clearfix">
    <div class="wrap">
      <div class="r_main">
        <div class="home_main">
          <div class="box box1 mb15">
            <div class="atil">
              <h3>待还款列表</h3>
            </div>
            <div class="con">
              <div class="clear"></div>
              <ul class="yhxq_li">
                <li>待还本金总额：<span class="blue"><%=Formater.formatAmount(stayRefundGather.dhAmount) %></span>元 </li>
              </ul>
              <ul class="yhxq_li">
                <li>逾期待还总额：<span class="blue"><%=Formater.formatAmount(stayRefundGather.yqdhAmount) %></span>元 </li>
              </ul>
              <ul class="yhxq_li">
                <li>严重逾期待还总额：<span class="blue"><%=Formater.formatAmount(stayRefundGather.yzyqdhAmount) %></span>元 </li>
              </ul>
              <div class="clear"></div>
            </div>
          </div>
          <form id="form1" action="<%=controller.getURI(request, YzyqList.class)%>" method="post">
          <div class="box box1 mb15">
            <div class="con">
                <div class="admin_input admin_pb">
                    <p>用户名：<input type="text" name="userName" class="yhgl_input" value="<%StringHelper.filterHTML(out, request.getParameter("userName"));%>" /></p>
                    <p>借款标题：<input type="text" name="loanRecordTitle" class="yhgl_input" value="<%StringHelper.filterHTML(out, request.getParameter("loanRecordTitle"));%>" /></p>
                    <p><input name="input" type="submit" class="btn2" value="搜索" /></p>
                </div>
              <div class="clear"></div>
            </div>
          </div>
          <div class="newsbox">
            <div class="til clearfix">
              <div class="Menubox">
                <ul>
                  <li id="one1" onclick="window.location.href='<%=controller.getURI(request, JsstList.class)%>'" >近30天待还款</li>
                  <li id="one2" onclick="window.location.href='<%=controller.getURI(request, YqList.class)%>'"  >逾期待还款</li>
                  <li id="one3" class="hover" >严重逾期待还款</li>
                </ul>
              </div>
            </div>
            <div class="border p15 Men_bt no_table" id="con_one_2">
	          <table width="100%" border="0" cellspacing="0" cellpadding="3" class="yhgl_table">
	            <tr class="hsbg">
	              <td align="center">序号</td>
	              <td align="center">借款标题</td>
	              <td align="center">用户名</td>
	              <td align="center">借款金额（元）</td>
	              <td align="center">期数</td>
	              <td align="center">本期应还金额（元）</td>
	              <td align="center">剩余应还总额（元）</td>              
	              <td align="center">逾期费用（元）</td>
	              <td align="center">逾期天数</td>
	              <td align="center">最近催收时间</td>
	              <td align="center">操作</td>
	            </tr>
	            <%
	            	if (greater30Array != null) {for (int i =0;i<greater30Array.length;i++){Less30 greater30=greater30Array[i];if (greater30 == null) {continue;}
	            %>
	            <tr class="dhsbg">
	              <td align="center"><%=i+1%></td>
	              <td><%StringHelper.filterHTML(out, greater30.loanRecordTitle);%></td>
	              <td align="center"><%
	              	StringHelper.filterHTML(out, greater30.userName);
	              %></td>
	              <td align="center"><%=Formater.formatAmount(greater30.loanAmount)%></td>
	              <td align="center"><%
	              	StringHelper.filterHTML(out, greater30.loandeadline);
	              %></td>
	              <td align="center"><%=Formater.formatAmount(greater30.principalAmount)%></td>
	              <td align="center"><%=Formater.formatAmount(greater30.residueAmount)%></td>
	              <td align="center"><%=Formater.formatAmount(greater30.collectionAmount)%></td>
	              <td align="center"><%=greater30.collectionNumber%>天</td>
	              <td align="center"><%=Formater.formatDate(greater30.refundDay)%></td>
	              <td align="center">
	              	<%if(T6110_F06.ZRR == greater30.userType){ %>
		              	<%if (dimengSession.isAccessableResource(com.dimeng.p2p.console.servlets.account.grxx.JbxxView.class)) {%>
		              	<span class="blue"><a href="<%=controller.getURI(request,com.dimeng.p2p.console.servlets.account.grxx.JbxxView.class)%>?userId=<%=greater30.userId%>&status=1">个人资源</a></span>
		              	<%}else{ %>
	                   	<span class="disabled">个人资源</span>
	                  	<%} %>
		              <%}else if(T6110_F06.FZRR == greater30.userType && T6110_F10.F == greater30.dbf){ %>
		              	<%if (dimengSession.isAccessableResource(com.dimeng.p2p.console.servlets.account.qyxx.jscl.UpdateJscl.class)) {%>
		              	<span class="blue"><a href="<%=controller.getURI(request,com.dimeng.p2p.console.servlets.account.qyxx.jscl.UpdateJscl.class)%>?id=<%=greater30.userId%>&status=1">个人资源</a></span>
		              	<%}else{ %>
	                   	<span class="disabled">企业资源</span>
	                  	<%} %>
		              <%}else if(T6110_F10.S == greater30.dbf){ %>
		             	<%if (dimengSession.isAccessableResource(com.dimeng.p2p.console.servlets.account.jgxx.jscl.UpdateJscl.class) ){%>
		              	<span class="blue"><a href="<%=controller.getURI(request,com.dimeng.p2p.console.servlets.account.jgxx.jscl.UpdateJscl.class)%>?id=<%=greater30.userId%>&status=1">个人资源</a></span>
		              	<%}else{ %>
	                   	<span class="disabled">机构资源</span>
	                  	<%} %>
		            <%} %>
                   	<%if (dimengSession.isAccessableResource(Cscl.class)) {%>
	              	<span class="blue"><a href="javascript:void(0)" onclick="showCs('<%=i %>')">催收</a></span>
	              	<%}else{ %>
                   	<span class="disabled">催收</span>
                   	<%} %>
                   	<%if (dimengSession.isAccessableResource(Black.class)) {%>
		              	<%if(T6110_F07.HMD != greater30.userStatus){ %>
	                    	<span class="blue"><a href="javascript:void(0)" onclick="showLh('<%=i %>')">拉黑</a></span>
	                    <%}else{ %>
	                    	<span class="disabled">拉黑</span>
	                    <%} %>
                    <%}else{ %>
                    	<span class="disabled">拉黑</span>
                    <%} %>
	              </td>
	            </tr>
	            <%
	            	}}
	            %>
	          </table>
          <%
          	AbstractConsoleServlet.rendPagingResult(out, greater30s);
          %>
			</div>
			<div class="clear"></div>
          </div>
          </form>
          <div class="box2 clearfix"></div>
        <%
        	if (greater30Array != null) {for (int i =0;i<greater30Array.length;i++){Less30 greater30=greater30Array[i];if (greater30 == null) {continue;}
          		StayRefundInfo stayRefundInfo = collectionManage.findStayRefund(greater30.collectionId);
          		T7152[] collectionRecords = userManage.csjlSearch(stayRefundInfo.userId);
        %>
	        <div id="cs_<%=i%>" style="display: none">
	        	<div class="popup_bg"></div>
	        	<div class="w650 thickbox thickpos" style="margin: -310px 0 0 -325px;">
				<div class="tit">
			    	<span class="fl pl15">催收</span>
			    	<span class="fr pr15 close" onclick="javascript:document.getElementById('cs_<%=i%>').style.display='none';return false;" ><a href="#">关闭</a></span>
			    </div>
		      	<form action="<%=controller.getURI(request, Cscl.class)%>" method="post" class="form<%=i%>">
		      	<input type="hidden" name="type" value="yzyq"/>
		      	<input type="hidden" name="collectionId" value="<%=greater30.collectionId %>"/>
		      	<input type="hidden" name="loanRecordId" value="<%=stayRefundInfo.loanRecordId %>"/>
		      	<input type="hidden" name="userId" value="<%=stayRefundInfo.userId%>"/>
		      	<div class="info clearfix">
		      		<div class="tips_con">
		          		<div class="clearfix">
			          		<div class="cell clearfix">
			               		<div class="list01">用户名：</div>
			               		<div class="list02"><%StringHelper.filterHTML(out, stayRefundInfo.userName); %></div>
			          		</div>
				          	<div class="cell clearfix">
				            	<div class="list01">姓名：</div>
				            	<div class="list02"><%StringHelper.filterHTML(out, stayRefundInfo.realName); %></div>
				          	</div>
			          		<div class="cell clearfix">
			               		<div class="list01">借款ID：</div>
			               		<div class="list02"><%=stayRefundInfo.loanRecordId %></div>
			          		</div>
			          		<div class="cell clearfix">
				               <div class="list01">催收方式：</div>
				               <div class="list02">
				                    <input name="collectionType" type="radio" value="DH" checked="checked" class="mr5"/>电话                  
				                    <input name="collectionType" type="radio" value="XC" class="mr5"/>现场
				                    <input name="collectionType" type="radio" value="FL" class="mr5"/>法律
				               </div>
			          		</div>
			          		<div class="cell clearfix">
			               		<div class="list01"><i class="red mr5">*</i>催收人：</div>
			               		<div class="list02">
			               		<input name="collectionPerson"  type="text" class="text w100 fl required max-length-20"/>
			               		<p tip></p>
								<p errortip class="" style="display: none"></p>
			               	</div>
			          	</div>
			          	<div class="cell clearfix">
			            	<div class="list01"><i class="red mr5">*</i>催收时间：</div>
			            	<div class="list02">
			               		<input readonly="readonly" name="collectionTime" id="tempDatepicker<%=i %>" type="text" class="yhgl_input date required"/>
			               		<p tip></p>
								<p errortip class="" style="display: none"></p>
			               </div>
			          	</div>
			          	<div class="cell clearfix">
			            	<div class="list01"><i class="red mr5">*</i>结果概要：</div>
			            	<div class="list02">
			               		<textarea name="resultDesc" id="keyWord" cols="45" rows="3" class="area required max-length-150"></textarea>
			               		<div class="clear"></div>
			               		<p tip>150字以内</p>
								<p errortip class="" style="display: none"></p>
			               </div>
			          </div>
		       		</div>
			      	<div class="dialog_btn">
				    	<input type="submit" value="确定"  class="btn4 fl mr10 sumbitForme" fromname="form<%=i%>"/>
				    	<input type="button" onclick="document.getElementById('cs_<%=i %>').style.display='none'" class="btn5 fl" value="取消"/>
			       		<div class="clear"></div>
			       	</div>
		       		<div class="mt10">
						<p>最近催收记录（所有借款）：</p>
						<table width="100%" border="0" cellspacing="0" class="ratetable">
							<tr class="titbj">
								<td>序号</td>
								<td>催收时间</td>
								<td>催收方式</td>
								<td>催收人</td>
								<td>结果概要</td>
							</tr>
							<%if (collectionRecords != null) {for (int n = 0,length=Math.min(collectionRecords.length, 3);n < length;n++) {T7152 t7152 = collectionRecords[n];if (t7152 == null) {continue;}%>
				             	<tr>
					                <td><%=n+1%></td>
					                <td><%=TimestampParser.format(t7152.F08) %></td>
					                <td><%=t7152.F04.getChineseName() %></td>
					                <td><%StringHelper.filterHTML(out, t7152.F05); %></td>
					                <td title="<%StringHelper.filterHTML(out, t7152.F06);%>"><%StringHelper.filterHTML(out, StringHelper.truncation(t7152.F06, 15));%></td>
				              	</tr>
				              <%}}%>
						</table>
						<p class="tr mt5">共<%=collectionRecords==null?0:collectionRecords.length %>条记录 | <a href="<%=controller.getURI(request, CsList.class)%>?userName=<%=stayRefundInfo.userName%>">查看全部&gt;&gt;</a></p>
					</div>
		       	</div>
		      </div>
		      </form>
			</div>
			</div>
			<%
				T7152[] csjllist = userManage.csjlSearch(stayRefundInfo.userId);
			%>
				<div id="lh_<%=i %>" style="display: none">
					<div class="popup_bg"></div>
					<div class="w650 thickbox thickpos" style='margin: -310px 0 0 -325px;'>
					<form action="<%=controller.getURI(request, Black.class)%>" method="post" class="form<%=i %>">
					<input type="hidden" name="type" value="1"/>
					<input type="hidden" name="userId" value="<%=stayRefundInfo.userId%>"/>
					<input type="hidden" name="state" value="LH"/>
					<div class="tit">
						<span class="fl pl15">拉黑</span><span class="fr pr15 close" onclick="javascript:document.getElementById('lh_<%=i %>').style.display='none';return false;"><a href="#">关闭</a></span>
					</div>
					<div class="info clearfix">
						<div class="tc">
							<span class="mr50">用户名：<%StringHelper.filterHTML(out, stayRefundInfo.userName); %></span><span>姓名：<%StringHelper.filterHTML(out, stayRefundInfo.realName); %></span>
						</div>
						<div class="tips_con">
							<div class="bigtit mt10 clearfix">
								<span class="fl">拉黑说明</span>
							</div>
							<div class="tc pt10">
								<textarea name="blacklistDesc" cols="" rows="" class="area required max-length-255"></textarea>
								<p tip></p>
								<p errortip class="" style="display: none"></p>
							</div>
							<div class="dialog_btn">
								<input type="submit" value="确定" class="btn4 fl mr10 sumbitForme" fromname="form<%=i %>"/> 
								<input type="button" class="btn5 fl" value="取消" onclick="document.getElementById('lh_<%=i %>').style.display='none'"/>
								<div class="clear"></div>
							</div>
							<div class="mt10">
								<p>最近催收记录（所有借款）：</p>
								<table width="100%" border="0" cellspacing="0" class="ratetable">
									<tr class="titbj">
										<td>序号</td>
										<td>催收时间</td>
										<td>催收方式</td>
										<td>催收人</td>
										<td>结果概要</td>
									</tr>
									<%if (csjllist != null) {for (int n = 0,length=Math.min(csjllist.length, 3);n < length;n++) {T7152 t7152 = csjllist[n];if (t7152 == null) {continue;}%>
					             	<tr>
						                <td><%=n+1%></td>
						                <td><%=TimestampParser.format(t7152.F08) %></td>
						                <td><%=t7152.F04.getChineseName() %></td>
						                <td><%StringHelper.filterHTML(out, t7152.F05); %></td>
						                <td title="<%StringHelper.filterHTML(out, t7152.F06);%>"><%StringHelper.filterHTML(out, StringHelper.truncation(t7152.F06, 15));%></td>
					              	</tr>
					              <%}}%>
								</table>
								<p class="tr mt5">共<%=csjllist==null?0:csjllist.length %>条记录 | <a href="<%=controller.getURI(request, CsList.class)%>?userName=<%=stayRefundInfo.realName%>">查看全部&gt;&gt;</a></p>
							</div>
						</div>
					</div>
					</form>
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
	<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/validation.js"></script>
	<script type="text/javascript">
		$(function() {
			$("#datepicker1").datepicker({inline: true});
		    $('#datepicker1').datepicker('option', {dateFormat:'yy-mm-dd'});
		    $("#datepicker2").datepicker({inline: true});
		    $('#datepicker2').datepicker('option', {dateFormat:'yy-mm-dd'});
		    <%if (greater30Array != null) {for (int i =0;i<greater30Array.length;i++){Less30 less30=greater30Array[i];if (less30 == null) {continue;}%>
		    $('#tempDatepicker<%=i%>').datepicker({inline: true});
		    $('#tempDatepicker<%=i%>').datepicker('option', {dateFormat:'yy-mm-dd'});
		    <%}}%>
		    $("#datepicker1").datepicker("setDate", "<%StringHelper.filterHTML(out, request.getParameter("createTimeStart"));%>");
		    $("#datepicker2").datepicker("setDate", "<%StringHelper.filterHTML(out, request.getParameter("createTimeEnd"));%>");
		});
		
		function showCs(i)
		{
			$("#cs_"+i).show();
		}
		
		function showLh(i)
		{
			if(confirm("是否拉黑！"))
		    {
				$("#lh_"+i).show();
		    }
		}
	</script>
</body>
</html>