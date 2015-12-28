<%@page import="com.dimeng.p2p.console.servlets.info.xytk.*"%>
<%@page import="com.dimeng.p2p.modules.base.console.service.entity.TermRecord"%>
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
	CURRENT_SUB_CATEGORY = "XYTK";
%>
<%@include file="/WEB-INF/include/header.jsp"%>
<div class="w_main">
<div class="main clearfix">
	 <%PagingResult<TermRecord> result = ObjectHelper.convert(request.getAttribute("result"), PagingResult.class); %>
	 <form action="<%=controller.getURI(request, SearchXytk.class)%>" method="post">
  	 <div class="wrap">
        <div class="r_main">
            <div class="home_main">
            	<div class="box box1 mb15">
                	<div class="atil">
                    	<h3>协议条款</h3>
                  </div>
                    <div class="con">
                    <div class="clear"></div>
                    <div class="admin_input admin_pb">
                    <p>
                    <span>发布者：</span><span><input type="text" name="publisherName" id="textfield4" class="yhgl_input" value="<%StringHelper.filterHTML(out, request.getParameter("publisherName"));%>"/></span>
                    </p>
                    <div class="clear"></div>   
                    <div class="mt10">   
                    <input name="" type="submit" class="btn2 mr10" value="搜索" style="cursor: pointer;"/>
                    <%if (dimengSession.isAccessableResource(AddXytk.class)) {%>
                   		<a href="<%=controller.getURI(request, AddXytk.class)%>" class="btn3 mr10"><span class="ico3"></span>添加</a>
                   	<%}else{ %>
						<a href="javascript:void(0)" class="btn5 mr10"><span class="ico3"></span>添加</a>
					<%} %> 
                    </div>               
                    <div class="clear"></div>
                    </div>                    	
                   
                  </div>
                </div>
                <div>
                  <table width="100%" border="0" cellspacing="0" cellpadding="3" class="yhgl_table tc">
                        <tr class="hsbg">
                          <td>序号</td>
                          <td>协议类型</td>
                          <td>浏览次数</td>
                          <td>发布者</td>
                          <td>最后修改时间</td>
                          <td>操作</td>                          
                        </tr>
                        <% TermRecord[] records = result.getItems();
                        	if(records != null){
                        		int index = 1;
                        		for(TermRecord record : records){
                        %>
                        <tr class="dhsbg">
                          <td><%=index++ %></td>
                          <td><%StringHelper.filterHTML(out, record.type.getName()); %></td>
                          <td><%=record.viewTimes %></td>
                          <td><%StringHelper.filterHTML(out, record.publisherName); %></td>
                          <td><%=DateTimeParser.format(record.updateTime) %></td>
                          <td class="blue">
                          	<%if (dimengSession.isAccessableResource(UpdateXytk.class)) {%>
                          		<a href="<%=controller.getURI(request, UpdateXytk.class)%>?id=<%StringHelper.filterHTML(out, record.type.name()); %>">修改</a>  
                        	<%}else{ %>
								<span class="gray6">修改</span>
							<%} %> 
                        	</td>                          
                        </tr>
                   <%	}}%>
                      </table>
              </div>
               <% SearchXytk.rendPagingResult(out, result);%>
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

</body>
</html>