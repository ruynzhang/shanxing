<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.S62.enums.T6231_F21"%>
<%@page import="com.dimeng.p2p.console.servlets.account.grxx.HfjlView"%>
<%@page import="com.dimeng.p2p.console.servlets.AbstractConsoleServlet"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F20"%>
<%@page import="com.dimeng.p2p.console.servlets.account.grxx.TbjlView"%>
<%@page import="com.dimeng.p2p.console.servlets.account.grxx.JkjlView"%>
<%@page import="com.dimeng.p2p.console.servlets.account.grxx.KxrzView"%>
<%@page import="com.dimeng.p2p.console.servlets.account.grxx.ByrzView"%>
<%@page import="com.dimeng.p2p.console.servlets.account.grxx.JbxxView"%>
<%@page import="com.dimeng.p2p.modules.account.console.service.entity.TenderRecord"%>
<%@page import="com.dimeng.p2p.modules.account.console.service.entity.BasicInfo"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<%@page import="org.omg.CORBA.Object"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%
		CURRENT_CATEGORY="YHGL";
		CURRENT_SUB_CATEGORY="GRXX";
		BasicInfo basicInfo = ObjectHelper.convert(request.getAttribute("basicInfo"), BasicInfo.class);
		PagingResult<TenderRecord> tenderRecords = ObjectHelper.convert(request.getAttribute("tenderRecords"), PagingResult.class);
	%>
	<%@include file="/WEB-INF/include/header.jsp"%>
