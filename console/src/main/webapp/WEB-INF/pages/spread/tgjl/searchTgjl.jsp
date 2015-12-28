<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.console.servlets.spread.tgjl.ExportTgjl"%>
<%@page import="com.dimeng.p2p.modules.spread.console.service.entity.SpreadList"%>
<%@page import="com.dimeng.p2p.console.servlets.spread.tgjl.SearchTgjl"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
<%
	CURRENT_CATEGORY = "TGGL";
	CURRENT_SUB_CATEGORY = "TGJL";
	PagingResult<SpreadList> result = ObjectHelper.convert(request.getAttribute("result"), PagingResult.class);
%>
<%@include file="/WEB-INF/include/header.jsp"%> 
<div class="w_main">
  <div class="main clearfix">
    <div class="wrap">
    <form action="<%=controller.getURI(request, SearchTgjl.class) %>" method="post">
      <div class="r_main">
        <div class="home_main">
          <div class="box box1 mb15">
            <div class="atil">
              <h3>推广持续奖励详情列表</h3>
            </div>
            <div class="con">
               <div class="admin_input admin_pb">
             	<div class="table">   
                <p>
                   <span> 推广人ID：</span>
                   <input type="text" name="id" id="textfield" class="yhgl_input" value="<%StringHelper.filterHTML(out, request.getParameter("id")); %>"/>
                 </p>
                 <P>
                  <span>推广人用户名：</span>
                    <input type="text" name="userName" id="textfield4" class="yhgl_input" value="<%StringHelper.filterHTML(out, request.getParameter("userName")); %>"/>
                 </P> 
                 <p> 
                   <span> 推广人姓名：</span>
                    <input type="text" name="name" id="textfield" class="yhgl_input" value="<%StringHelper.filterHTML(out, request.getParameter("name")); %>"/>
                </p>
                <p>
                    <span>被推广人ID：</span>
                    <input type="text" name="personID" id="textfield" class="yhgl_input" value="<%StringHelper.filterHTML(out, request.getParameter("personID")); %>"/>
                </p>
                <p>
                  	<span>被推广人姓名：</span>
                    <input type="text" name="personName" id="textfield" class="yhgl_input" value="<%StringHelper.filterHTML(out, request.getParameter("personName")); %>"/>
                </p>
                <P>
                    <span>被推广人用户名：</span>
                   <input type="text" name="personUserName" id="textfield" class="yhgl_input" value="<%StringHelper.filterHTML(out, request.getParameter("personUserName")); %>"/>
                  </P>
                  <P>
                    <span>投资时间：</span>
                   <input type="text" name="startTime" readonly="readonly" id="datepicker1" class="yhgl_input date" /> 至
                    				 <input type="text" name="endTime" readonly="readonly" id="datepicker2" class="yhgl_input date" />
               
                </P>
                <div class="clear"></div>   
                 	<div class="mt10">   
                    	<input name="" type="submit" class="btn2 mr10" value="搜索" style="cursor: pointer;"/>
                    	<%if (dimengSession.isAccessableResource(ExportTgjl.class)) {%>
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
              <td>推广人ID</td>
              <td>推广人用户名</td>
              <td>推广人姓名</td>
              <td>被推广人ID</td>
              <td>被推广人用户名</td>
              <td>被推广人姓名</td>              
              <td>推广投资金额（元）</td>
              <td>持续奖励（元）</td>
              <td>投资时间</td>
            </tr>
            <% 
            SpreadList[] lists = result.getItems(); 
	            if(lists != null ){
	            	int index = 1;
	            	for(SpreadList list : lists){
            %>
            <tr class="dhsbg">
              <td><%=index++ %></td>
              <td><%=list.id %></td>
              <td><%StringHelper.filterHTML(out, list.userName); %></td>
              <td><%StringHelper.filterHTML(out, list.name); %></td>
              <td><%=list.personID %> </td>
              <td><%StringHelper.filterHTML(out,list.personUserName); %></td>
              <td><%StringHelper.filterHTML(out, list.personName); %></td>
              <td><%=list.spreadTotalMoney %></td>
              <td><%=list.rewardMoney %></td>
              <td><%=DateParser.format(list.investTime) %></td>
            </tr>
           <%}}%>
          </table>
          <div class="box2 clearfix"></div>
          <% 
        	 SearchTgjl.rendPagingResult(out, result);
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
		$("#datepicker1").datepicker({inline: true,
			onSelect : function(selectedDate) {
	            $("#datepicker2").datepicker("option", "minDate", selectedDate); 
	        }
		});
	    $('#datepicker1').datepicker('option', {dateFormat:'yy-mm-dd'});
	    $("#datepicker2").datepicker({inline: true});
	    $('#datepicker2').datepicker('option', {dateFormat:'yy-mm-dd'});
	    $("#datepicker1").datepicker("setDate", "<%StringHelper.filterHTML(out, request.getParameter("startTime"));%>");
	    $("#datepicker2").datepicker("setDate", "<%StringHelper.filterHTML(out, request.getParameter("endTime"));%>");
	    $("#datepicker2").datepicker('option', 'minDate',$("#datepicker1").datepicker().val());
	});
	</script>
	<script type="text/javascript">
		function exportList(){
			var del_url = '<%=controller.getURI(request, ExportTgjl.class) %>';
	   		var form = document.forms[0];
			form.action = del_url;
			form.submit();
			form.action = '<%=controller.getURI(request, SearchTgjl.class) %>';
		}
   	
</script>
</body>
</html>