<%@page import="com.dimeng.p2p.console.servlets.info.yqlj.*"%>
<%@page import="com.dimeng.p2p.modules.base.console.service.entity.FriendlyLinkRecord"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html >
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>

<body>
<%
	CURRENT_CATEGORY = "XCGL";
	CURRENT_SUB_CATEGORY = "YQLJ";
%>
<%@include file="/WEB-INF/include/header.jsp"%>
<div class="w_main">
<div class="main clearfix">
	 <%PagingResult<FriendlyLinkRecord> result = ObjectHelper.convert(request.getAttribute("result"), PagingResult.class); %>
	 <form action="<%=controller.getURI(request, SearchYqlj.class)%>" method="post">
  	 <div class="wrap">
        <div class="r_main">
            <div class="home_main">
            	<div class="box box1 mb15">
                	<div class="atil">
                    	<h3>友情链接</h3>
                  </div>
                    <div class="con">
                    <div class="clear"></div>
                    <div class="admin_input admin_pb">
                    <p>
                    <span>名称：</span><span><input type="text" name="name" id="textfield" class="yhgl_input" value="<%StringHelper.filterHTML(out, request.getParameter("name"));%>"/></span>
                    </p>
                    <p>
                    <span>发布者：</span><span><input type="text" name="publisherName" id="textfield4" class="yhgl_input" value="<%StringHelper.filterHTML(out, request.getParameter("publisherName"));%>"/></span>
                    </p>
                    <p>
                    <span>修改时间：</span><span><input type="text" name="updateTimeStart" readonly="readonly" id="datepicker1" class="yhgl_input date" value="<%StringHelper.filterHTML(out, request.getParameter("updateTimeStart"));%>"/></span>
                    <span>至</span><span><input type="text" name="updateTimeEnd" readonly="readonly" id="datepicker2" class="yhgl_input date " value="<%StringHelper.filterHTML(out, request.getParameter("updateTimeEnd"));%>"/></span>
                    </p>
                    <div class="clear"></div>   
                    <div class="mt10">   
                    <input name="" type="submit" class="btn2 mr10" value="搜索" style="cursor: pointer;"/>
                    <%if (dimengSession.isAccessableResource(AddYqlj.class)) {%>
                     	<a href="<%=controller.getURI(request, AddYqlj.class)%>" class="btn3 mr10"><span class="ico3"></span>添加</a>
                     <%}else{ %>
						<span class="btn3 btn5 mr10"><span class="ico3"></span>添加</span>
					<%} %>
					<%if (dimengSession.isAccessableResource(DeleteYqlj.class)) {%> 
                    	<a href="javascript:void(0)" id="delAll" class="btn3 mr10"><span class="ico4"></span>批量删除</a>
                    <%}else{ %>
						<span class="btn3 btn5 mr10"><span class="ico4"></span>批量删除</span>
					<%} %>  
                    </div>               
                    <div class="clear"></div>
                   
                    </div>                    	
                   
                  </div>
                </div>
               
                <div>
                  <table width="100%" border="0" cellspacing="0" cellpadding="3" class="yhgl_table tc">
                        <tr class="hsbg">
                      	  <td><input id="checkAll" type="checkbox" /></td>
                          <td>序号</td>
                          <td>名称</td>
                          <td>浏览次数</td>
                          <td>发布者</td>
                          <td>链接地址</td>
                          <td>最后修改时间</td>
                          <td>排序值</td>
                          <td>nofollow</td>
                          <td>操作</td>                          
                        </tr>
                        <% FriendlyLinkRecord[] records = result.getItems();
                        	if(records != null){
                        		int index = 1;
                        		for(FriendlyLinkRecord record : records){
                        %>
                        <tr class="dhsbg">
                          <td><input name="id" type="checkbox" value="<%=record.id %>" /></td>
                          <td><%=index++ %></td>
                          <td title="<%StringHelper.filterHTML(out, record.name); %>"><%StringHelper.filterHTML(out,StringHelper.truncation(record.name, 15)); %></td>
                          <td><%=record.viewTimes %></td>
                          <td><%StringHelper.filterHTML(out, record.publisherName); %></td>
                          <td><a href="<%=record.url%>" target="_blank" ><%StringHelper.filterHTML(out, record.url);%></a></td> 
                          <td><%=DateTimeParser.format(record.updateTime) %></td>
                          <td><%=record.sortIndex %></td>
                          <td><%="T".equals(record.nofollow)?"是":"否"%></td>
                          <td class="blue">
                          	<%if (dimengSession.isAccessableResource(UpdateYqlj.class)) {%>
                          		<a href="<%=controller.getURI(request, UpdateYqlj.class)%>?id=<%=record.id %>">修改</a>
                          	<%}else{ %>
								<span class="gray6">修改</span>
							<%} %>   
							<%if (dimengSession.isAccessableResource(DeleteYqlj.class)) {%>
                          		<a href="<%=controller.getURI(request, DeleteYqlj.class)%>?id=<%=record.id %>">删除</a>
                          	<%}else{ %>
								<span class="gray6">删除</span>
							<%} %> 
                        	</td>                          
                        </tr>
                   <%	}}%>
                      </table>
              </div>
               <% SearchYqlj.rendPagingResult(out, result);%>
              <div class="box2 clearfix"></div>
            </div>
        </div>   
    </div>
   </form>
   <%@include file="/WEB-INF/include/left.jsp" %>
   </div>
   </div>

<%@include file="/WEB-INF/include/footer.jsp"%>
<%@include file="/WEB-INF/include/script.jsp"%>
<script type="text/javascript">
   		var del_url = '<%=controller.getURI(request, DeleteYqlj.class) %>';
</script>
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/checkAll.js"></script>
<%@include file="/WEB-INF/include/datepicker.jsp"%>
	<script type="text/javascript">
	$(function() {
		$("#datepicker1").datepicker({inline: true});
	    $('#datepicker1').datepicker('option', {dateFormat:'yy-mm-dd'});
	    $("#datepicker2").datepicker({inline: true});
	    $('#datepicker2').datepicker('option', {dateFormat:'yy-mm-dd'});
	    $("#datepicker1").datepicker("setDate", "<%StringHelper.filterHTML(out, request.getParameter("updateTimeStart"));%>");
	    $("#datepicker2").datepicker("setDate", "<%StringHelper.filterHTML(out, request.getParameter("updateTimeEnd"));%>");
	});
	</script>
</body>
</html>