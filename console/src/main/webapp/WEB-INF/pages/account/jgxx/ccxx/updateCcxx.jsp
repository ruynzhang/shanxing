<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.console.servlets.account.jgxx.UpdateJgxx"%>
<%@page import="com.dimeng.p2p.console.servlets.account.jgxx.cwzk.UpdateCwzk"%>
<%@page import="com.dimeng.p2p.console.servlets.account.jgxx.ccxx.ListCcxx"%>
<%@page import="com.dimeng.p2p.console.servlets.account.jgxx.ccxx.UpdateCcxx"%>
<%@page import="com.dimeng.p2p.console.servlets.account.jgxx.fcxx.ListFcxx"%>
<%@page import="com.dimeng.p2p.console.servlets.account.jgxx.lxxx.UpdateLxxx"%>
<%@page import="com.dimeng.p2p.console.servlets.account.jgxx.jscl.UpdateJscl"%>
<%@page import="com.dimeng.p2p.S61.entities.T6113"%>
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
	T6113 entity = ObjectHelper.convert(request.getAttribute("info"),T6113.class );
	%>
	<%@include file="/WEB-INF/include/header.jsp"%>
<div class="w_main">
<div class="main clearfix">
    <div class="wrap">
        <div class="r_main">
            <div class="home_main">
            	<div class="box box1 mb15">
                	<div class="atil">
                    	<h3>修改机构信息</h3>
                    </div>
                 </div>
                <div class="newsbox">
                <div class="til clearfix">
					<div class="Menubox">
						<ul>
						<li><a href="<%=controller.getURI(request, UpdateJgxx.class)%>?id=<%StringHelper.filterHTML(out, request.getParameter("userId"));%>">机构信息</a></li>
						<li><a href="<%=controller.getURI(request, UpdateJscl.class)%>?id=<%StringHelper.filterHTML(out, request.getParameter("userId"));%>">介绍资料</a></li>
						<li><a href="<%=controller.getURI(request, UpdateCwzk.class)%>?id=<%StringHelper.filterHTML(out, request.getParameter("userId"));%>">财务状况</a></li>
						<li><a href="<%=controller.getURI(request, UpdateLxxx.class)%>?id=<%StringHelper.filterHTML(out, request.getParameter("userId"));%>">联系信息</a></li>
						<li  class="hover">车产信息</li>
						<li><a href="<%=controller.getURI(request, ListFcxx.class)%>?id=<%StringHelper.filterHTML(out, request.getParameter("userId"));%>">房产信息</a></li>
						</ul>
					</div>
				</div>
                  <div class="border p30 Men_bt no_table">
                    <form action="<%=controller.getURI(request, UpdateCcxx.class)%>?id=<%StringHelper.filterHTML(out, request.getParameter("userId"));%>&paging.current=<%=request.getParameter("paging.current") %>" method="post" class="form1">
                    <ul class="cell noborder no_wi">
                    <li>
                        <div class="til"><span class="red">*</span>汽车品牌：</div>
                        <div class="info">
                       		 <input name="F03" maxlength="20" type="text" class="text yhgl_ser required" value="<%StringHelper.filterHTML(out, entity.F03); %>" />
                        	<p tip></p>
							<p errortip class="" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                   <li>
                        <div class="til"><span class="red">*</span>车牌号码：</div>
                        <div class="info">
                        		<input name="F04" maxlength="20" type="text" class="text yhgl_ser required" value="<%StringHelper.filterHTML(out, entity.F04); %>" />
                        	<p tip></p>
							<p errortip class="" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                     <li>
                        <div class="til"><span class="red">*</span>购车年份：</div>
                        <div class="info">
                        		<input name="F05" maxlength="20" type="text" class="text yhgl_ser required isint" value="<%=entity.F05 %>" />年
                        	<p tip></p>
							<p errortip class="" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                     <li>
                        <div class="til"><span class="red">*</span>购买价格：</div>
                        <div class="info">
                        	<input name="F06" type="text" class="text yhgl_ser"  maxlength="15" mtest="/^((([1-9][0-9]*)|0)|((([1-9][0-9]*)|0)\.[0-9]{1,2}))$/" mtestmsg="必须为数字格式(且是两位小数)" value="<%=entity.F06 %>" />万元
                        	<p tip></p>
							<p errortip class="" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red">*</span>评估价格：</div>
                        <div class="info">
                        	<input name="F07" maxlength="15" mtest="/^((([1-9][0-9]*)|0)|((([1-9][0-9]*)|0)\.[0-9]{1,2}))$/" mtestmsg="必须为数字格式(且是两位小数)" type="text" class="text yhgl_ser" value="<%=entity.F07 %>" />万元
                        	<p tip></p>
							<p errortip class="" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                      <div class="info"><input type="hidden" name="F01" value="<%=entity.F01 %>"/></div>
                    </li> 
                    <li>
                      <div class="clear"></div>
                    </li>         
                    </ul>
                    <div class="tc w220">
                    	<input type="submit" class="btn4 mr30 sumbitForme" value="确认" fromname="form1" />
                    	<input type="button" class="btn4" onclick="window.location.href='<%=controller.getURI(request, ListCcxx.class)%>?id=<%StringHelper.filterHTML(out, request.getParameter("userId"));%>&paging.current=<%=request.getParameter("paging.current") %>'" value="返回" /></div>
                    <div class="clear"></div>
                    </form>                  
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