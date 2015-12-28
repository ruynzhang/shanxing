<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.console.servlets.base.bfjlx.TyBfjlx"%>
<%@page import="com.dimeng.p2p.console.servlets.base.bfjlx.QyBfjlx"%>
<%@page import="com.dimeng.p2p.console.servlets.base.bfjlx.ViewBfjlx"%>
<%@page import="com.dimeng.p2p.console.servlets.base.bfjlx.AddBfjlx"%>
<%@page import="com.dimeng.p2p.S62.enums.T6212_F04"%>
<%@page import="com.dimeng.p2p.S62.entities.T6212"%>
<%@page import="com.dimeng.p2p.console.servlets.AbstractConsoleServlet"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
<%
	CURRENT_CATEGORY="JCXXGL";
	CURRENT_SUB_CATEGORY="BFJLX";
	PagingResult<T6212> result = (PagingResult<T6212>)request.getAttribute("result");
	T6212[] entityArray = result.getItems();
%>
<%@include file="/WEB-INF/include/header.jsp"%>
<div class="w_main">
  <div class="main clearfix">
    <div class="wrap">
      <div class="r_main">
        <div class="home_main">
          <div class="box box1 mb15">
            <div class="atil">
              <h3>标附件类型管理</h3>
            </div>
          </div>
          <form id="form1" action="<%=controller.getURI(request, BfjlxList.class)%>" method="post">
          <div class="box box1 mb15">
            <div class="con">
                <div class="admin_input admin_pb">
                    <p>类型名称：<input type="text" name="f02" class="yhgl_input" value="<%StringHelper.filterHTML(out, request.getParameter("f02"));%>"/></p>
                    <p>状态：
						<select name="f04" class="yhgl_sel">
	                    	<option value="">全部</option>
	                    	<%
                        	for (T6212_F04 t6212_F04 : T6212_F04.values()) {
                        	%>
							<option value="<%=t6212_F04.name()%>" <%if (t6212_F04.name().equals(request.getParameter("f04"))) {%> selected="selected" <%}%>><%=t6212_F04.getChineseName()%></option>
							<%
							}
							%>
	                    </select>
					</p>
                    <p><input name="input" type="submit" class="btn2" value="搜索" /></p>
                    <p>
                    <%if (dimengSession.isAccessableResource(AddBfjlx.class)) {%>
                    	<a href="javascript:void(0)" name="input" onclick="window.location.href='<%=controller.getURI(request, AddBfjlx.class)%>'" class="btn3 "><span class="ico1"></span>新增</a>
                    <%}else{%>
                    	<span class="btn3 mr10 btn5"><span class="ico1"></span>新增</span>
                    <%} %>
                    </p>
              	</div>
              <div class="clear"></div>
            </div>
          </div>
          
          <div class="newsbox">
	          <table width="100%" border="0" cellspacing="0" cellpadding="3" class="yhgl_table tc">
	            <tr class="hsbg">
	              <td>序号</td>
	              <td>类型名称</td>
	              <td>显示顺序</td>
	              <td>状态</td>
	              <td>操作</td>
	            </tr>
	            <%
	            if (entityArray != null) {for (int i =0;i<entityArray.length;i++){T6212 t6212=entityArray[i];if (t6212 == null) {continue;}
	            %>
	            <tr class="dhsbg">
	              <td><%=i+1%></td>
	              <td><%StringHelper.filterHTML(out, t6212.F02);%></td>
	              <td><%=t6212.F03%></td>
	              <td><%=t6212.F04.getChineseName()%></td>
	              <td>
	             	<%if (dimengSession.isAccessableResource(ViewBfjlx.class)) {%>
	              	<span class="blue"><a href="<%=controller.getURI(request,ViewBfjlx.class)%>?id=<%=t6212.F01%>">修改</a></span>
	              	<%}else{ %>
                   	<span class="disabled">修改</span>
                   	<%} %>
                   	<%if(t6212.F04 ==  T6212_F04.TY){ %>
	                   	<%if (dimengSession.isAccessableResource(QyBfjlx.class)) {%>
		              	<span class="blue"><a href="<%=controller.getURI(request,QyBfjlx.class)%>?id=<%=t6212.F01%>">启用</a></span>
		              	<%}else{ %>
	                   	<span class="disabled">启用</span>
	                   	<%} %>
                   	<%}else{ %>
	                   	<%if (dimengSession.isAccessableResource(TyBfjlx.class)) {%>
		              	<span class="blue"><a href="<%=controller.getURI(request,TyBfjlx.class)%>?id=<%=t6212.F01%>">停用</a></span>
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