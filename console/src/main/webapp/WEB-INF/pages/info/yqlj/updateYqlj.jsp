<%@page import="com.dimeng.p2p.modules.base.console.service.entity.FriendlyLinkRecord"%>
<%@page import="com.dimeng.p2p.modules.base.console.service.FriendlyLinkManage"%>
<%@page import="com.dimeng.p2p.console.servlets.info.yqlj.UpdateYqlj"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html >
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>

<body>
<%
	CURRENT_CATEGORY = "XCGL";
	CURRENT_SUB_CATEGORY = "YQLJ";
%>
<%@include file="/WEB-INF/include/header.jsp"%>
<div class="w_main">
<div class="main clearfix">
	<%
	FriendlyLinkRecord record = ObjectHelper.convert(request.getAttribute("record"), FriendlyLinkRecord.class); 
	%>
    <div class="wrap">
        <div class="r_main">
            <div class="home_main">
            	<div class="box box1 mb15">
                	<div class="atil">
                    	<h3>修改友情链接</h3>
                  </div>
                    <div class="con">
                    <div class="clear"></div>
                    <form name="example" method="post" action="<%=controller.getURI(request, UpdateYqlj.class)%>" class="form1">
                      <input type="hidden" value="<%=record.id %>" name="id"/>
                    <ul class="cell xc_jcxx ">
                    <li>
                        <div class="til"><span class="red">&nbsp;</span></div>
                        <div class="info orange">
                        <%StringHelper.filterHTML(out, controller.getPrompt(request, response, PromptLevel.ERROR));%>
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red">*</span>名称：</div>
                        <div class="info">
                        	<input type="text" class="text yhgl_ser yw_w4 required max-length-30" name="name" value="<%StringHelper.filterHTML(out, record.name);%>"/>
                        	<p tip>最大30个字符</p>
							<p errortip class="" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red">*</span>链接地址：</div>
                        <div class="info orange">
                        	<input type="text" class="text yhgl_ser yw_w4 required" name="url" value="<%StringHelper.filterHTML(out, record.url);%>"/>
                        	<p tip></p>
							<p errortip class="" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red">*</span>排序值：</div>
                        <div class="info orange">
                        	<input type="text" class="text yhgl_ser yw_w4 required isint max-length-10" name="sortIndex" value="<%=record.sortIndex%>"/>
                        	<p tip></p>
							<p errortip class="" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                   	<li>
                        <div class="til"><span class="red">*</span>nofollow：</div>
                        <div class="info orange">
                        	<select name="nofollow" class="text yhgl_ser">
                        		<option value="T" <%="T".equals(record.nofollow)?"selected":"" %>>是</option>
                        		<option value="F" <%="F".equals(record.nofollow)?"selected":"" %>>否</option>
                        	</select>
                        </div>
                        <div class="clear"></div>
                    </li>
                 
               		</ul>
                    <div class="tc w220 pt20">
                    	<input type="submit" class="btn4 mr30 sumbitForme" style="cursor: pointer;" fromname="form1" value="确认发布" />
                    	<a href="<%=controller.getURI(request, SearchYqlj.class) %>" class="btn4">返回</a>
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
    <%@include file="/WEB-INF/include/left.jsp" %>
    </div>
    </div>
<%@include file="/WEB-INF/include/footer.jsp"%>
<%@include file="/WEB-INF/include/script.jsp"%>
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/validation.js"></script>
</body>
</html>