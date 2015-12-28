<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.console.servlets.account.kfxx.AddHfjl"%>
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
	CURRENT_SUB_CATEGORY="KFXX";
	Grxx user = ObjectHelper.convert(request.getAttribute("user"), Grxx.class);
	%>
	<%@include file="/WEB-INF/include/header.jsp"%>
<div class="w_main">
<div class="main clearfix">
    <div class="wrap">
        <div class="r_main">
            <div class="home_main">
            	<div class="box box1 mb15">
                	<div class="atil">
                    	<h3>新增回访记录</h3>
                    </div>
                 </div>
                  <div class="border p30 Men_bt no_table">
                    <form action="<%=controller.getURI(request, AddHfjl.class)%>" method="post" class="form1">
                    <ul class="cell noborder no_wi">
                    <li>
                        <div class="til"><span class="red">*</span> 回访用户：</div>
                        <div class="info"><%StringHelper.filterHTML(out, user.userName);%></div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red">*</span>回访详情：</div>
                        <div class="info fl">
                        	<textarea name="F03" class="yhgl_ser required  max-length-100" cols="100" rows="8" style="width:400px;height:200px;"><%StringHelper.format(out, request.getParameter("content"), fileStore); %></textarea>
                        	 <div class="clear"></div>
                        	<p tip>&nbsp;</p>
							<p errortip class="" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red">*</span>回访时间：</div>
                        <div class="info">
                        	<input type="text" readonly="readonly" id="datepicker1" name="F04" class="text yhgl_ser required" value="<%StringHelper.filterHTML(out, request.getParameter("F04"));%>"/>
                        	<p tip></p>
                        	<p errortip class="" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                      <div class="info"><input name="F02" type="hidden" value="<%=user.id%>"/></div>
                    </li> 
                    <li>
                      <div class="clear"></div>
                    </li>         
                    </ul>
                    <div class="tc w220">
                    	<input type="submit" class="btn4 mr30 sumbitForme" value="确认" fromname="form1" />
                    	<input type="button" class="btn4" onclick="window.location.href='<%=controller.getURI(request, KfList.class)%>'" value="返回" /></div>
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
	<%@include file="/WEB-INF/include/datepicker.jsp"%>
		<script type="text/javascript"
		src="<%=controller.getStaticPath(request)%>/js/jquery-ui-1.10.4/js/time.js"></script>
	<script type="text/javascript">
	$(function() {
		 $('#datepicker1').datetimepicker({
				timeFormat: 'HH:mm:ss',
				dateFormat:'yy-mm-dd'
				});
	});
	</script>
</body>
</html>