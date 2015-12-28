<%@page import="com.dimeng.p2p.user.servlets.account.Upload"%>
<%@include file="/WEB-INF/include/authenticatedSession.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title></title>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
<%
	if(request.getAttribute("close") != null){
	%>
	<script type="text/javascript">
		var list=parent.art.dialog.list;
		for(var i in list){
			list[i].close();
		}
	</script>
	<%
		return;
	}
	%>
</head>
<body>
<%@include file="/WEB-INF/include/upload.jsp" %>
<div class="dialog_pak_dialog_close fr" onclick="var list=parent.art.dialog.list;for(var i in list)list[i].close();">
  <a href="javascript:void(-1)"></a></div>
<div class="clear"></div>
<div class="dialog_pak d_error">
  <div class="dialog_close fr"><a href="#"></a></div>
  <div class="con clearfix">
    <div class="info">
     <form action="<%=controller.getURI(request, Upload.class)%>" method="post" enctype="multipart/form-data">
		<div id="uploader" style="width:523px;height:208px;">
			<p>您的浏览器未安装 Flash, Silverlight, Gears, BrowserPlus 或者支持 HTML5 .</p>
		</div>
	</form>
    </div>
    <div class="clear"></div>
    <div class="dialog_btn"><a href="#" class="btn btn001">关闭</a></div>
  </div>
  <div class="clear"></div>
    <div class="dialog_btn pt10">
    <input type="button" class="btn btn05 " onclick="var list=parent.art.dialog.list;for(var i in list)list[i].close();" value="关闭"/>
  </div>
  
</div>


			          
	<%@include file="/WEB-INF/include/script.jsp"%>
	<%@include file="/WEB-INF/include/upload.jsp"%>
	<script type="text/javascript">
	$(function() {
		$("#uploader").plupload({
			runtimes : 'html5,flash,silverlight,html4',
			url : '<%=controller.getURI(request, Upload.class)%>',
			max_file_size : '4mb',
			chunk_size : '4mb',			
			filters : [ {
				title : "Image files",
				extensions : "jpg,gif,png,jpeg"
			}],
			rename : false,
			sortable : true,
			dragdrop : true,
			views : {
				list : true,
				thumbs : true,
				active : 'thumbs'
			},
			flash_swf_url : '<%=controller.getStaticPath(request)%>/js/upload/js/Moxie.swf',
			silverlight_xap_url : '<%=controller.getStaticPath(request)%>/js/upload/js/Moxie.xap',
			init: {
				PostInit: function() {
					
				},
				FilesAdded: function(up, files) {
					
				},
				BeforeUpload: function(up, file) {
					var count = $("#uploader_filelist").children().size();
					var total = parseInt(count);
					if(total>2){
						alert("每次最多能上传1张！请删除多余的");
						stop();
						return false;
					}
				},

				Error: function(up, err) {
				}
			}
			
		});
	});
</script>
</body>
</html>
