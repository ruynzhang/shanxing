<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.console.servlets.account.qyxx.UpdateQyxx"%>
<%@page import="com.dimeng.p2p.console.servlets.account.qyxx.dgzh.UpdateDgzh"%>
<%@page import="com.dimeng.p2p.console.servlets.account.qyxx.cwzk.UpdateCwzk"%>
<%@page import="com.dimeng.p2p.console.servlets.account.qyxx.ccxx.ListCcxx"%>
<%@page import="com.dimeng.p2p.console.servlets.account.qyxx.fcxx.ListFcxx"%>
<%@page import="com.dimeng.p2p.console.servlets.account.qyxx.lxxx.UpdateLxxx"%>
<%@page import="com.dimeng.p2p.console.servlets.account.qyxx.jscl.UpdateJscl"%>
<%@page import="com.dimeng.p2p.modules.account.console.service.QyManage"%>
<%@page import="com.dimeng.p2p.S61.entities.T6112"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%
	CURRENT_CATEGORY="YHGL";
	CURRENT_SUB_CATEGORY="QY";
	QyManage manage = serviceSession.getService(QyManage.class);
	T6112 info = ObjectHelper.convert(request.getAttribute("info"), T6112.class);
	%>
	<%@include file="/WEB-INF/include/header.jsp"%>
<div class="w_main">
<div class="main clearfix">
    <div class="wrap">
        <div class="r_main">
            <div class="home_main">
            	<div class="box box1 mb15">
                	<div class="atil">
                    	<h3>修改企业信息</h3>
                    </div>
                 </div>
                  <div class="newsbox">
                   <div class="til clearfix">
					<div class="Menubox">
						<ul>
						<li><a href="<%=controller.getURI(request, UpdateQyxx.class)%>?id=<%StringHelper.filterHTML(out, request.getParameter("userId"));%>">企业信息</a></li>
						<li><a href="<%=controller.getURI(request, UpdateJscl.class)%>?id=<%StringHelper.filterHTML(out, request.getParameter("userId"));%>">介绍资料</a></li>
						<li><a href="<%=controller.getURI(request, UpdateCwzk.class)%>?id=<%StringHelper.filterHTML(out, request.getParameter("userId"));%>">财务状况</a></li>
						<li><a href="<%=controller.getURI(request, UpdateLxxx.class)%>?id=<%StringHelper.filterHTML(out, request.getParameter("userId"));%>">联系信息</a></li>
						<li><a href="<%=controller.getURI(request, ListCcxx.class)%>?id=<%StringHelper.filterHTML(out, request.getParameter("userId"));%>">车产信息</a></li>
						<li class="hover">房产信息</li>
						<%--
						<li><a href="<%=controller.getURI(request, UpdateDgzh.class)%>?id=<%StringHelper.filterHTML(out, request.getParameter("userId"));%>">对公账户</a></li>
						 --%>
						</ul>
					</div>
				</div>
                  <div class="border p30 Men_bt no_table">
                    <ul class="cell noborder no_wi">
                    <li>
                        <div class="til"><span class="red">*</span>小区名称：</div>
                        <div class="info"><%StringHelper.filterHTML(out, info.F03);%></div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red">*</span>建筑面积：</div>
                        <div class="info"><%=info.F04 %>平方米</div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red">*</span>使用年限：</div>
                        <div class="info"><%=info.F05%>年</div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red">*</span>购买价格：</div>
                        <div class="info"><%=info.F06%>万元</div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red">*</span>评估价格：</div>
                        <div class="info"><%=info.F07%>万元</div>
                        <div class="clear"></div>
                    </li>
                   <li>
                        <div class="til"><span class="red">*</span>区域：</div>
                        <div class="info"><%StringHelper.filterHTML(out, manage.getRegion(info.F08));%></div>
                        <div class="clear"></div>
                    </li>
                     <li>
                        <div class="til"><span class="red">*</span>地址：</div>
                        <div class="info"><%StringHelper.filterHTML(out, info.F09);%></div>
                        <div class="clear"></div>
                    </li>
                     <li>
                        <div class="til"><span class="red">*</span>房产证编号：</div>
                        <div class="info"><%StringHelper.filterHTML(out, info.F10);%></div>
                        <div class="clear"></div>
                    </li>
                     <li>
                        <div class="til"><span class="red">*</span>参考价格：</div>
                        <div class="info"><%=info.F11%>万元</div>
                        <div class="clear"></div>
                    </li>
                    <li>
                      <div class="info"></div>
                    </li> 
                    <li>
                      <div class="clear"></div>
                    </li>         
                    </ul>
                    <div class="tc w220">
                    	<input type="button" class="btn4" onclick="window.location.href='<%=controller.getURI(request, ListFcxx.class)%>?id=<%StringHelper.filterHTML(out, request.getParameter("userId"));%>'" value="返回" /></div>
                    <div class="clear"></div>
                    </div>
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