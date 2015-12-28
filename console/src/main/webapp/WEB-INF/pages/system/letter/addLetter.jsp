<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.variables.FileType"%>
<%@page import="com.dimeng.p2p.console.servlets.upload.Upload"%>
<%@page import="com.dimeng.p2p.console.servlets.system.letter.ImportLetter"%>
<%@page import="com.dimeng.p2p.common.enums.SendType"%>
<%@page import="com.dimeng.p2p.console.servlets.system.letter.AddLetter"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
<%@include file="/WEB-INF/include/kindeditor.jsp"%>
</head>
<body>
	<%
		String[] userNames = ObjectHelper.convertArray(
		request.getAttribute("userNames"), String.class);
			String sendType=request.getParameter("sendType");
			String content=ObjectHelper.convert(request.getAttribute("content"), String.class);
			if(StringHelper.isEmpty(sendType))
			{
		sendType=SendType.ZDR.name();
			}
	%>
	<%
		CURRENT_CATEGORY = "XTGL";
		CURRENT_SUB_CATEGORY = "ZNXTG";
	%>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="w_main">
		<div class="main clearfix">
			<div class="wrap">
				<div class="r_main">
					<div class="home_main">
						<div class="box box1 mb15">
							<div class="atil">
								<h3>发送站内信息</h3>
							</div>
							<div class="con">
								<div class="clear"></div>
								<form action="<%=controller.getURI(request, AddLetter.class)%>"
									method="post" class="form1" id="form1"
									onsubmit="return onSubmit();">
									<ul class="cell xc_jcxx ">
										<li>
											<div class="til">
												<span class="red">*</span>发送对象：
											</div>
											<div class="info">
												<%
													for(SendType type:SendType.values())
													{
												%>
												<input type="radio" value="<%=type.name()%>" name="sendType"
													onchange="showLetter('<%=type%>')"
													<%if(type.name().equals(sendType)) {%> checked="checked"
													<%}%> /><%=type.getName()%>
												<%
													}
												%>
											</div>
											<div class="clear"></div>
										</li>
										<li id="letterLi">
											<div class="til">
												<span class="red">*</span>用户名：
											</div>
											<div class="info">
												<textarea name="userName" id="username" cols="45" rows="5" class="border fl mr10 yw_w5 required"><%if (userNames != null) {for (String s : userNames) {%><%=s+"\n"%><%}}%></textarea>
												<p tip></p>
												<p errortip class="" style="display: none"></p>
												<a href="javascript:void(0)" id="importUser" class="btn3 tc">导入用户名</a>
											</div>
											<div class="clear"></div>
										</li>
										<div id="drsm" style="padding-left: 169px;">支持导入csv、txt格式数据</div>
										<li>
											<div class="til">
												<span class="red">*</span>站内信标题：
											</div>
											<div class="info">
												<input type="text" name="title" maxlength="30"
													class="text yhgl_ser yw_w5 required"
													value="<%StringHelper.filterHTML(out, request.getParameter("title"));%>" />
												<p tip></p>
												<p errortip class="" style="display: none"></p>
											</div>
											<div class="clear"></div>
										</li>
										<li>
											<div class="til">
												<span class="red">*</span>站内信内容：
											</div>
											<div class="info orange">
												<textarea name="content" id="content" cols="80" rows="9"
													style="width: 700px; height: 200px; visibility: hidden;"><%StringHelper.filterHTML(out, content);%>
												</textarea>
												<p id="errorContent">&nbsp;</p>
											</div>
											<div class="clear"></div>
										</li>
									</ul>
									<div class="tc w220 pt20">
										<input type="submit" class="btn4 mr30 sumbitForme"
											fromname="form1" value="确认" /><input type="button"
											onclick="location.href='<%=controller.getURI(request, LetterList.class)%>'"
											class="btn4" value="返回" />
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
		<div id="import" style="display: none">
			<div class="popup_bg"></div>
			<div class="w440 thickbox thickpos" style="margin: -80px 0 0 -220px;"
				id="showDiv">
				<div class="info clearfix">
					<form action="<%=controller.getURI(request, ImportLetter.class)%>"
						method="post" enctype="multipart/form-data">
						<div class="clearfix">
							导入用户名:<input type="file" name="file" value="导入用户名" />
						</div>
						<div class="dialog_btn">
							<input type="submit" value="提交" class="btn3 mr10" /> <input
								type="button" name="button2" onclick="$('#import').hide()"
								value="取消" class="btn5" />
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
	<script type="text/javascript"
		src="<%=controller.getStaticPath(request)%>/js/validation.js"></script>
	<script type="text/javascript">
		$("#importUser").click(function() {
			$("#import").show();
		});
		$("#close").click(function() {
			$("#import").hide();
		});
		var editor1;
		KindEditor.ready(function(K) {
			    editor1 = K.create('textarea[name="content"]', {
			    resizeType : 1,
				allowPreviewEmoticons : false,
				allowImageUpload : false,
				items : [
						'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 'italic', 'underline',
						'removeformat', '|', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
						'insertunorderedlist', '|', 'emoticons', 'link'],
				afterBlur:function(){
					this.sync();
					if(this.count('text')=='')
					{
						$("#errorContent").addClass("red");
						$("#errorContent").html("站内信内容不能为空");	
					}
					else if(this.count('text')>250)
					{
						$("#errorContent").addClass("red");
						$("#errorContent").html("站内信内容不能超过250个字");
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
				$("#errorContent").html("站内信内容不能为空");
				return false;
			}
			else if(editor1.count('text')>250)
			{
				$("#errorContent").addClass("red");
				$("#errorContent").html("站内信内容不能超过250个字");
				return false;	
			}
			else
			{
				$("#errorContent").removeClass("red");
				$("#errorContent").html("&nbsp;");
				return true;
			}
		}
		function showLetter(type)
		{
			if(type=='<%=SendType.ZDR%>')
			{
				$("#letterLi").show();
				$("#username").attr("value","")
				$("#drsm").show();
			}else if(type=='<%=SendType.SY%>') {
				$("#letterLi").hide();
				$("#username").attr("value", "all")
				$("#drsm").hide();
			}
		}
	</script>
</body>
</html>