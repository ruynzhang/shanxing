<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.console.servlets.system.skin.UploadAddSkin"%>
<%@page import="com.dimeng.p2p.common.enums.SkinStatus"%>
<%@page import="com.dimeng.p2p.console.servlets.system.skin.AddSkin"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%
		CURRENT_CATEGORY = "XTGL";
		CURRENT_SUB_CATEGORY = "QTPFSZ";
			String fileCode=ObjectHelper.convert(request.getAttribute("fileCode"), String.class);
	%>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="w_main">
		<div class="main clearfix">
			<div class="wrap">
				<div class="r_main">
					<div class="home_main">
						<div class="box box1 mb15">
							  <div class="atil">
					              <h3>添加前台皮肤</h3>
					            </div>
							<div class="con">
								<div class="clear"></div>
								<form method="post" id="form1">
									<input type="hidden" name="pic" <%if(!StringHelper.isEmpty(fileCode)){%> value="<%=fileStore.getURL(fileCode)%>" <%}%>>
									<ul class="cell noborder yw_jcxx">
										<li>
											<div class="til">
												<span class="red">*</span> 皮肤名称：<br />
											</div>
											<div class="info orange">
												<input type="text" name="name" id="name" onblur="nameCheck()" value="<%StringHelper.filterSingleQuoter(out, request.getParameter("name"));%>" class="text yhgl_ser yw_w4 required" />
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
													<option value="<%=skinStatus.name()%>" <%if(skinStatus.name().equals(request.getParameter("location"))){%> selected="selected" <%}%>><%=skinStatus.getName()%></option>
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
												<img id="imgFile" <%if(!StringHelper.isEmpty(fileCode)){%> src="<%=fileStore.getURL(fileCode)%>" <%}%> class="bm10 bo_xxk">
												<input type="file" name="file" onblur="fileCheck()" id="uploadFile" value="选择文件" onchange="upload()" class="required">
												<p id="fileError"></p>
											</div>
											<div class="clear"></div>
										</li>
									</ul>
									<div class="tc w220 pt20">
										<input type="button" class="btn4 mr30" value="确认" onclick="onSubmit()" />
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
			document.getElementById("form1").action ="<%=controller.getURI(request, UploadAddSkin.class)%>";
			document.getElementById("form1").enctype="multipart/form-data";
			$("#form1").submit();
		}
		function onSubmit()
		{
			document.getElementById("form1").action ="<%=controller.getURI(request, AddSkin.class)%>";
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