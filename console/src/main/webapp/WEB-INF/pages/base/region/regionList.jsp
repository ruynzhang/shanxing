<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.console.servlets.base.region.DisableAll"%>
<%@page import="com.dimeng.p2p.console.servlets.base.region.EnableAll"%>
<%@page import="com.dimeng.p2p.S50.enums.T5019_F11"%>
<%@page import="com.dimeng.p2p.S50.enums.T5019_F13"%>
<%@page import="com.dimeng.p2p.console.servlets.base.region.Disable"%>
<%@page import="com.dimeng.p2p.console.servlets.base.region.Enable"%>
<%@page import="com.dimeng.p2p.S50.entities.T5019"%>
<%@page import="com.dimeng.p2p.console.servlets.AbstractConsoleServlet"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
<%
	CURRENT_CATEGORY="JCXXGL";
	CURRENT_SUB_CATEGORY="QYGL";
	PagingResult<T5019> result = (PagingResult<T5019>)request.getAttribute("result");
	T5019[] entityArray = result.getItems();
%>
<%@include file="/WEB-INF/include/header.jsp"%>
<div class="w_main">
  <div class="main clearfix">
    <div class="wrap">
      <div class="r_main">
        <div class="home_main">
          <div class="box box1 mb15">
            <div class="atil">
              <h3>区域管理</h3>
            </div>
          </div>
          <form id="form1" action="<%=controller.getURI(request, RegionList.class)%>" method="post">
          <div class="box box1 mb15">
            <div class="con">
                <div class="admin_input admin_pb">
                    <p>名称：<input type="text" name="name" class="yhgl_input" value="<%StringHelper.filterHTML(out, request.getParameter("name"));%>"/></p>
                     <p>类型：
						<select name="type" class="yhgl_sel">
	                    	<option value="">全部</option>
	                    	<%
                        	for (T5019_F11 type : T5019_F11.values()) {
                        	%>
							<option value="<%=type.name()%>" <%if (type.name().equals(request.getParameter("type"))) {%> selected="selected" <%}%>><%=type.getChineseName()%></option>
							<%
							}
							%>
	                    </select>
					</p>
                    <p>状态：
						<select name="status" class="yhgl_sel">
	                    	<option value="">全部</option>
	                    	<%
                        	for (T5019_F13 status : T5019_F13.values()) {
                        	%>
							<option value="<%=status.name()%>" <%if (status.name().equals(request.getParameter("status"))) {%> selected="selected" <%}%>><%=status.getChineseName()%></option>
							<%
							}
							%>
	                    </select>
					</p>
					<div class="clear"></div>
                     <div class="mt10">
                    	<input name="input" type="submit" class="btn2 mr10" value="搜索" />
                    		<%if (dimengSession.isAccessableResource(EnableAll.class)) {%>
                    	<a href="<%=controller.getURI(request, EnableAll.class)%>" class="btn3 mr10">&nbsp;&nbsp;全部启用</a>
                    	<%} %>
                    	<%if (dimengSession.isAccessableResource(DisableAll.class)) {%>
                    	<a href="<%=controller.getURI(request, DisableAll.class)%>" class="btn3">&nbsp;&nbsp;全部停用</a>
                    	<%} %>
                    </div>
              	</div>
              <div class="clear"></div>
            </div>
          </div>
          
          <div class="newsbox">
	          <table width="100%" border="0" cellspacing="0" cellpadding="3" class="yhgl_table tc">
	            <tr class="hsbg">
	              <td>序号</td>
	              <td>名称</td>
	              <td>省级名称</td>
	              <td>市级名称</td>
	              <td>县级名称</td>
	              <td>电话区号</td>
	              <td>级别</td>
	              <td>状态</td>
	              <td>操作</td>
	            </tr>
	            <%
	            if (entityArray != null) {for (int i =0;i<entityArray.length;i++){T5019 t5019=entityArray[i];if (t5019 == null) {continue;}
	            %>
	            <tr class="dhsbg">
	              <td><%=i+1%></td>
	              <td><%StringHelper.filterHTML(out, t5019.F05);%></td>
	              <td><%StringHelper.filterHTML(out,t5019.F06);%></td>
	              <td><%StringHelper.filterHTML(out,t5019.F07);%></td>
	              <td><%StringHelper.filterHTML(out,t5019.F08);%></td>
	              <td><%=t5019.F09%></td>
	              <td><%=t5019.F11.getChineseName() %></td>
	              <td><%=t5019.F13.getChineseName() %></td>
	              <td>
                   	<%if(t5019.F13 ==  T5019_F13.TY){ %>
	                   	<%if (dimengSession.isAccessableResource(Enable.class)) {%>
		              	<span class="blue"><a href="<%=controller.getURI(request,Enable.class)%>?id=<%=t5019.F01%>&paging.current=<%=result.getCurrentPage()%>">启用</a></span>
		              	<%}else{ %>
	                   	<span class="disabled">启用</span>
	                   	<%} %>
                   	<%}else{ %>
	                   	<%if (dimengSession.isAccessableResource(Disable.class)) {%>
		              	<span class="blue"><a href="<%=controller.getURI(request,Disable.class)%>?id=<%=t5019.F01%>&paging.current=<%=result.getCurrentPage()%>">停用</a></span>
		              	<%}else{ %>
	                   	<span class="disabled">停用</span>
	                   	<%} %>
	                 <%} %>
	              </td>
	            </tr>
	            <%
	            	}}
	            %>
	          </table>
          <%
          	AbstractConsoleServlet.rendPagingResult(out, result);
          %>
			<div class="clear"></div>
          </div>
          </form>
          <div class="box2 clearfix"></div>
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