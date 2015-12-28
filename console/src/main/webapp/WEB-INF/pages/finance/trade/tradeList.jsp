<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.console.servlets.finance.trade.TradeExport"%>
<%@page import="com.dimeng.p2p.modules.account.console.service.entity.TradeVo"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.trade.Trade"%>
<%@page import="com.dimeng.p2p.console.servlets.finance.trade.TradeList"%>
<%@page import="java.util.List"%>
<%@page import="com.dimeng.p2p.console.servlets.AbstractConsoleServlet"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
<%
CURRENT_CATEGORY = "CWGL";
CURRENT_SUB_CATEGORY = "TRADELIST";
PagingResult<TradeVo> list = ObjectHelper.convert(request.getAttribute("list"), PagingResult.class);
%>
<%@include file="/WEB-INF/include/header.jsp"%>
<div class="w_main">
<div class="main clearfix">
    <div class="wrap">
        <div class="r_main">
            <div class="home_main">
            	<form action="<%=controller.getURI(request, TradeList.class)%>" method="post" id="searchForm" onsubmit="return onSubmit();">
            	<div class="box box1 mb15">
                	<div class="atil">
                    	<h3>转账管理</h3>
                    </div>
                    <div class="con">
                    	  <div class="admin_input admin_pb">
                    	  		<P>
									<span>姓名：</span>
									<input type="text" name="inName" class="yhgl_input" value="<%StringHelper.filterHTML(out, request.getParameter("inName"));%>"/>
								</P>
								<P>
									<span>开始时间：</span>
									<input type="text" name="staDate" id="datepicker1" readonly="readonly" class="yhgl_input date" value="<%StringHelper.filterHTML(out, request.getParameter("staDate"));%>"/>至
									<input type="text" name="endDate" id="datepicker2" readonly="readonly" class="yhgl_input date" value="<%StringHelper.filterHTML(out, request.getParameter("endDate"));%>"/>
								</P>
								<P>
									<input name="search" type="submit" class="btn2" value="搜索" />
									<%if (dimengSession.isAccessableResource(Trade.class)) {%>
									<a href="<%=controller.getURI(request, Trade.class)%>" class="btn3 mr10" style="margin-left: 10px;"><span class="ico"></span>转账</a> 
	                          		<%}else{%>
									<span class="btn3 btn5 mr10" style="margin-top: -0px;margin-left: 10px;"><span class="ico"></span>转账</span>
									<%}%>
									<%if (dimengSession.isAccessableResource(TradeExport.class)) {%>
									<a href="javascript:void(0)" onclick="showExport();" class="btn3 mr10" style="margin-left: 10px;"><span class="ico"></span>导出</a> 
	                          		<%}else{%>
									<span class="btn3 btn5 mr10" style="margin-top: -0px;margin-left: 10px;"><span class="ico"></span>导出</span>
									<%}%>
									
								</P>
                              <div class="clear"></div>
                    	</div>    
                    </div>
                </div>
              	<div>
                <table width="100%" border="0" cellspacing="0" cellpadding="3" class="yhgl_table tc">
                        <tr class="hsbg">
                          <td>序号</td>
                          <td>支出用户名</td>
                          <td>收入用户名</td>
                          <td>转账金额</td>
                          <td>操作时间</td>
                          <td>备注</td>
                        </tr>
                        <%
                        	if (list!=null && list.getItems() != null) {
                        		int index = 1;
                        		for (TradeVo vo:list.getItems()){
                        %>
                        <tr class="dhsbg">
                          <td><%=index++ %></td>
                          <td><%StringHelper.filterHTML(out, vo.outName);%></td>
                          <td><%StringHelper.filterHTML(out, vo.inName); %></td>
                          <td><%=Formater.formatAmount(vo.t_amount)%></td>
                          <td><%=Formater.formatDateTime(vo.createTime)%></td>
                          <td><%StringHelper.filterHTML(out, vo.remark); %></td>
                        </tr> 
                        <%}}%>
                 </table>
                </div>
                <%TradeList.rendPagingResult(out, list); %>
                </form>       
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
	$(function(){
	    $('#datepicker1').datepicker('option', {dateFormat:'yy-mm-dd'});
	    $("#datepicker2").datepicker({inline: true});
	    $('#datepicker2').datepicker('option', {dateFormat:'yy-mm-dd'});
	    $("#datepicker2").datepicker('option', 'minDate',$("#datepicker1").datepicker().val());
	});
	onSubmit=function(){
	 	var date1=$("#datepicker1").val();
	 	var date2=$("#datepicker2").val();
	 	if(date1>date2 && date2.length>0){
	 		alert("开始时间不能大于结束时间!");
	 		return false;
	 	}
		return true;
	}
	function showExport()
	{
		document.getElementById("searchForm").action ="<%=controller.getURI(request, TradeExport.class)%>";
		$("#searchForm").submit();
		document.getElementById("searchForm").action ="<%=controller.getURI(request, TradeList.class)%>";
	}
	</script>
</body>
</html>