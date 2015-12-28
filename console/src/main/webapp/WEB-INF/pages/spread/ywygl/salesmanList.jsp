<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.console.servlets.spread.ywygl.UpdateSalesman"%>
<%@page import="com.dimeng.p2p.console.servlets.spread.ywygl.Statistics"%>
<%@page import="com.dimeng.p2p.console.servlets.spread.ywygl.ExportYwy"%>
<%@page import="com.dimeng.p2p.console.servlets.spread.ywygl.AddSalesman"%>
<%@page import="com.dimeng.p2p.console.servlets.spread.ywygl.SalesmanList"%>
<%@page import="com.dimeng.p2p.modules.salesman.console.service.entity.Salesman"%>
<%@page import="com.dimeng.p2p.console.servlets.spread.AbstractSpreadServlet"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
<%
	CURRENT_CATEGORY = "TGGL";
	CURRENT_SUB_CATEGORY = "YWYGL";
	PagingResult<Salesman> result = ObjectHelper.convert(request.getAttribute("result"), PagingResult.class);
%>
<%@include file="/WEB-INF/include/header.jsp"%> 
<div class="w_main">
<div class="main clearfix">
    <div class="wrap">
     <form action="<%=controller.getURI(request, SalesmanList.class) %>" method="post">
        <div class="r_main">
            <div class="home_main">
            	<div class="box box1 mb15">
                	<div class="atil">
                    	<h3>业务员信息</h3>
                  </div>
                    <div class="con">
                    <div class="clear"></div>
                    <div class="table top3">
                    <span>业务ID：</span><span><input value="<%StringHelper.filterHTML(out, request.getParameter("ywyId")); %>" type="text" name="ywyId" id="ywyId" class="yhgl_input" /></span>
                    <span>业务员姓名：</span><span><input value="<%StringHelper.filterHTML(out, request.getParameter("name")); %>" type="text" name="name" id="name" class="yhgl_input" /></span>
                    <span>业务员手机号：</span><span><input value="<%StringHelper.filterHTML(out, request.getParameter("tel")); %>" type="text" name="tel" id="tel" class="yhgl_input" /></span>
                    <input  type="submit" class="btn2" value="搜索" />
                    </div>                    
                    <div class="clear"></div>                    
                  </div>
                </div>
                <div class="mb15">                    
                    <%
						if (dimengSession.isAccessableResource(AddSalesman.class)) {
					%> 
						 <a href="<%=controller.getURI(request, AddSalesman.class) %>" class="btn3 mr10"><span class="ico3"></span>新建</a>
					<%} else {%>
						<span class="btn3 mr10 btn5"><span class="ico1"></span>新建</span>
					<%} %>
                    <a href="<%=controller.getURI(request, ExportYwy.class) %>" class="btn3 mr10"><span class="ico"></span>导出</a>                    
                    <div class="clear"></div>
                </div>
                <div>
                <table width="100%" border="0" cellspacing="0" cellpadding="3" class="yhgl_table tc">
                        <tr class="hsbg">
                          <td>序号</td>
                          <td>业务ID</td>
                          <td>业务员姓名</td>
                          <td>业务员手机号</td>
                          <td>操作</td>
                        </tr>
                         <% 
                         Salesman[] lists = result.getItems(); 
				            if(lists != null && lists.length >0 ){
				            	int index = 1;
				            	for(Salesman info : lists){
				            		if(info == null){
				            			continue;
				            		}
			            %>
                        <tr class="dhsbg">
                          <td><%=index++ %></td>
                          <td><%StringHelper.filterHTML(out, info.ywyId);  %></td>
                          <td><%StringHelper.filterHTML(out, info.name); %></td>
                          <td><%StringHelper.filterHTML(out, info.tel); %></td>
                          <td>
                          <%if (dimengSession.isAccessableResource(UpdateSalesman.class)) {%>
                          <a href="<%=controller.getURI(request, UpdateSalesman.class)%>?ywyId=<%=info.ywyId%>" class="blue">修改</a>
                          <%}else{ %>
                          	修改
                          <%} %>
                          <%if (dimengSession.isAccessableResource(Statistics.class)) {%>
                          	<span class="blue"><a href="<%=controller.getURI(request, Statistics.class)%>?ywyId=<%=info.ywyId%>" class="blue ml30">查看推荐统计</a></span>
                          	<%}else{ %>
                          	<span class="disabled">查看推荐统计</span>
                          	<%} %>
                          </td>
                        </tr>
                        <%}} %>
                      </table>
            </div>
                <div class="page">
                      <% 
                      AbstractSpreadServlet.rendPagingResult(out, result);
			          %>
                </div>  
              <div class="box2 clearfix"></div>
            </div>
        </div> 
        </form>  
    </div>
    <%@include file="/WEB-INF/include/left.jsp"%>
    </div></div>
<%@include file="/WEB-INF/include/footer.jsp"%>
<%@include file="/WEB-INF/include/script.jsp"%>
</body>
</html>