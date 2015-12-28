<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.modules.spread.console.service.entity.BenefitEnum"%>
<%@page import="com.dimeng.p2p.console.servlets.spread.hdgl.ExportHdcry"%>
<%@page import="com.dimeng.p2p.modules.spread.console.service.entity.PartakeTotalInfo"%>
<%@page import="com.dimeng.p2p.modules.spread.console.service.entity.PartakePersonList"%>
<%@page import="com.dimeng.p2p.console.servlets.spread.hdgl.SearchCyr"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
<%
	CURRENT_CATEGORY = "TGGL";
	CURRENT_SUB_CATEGORY = "HDGL";
	PagingResult<PartakePersonList> result = ObjectHelper.convert(request.getAttribute("result"), PagingResult.class);
	PartakeTotalInfo totalInfo = ObjectHelper.convert(request.getAttribute("totalInfo"), PartakeTotalInfo.class);
%>
<%@include file="/WEB-INF/include/header.jsp"%> 
<div class="w_main">
  <div class="main clearfix">
    <div class="wrap">
    <form action="<%=controller.getURI(request, SearchCyr.class) %>" method="post">
    	<input type="hidden" value="<%=totalInfo.id %>" name="id"/>
      <div class="r_main">
        <div class="home_main">
          <div class="box box1 mb15">
            <div class="atil">
              <h3>参与人列表</h3>
            </div>
            <div class="con">
              <div class="clear"></div>
              <ul class="yhxq_li">
                <li>活动主题：<span class="blue"><%=totalInfo.id %></span> </li>
              </ul>
              <ul class="yhxq_li">
                <li>总奖励：<span class="blue"><%=totalInfo.totalMoney %></span>元 </li>
              </ul>
              <ul class="yhxq_li">
                <li>总受益人数：<span class="blue"><%=totalInfo.personNum %></span>人 </li>
              </ul>
              <div class="clear"></div>
            </div>
          </div>
          <div class="box box1 mb15">
            <div class="con">
              <div class="admin_input admin_pb">
             	<div class="table">
            		<p>
                    	<span>参与人：</span>
                  		<input type="text" name="userName" id="textfield" class="yhgl_input" value="<%StringHelper.filterHTML(out, request.getParameter("userName")); %>"/>
          			</p>  
           			<p>      
                   		<span>开始时间：</span>
                    	<input type="text" name="startTime" readonly="readonly" id="datepicker1" class="yhgl_input date" value="<%StringHelper.filterHTML(out, request.getParameter("startTime"));%>"/> 至 
                    	<input type="text" name="endTime" readonly="readonly" id="datepicker2" class="yhgl_input date" value="<%StringHelper.filterHTML(out, request.getParameter("endTime"));%>"/>
                   	</p>
		 			<div class="clear"></div>   
                 	<div class="mt10">   
                    	<input name="" type="submit" class="btn2 mr10" value="搜索" style="cursor: pointer;"/>
                    	<%if (dimengSession.isAccessableResource(ExportHdcry.class)) {%>
                   		 	<a onclick="exportList();"  style="cursor: pointer;"  class="btn3 mr10"><span class="ico"></span>导出</a>
                 		<%}else{ %>
							<span class="btn3 btn5 mr10"><span class="ico"></span>导出</span>
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
              <td>参与人</td>
              <td>姓名</td>
              <td>活动奖励（元）</td>
              <td>使用类型</td>
              <td>领取时间</td>
              <td>使用时间</td>
            </tr>
			  <% 
			  PartakePersonList[] lists = result.getItems(); 
	            if(lists != null ){
	            	int index = 1;
	            	for(PartakePersonList list : lists){
            %>
            <tr class="dhsbg">
              <td><%=index++ %></td>
              <td><%StringHelper.filterHTML(out, list.userName); %></td>
              <td><%StringHelper.filterHTML(out, list.name); %></td>
              <td><%=list.reward %></td>
              <td><%StringHelper.filterHTML(out, list.T6322_F07.getChineseName()); %></td>
              <td><%=DateTimeParser.format(list.getTime) %></td>
              <td><%=DateTimeParser.format(list.useTime) %></td>
            </tr>
           <%}}%>
          </table>
          <div class="box2 clearfix"></div>
          <% 
        	 SearchCyr.rendPagingResult(out, result);
          %>
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
	<script type="text/javascript">
		function exportList(){
			var del_url = '<%=controller.getURI(request, ExportHdcry.class) %>';
	   		var form = document.forms[0];
			form.action = del_url;
			form.submit();
			form.action = '<%=controller.getURI(request, SearchCyr.class) %>';
		}
</script>
</body>
</html>