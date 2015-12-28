<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.variables.P2PConst"%>
<%@page import="com.dimeng.p2p.console.servlets.system.skin.UploadUpdateSkin"%>
<%@page import="com.dimeng.p2p.console.servlets.system.skin.UploadAddSkin"%>
<%@page import="com.dimeng.p2p.common.enums.SkinStatus"%>
<%@page import="com.dimeng.p2p.modules.systematic.console.service.entity.Skin"%>
<%@page import="com.dimeng.p2p.console.servlets.system.skin.UpdateSkin"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%
			Skin skin = ObjectHelper.convert(request.getAttribute("skin"),
				Skin.class);
			String fileCode=ObjectHelper.convert(request.getAttribute("fileCode"), String.class);
			if(skin==null)
			{
				response.sendError(HttpServletResponse.SC_NOT_FOUND);
				return;
			}
	%>
	<%
		CURRENT_CATEGORY = "XTGL";
		CURRENT_SUB_CATEGORY = "QTPHSZ";
	%>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="w_main">
		<div class="main clearfix">
			<div class="wrap">
				<div class="r_main">
					<div class="home_main">
						<div class="box box1 mb15">
							<div class="con">
								<div class="clear"></div>
								<form id="form1" method="post" class="form1">
									<input type="hidden" name="pic" <%if(!StringHelper.isEmpty(fileCode)){%> value="<%=fileStore.getURL(fileCode)%>" <%}else{%> value="<%=skin.pic%>" <%}%>>
									<input type="hidden" name="id" value="<%=skin.id%>">
									<ul class="cell noborder yw_jcxx">
										<li>
											<div class="til">
												<span class="red">*</span> 皮肤名称：<br />
											</div>
											<div class="info orange">
												<input type="text" name="name" id="name" onblur="nameCheck()" class="text yhgl_ser yw_w4 required" value="<%StringHelper.filterHTML(out, skin.name);%>"/>
												<p id="nameError"></p>
											</div>
											<div class="clear"></div>
										</li>
										<li>
											<div class="til">
												<span class="red">*</span>皮肤位置：
											</div>
											<div class="info">
												<select name="location" class="yhgl_ser yw_w1">
													<%
														for(SkinStatus skinStatus:SkinStatus.values())
																									{
													%>
													<option value="<%=skinStatus.name()%>" <%if(skinStatus.equals(skin.location)) {%> selected="selected" <%}%>><%=skinStatus.getName()%></option>
													<%
														}
													%>
												</select>
											</div>
											<div class="clear"></div>
										</li>
										<li>
											<div class="til">
												<span class="red">*</span>皮肤图片：
											</div>
											<div class="info orange">
												<img id="imgFile" <%if(!StringHelper.isEmpty(fileCode)) {%> src="<%=fileStore.getURL(fileCode)%>" <%}else{%> src="<%=skin.pic%> <%}%>" class="bm10 bo_xxk">
													<input type="file" name="file" value="选择文件" onchange="upload()" class="required">
													<p id="fileError"></p>
											</div>
											<div class="clear"></div>
										</li>
									</ul>
									<div class="tc w220 pt20">
										<input type="button" class="btn4 mr30" onclick="onSubmit()" value="确认" />
										<a href="<%=controller.getURI(request, SkinList.class)%>" class="btn4">返回</a>
									</div>
									<div class="clear"></div>
								</form>
							</div>
						</div>
						<div class="box2 clearfix"></div>
					</div>
				</div>
			</div>
			<%@include file="/WEB-INF/include/left.jsp"%>
		</div>
	</div>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
	<script type="text/javascript"
		src="<%=controller.getStaticPath(request)%>/js/validation.js"></script>
	<script type="text/javascript">
		function upload()
		{
			document.getElementById("form1").action ="<%=controller.getURI(request, UploadUpdateSkin.class)%>";
			document.getElementById("form1").enctype="multipart/form-data";
			$("#form1").submit();
		}
		function onSubmit()
		{
			document.getElementById("form1").action ="<%=controller.getURI(request, UpdateSkin.class)%>";
			document.getElementById("form1").enctype="";
			if(fileCheck()&&nameCheck())
			{
				$("#form1").submit();
			}
		}
		function nameCheck()
		{
			var name=$("#name").val();
			if(name=='')
			{
				$("#nameError").addClass("red");
				$("#nameError").html("皮肤名称不能为空");
				return false;	
			}
			$("#nameError").html("");
			return true;
		}
		function fileCheck()
		{
			var oFile = document.getElementById('imgFile');
			if(oFile.src=='')
			{
				$("#fileError").addClass("red");
				$("#fileError").html("上传图片不能为空");
				return false;	
			}
			$("#fileError").html("");
			return true;
		}
	</script>
</body>
</html>