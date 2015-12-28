<%@page import="com.dimeng.p2p.common.enums.PerformanceReportPublishStatus"%>
<%@page import="com.dimeng.p2p.modules.base.console.service.entity.PerformanceReportRecord"%>
<%@page import="com.dimeng.p2p.modules.base.console.service.PerformanceReportManage"%>
<%@page import="com.dimeng.p2p.console.servlets.info.yjbg.UpdateYjbg"%>
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
	CURRENT_SUB_CATEGORY = "YJBG";
%>
<%@include file="/WEB-INF/include/header.jsp"%>
<%PerformanceReportManage manage = serviceSession.getService(PerformanceReportManage.class); 
PerformanceReportRecord record = manage.get(IntegerParser.parse(request.getParameter("id")));
%>
<div class="w_main">
<div class="main clearfix">
    <div class="wrap">
        <div class="r_main">
            <div class="home_main">
            	<div class="box box1 mb15">
                	<div class="atil">
                    	<h3>修改业绩报告</h3>
                  </div>
                    <div class="con">
                    <div class="clear"></div>
                    <form name="example" method="post" action="<%=controller.getURI(request, UpdateYjbg.class)%>" class="form1" enctype="multipart/form-data">
                      <input type="hidden" value="<%=record.id %>" name="id"/>
                    <ul class="cell xc_jcxx "> 
                      <li>
                        <div class="til"><span class="red"></span>&nbsp;</div>
                        <div class="info orange">
							<p errortip class="""><%StringHelper.filterHTML(out, controller.getPrompt(request, response,PromptLevel.ERROR));  %></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red">*</span>文章标题：</div>
                        <div class="info">
                        	<input type="text" class="text yhgl_ser yw_w4 required max-length-30" name="title" value="<%StringHelper.filterHTML(out, record.title);%>"/>
                        	<p tip>最大30个字符</p>
							<p errortip class="" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red"></span>是否发布：</div>
                        <div class="info orange">
                        <select name="status">
                        	<option value="<%=PerformanceReportPublishStatus.WFB %>" <%if(record.publishStatus.equals(PerformanceReportPublishStatus.WFB)){ %>selected="selected"<%} %>><%=PerformanceReportPublishStatus.WFB.getName() %></option>
                    		<option value="<%=PerformanceReportPublishStatus.YFB %>" <%if(record.publishStatus.equals(PerformanceReportPublishStatus.YFB)){ %>selected="selected"<%} %>><%=PerformanceReportPublishStatus.YFB.getName() %></option>
                        </select>
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red"></span>导入PDF：</div>
                        <div class="info orange"><input type="file" class="text yhgl_ser yw_w4" name="file"/></div>
                        <div class="clear"></div>
                    </li>
                   	
                 
               		</ul>
                    <div class="tc w220 pt20">
                    	<input type="submit" class="btn4 mr30 sumbitForme" style="cursor: pointer;" fromname="form1" value="确认发布" />
                    	<a href="<%=controller.getURI(request, SearchYjbg.class) %>" class="btn4">返回</a>
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