<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.S71.entities.T7110"%>
<%@page import="com.dimeng.p2p.modules.account.console.service.GrManage"%>
<%@page import="com.dimeng.p2p.console.servlets.account.grxx.Szkhjl"%>
<%@page import="com.dimeng.p2p.modules.account.console.service.entity.Grxx"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%
	CURRENT_CATEGORY="YHGL";
	CURRENT_SUB_CATEGORY="GRXX";
	Grxx user = ObjectHelper.convert(request.getAttribute("user"), Grxx.class);
	GrManage manage = serviceSession.getService(GrManage.class);
	%>
	<%@include file="/WEB-INF/include/header.jsp"%>
<div class="w_main">
<div class="main clearfix">
    <div class="wrap">
        <div class="r_main">
            <div class="home_main">
            	<div class="box box1 mb15">
                	<div class="atil">
                    	<h3>设置客户经理</h3>
                    </div>
                 </div>
                  <div class="border p30 Men_bt no_table">
                    <form action="<%=controller.getURI(request, Szkhjl.class)%>" method="post" class="form1">
                    <ul class="cell noborder no_wi">
                    <li>
                        <div class="til"><span class="red">*</span> 用户Id：</div>
                        <div class="info"><%=user.id %></div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red">*</span> 用户名：</div>
                        <div class="info"><%StringHelper.filterHTML(out, user.userName);%></div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red">*</span> 姓   名：</div>
                        <div class="info"><%StringHelper.filterHTML(out, user.name);%></div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red">*</span> 手机号：</div>
                        <div class="info"><%StringHelper.filterHTML(out, user.phone);%></div>
                        <div class="clear"></div>
                    </li>
                   <li>
                        <div class="til"><span class="red">*</span> 邮箱：</div>
                        <div class="info"><%StringHelper.filterHTML(out, user.email);%></div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red">*</span>客户经理：</div>
                        <div class="info">
                        	<input name="name" maxlength="18" type="text" class="text yhgl_ser required" value="<%StringHelper.filterHTML(out, request.getParameter("name"));%>" />
                        	<select id="kfjl">
                        		<option value="">全部</option>
                        		<%T7110[] t = manage.getKfjl();
                        			if(t != null){
                        				for(T7110 entity :t){
                        		%>
                        		<option value="<%StringHelper.filterHTML(out, entity.F02); %>"><%StringHelper.filterHTML(out, entity.F02); %></option>
                        		<%}} %>
                        	</select>
                     		<p tip></p>
							<p errortip class="" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                      <div class="info"><input name="userId" type="hidden" value="<%=user.id%>"/></div>
                    </li> 
                    <li>
                      <div class="clear"></div>
                    </li>         
                    </ul>
                    <div class="tc w220">
                    	<input type="submit" class="btn4 mr30 sumbitForme" value="确认" fromname="form1" />
                    	<input type="button" class="btn4" onclick="window.location.href='<%=controller.getURI(request, GrList.class)%>'" value="返回" /></div>
                    <div class="clear"></div>
                    </form>                  
                    </div>
            	<div class="mb15"></div>
                <div class="box2 clearfix"></div>
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
	<script type="text/javascript">
		$("#kfjl").change(function(){
			$("input[name='name']").val($("#kfjl").val());
		});	
	</script>
</body>
</html>