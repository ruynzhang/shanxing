<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.console.servlets.finance.xxczgl.AddXxcz"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
<%
	CURRENT_CATEGORY="CWGL";
	CURRENT_SUB_CATEGORY="XXCZGL";
%>
<%@include file="/WEB-INF/include/header.jsp"%>
<div class="w_main">
  <div class="main clearfix">
    <div class="wrap">
        <div class="r_main">
            <div class="home_main">
            	<div class="box box1 mb15">
                	<div class="atil">
                    	<h3>线下充值</h3>
                    </div>
                    <div class="con">
                    <form action="<%=controller.getURI(request, AddXxcz.class)%>" method="post" class="form1">
                    <ul class="cell noborder yxjh ">
                    <li>
                        <div class="til"><span class="red">*</span>用户帐号：</div>
                        <div class="info">
                        	<input name="accountName" type="text" class="yhgl_ser required" value="<%StringHelper.filterHTML(out, request.getParameter("accountName"));%>"/>
                        	<p tip></p>
							<p errortip class="" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red">*</span>充值金额：</div>
                        <div class="info">
                        	<input name="amount" type="text" class="yhgl_ser required minf-size-0" maxlength="18" value="<%StringHelper.filterHTML(out, request.getParameter("amount"));%>" mtest="/^[-\+]?\d+(\.\d+)?$/" mtestmsg="金额格式不正确"/>
                        	<p tip></p>
							<p errortip class="" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red">*</span>备注：</div>
                        <div class="info">
                        	<textarea name=remark cols="" rows="" class="area required max-length-80"><%StringHelper.format(out, request.getParameter("remark"), fileStore); %></textarea>
							<p tip></p>
							<p errortip class="" style="display: none"></p>
                      	</div>
                        <div class="clear"></div>
                    </li>
                    <li>
                      <div class="til">&nbsp;</div>
                      <div class="info">
                      	<p errortip class="">
                      		<%String msg = controller.getPrompt(request, response, PromptLevel.ERROR);
                      			if(msg != null){
                      		%>
                      		<%StringHelper.filterHTML(out, msg);%>
                      		<%} %>
                      	</p>
                      </div>
                      <div class="clear"></div>
                    </li>
                    <li>
                      <div class="clear"></div>
                    </li>                    
               		</ul>
                    <div class="tc w220 pt20">
                    	<input type="submit" class="btn4 mr30 sumbitForme" value="提交" fromname="form1" />
                    	<input type="button" onclick="window.location.href='<%=controller.getURI(request, XxczglList.class)%>'" class="btn4" value="返回" />
                    </div>
                	<div class="clear"></div>
                    </form>
                    <div class="clear"></div>
                    </div>
                </div>
              <div class="box2 clearfix"></div>
            </div>
        </div>   
    </div>
        
	<%@include file="/WEB-INF/include/left.jsp"%>
	</div>
</div>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
	<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/validation.js"></script>
</body>
</html>