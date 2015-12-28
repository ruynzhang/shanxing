<%@page import="com.dimeng.p2p.common.enums.NoticePublishStatus"%>
<%@page import="com.dimeng.p2p.common.enums.NoticeType"%>
<%@page import="com.dimeng.p2p.console.servlets.info.wzgg.AddWzgg"%>
<%@page import="com.dimeng.p2p.variables.FileType"%>
<%@page import="com.dimeng.p2p.console.servlets.upload.Upload"%>
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
	CURRENT_SUB_CATEGORY = "WZGG";
%>
<%@include file="/WEB-INF/include/header.jsp"%>
<div class="w_main">
<div class="main clearfix">
    <div class="wrap">
        <div class="r_main">
            <div class="home_main">
            	<div class="box box1 mb15">
                	<div class="atil">
                    	<h3>添加网站公告</h3>
                  </div>
                    <div class="con">
                    <div class="clear"></div>
                    <form name="example" method="post" action="<%=controller.getURI(request, AddWzgg.class)%>" class="form1" onsubmit="return onSubmit();">
                    <ul class="cell xc_jcxx ">
                     <li>
                        <div class="til"><span class="red">&nbsp;</span></div>
                        <div class="info orange">
                        <%StringHelper.filterHTML(out, controller.getPrompt(request, response,PromptLevel.ERROR )); %>
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
                        <div class="til"><span class="red"></span>类型：</div>
                        <div class="info orange">
                        	<select name="type"  class="yhgl_ser">
                        		<%String status =request.getParameter("type");  %>
                        		<option value="<%=NoticeType.XT %>" <%if(!StringHelper.isEmpty(status) && status.equals(NoticeType.XT.name())){ %>selected="selected" <%} %>><%=NoticeType.XT.getName() %></option>
                        		<option value="<%=NoticeType.HD %>" <%if(!StringHelper.isEmpty(status) && status.equals(NoticeType.HD.name())){ %>selected="selected" <%} %>><%=NoticeType.HD.getName() %></option>
                        	</select>
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red"></span>是否发布：</div>
                        <div class="info orange">
                        	<select name="publishStatus"  class="yhgl_ser">
                        		<%String publishStatus =request.getParameter("publishStatus");  %>
                        		<option value="<%=NoticePublishStatus.WFB%>" <%if(!StringHelper.isEmpty(publishStatus) && publishStatus.equals(NoticePublishStatus.WFB.name())){ %>selected="selected" <%} %>><%=NoticePublishStatus.WFB.getName()%></option>
                        		<option value="<%=NoticePublishStatus.YFB%>" <%if(!StringHelper.isEmpty(publishStatus) && publishStatus.equals(NoticePublishStatus.YFB.name())){ %>selected="selected" <%} %>><%=NoticePublishStatus.YFB.getName()%></option>
                        	</select>
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red"></span>标题：</div>
                        <div class="info">
                        	<input type="text" class="text yhgl_ser yw_w4 max-length-30" name="html_title" value="<%StringHelper.filterHTML(out, request.getParameter("html_title"));%>"/>
                       		<p tip>最大30个字符</p>
							<p errortip class="" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red"></span>关键字：</div>
                        <div class="info">
                        	<input type="text" class="text yhgl_ser yw_w4 max-length-50" name="html_keywords" value="<%StringHelper.filterHTML(out, request.getParameter("html_keywords"));%>"/>
                        	<p tip>最大50个字符</p>
							<p errortip class="" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red"></span>描述：</div>
                        <div class="info">
                        	<input type="text" class="text yhgl_ser yw_w4 max-length-110" name="html_description" value="<%StringHelper.filterHTML(out, request.getParameter("html_description"));%>"/>
                        	<p tip>最大110个字符</p>
							<p errortip class="" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red">*</span>公告内容：</div>
                        <div class="info">
	                        <textarea name="content" cols="100" rows="8" style="width:700px;height:500px;visibility:hidden;"><%StringHelper.format(out, request.getParameter("content"), fileStore); %></textarea>
	                        <p id="errorContent">&nbsp;</p>
                        </div>
                        <div class="clear"></div>
                    </li>
                          
               		</ul>
                    <div class="tc w220 pt20">
                    	<input type="submit" class="btn4 mr30 sumbitForme" style="cursor: pointer;" fromname="form1" value="确认发布" />
                    	<a href="<%=controller.getURI(request, SearchWzgg.class) %>" class="btn4">返回</a>
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
    <div class="l_main">
    </div>
    <%@include file="/WEB-INF/include/left.jsp" %>
 </div>
</div>
<%@include file="/WEB-INF/include/footer.jsp"%>
<%@include file="/WEB-INF/include/script.jsp"%>
<%@include file="/WEB-INF/include/kindeditor.jsp" %>
	<script>
		var editor1;
		KindEditor.ready(function(K) {
			editor1 = K.create('textarea[name="content"]', {
				uploadJson : '<%=controller.getURI(request, Upload.class)%>?type=<%=FileType.ARTICLE_ATTACHMENT.ordinal()%>',
				allowFileManager : false,
				formatUploadUrl: false,
				afterBlur:function(){
					this.sync();
					if(this.count('text')=='')
					{
						$("#errorContent").addClass("red");
						$("#errorContent").html("公告内容不能为空");	
					}
					else
					{
						$("#errorContent").removeClass("red");
						$("#errorContent").html("&nbsp;");
					}
				}
			});
			prettyPrint();
		});
		
		function onSubmit()
		{
			if(editor1.count('text')=='')
			{
				$("#errorContent").addClass("red");
				$("#errorContent").html("公告内容不能为空");
				return false;
			}
			else
			{
				$("#errorContent").removeClass("red");
				$("#errorContent").html("&nbsp;");
				return true;
			}
		}
	</script>
	<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/validation.js"></script>
</body>
</html>