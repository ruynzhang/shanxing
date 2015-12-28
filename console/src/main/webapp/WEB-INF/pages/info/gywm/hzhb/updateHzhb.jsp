<%@page import="com.dimeng.p2p.console.servlets.info.gywm.hzhb.UpdateHzhb"%>
<%@page import="com.dimeng.p2p.modules.base.console.service.entity.PartnerRecord"%>
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
	CURRENT_SUB_CATEGORY = "HZHB";
%>
<%
	PartnerRecord record  = ObjectHelper.convert(request.getAttribute("record"), PartnerRecord.class);
%>
<%@include file="/WEB-INF/include/header.jsp"%>
<div class="w_main">
<div class="main clearfix">
    <div class="wrap">
        <div class="r_main">
            <div class="home_main">
            	<div class="box box1 mb15">
                	<div class="atil">
                    	<h3>修改合作伙伴</h3>
                  </div>
                    <div class="con">
                    <div class="clear"></div>
                    <form name="example" method="post" action="<%=controller.getURI(request, UpdateHzhb.class)%>" class="form1" enctype="multipart/form-data" onsubmit="return onSubmit();">
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
                        <div class="til"><span class="red">*</span>公司名称：</div>
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
                        	<input type="text" class="text yhgl_ser yw_w4 required max-length-255" name="url"  value="<%StringHelper.filterHTML(out, record.url);%>"/>
                       		<p tip></p>
							<p errortip class="" style="display: none"></p>
                       	</div>
                        <div class="clear"></div>
                    </li>
                      <li>
                      	
                        <div class="til"><span class="red"></span>封面图片：</div>
                        
                        <div class="info orange">
                        <p class="mb10"><img src="<%=fileStore.getURL(record.imageCode) %>" width="277" height="89" /></p>
                        <input type="file" class="text yhgl_ser yw_w4" name="image"/>
                        </div>
                        <div class="clear"></div>
                    </li>
                  
                    
                    <li>
                        <div class="til"><span class="red">*</span>联系地址：</div>
                        <div class="info orange">
                        	<input type="text" class="text yhgl_ser yw_w4 required max-length-30" name="address"  value="<%StringHelper.filterHTML(out, record.address);%>"/>
                        	<p tip></p>
							<p errortip class="" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                     <li>
                        <div class="til"><span class="red">*</span>公司简介：</div>
                        <div class="info orange">
                         	<textarea name="content" cols="100" rows="8" style="width:700px;height:500px;visibility:hidden;"><%StringHelper.format(out, record.description, fileStore); %></textarea>
                        	<p id="errorContent">&nbsp;</p>
                        </div>
                        <div class="clear"></div>
                    </li>
               		</ul>
                    <div class="tc w220 pt20"><input type="submit" class="btn4 mr30 sumbitForme" style="cursor: pointer;" fromname="form1" value="确认发布" />
                    <a href="<%=controller.getURI(request, SearchHzhb.class) %>" class="btn4">返回</a>
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
						$("#errorContent").html("公司简介内容不能为空");	
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
				$("#errorContent").html("公司简介内容不能为空");
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