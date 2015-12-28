<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="com.dimeng.p2p.user.servlets.account.Rzsc"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<%
	int rzId =IntegerParser.parse(request.getParameter("id"));
%>
<body style="background: #fff !important;">
	<%@include file="/WEB-INF/include/upload.jsp"%>
	<div class="clear"></div>
	<div class="popup_tips_jz">
		<div class="">
			<div class="con clearfix">
				<div class="mt10">
				<form  method="post" enctype="multipart/form-data" class="form1">
					<div>
					<p id="errortip" style="margin-left: 101px"></p>
					</div><br />
						<div id="uploader" style="width: 523px; height: 208px; margin-left: 101px; margin-bottom: 103px;">
							<p>您的浏览器未安装 Flash, Silverlight, Gears, BrowserPlus 或者支持 HTML5 .</p>
						</div>
					<div class="pt10 ml300">
						<a href="javascript:void(-1);" style="margin:10px 0 0 300px;" onclick="submitForm()" class="btn btn01">保存</a>
					</div>
					</form>
				</div>
			</div>
		</div>
		<input id="isupload" value="0" type="hidden" />
	</div>
	<%@include file="/WEB-INF/include/script.jsp"%>
	<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/validation.js"></script>
	<script type="text/javascript">
	$(function() {
		$("#uploader").plupload({
			runtimes : 'html5,flash,silverlight,html4',
			url : '<%=controller.getURI(request, Rzsc.class) %>?id=<%=rzId %> ',
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
			multi_selection:false,
			flash_swf_url : '<%=controller.getStaticPath(request)%>/js/upload/js/Moxie.swf',
			silverlight_xap_url : '<%=controller.getStaticPath(request)%>/js/upload/js/Moxie.xap',
								init : {
									PostInit : function() {

									},
									FilesAdded : function(up, files) {
										var count = $("#uploader_filelist").children().size();
										var total = parseInt(count);
										if(total>1){
											alert("每次最多能上传1张! 将删除多余的");
											up.splice(1,1);
											$($("#uploader_filelist").children()[1]).remove();
										}
										$("#isupload").val(1);
									},
									BeforeUpload : function(up, file) {
										var count = $("#uploader_filelist")
										.children().size();
								        var total = parseInt(count);
								        if(total>1){
									        alert("每次最多能上传1张！请删除多余的");
									        return false;
								        }
								        $("#isupload").val(1);

									},

									Error : function(up, err) {
									}
								}
							});
		});
		function submitForm()
		{
			var typeId=$("#type").val();
			if(typeId=='')
			{
				$("#errortip").text("附件类型不能为空");
				$("#errortip").addClass("red");
				return;	
			}
			var list=parent.art.dialog.list;for(var i in list)list[i].close();
		}
	</script>
</body>
</html>
