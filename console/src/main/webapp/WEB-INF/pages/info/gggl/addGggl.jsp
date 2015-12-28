<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.console.servlets.info.gggl.AddGggl"%>
<%@page import="com.dimeng.p2p.modules.base.console.service.entity.AdvertisementRecord"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
<link href="<%=controller.getStaticPath(request) %>/css/hhmmss.css" rel="stylesheet">
</head>
<%
	CURRENT_CATEGORY = "XCGL";
	CURRENT_SUB_CATEGORY = "GGGL";
%>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="w_main">
	<div class="main clearfix">  
    <div class="wrap">
        <div class="r_main">
            <div class="home_main">
            	<div class="box box1 mb15">
                	<div class="atil">
                    	<h3>添加广告</h3>
                  </div>
                    <div class="con">
                    <div class="clear"></div>
                    <form action="<%=controller.getURI(request, AddGggl.class)%>" method="post" enctype="multipart/form-data" onsubmit="return checkImage();" class="form1">
                    <ul class="cell yw_jcxx">
                    <li>
                        <div class="til"><span class="red">&nbsp;</span></div>
                        <div class="info orange">
                        <%StringHelper.filterHTML(out, controller.getPrompt(request, response, PromptLevel.ERROR));%>
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red">*</span>广告类型：</div>
                        <div class="info orange">
                        	<input name="advType" id="advType1" type="radio" value="0" checked="checked" class="mr5"/>
                            <label for="advType1">Web</label>
                        	<input name="advType" id="advType2" type="radio" value="1" class="mr5"/>
                            <label for="advType2">手机</label>
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red">*</span>广告图片标题：</div>
                        <div class="info orange">
                        	<input type="text" class="text yhgl_ser required max-length-30" name="title" value="<%StringHelper.filterHTML(out,request.getParameter("title"));%>"/>
                        	 <p tip></p>
							<p errortip class="" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red">*</span>广告图片：</div>
                        <div class="info orange">
                        <p class="mb10"><input  type="file" name="image" value="">（建议尺寸：宽1680像素，高300像素）</p>
                        <p id="errorImage">&nbsp;</p>
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til">链接：</div>
                        <div class="info orange">
                        	<input type="text" class="text yhgl_ser max-length-250" name="url" value="<%StringHelper.filterHTML(out,request.getParameter("url"));%>"/>
                        	 <p tip></p>
							<p errortip class="" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red">*</span>排序值：</div>
                        <div class="info orange">
                        	<input type="text" class="text yhgl_ser required isint max-length-10" name="sortIndex" value="<%StringHelper.filterHTML(out,request.getParameter("sortIndex"));%>"/>
                        	<p tip></p>
							<p errortip class="" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red">*</span>上架时间：</div>
                        <div class="info">
	                        <input type="text" class="text yhgl_ser date required" id="datepicker1" readonly="readonly" name="showTime" value="<%StringHelper.filterHTML(out,request.getParameter("showTime"));%>"/>
	                         <p tip></p>
	                        <p errortip class="" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                      <li>
                        <div class="til"><span class="red">*</span>下架时间：</div>
                        <div class="info">
	                        <input type="text" id="datepicker2" readonly="readonly" class="text yhgl_ser  date required" name="unshowTime" value="<%StringHelper.filterHTML(out,request.getParameter("unshowTime"));%>"/>
	                         <p tip></p>
	                        <p errortip class="" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
               		</ul>
                    <div class="tc w220 pt20"><button type="submit" class="btn4 mr30 sumbitForme" id="subBtn" style="cursor: pointer;" fromname="form1">确认发布</button>
                    	<a href="<%=controller.getURI(request, SearchGggl.class) %>" class="btn4">返回</a>
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
	<%@include file="/WEB-INF/include/datepicker.jsp"%>
	<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/jquery-ui-1.10.4/js/time.js"></script>
	<script type="text/javascript">
	$(function() {
		 $('#datepicker1').datetimepicker({
				timeFormat: 'HH:mm:ss',
				dateFormat:'yy-mm-dd'
				});
		 $('#datepicker2').datetimepicker({
				timeFormat: 'HH:mm:ss',
				dateFormat:'yy-mm-dd'
				});
	   
	});
	
	
	function checkImage(){
		$("#subBtn").attr("disabled",false);
		var suffix = $("input:file").val();
		if('' == suffix || suffix == null || suffix.length == 0){
			$("#errorImage").addClass("red");
			$("#errorImage").html("您还没有选择图片");	
			return false;
		}
		var img = ['jpg','png','jpeg','gif','ico'];
		for(var i=0; i<img.length; i++){
			if(suffix.length > img[i].length && img[i] == suffix.substring(suffix.length-img[i].length)){
				$("#errorImage").removeClass("red");
				$("#errorImage").html("&nbsp;");
				$("#subBtn").attr("disabled",true);
				$("#subBtn").text("发布中...");
				return true;
			}
		}
		$("#errorImage").addClass("red");
		$("#errorImage").html("您插入的图片格式不正确");	
		return false;
	}
	
	
	
	</script>
</body>
</html>