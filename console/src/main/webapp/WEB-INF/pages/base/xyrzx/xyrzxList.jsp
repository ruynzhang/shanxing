<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.console.servlets.AbstractConsoleServlet"%>
<%@page import="com.dimeng.p2p.console.servlets.base.xyrzx.TyXyrzx"%>
<%@page import="com.dimeng.p2p.console.servlets.base.xyrzx.QyXyrzx"%>
<%@page import="com.dimeng.p2p.console.servlets.base.xyrzx.ViewXyrzx"%>
<%@page import="com.dimeng.p2p.S51.entities.T5123"%>
<%@page import="com.dimeng.p2p.console.servlets.base.xyrzx.AddXyrzx"%>
<%@page import="com.dimeng.p2p.S51.enums.T5123_F04"%>
<%@page import="com.dimeng.p2p.S51.enums.T5123_F03"%>
<%@page import="com.dimeng.p2p.S51.entities.T5123"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
<%
	CURRENT_CATEGORY="JCXXGL";
	CURRENT_SUB_CATEGORY="XYRZX";
	PagingResult<T5123> result = (PagingResult<T5123>)request.getAttribute("result");
	T5123[] entityArray = result.getItems();
%>
<%@include file="/WEB-INF/include/header.jsp"%>
<div class="w_main">
  <div class="main clearfix">
    <div class="wrap">
      <div class="r_main">
        <div class="home_main">
          <div class="box box1 mb15">
            <div class="atil">
              <h3>信用认证项管理</h3>
            </div>
          </div>
          <form id="form1" action="<%=controller.getURI(request, XyrzxList.class)%>" method="post">
          <div class="box box1 mb15">
            <div class="con">
                <div class="admin_input admin_pb">
                    <p>类型名称：<input type="text" name="name" class="yhgl_input" value="<%StringHelper.filterHTML(out, request.getParameter("name"));%>"/></p>
                   	<p>必要认证：
						<select name="type" class="yhgl_sel">
	                    	<option value="">全部</option>
	                    	<%
                        	for (T5123_F03 t5123_F03 : T5123_F03.values()) {
                        	%>
							<option value="<%=t5123_F03.name()%>" <%if (t5123_F03.name().equals(request.getParameter("type"))) {%> selected="selected" <%}%>><%=t5123_F03.getChineseName()%></option>
							<%
							}
							%>
	                    </select>
					</p>
                    <p>状态：
						<select name=status class="yhgl_sel">
	                    	<option value="">全部</option>
	                    	<%
                        	for (T5123_F04 t5123_F04 : T5123_F04.values()) {
                        	%>
							<option value="<%=t5123_F04.name()%>" <%if (t5123_F04.name().equals(request.getParameter("status"))) {%> selected="selected" <%}%>><%=t5123_F04.getChineseName()%></option>
							<%
							}
							%>
	                    </select>
					</p>
					<div class="clear"></div>
                    <div class="mt10">
                    <input name="input" type="submit" class="btn2 mr10" value="搜索" /></p>
                    <%if (dimengSession.isAccessableResource(AddXyrzx.class)) {%>
                    	<a href="javascript:void(0)" name="input" onclick="window.location.href='<%=controller.getURI(request, AddXyrzx.class)%>'" class="btn3 "><span class="ico1"></span>新增</a>
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
	              <td>类型名称</td>
	              <td>必要认证</td>
	              <td>状态</td>
	              <td>最高分数</td>
	              <td>操作</td>
	            </tr>
	            <%
	            if (entityArray != null) {for (int i =0;i<entityArray.length;i++){T5123 t5123=entityArray[i];if (t5123 == null) {continue;}
	            %>
	            <tr class="dhsbg">
	              <td><%=i+1%></td>
	              <td><%StringHelper.filterHTML(out, t5123.F02);%></td>
	              <td><%=t5123.F03.getChineseName()%></td>
	              <td><%=t5123.F04.getChineseName()%></td>
	              <td><%=t5123.F05%></td>
	              <td>
	             	<%if (dimengSession.isAccessableResource(ViewXyrzx.class)) {%>
	              	<span class="blue"><a href="<%=controller.getURI(request,ViewXyrzx.class)%>?id=<%=t5123.F01%>">修改</a></span>
	              	<%}else{ %>
                   	<span class="disabled">修改</span>
                   	<%} %>
                   	<%if(t5123.F04 ==  T5123_F04.TY){ %>
                   	<%if (dimengSession.isAccessableResource(QyXyrzx.class)) {%>
	              	<span class="blue"><a href="<%=controller.getURI(request,QyXyrzx.class)%>?id=<%=t5123.F01%>">启用</a></span>
	              	<%}else{ %>
                   	<span class="disabled">启用</span>
                   	<%} %>
                   	<%}else{ %>
                   	<%if (dimengSession.isAccessableResource(TyXyrzx.class)) {%>
	              	<span class="blue"><a href="<%=controller.getURI(request,TyXyrzx.class)%>?id=<%=t5123.F01%>">停用</a></span>
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