<div class="w_main">
<div class="main clearfix">
  
    <div class="wrap">
        <div class="r_main">
            <div class="home_main">
            	<div class="box box1 mb15">
			 			<div class="atil"><h3>用户详细情况</h3></div>
			     		<div class="con con1">
			     			<ul class="yhxq_li">
						     	<li>用户名：<%StringHelper.filterHTML(out, basicInfo.userName);%></li>      
						     	<li>净资产： <%=Formater.formatAmount(basicInfo.netAssets)%>元</li>              
						    </ul>
						     <ul class="yhxq_li">
						      	<li>账户余额：  <%=Formater.formatAmount(basicInfo.accountBalance)%>元</li>
						      	<li>理财资产： <%=Formater.formatAmount(basicInfo.lczc)%>元</li>
						     </ul>
						     <ul class="yhxq_li">
						     	<li>借款负债： <%=Formater.formatAmount(basicInfo.borrowingLiability)%>元</li>
						  </ul>
						  <ul class="yhxq_li">
						   		<li>必要认证： 
							     <%
							     	int byrztg = basicInfo.byrztg;
							        if(byrztg <= 0){
							     %>
							     	未认证
							     <%
							     	}else{
							     %>
							   	 通过<%=byrztg%>项
							   	 <%
							     	}
							     %>
							   	</li>
						   		<li>可选认证： 
								<%
							     	int kxrztg = basicInfo.kxrztg;
							        if(kxrztg <= 0){
							     %>
							     	未认证
							     <%
							     	}else{
							     %>
							   	 通过<%=kxrztg%>项
							   	 <%
							     	}
							     %>              
							     </li>
						  </ul>
						  <ul class="yhxq_li">
						  	<li>注册时间：  <%=TimestampParser.format(basicInfo.registrationTime)%></li>
						  </ul>
			     		<div class="clear"></div>
			     	</div>
				</div>
                <div class="newsbox">
                  <div class="til clearfix">
                   <div class="Menubox">
                     <ul>
                        <li id="one1" onclick="window.location.href='<%=controller.getURI(request, JbxxView.class)%>?userId=<%=basicInfo.userId%>'">基本信息</li>
                        <li id="one2" onclick="window.location.href='<%=controller.getURI(request, ByrzView.class)%>?userId=<%=basicInfo.userId%>'">必要认证（<%=byrztg%>/<%=basicInfo.needAttestation%>）</li>
                        <li id="one3" onclick="window.location.href='<%=controller.getURI(request, KxrzView.class)%>?userId=<%=basicInfo.userId%>'">可选认证（<%=kxrztg%>/<%=basicInfo.notNeedAttestation%>）</li>
                        <li id="one5" onclick="window.location.href='<%=controller.getURI(request, JkjlView.class)%>?userId=<%=basicInfo.userId%>'">借款记录</li>
                        <li id="one6" class="hover">投资记录</li>
                        <li id="one7" onclick="window.location.href='<%=controller.getURI(request, HfjlView.class)%>?userId=<%=basicInfo.userId%>'" style="border-right:1px #d7dfe3 solid;">回访记录</li>
                     </ul>
                    </div>     
                  </div>
                  <div class="border p15 Men_bt no_table" id="con_one_6">
                  	<form action="<%=controller.getURI(request, TbjlView.class)%>?userId=<%=basicInfo.userId%>" method="post">
                    	<div class="admin_input admin_pb">
                        	<p>债权ID：<input type="text" name="tenderRecordId" class="yhgl_input" value="<%StringHelper.filterHTML(out, request.getParameter("tenderRecordId"));%>" /></p>
                            <p>借款标题：<input type="text" name="tenderRecordTitle" class="yhgl_input" value="<%StringHelper.filterHTML(out, request.getParameter("tenderRecordTitle"));%>" /></p>
                            <p>时间：<input type="text" readonly="readonly" name="createTimeStart" id="datepicker1" class="yhgl_input date" /><span class="pr10">至</span><input type="text" readonly="readonly" name="createTimeEnd" id="datepicker2" class="yhgl_input date" /></p>
                            <p>状态：
                            	<select name="loanRecordState" class="yhgl_sel">
                              	<option value="">全部</option>
                              	<option value="TBZ" <%if (T6230_F20.TBZ.name().equals(request.getParameter("loanRecordState"))) {%> selected="selected" <%}%>>投标中</option>
                                <option value="DFK" <%if (T6230_F20.DFK.name().equals(request.getParameter("loanRecordState"))) {%> selected="selected" <%}%>>待放款</option>
                                <option value="HKZ" <%if (T6230_F20.HKZ.name().equals(request.getParameter("loanRecordState"))) {%> selected="selected" <%}%>>还款中</option>
                                <option value="YJQ" <%if (T6230_F20.YJQ.name().equals(request.getParameter("loanRecordState"))) {%> selected="selected" <%}%>>已结清</option>
                                <option value="YLB" <%if (T6230_F20.YLB.name().equals(request.getParameter("loanRecordState"))) {%> selected="selected" <%}%>>已流标</option>
                                <option value="YDF" <%if (T6230_F20.YDF.name().equals(request.getParameter("loanRecordState"))) {%> selected="selected" <%}%>>已垫付</option>
                               	</select>
                              </p>
                              <p><input name="" type="submit" class="btn2" value="搜索" /></p>
                    	</div>
                    	<div class="clear"></div>
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="yhgl_table">
                      <tr class="hsbg"> 
                      	<td align="center">债权ID</td>
                        <td align="center">债权标题</td>
                        <td align="center">投标金额</td>
                        <td align="center">年利率</td>
                        <td align="center">期限</td>
                        <td align="center">投标时间</td>
                        <td align="center">状态</td>
                      </tr>
                      <%
                      TenderRecord[] tenderRecordArray = tenderRecords.getItems();
							if (tenderRecordArray != null) {
								int i = 1;
								for (TenderRecord tenderRecord : tenderRecordArray) {
									if (tenderRecord == null) {
										continue;
									}
						%>
                      
                      <tr class="bom">                                                                                
                        <td align="center"><%=tenderRecord.tenderRecordId%></td>
                        <td><%StringHelper.filterHTML(out, tenderRecord.tenderRecordTitle);%></td>
                        <td align="center"><%=Formater.formatAmount(tenderRecord.tenderMoney)%>元</td>
                        <td align="center"><%=Formater.formatRate(tenderRecord.yearRate)%></td>
                        <td align="center"><%=tenderRecord.deadline%><%=T6231_F21.S==tenderRecord.dayBorrowFlg?"天":"个月" %></td>
                        <td align="center"><%=TimestampParser.format(tenderRecord.tenderTime)%></td>
                        <td align="center"><%=tenderRecord.tenderRecordState.getChineseName()%></td>
                      </tr>
                      <%	}
						}%>
                    </table>
                    <%
						AbstractConsoleServlet.rendPagingResult(out, tenderRecords);
					%>
					</form>
              	  <div class="clear"></div>
                  </div>
                </div> 
                <div class="box2 clearfix"></div>
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
			$("#datepicker1").datepicker({inline: true});
		    $('#datepicker1').datepicker('option', {dateFormat:'yy-mm-dd'});
		    $("#datepicker2").datepicker({inline: true});
		    $('#datepicker2').datepicker('option', {dateFormat:'yy-mm-dd'});
		    $("#datepicker1").datepicker("setDate", "<%StringHelper.filterHTML(out, request.getParameter("createTimeStart"));%>");
		    $("#datepicker2").datepicker("setDate", "<%StringHelper.filterHTML(out, request.getParameter("createTimeEnd"));%>");
		});
	</script>
</body>
</html>