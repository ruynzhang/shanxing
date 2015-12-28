<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.console.servlets.account.jgxx.ViewJgxx"%>
<%@page import="com.dimeng.p2p.console.servlets.account.jgxx.ccxx.ListCcxx"%>
<%@page import="com.dimeng.p2p.console.servlets.account.jgxx.jscl.ViewJscl"%>
<%@page import="com.dimeng.p2p.console.servlets.account.jgxx.cwzk.ViewCwzk"%>
<%@page import="com.dimeng.p2p.console.servlets.account.jgxx.lxxx.ViewLxxx"%>
<%@page import="com.dimeng.p2p.console.servlets.account.jgxx.ccxx.ViewListCcxx"%>
<%@page import="com.dimeng.p2p.S61.entities.T6112"%>
<%@page import="com.dimeng.p2p.S61.entities.T6162"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%
	CURRENT_CATEGORY="YHGL";
	CURRENT_SUB_CATEGORY="JG";
	PagingResult<T6112> result = ObjectHelper.convert(request.getAttribute("result"), PagingResult.class);
	%>
	<%@include file="/WEB-INF/include/header.jsp"%>
<div class="w_main">
<div class="main clearfix">
    <div class="wrap">
        <div class="r_main">
            <div class="home_main">
            	<div class="box box1 mb15">
                	<div class="atil">
                    	<h3>机构信息</h3>
                    </div>
                 </div>
                <div class="newsbox">
                <div class="til clearfix">
					<div class="Menubox">
						<ul>
						<li><a href="<%=controller.getURI(request, ViewJgxx.class)%>?id=<%StringHelper.filterHTML(out, request.getParameter("id"));%>">机构信息</a></li>
						<li><a href="<%=controller.getURI(request, ViewJscl.class)%>?id=<%StringHelper.filterHTML(out, request.getParameter("id"));%>">介绍资料</a></li>
						<li><a href="<%=controller.getURI(request, ViewCwzk.class)%>?id=<%StringHelper.filterHTML(out, request.getParameter("id"));%>">财务状况</a></li>
						<li><a href="<%=controller.getURI(request, ViewLxxx.class)%>?id=<%StringHelper.filterHTML(out, request.getParameter("id"));%>">联系信息</a></li>
						<li><a href="<%=controller.getURI(request, ViewListCcxx.class)%>?id=<%StringHelper.filterHTML(out, request.getParameter("id"));%>">车产信息</a></li>
						<li class="hover">房产信息</li>
						</ul>
					</div>
				</div>
				<form action="">
				<input type="hidden" id="id" name="id" value="<%=request.getParameter("id")%>">
                  <div class="border p30 Men_bt no_table">
                <table width="100%" border="0" cellspacing="0" cellpadding="3" class="yhgl_table">
	            <tr class="hsbg">
	              <td align="center">序号</td>
	              <td align="center">小区名称</td>
	              <td align="center">建筑面积</td>
	              <td align="center">购买价格</td>
	              <td align="center">地址</td>
	              <td align="center">房产证编号</td>
	            </tr>
	            <%
	            T6112[] t = result.getItems();
	            if(t != null){ 
	            	int index = 1;
	            	for(T6112 entity :t){
	            %>
	            <tr class="dhsbg">
	              <td align="center"><%=index++ %></td>
	              <td align="center"><%StringHelper.filterHTML(out, entity.F03); %></td>
	              <td align="center"><%=entity.F04 %>平方米</td>
	              <td align="center"><%=entity.F06 %>万元</td>
	              <td align="center"><%StringHelper.filterHTML(out, entity.F09); %></td>
	              <td align="center"><%StringHelper.filterHTML(out, entity.F10); %></td>
	            </tr>
	            <%}} %>
	          </table>
	          <%ListCcxx.rendPagingResult(out, result); %>
                    </div>
                    </form>
            	<div class="mb15"></div>
                <div class="box2 clearfix"></div>
            </div>
            </div>
        </div>   
    </div>
	<%
		String warringMessage=controller.getPrompt(request, response, PromptLevel.ERROR);
		if(!StringHelper.isEmpty(warringMessage))
		{
	%>
	<div class="w440 thickbox thickpos" style="margin:-80px 0 0 -220px;" id="showDiv">
      <div class="info clearfix">
        <div class="clearfix">
            <span class="fl tips"><%StringHelper.filterHTML(out, warringMessage); %></span>
        </div>
        <div class="dialog_btn"><input type="button" name="button2" onclick="$('#showDiv').hide()" value="确认"  class="btn4 ml50"/></div> 
      </div>
	</div>
	<%} %>
	<%@include file="/WEB-INF/include/left.jsp"%>
</div>
</div>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
	<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/validation.js"></script>
</body>
</html>