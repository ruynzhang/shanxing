<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="com.dimeng.p2p.console.servlets.bid.jkgl.AnnexWz"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<%@page import="com.dimeng.p2p.S62.entities.T6212"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.jkgl.AddAnnexWz"%>
<%@page import="com.dimeng.p2p.S60.enums.T6216_F03"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.jkgl.AddAnnexMsk"%>
<%@page import="com.dimeng.p2p.modules.business.console.service.CheckUserManage"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<%
	int loanId=IntegerParser.parse(request.getParameter("loanId"));
	int userId=IntegerParser.parse(request.getParameter("userId"));
	T6212[] t6212s=ObjectHelper.convertArray(request.getAttribute("annexTypes"), T6212.class);
	int typeId=IntegerParser.parse(request.getParameter("typeId"));
%>
<body style="background: #fff !important;">
	<%@include file="/WEB-INF/include/upload.jsp"%>
	<div class="clear"></div>
	<div class="popup_tips_jz">
		<div class="">
			<div class="con clearfix">
				<div class="mt10">
					<div>
					<span style="margin-left: 101px;font-size: 15px;color: red;"><span class="red">*</span>&nbsp;&nbsp;请选择附件类型:</span>
					<select name="typeId" id="type" onchange="changeType()" class="required">
					<option value="">全部</option>
					<%
						if(t6212s!=null)
						{
							for(T6212 t6212:t6212s)
							{if(t6212==null){continue;}
					%>
					<option value="<%=t6212.F01%>" <%if(typeId==t6212.F01) {%> selected="selected" <%} %>><%StringHelper.filterHTML(out, t6212.F02); %></option>
					<%}} %>
					</select>
					<p id="errortip" style="margin-left: 101px"></p>
					</div><br />
					<form method="post" enctype="multipart/form-data">
						<div id="uploader" style="width: 523px; height: 208px; margin-left: 101px; margin-bottom: 103px;">
							<p>您的浏览器未安装 Flash, Silverlight, Gears, BrowserPlus 或者支持 HTML5 .</p>
						</div>
					</form>
					<div class="pt10 ml300">
						<a href="javascript:void(-1);" onclick="submitForm()" class="btn btn01">保存</a>
					</div>
				</div>
			</div>
		</div>
		<input id="isupload" value="0" type="hidden" />
	</div>
	<%@include file="/WEB-INF/include/script.jsp"%>
	<script type="text/javascript">
	$(function() {
		$("#uploader").plupload({
			runtimes : 'html5,flash,silverlight,html4',
			url : '<%=controller.getURI(request, AddAnnexWz.class)%>?loanId=<%=loanId%>&typeId=<%=typeId%>&userId=<%=userId%>',
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
								init : {
									PostInit : function() {

									},
									FilesAdded : function(up, files) {

									},
									BeforeUpload : function(up, file) {
										var count = $("#uploader_filelist")
												.children().size();
										var total = parseInt(count);
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
		function changeType()
		{
			var typeId=$("#type").val();
			location.href="<%=controller.getURI(request, AnnexWz.class)%>?loanId=<%=loanId%>&userId=<%=userId%>&typeId="+typeId;
		}
	</script>
</body>
</html>
