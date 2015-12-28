<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.console.servlets.AbstractConsoleServlet"%>
<%@page import="com.dimeng.p2p.console.servlets.base.blx.TyBlx"%>
<%@page import="com.dimeng.p2p.console.servlets.base.blx.QyBlx"%>
<%@page import="com.dimeng.p2p.console.servlets.base.blx.ViewBlx"%>
<%@page import="com.dimeng.p2p.console.servlets.base.blx.AddBlx"%>
<%@page import="com.dimeng.p2p.S62.enums.T6211_F03"%>
<%@page import="com.dimeng.p2p.S62.entities.T6211"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
<%
	CURRENT_CATEGORY="JCXXGL";
	CURRENT_SUB_CATEGORY="BLX";
	PagingResult<T6211> result = (PagingResult<T6211>)request.getAttribute("result");
	T6211[] entityArray = result.getItems();
%>
<%@include file="/WEB-INF/include/header.jsp"%>
<div class="w_main">
  <div class="main clearfix">
    <div class="wrap">
      <div class="r_main">
        <div class="home_main">
          <div class="box box1 mb15">
            <div class="atil">
              <h3>标类型管理</h3>
            </div>
          </div>
          <form id="form1" action="<%=controller.getURI(request, BlxList.class)%>" method="post">
          <div class="box box1 mb15">
            <div class="con">
                <div class="admin_input admin_pb">
                    <p>类型名称：<input type="text" name="f02" class="yhgl_input" value="<%StringHelper.filterHTML(out, request.getParameter("f02"));%>"/></p>
                    <p>状态：
						<select name="f03" class="yhgl_sel">
	                    	<option value="">全部</option>
	                    	<%
                        	for (T6211_F03 t6211_F03 : T6211_F03.values()) {
                        	%>
							<option value="<%=t6211_F03.name()%>" <%if (t6211_F03.name().equals(request.getParameter("f03"))) {%> selected="selected" <%}%>><%=t6211_F03.getChineseName()%></option>
							<%
							}
							%>
	                    </select>
					</p>
                    <p><input name="input" type="submit" class="btn2" value="搜索" /></p>
                    <p>
                    <%if (dimengSession.isAccessableResource(AddBlx.class)) {%>
                    	<a href="javascript:void(0)" name="input" onclick="window.location.href='<%=controller.getURI(request, AddBlx.class)%>'" class="btn3 "><span class="ico1"></span>新增</a>
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
	              <td>状态</td>
	              <td>操作</td>
	            </tr>
	            <%
	            if (entityArray != null) {for (int i =0;i<entityArray.length;i++){T6211 t6211=entityArray[i];if (t6211 == null) {continue;}
	            %>
	            <tr class="dhsbg">
	              <td><%=i+1%></td>
	              <td><%StringHelper.filterHTML(out, t6211.F02);%></td>
	              <td><%=t6211.F03.getChineseName()%></td>
	              <td>
	             	<%if (dimengSession.isAccessableResource(ViewBlx.class)) {%>
	              	<span class="blue"><a href="<%=controller.getURI(request,ViewBlx.class)%>?id=<%=t6211.F01%>">修改</a></span>
	              	<%}else{ %>
                   	<span class="disabled">修改</span>
                   	<%} %>
                   	<%if(t6211.F03 ==  T6211_F03.TY){ %>
	                   	<%if (dimengSession.isAccessableResource(QyBlx.class)) {%>
		              	<span class="blue"><a href="<%=controller.getURI(request,QyBlx.class)%>?id=<%=t6211.F01%>">启用</a></span>
		              	<%}else{ %>
	                   	<span class="disabled">启用</span>
	                   	<%} %>
                   	<%}else{ %>
	                   	<%if (dimengSession.isAccessableResource(TyBlx.class)) {%>
		              	<span class="blue"><a href="<%=controller.getURI(request,TyBlx.class)%>?id=<%=t6211.F01%>">停用</a></span>
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