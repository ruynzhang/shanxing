<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.console.servlets.account.ptgl.ViewPtgl"%>
<%@page import="com.dimeng.p2p.console.servlets.account.ptgl.PtglList"%>
<%@page import="com.dimeng.p2p.S71.entities.T7101"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
<%
	CURRENT_CATEGORY="YHGL";
	CURRENT_SUB_CATEGORY="PT";
	T7101 result = (T7101)request.getAttribute("result");
%>
<%@include file="/WEB-INF/include/header.jsp"%>
<div class="w_main">
  <div class="main clearfix">
    <div class="wrap">
      <div class="r_main">
        <div class="home_main">
          <div class="box box1 mb15">
            <div class="atil">
              <h3>平台管理</h3>
            </div>
          </div>
          <form id="form1" action="<%=controller.getURI(request, PtglList.class)%>" method="post">
          <div class="newsbox">
	          <table width="100%" border="0" cellspacing="0" cellpadding="3" class="yhgl_table tc">
	            <tr class="hsbg">
	              <td>序号</td>
	              <td>前台LOGO文件编码</td>
	              <td>后台登录LOGO文件编码</td>
	              <td>后台首页LOGO文件编码</td>
	              <td>操作</td>
	            </tr>
	            <%
	            if (result != null){
	            %>
	            <tr class="dhsbg">
	              <td>1</td>
	              <td><img src="<%=fileStore.getURL(configureProvider.getProperty(SystemVariable.QTLOGO))%>" width="277" height="89" /></td>
	              <td><img src="<%=fileStore.getURL(configureProvider.getProperty(SystemVariable.HTDLLOGO))%>" width="277" height="89" /></td>
	              <td><img src="<%=fileStore.getURL(configureProvider.getProperty(SystemVariable.HTSYLOGO))%>" width="277" height="89" /></td>
	              <td>
	             	<%if (dimengSession.isAccessableResource(ViewPtgl.class)) {%>
	              	<span class="blue"><a href="<%=controller.getURI(request,ViewPtgl.class)%>?id=<%=result.F01%>">修改</a></span>
	              	<%}else{ %>
                   	<span class="disabled">修改</span>
                   	<%} %>
	              </td>
	            </tr>
	            <%
	            	}
	            %>
	          </table>
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