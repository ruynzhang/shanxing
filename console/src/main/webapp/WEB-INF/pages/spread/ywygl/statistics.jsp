<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.math.BigDecimal"%>
<%@page import="com.dimeng.p2p.console.servlets.spread.ywygl.ExportStatistics"%>
<%@page import="com.dimeng.p2p.console.servlets.spread.ywygl.Statistics"%>
<%@page import="com.dimeng.p2p.console.servlets.spread.AbstractSpreadServlet"%>
<%@page import="com.dimeng.p2p.modules.salesman.console.service.entity.Customers"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
<%
	CURRENT_CATEGORY = "TGGL";
	CURRENT_SUB_CATEGORY = "TJTJ";
	PagingResult<Customers> result = ObjectHelper.convert(request.getAttribute("result"), PagingResult.class);
	BigDecimal ljTotle= (BigDecimal)request.getAttribute("ljTotle");
	
%>
<%@include file="/WEB-INF/include/header.jsp"%> 
<div class="w_main">
  <div class="main clearfix">
     <div class="wrap">
     <form action="<%=controller.getURI(request, Statistics.class) %>" method="post">
        <div class="r_main">
            <div class="home_main">
            	<div class="box box1 mb15">
                	<div class="atil">
                    	<h3>推荐统计</h3>
                  </div>
                    <div class="con">
                    <div class="clear"></div>
                    <div class="table top3">
                    <span>业务ID：</span><span><input type="text" name="ywyId" id="ywyId" class="yhgl_input" value="<%StringHelper.filterHTML(out, request.getParameter("ywyId")); %>"/></span>
                    <span>业务员姓名：</span><span><input type="text" name="name" id="name" class="yhgl_input" value="<%StringHelper.filterHTML(out, request.getParameter("name")); %>"/></span>
                    <span>业务员手机号：</span><span><input type="text" name="tel" id="tel" class="yhgl_input" value="<%StringHelper.filterHTML(out, request.getParameter("tel")); %>"/></span>
                    <span>录入时间：</span><span>
                   		 <input type="text" name="startTime" readonly="readonly" id="datepicker1" class="yhgl_input date" value="<%StringHelper.filterHTML(out, request.getParameter("startTime"));%>"/> 至 
                    	<input type="text" name="endTime" readonly="readonly" id="datepicker2" class="yhgl_input date" value="<%StringHelper.filterHTML(out, request.getParameter("endTime"));%>"/>
                    </span>
                    <input  type="submit" class="btn2" value="搜索" />
                    </div>                    
                    <div class="clear"></div>                    
                  </div>
                </div>
                <div class="mb15"><a href="<%=controller.getURI(request, ExportStatistics.class) %>" class="btn3 mr10"><span class="ico"></span>导出</a>                    
                  <div class="clear"></div>
                </div>
                <div>
                <table width="100%" border="0" cellspacing="0" cellpadding="3" class="yhgl_table tc">
                        <tr class="hsbg">
                          <td>日期</td>
                          <td>用户账户</td>
                          <td>用户姓名</td>
                          <td>金额</td>
                          <td>交易类型</td>
                        </tr>
                        <% 
                        Customers[] lists = result.getItems(); 
				            if(lists != null && lists.length >0){
				            	
				            	int index = 1;
				            	for(Customers info : lists){
				            		if(info == null){
				            			continue;
				            		}
			            %>
                        <tr class="dhsbg">
                          <td><%=TimestampParser.format(info.F04) %></td>
                          <td><%StringHelper.filterHTML(out, info.loginName); %></td>
                          <td><%StringHelper.filterHTML(out, info.userName); %></td>
                          <td><%=Formater.formatAmount(info.F05)%></td>
                          <td><%StringHelper.filterHTML(out, info.F06.getChineseName()); %></td>
                        </tr>
                        <%}} %>
                      </table>
            </div>
                <div class="page">
                      <% 
                      AbstractSpreadServlet.rendPagingResult(out, result);
			          %>
			          
			                       累计总额：
                	<%if(ljTotle.doubleValue() >10000){%>
                	 <%=Formater.formatAmount(ljTotle.doubleValue()/10000) %>万元
                	 <%}else{%>
                	 <%=Formater.formatAmount(ljTotle.doubleValue()) %>
                	  <%}%>
                </div>  
               
              <div class="box2 clearfix"></div>
            </div>
        </div>   
        </form>
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
	    $("#datepicker1").datepicker("setDate", "<%StringHelper.filterHTML(out, request.getParameter("startTime"));%>");
	    $("#datepicker2").datepicker("setDate", "<%StringHelper.filterHTML(out, request.getParameter("endTime"));%>");
	});
	</script>
</body>
</html>