<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.console.servlets.AbstractConsoleServlet"%>
<%@page import="com.dimeng.p2p.console.servlets.base.xymb.UpdateXymb"%>
<%@page import="com.dimeng.p2p.S51.entities.T5125"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
<%
	CURRENT_CATEGORY="JCXXGL";
	CURRENT_SUB_CATEGORY="XYMBSZ";
	PagingResult<T5125> result = (PagingResult<T5125>)request.getAttribute("result");
	T5125[] entityArray = result.getItems();
%>
<%@include file="/WEB-INF/include/header.jsp"%>
<div class="w_main">
  <div class="main clearfix">
    <div class="wrap">
      <div class="r_main">
        <div class="home_main">
          <div class="box box1 mb15">
            <div class="atil">
              <h3>协议模板管理</h3>
            </div>
          </div>
          <form id="form1" action="<%=controller.getURI(request, XydjList.class)%>" method="post">
          <div class="newsbox">
	          <table width="100%" border="0" cellspacing="0" cellpadding="3" class="yhgl_table tc">
	            <tr class="hsbg">
	              <td>序号</td>
	              <td>协议类型编号</td>
	              <td>协议版本号</td>
	              <td>协议类型名称</td>
	              <td>最后更新时间</td>
	              <td>操作</td>
	            </tr>
	            <%
	            if (entityArray != null) {for (int i =0;i<entityArray.length;i++){T5125 t5125=entityArray[i];if (t5125 == null) {continue;}
	            %>
	            <tr class="dhsbg">
	              <td><%=i+1%></td>
	              <td><%=t5125.F01%></td>
	              <td><%=t5125.F02%></td>
	              <td><%StringHelper.filterHTML(out, t5125.F03);%></td>
	              <td><%=DateTimeParser.format(t5125.F04)%></td>
	              <td>
	             	<%if (dimengSession.isAccessableResource(UpdateXymb.class)) {%>
	              	<span class="blue"><a href="<%=controller.getURI(request,UpdateXymb.class)%>?id=<%=t5125.F01%>&version=<%=t5125.F02%>">修改</a></span>
	              	<%}else{ %>
                   	<span class="disabled">修改</span>
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