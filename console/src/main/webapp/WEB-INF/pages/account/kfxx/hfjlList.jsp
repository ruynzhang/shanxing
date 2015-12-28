<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.console.servlets.account.kfxx.HfjlList"%>
<%@page import="com.dimeng.p2p.S71.entities.T7168"%>
<%@page import="com.dimeng.p2p.console.servlets.AbstractConsoleServlet"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
<%
	CURRENT_CATEGORY="YHGL";
	CURRENT_SUB_CATEGORY="KFXX";
	PagingResult<T7168> list = ObjectHelper.convert(request.getAttribute("list"), PagingResult.class);
	T7168[] entitys = list.getItems();
%>
<%@include file="/WEB-INF/include/header.jsp"%>
<div class="w_main">
<div class="main clearfix">
    <div class="wrap">
        <div class="r_main">
            <div class="home_main">
            	<form id="form1" action="<%=controller.getURI(request, HfjlList.class)%>" method="post">
            	<input name="userId" type="hidden" value="<%=request.getParameter("userId")%>">
            	<div class="box box1 mb15">
                	<div class="atil">
                    	<h3>回访记录信息</h3>
                    </div>
                </div>
              	<div>
                <table width="100%" border="0" cellspacing="0" cellpadding="3" class="yhgl_table tc">
                        <tr class="hsbg">
                          <td>序号</td>
                          <td>回访详情</td>
                          <td>回访时间</td>
                          <td>记录时间</td>
                        </tr>
                        <%
                        	if (entitys != null) {
                        		int index = 1;
                        		for (T7168 entity : entitys)
                        		{if (entity == null) {continue;}
                        %>
                        <tr class="dhsbg">
                          <td><%=index++ %></td>
                          <td title="<%StringHelper.filterHTML(out, entity.F03);%>"><%StringHelper.truncation(out,entity.F03, 20);%></td>
                          <td><%=DateTimeParser.format(entity.F04)%></td>
                          <td><%=DateTimeParser.format(entity.F05)%></td>
                        </tr>
                        <%
                        	}}
                        %>
                      </table>
                </div>
                <%HfjlList.rendPagingResult(out, list); %>
                </form>       
            </div>
        </div>   
    </div>
    <%@include file="/WEB-INF/include/left.jsp"%>
</div>
</div>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
</body>
</html>