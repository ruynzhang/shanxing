<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.console.servlets.base.xydj.TyXydj"%>
<%@page import="com.dimeng.p2p.console.servlets.base.xydj.QyXydj"%>
<%@page import="com.dimeng.p2p.console.servlets.base.xydj.ViewXydj"%>
<%@page import="com.dimeng.p2p.console.servlets.base.xydj.AddXydj"%>
<%@page import="com.dimeng.p2p.console.servlets.AbstractConsoleServlet"%>
<%@page import="com.dimeng.p2p.S51.enums.T5124_F05"%>
<%@page import="com.dimeng.p2p.S51.entities.T5124"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
<%
	CURRENT_CATEGORY="JCXXGL";
	CURRENT_SUB_CATEGORY="XYDJGL";
	PagingResult<T5124> result = (PagingResult<T5124>)request.getAttribute("result");
	T5124[] entityArray = result.getItems();
%>
<%@include file="/WEB-INF/include/header.jsp"%>
<div class="w_main">
  <div class="main clearfix">
    <div class="wrap">
      <div class="r_main">
        <div class="home_main">
          <div class="box box1 mb15">
            <div class="atil">
              <h3>信用等级管理</h3>
            </div>
          </div>
          <form id="form1" action="<%=controller.getURI(request, XydjList.class)%>" method="post">
          <div class="box box1 mb15">
            <div class="con">
                <div class="admin_input admin_pb">
                    <p>等级名称：<input type="text" name="name" class="yhgl_input" value="<%StringHelper.filterHTML(out, request.getParameter("name"));%>"/></p>
                    <p>状态：
						<select name="status" class="yhgl_sel">
	                    	<option value="">全部</option>
	                    	<%
                        	for (T5124_F05 t5124_F05 : T5124_F05.values()) {
                        	%>
							<option value="<%=t5124_F05.name()%>" <%if (t5124_F05.name().equals(request.getParameter("status"))) {%> selected="selected" <%}%>><%=t5124_F05.getChineseName()%></option>
							<%
							}
							%>
	                    </select>
					</p>
					<div class="clear"></div>
                    <div class="mt10">
                  	<input name="input" type="submit" class="btn2 mr10" value="搜索" />
                    <%if (dimengSession.isAccessableResource(AddXydj.class)) {%>
                    	<a href="javascript:void(0)" name="input" onclick="window.location.href='<%=controller.getURI(request, AddXydj.class)%>'" class="btn3 "><span class="ico1"></span>新增</a>
                    <%}else{%>
                    	<span class="btn3 mr10 btn5"><span class="ico1"></span>新增</span>
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
	              <td>等级名称</td>
	              <td>下限分数</td>
	              <td>上限分数</td>
	              <td>状态</td>
	              <td>操作</td>
	            </tr>
	            <%
	            if (entityArray != null) {for (int i =0;i<entityArray.length;i++){T5124 t5124=entityArray[i];if (t5124 == null) {continue;}
	            %>
	            <tr class="dhsbg">
	              <td><%=i+1%></td>
	              <td><%StringHelper.filterHTML(out, t5124.F02);%></td>
	              <td><%=t5124.F03%></td>
	              <td><%=t5124.F04%></td>
	              <td><%=t5124.F05.getChineseName()%></td>
	              <td>
	             	<%if (dimengSession.isAccessableResource(ViewXydj.class)) {%>
	              	<span class="blue"><a href="<%=controller.getURI(request,ViewXydj.class)%>?id=<%=t5124.F01%>">修改</a></span>
	              	<%}else{ %>
                   	<span class="disabled">修改</span>
                   	<%} %>
                   	<%if(t5124.F05 ==  T5124_F05.TY){ %>
	                   	<%if (dimengSession.isAccessableResource(QyXydj.class)) {%>
		              	<span class="blue"><a href="<%=controller.getURI(request,QyXydj.class)%>?id=<%=t5124.F01%>">启用</a></span>
		              	<%}else{ %>
	                   	<span class="disabled">启用</span>
	                   	<%} %>
                   	<%}else{ %>
	                   	<%if (dimengSession.isAccessableResource(TyXydj.class)) {%>
		              	<span class="blue"><a href="<%=controller.getURI(request,TyXydj.class)%>?id=<%=t5124.F01%>">停用</a></span>
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