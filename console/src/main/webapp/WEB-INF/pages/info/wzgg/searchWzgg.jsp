<%@page import="com.dimeng.p2p.common.enums.NoticePublishStatus"%>
<%@page import="com.dimeng.p2p.common.enums.NoticeType"%>
<%@page import="com.dimeng.p2p.console.servlets.info.wzgg.*"%>
<%@page import="com.dimeng.p2p.modules.base.console.service.entity.NoticeRecord"%>
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
	CURRENT_SUB_CATEGORY = "WZGG";
%>
<%@include file="/WEB-INF/include/header.jsp"%>
<div class="w_main">
<div class="main clearfix">
	 <%PagingResult<NoticeRecord> result = ObjectHelper.convert(request.getAttribute("result"), PagingResult.class); %>
	 <form action="<%=controller.getURI(request, SearchWzgg.class)%>" method="post">
  	 <div class="wrap">
        <div class="r_main">
            <div class="home_main">
            	<div class="box box1 mb15">
                	<div class="atil">
                    	<h3>网站公告</h3>
                  </div>
                    <div class="con">
                    <div class="clear"></div>
                    <div class="admin_input admin_pb">
                    <p>
                    <span>文章标题：</span><span><input type="text" name="title" id="textfield" class="yhgl_input" value="<%StringHelper.filterHTML(out, request.getParameter("title"));%>"/></span>
                    </p>
                    <p>
                    <span>发布者：</span><span><input type="text" name="publisherName" id="textfield4" class="yhgl_input" value="<%StringHelper.filterHTML(out, request.getParameter("publisherName"));%>"/></span>
                    </p>
                    <p>
                    <span>修改时间：</span><span><input type="text" name="updateTimeStart" readonly="readonly" id="datepicker1" class="yhgl_input date" value="<%StringHelper.filterHTML(out, request.getParameter("updateTimeStart"));%>"/></span>
                    <span>至</span><span><input type="text" name="updateTimeEnd" readonly="readonly" id="datepicker2" class="yhgl_input date " value="<%StringHelper.filterHTML(out, request.getParameter("updateTimeEnd"));%>" /></span>
                    </p>
                    <p>
                    <span>发布状态：</span>
                    <span>
                    <select name="publishStatus">
                    	<option >全部</option>
                    	<option value="<%=NoticePublishStatus.WFB%>" <%if(! StringHelper.isEmpty(request.getParameter("publishStatus")) && request.getParameter("publishStatus").equals(NoticePublishStatus.WFB.name())){ %>selected="selected"<%} %>><%=NoticePublishStatus.WFB.getName()%></option>
                    	<option value="<%=NoticePublishStatus.YFB%>" <%if(! StringHelper.isEmpty(request.getParameter("publishStatus")) && request.getParameter("publishStatus").equals(NoticePublishStatus.YFB.name())){ %>selected="selected"<%} %>><%=NoticePublishStatus.YFB.getName()%></option>
                    </select>
                    </span>
                    </p>
                    <p>
                    <span>发布类型：</span>
                    <span>
                    <select name="type" >
                    	<option >全部</option>
                    	<option value="<%=NoticeType.XT %>" <%if(! StringHelper.isEmpty(request.getParameter("type")) && request.getParameter("type").equals(NoticeType.XT.name())){ %>selected="selected"<%} %>><%=NoticeType.XT.getName() %></option>
                    	<option value="<%=NoticeType.HD %>" <%if(! StringHelper.isEmpty(request.getParameter("type")) && request.getParameter("type").equals(NoticeType.HD.name())){ %>selected="selected"<%} %>><%=NoticeType.HD.getName() %></option>
                    </select>
                    </span>
                    </p>
            		 <div class="clear"></div>   
                    <div class="mt10">   
                    <input name="" type="submit" class="btn2 mr10" value="搜索" style="cursor: pointer;"/>
                    <%if (dimengSession.isAccessableResource(AddWzgg.class)) {%>
                    	<a href="<%=controller.getURI(request, AddWzgg.class)%>" class="btn3 mr10"><span class="ico3"></span>添加</a>
                    <%}else{ %>
						<span class="btn3 btn5 mr10"><span class="ico3"></span>添加</span>
					<%} %> 
					<%if (dimengSession.isAccessableResource(DeleteWzgg.class)) {%>
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
                      	  <td><input type="checkbox" id="checkAll"/></td>
                          <td>序号</td>
                          <td>文章标题</td>
                          <td>浏览次数</td>
                          <td>发布者</td>
                          <td>类型</td>
                          <td>是否发布</td>
                          <td>最后修改时间</td>
                          <td>操作</td>                          
                        </tr>
                        <%NoticeRecord[] records = result.getItems();if(records != null){int index = 1;for(NoticeRecord record : records){%>
                        <tr class="dhsbg">
                          	<td><input name="id" type="checkbox" value="<%=record.id %>" /></td>
                          	<td><%=index++ %></td>
                          	<td title="<%StringHelper.filterHTML(out, record.title); %>"><%StringHelper.filterHTML(out, StringHelper.truncation(record.title, 15)); %></td>
                          	<td><%=record.viewTimes %></td>
                          	<td><%StringHelper.filterHTML(out, record.publisherName); %></td>
                          	<td><%StringHelper.filterHTML(out, record.type.getName()); %></td>
                          	<td><%StringHelper.filterHTML(out, record.publishStatus.getName()); %></td>
                          	<td><%=DateTimeParser.format(record.updateTime) %></td>
                          	<td class="blue">
                          		<%if (dimengSession.isAccessableResource(UpdateWzgg.class)) {%>
	                          		<a href="<%=controller.getURI(request, UpdateWzgg.class)%>?id=<%=record.id %>">修改</a>
	                          	<%}else{ %>
									<span class="gray6">修改</span>
								<%} %>
								<%if (dimengSession.isAccessableResource(DeleteWzgg.class)) {%>   
	                          		<a href="<%=controller.getURI(request, DeleteWzgg.class)%>?id=<%=record.id %>">删除</a>
	                          	<%}else{ %>
									<span class="gray6">删除</span>
								<%} %>
                        	</td>                          
                        </tr>
                   		<%}}%>
                      </table>
              </div>
              <%SearchWzgg.rendPagingResult(out, result);%>
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
   		var del_url = '<%=controller.getURI(request, DeleteWzgg.class) %>';
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