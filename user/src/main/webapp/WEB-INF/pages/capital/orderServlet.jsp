<%@page import="com.dimeng.p2p.user.servlets.financing.AbstractFinancingServlet"%>
<%@page import="com.dimeng.p2p.user.servlets.Index"%>
<%@page import="com.dimeng.p2p.S65.entities.T6501"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<%@page import="com.dimeng.p2p.OrderType"%>
<%@include file="/WEB-INF/include/authenticatedSession.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>收款明细-<%
	configureProvider.format(out,SystemVariable.SITE_NAME);
%></title>
<%@include file="/WEB-INF/include/meta.jsp" %>
<%@include file="/WEB-INF/include/style.jsp" %>
</head>
<%
	CURRENT_CATEGORY = "ZJGL";
	CURRENT_SUB_CATEGORY = "DDCX";
	PagingResult<T6501> result= ObjectHelper.convert(request.getAttribute("reslut"), PagingResult.class);
%>
<body>
<%@include file="/WEB-INF/include/header.jsp" %>

<div class="contain clearfix">

<div class="user_top"></div>
   <div class="about">
      <%@include file="/WEB-INF/include/menu.jsp"%>
      <div class="w780 fr" style="border:none;">
				
      <form id="userprofits" method="post" action="https://www.sh.com/user/userprofits">
		<div class="mainDiv bor1">
      <!--理财管理 S-->
			<div class="tb-state">
                <span>
                <select id="repayType" class="select-reg" name="repayType">
					<option selected="selected" value="daishoukuan">待收款明细</option>
					<option value="yishoukuan">已收款明细</option>
				</select>
                </span>
                <span><input type="text" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" value="2015-07-01" name="repaydateS" class="Wdate inputStyle btnW4" id="repaydateS"></span>
                <span><input type="text" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" value="2015-10-22" name="repaydateE" class="Wdate inputStyle btnW4" id="repaydateE"></span>
                <input type="button" id="querybutton" name="" value="查询" class="butStyle editquestion">&nbsp;&nbsp;
          <!--       <input type="button" value="报表导出" id="exprot" class="butStyle editquestion"/> -->
			</div>
		</div>
		<div id="funds" class="mainDiv bor1 min400">
			<p class="title1"><b>收款明细</b></p>
				<div class="tb-list">
					<table class="tableOdd">
					
					  <tbody><tr>
						<th>预计到账时间</th>
						<th>项目名称|编号</th>
                        <th>预期收款额（元）</th>
						<th>预期本金（元）</th>
                        <th>预期收益（元）</th>
                        <th>详情</th>
					  </tr>
					
                    
					
						 <tr class="tdColor">
							<td>2015-08-22</td>
							<td>能源公司短期周转M07210930十一期|<a href="https://www.sh.com/tender/info/XM01507171015574">XM01507171015574</a></td>
							<td>￥300.00</td>
							<td>￥0.00</td>
							<td>￥300.00</td>
							<td><a class="profitinfo" avalue="TZ1507211065273" href="javascript:void(0)">详情</a></td>
						</tr>
				  
						 <tr>
							<td>2015-09-22</td>
							<td>能源公司短期周转M07210930十一期|<a href="https://www.sh.com/tender/info/XM01507171015574">XM01507171015574</a></td>
							<td>￥20300.00</td>
							<td>￥20000.00</td>
							<td>￥300.00</td>
							<td><a class="profitinfo" avalue="TZ1507211065273" href="javascript:void(0)">详情</a></td>
						</tr>
				  
					</tbody></table>
				</div>
               

<input type="hidden" value="1" name="pageindex" id="pageindex">
<p class="page2">
<a class="none">上一页</a>

 	<a href="javascript:void(0)" class="focus">1</a> 
 	
<a class="none">下一页</a></p>
 <script type="text/javascript">
	function pageJump(page){
		$("#pageindex").val(page);
		$("#pageindex").parents("form:eq(0)").submit();
	}
</script>
		</div>
		</form>          
                
      </div>
   <div class="clear"></div>
   </div>
</div>
    
<%@include file="/WEB-INF/include/footer.jsp" %>
<%@include file="/WEB-INF/include/script.jsp" %>
<%@include file="/WEB-INF/include/datepicker.jsp"%>
<script type="text/javascript">
		$(function() {
			$("#startDate").datepicker({inline: true,
				onSelect : function(selectedDate) {
		            $("#endDate").datepicker("option", "minDate", selectedDate); 
		        }
			});
		    $('#startDate').datepicker('setDate', "<%StringHelper.filterQuoter(out,request.getParameter("startTime"));%>");
		    $("#endDate").datepicker({inline: true});
		    $('#endDate').datepicker('setDate', "<%StringHelper.filterQuoter(out,request.getParameter("endTime"));%>");
		    $("#endDate").datepicker('option', 'minDate',$("#startDate").datepicker().val());
		});
</script>
</body>
</html>