<%@page import="com.dimeng.p2p.common.enums.ArticlePublishStatus"%>
<%@page import="com.dimeng.p2p.console.servlets.info.zxdt.wdhyzx.*"%>
<%@page import="com.dimeng.p2p.modules.base.console.service.entity.ArticleRecord"%>
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
	CURRENT_SUB_CATEGORY = "WDHYZX";
%>
<%@include file="/WEB-INF/include/header.jsp"%>
<div class="w_main">
<div class="main clearfix">
	 <%PagingResult<ArticleRecord> result = ObjectHelper.convert(request.getAttribute("result"), PagingResult.class); %>
	 <form action="<%=controller.getURI(request, SearchWdhyzx.class)%>" method="post">
  	 <div class="wrap">
        <div class="r_main">
            <div class="home_main">
            	<div class="box box1 mb15">
                	<div class="atil">
                    	<h3>网贷行业资讯</h3>
                  </div>
                    <div class="con">
                     <div class="admin_input admin_pb">
                    <div class="clear"></div>
                    <div class="table">
                    <p><span>标题：</span><span><input type="text" name="title" id="textfield" class="yhgl_input" value="<%StringHelper.filterHTML(out, request.getParameter("title"));%>" /></span></p>
                    <p><span>发布者：</span><span><input type="text" name="publisherName" id="textfield4" class="yhgl_input" value="<%StringHelper.filterHTML(out, request.getParameter("publisherName"));%>"/></span></p>
                    <p><span>修改时间：</span><span><input type="text" name="createTimeStart" readonly="readonly" id="datepicker1" class="yhgl_input date"  value="<%StringHelper.filterHTML(out, request.getParameter("createTimeStart"));%>"/></span>
                    <span>至</span><span><input type="text" name="createTimeEnd" readonly="readonly" id="datepicker2" class="yhgl_input date " value="<%StringHelper.filterHTML(out, request.getParameter("createTimeEnd"));%>" /></span></p>
                    <p><span>发布状态：</span>
                    <span>
                    <select name="status" class="yhgl_sel">
                    		<option >全部</option>
							<option value="<%=ArticlePublishStatus.WFB%>" <%if(! StringHelper.isEmpty(request.getParameter("status")) && request.getParameter("status").equals(ArticlePublishStatus.WFB.name())){ %>selected="selected"<%} %>><%=ArticlePublishStatus.WFB.getName()%></option>
                        	<option value="<%=ArticlePublishStatus.YFB%>" <%if(! StringHelper.isEmpty(request.getParameter("status")) && request.getParameter("status").equals(ArticlePublishStatus.YFB.name())){ %>selected="selected"<%} %>><%=ArticlePublishStatus.YFB.getName()%></option>
                    </select>
                    </span>
                    </p>
                    <div class="clear"></div>   
                    <div class="mt10">   
                    <input name="" type="submit" class="btn2 mr10" value="搜索" style="cursor: pointer;"/>
                    <%if (dimengSession.isAccessableResource(AddWdhyzx.class)) {%>
                    	<a href="<%=controller.getURI(request, AddWdhyzx.class)%>" class="btn3 mr10"><span class="ico3"></span>添加</a>
                    <%}else{ %>
						<span class="btn3 btn5 mr10"><span class="ico3"></span>添加</span>
					<%} %>
					<%if (dimengSession.isAccessableResource(DeleteWdhyzx.class)) {%> 
                    	<a href="javascript:void(0)" id="delAll" class="btn3 mr10"><span class="ico4"></span>批量删除</a>
                    <%}else{ %>
                    	<span class="btn3 btn5 mr10"><span class="ico4"></span>批量删除</span>
					<%} %>   
                    </div>               
                    <div class="clear"></div>
                    </div>                    	
                  </div>
                  </div>
                </div>
                <div>
                  <table width="100%" border="0" cellspacing="0" cellpadding="3" class="yhgl_table tc">
                        <tr class="hsbg">
                      	  <td><input  type="checkbox" id="checkAll" /></td>
                          <td>序号</td>
                          <td>文章标题</td>
                          <td>浏览次数</td>
                          <td>来源</td>
                          <td>发布者</td>
                          <td>是否发布</td>
                          <td>最后修改时间</td>
                          <td>发布时间</td>
                          <td>排序值</td>
                          <td>操作</td>                          
                        </tr>
                        <% ArticleRecord[] records = result.getItems();
                        	if(records != null){
                        		int index = 1;
                        		for(ArticleRecord record : records){
                        %>
                        <tr class="dhsbg">
                          <td><input name="id" type="checkbox" value="<%=record.id %>" /></td>
                          <td><%=index++ %></td>
                          <td title="<%StringHelper.filterHTML(out, record.title);%>"><%StringHelper.filterHTML(out,StringHelper.truncation(record.title, 15)); %></td>
                          <td><%=record.viewTimes %></td>
                          <td title="<%StringHelper.filterHTML(out, record.source); %>"><%StringHelper.filterHTML(out,StringHelper.truncation(record.source, 15)); %></td>
                          <td><%StringHelper.filterHTML(out, record.publisherName); %></td>
                          <td><%StringHelper.filterHTML(out, record.publishStatus.getName()); %></td>
                          <td><%=DateTimeParser.format(record.createtime) %></td>
                          <td><%=DateParser.format(record.publishTime) %></td>
                           <td><%=record.sortIndex %></td>
                          <td class="blue">
                          	<%if (dimengSession.isAccessableResource(UpdateWdhyzx.class)) {%>
                          		<a href="<%=controller.getURI(request, UpdateWdhyzx.class)%>?id=<%=record.id %>">修改</a>
                          	<%}else{ %>
								<span class="gray6">修改</span>
							<%} %> 
                          	<%if (dimengSession.isAccessableResource(DeleteWdhyzx.class)) {%>  
                          		<a href="<%=controller.getURI(request, DeleteWdhyzx.class)%>?id=<%=record.id %>">删除</a>
                          	<%}else{ %>
								<span class="gray6">删除</span>
							<%} %> 
                        	</td>                          
                        </tr>
                   <%	}}%>
                      </table>
              </div>
               <% SearchWdhyzx.rendPagingResult(out, result);%>
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
   		var del_url = '<%=controller.getURI(request, DeleteWdhyzx.class) %>';
</script>
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/checkAll.js"></script>
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