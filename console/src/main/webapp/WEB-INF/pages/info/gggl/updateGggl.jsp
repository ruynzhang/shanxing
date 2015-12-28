<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.console.servlets.info.gggl.UpdateGggl"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
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
	AdvertisementRecord record  = ObjectHelper.convert(request.getAttribute("record"), AdvertisementRecord.class);
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
                    	<h3>修改广告</h3>
                  </div>
                    <div class="con">
                    <div class="clear"></div>
                    <form action="<%=controller.getURI(request, UpdateGggl.class)%>" method="post" enctype="multipart/form-data" class="form1">
                    <input type="hidden" name="id" value="<%=record.id%>" />
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
                        	<input name="advType" id="advType1" type="radio" value="0" <%if(record.advType.equals("0")){%>checked="checked"<%}%> class="mr5"/>
                            <label for="advType1">Web</label>
                        	<input name="advType" id="advType2" type="radio" value="1" <%if(record.advType.equals("1")){%>checked="checked"<%}%> class="mr5"/>
                            <label for="advType2">手机</label>
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red">*</span>广告图片标题：</div>
                        <div class="info orange">
                        	<input type="text" class="text yhgl_ser required max-length-30" name="title" value="<%StringHelper.filterHTML(out,record.title);%>"/>
                        	<p tip></p>
							<p errortip class="" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red"></span>广告图片：</div>
                        <div class="info orange">
                        <p class="mb10"><img src="<%=fileStore.getURL(record.imageCode) %>" width="277" height="89" /></p>
                        <p class="mb10"><input type="file" name="image" value="">（建议尺寸：宽1680像素，高300像素）</p>
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til">链接：</div>
                        <div class="info orange">
                        	<input type="text" class="text yhgl_ser max-length-250" name="url" value="<%StringHelper.filterHTML(out,record.url);%>"/>
                        	<p tip></p>
							<p errortip class="" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til"><span class="red">*</span>排序值：</div>
                        <div class="info orange">
                        	<input type="text" class="text yhgl_ser required isint max-length-10" name="sortIndex" value="<%=record.sortIndex%>"/>
                        	<p tip></p>
							<p errortip class="" style="display: none"></p>
                        </div>
                        <div class="clear"></div>
                    </li>
                    <li>
                        <div class="til">上架时间：</div>
                        <div class="info">
                        <input type="text" class="text yhgl_ser date " readonly="readonly" id="datepicker1" name="showTime" value="<%=DateTimeParser.format(record.showTime)%>"/>
                       </div>
                        <div class="clear"></div>
                    </li>
                      <li>
                        <div class="til">下架时间：</div>
                        <div class="info">
                       <input type="text" readonly="readonly" id="datepicker2" class="text yhgl_ser  date" name="unshowTime" value="<%=DateTimeParser.format(record.unshowTime)%>"/>
                       </div>
                        <div class="clear"></div>
                    </li>
               		</ul>
                    <div class="tc w220 pt20"><button type="submit" class="btn4 mr30 sumbitForme" style="cursor: pointer;" fromname="form1">确认发布</button>
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
	</script>
</body>
</html>