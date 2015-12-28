<%@page import="com.dimeng.p2p.common.enums.PerformanceReportPublishStatus"%>
<%@page import="com.dimeng.p2p.console.servlets.info.yjbg.AddYjbg"%>
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
<div class="w_main">
<div class="main clearfix">
    <div class="wrap">
        <div class="r_main">
            <div class="home_main">
            	<div class="box box1 mb15">
                	<div class="atil">
                    	<h3>添加业绩报告</h3>
                  </div>
                    <div class="con">
                    <div class="clear"></div>
                    <form name="example" method="post" action="<%=controller.getURI(request, AddYjbg.class)%>" onsubmit="return checkImage();" class="form1" enctype="multipart/form-data">
                    <ul class="cell xc_jcxx ">
                    <li>
                        <div class="til"><span class="red"></span>&nbsp;</div>
                        <div class="info orange">
							<p errortip class=""><%StringHelper.filterHTML(out, controller.getPrompt(request, response,PromptLevel.ERROR));  %></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red">*</span>文章标题：</div>
                        <div class="info">
                        	<input type="text" class="text yhgl_ser yw_w4 required max-length-30" name="title" value="<%StringHelper.filterHTML(out,request.getParameter("title"));%>"/>
                        	<p tip>最大30个字符</p>
							<p errortip class="" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red"></span>是否发布：</div>
                        <div class="info orange">
                        <select name="status">
                        	<%String status =request.getParameter("status");  %>
                        	<option value="<%=PerformanceReportPublishStatus.WFB %>" <%if(!StringHelper.isEmpty(status) && status.equals(PerformanceReportPublishStatus.WFB.name())){ %>selected="selected" <%} %>><%=PerformanceReportPublishStatus.WFB.getName() %></option>
                    		<option value="<%=PerformanceReportPublishStatus.YFB %>" <%if(!StringHelper.isEmpty(status) && status.equals(PerformanceReportPublishStatus.YFB.name())){ %>selected="selected" <%} %>><%=PerformanceReportPublishStatus.YFB.getName() %></option>
                        </select>
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red">*</span>导入PDF：</div>
                        <div class="info orange">
                        <input type="file" class="text yhgl_ser yw_w4" name="file" />
                      	<p id="errorImage">&nbsp;</p>
                        </div>
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
<script type="text/javascript">
function checkImage(){
	var suffix = $("input:file").val();
	if('' == suffix || suffix == null || suffix.length == 0){
		$("#errorImage").addClass("red");
		$("#errorImage").html("您还没有选择PDF");	
		return false;
	}
	$("#errorImage").removeClass("red");
	$("#errorImage").html("&nbsp;");
	return true;
}
</script>
</body>
</html>