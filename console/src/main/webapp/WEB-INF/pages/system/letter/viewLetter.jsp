<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.util.ObjectHelper"%>
<%@page import="com.dimeng.p2p.console.servlets.system.letter.ExportLetter"%>
<%@page import="com.dimeng.p2p.console.servlets.system.letter.LetterList"%>
<%@page import="com.dimeng.p2p.modules.systematic.console.service.entity.Letter"%>
<%@page import="com.dimeng.p2p.console.servlets.system.letter.ImportLetter"%>
<%@page import="com.dimeng.p2p.common.enums.SendType"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
<%@include file="/WEB-INF/include/kindeditor.jsp" %>
</head>
<body>
	<%
		Letter letter = ObjectHelper.convert(
					request.getAttribute("letter"), Letter.class);
			if (letter == null) {
				response.sendError(HttpServletResponse.SC_NOT_FOUND);
				return;
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
								<ul class="cell xc_jcxx ">
									<li>
										<div class="til">
											<span class="red">*</span>管理员：
										</div>
										<div class="info">
											<%
												StringHelper.filterHTML(out, letter.name);
											%>
										</div>
										<div class="clear"></div>
									</li>
									<li>
										<div class="til">
											<span class="red">*</span>创建时间：
										</div>
										<div class="info">
											<%=DateTimeParser.format(letter.createTime)%>
										</div>
										<div class="clear"></div>
									</li>
									<li>
										<div class="til">
											<span class="red">*</span>发送数量：
										</div>
										<div class="info">
											<%=letter.count%>
										</div>
										<div class="clear"></div>
									</li>
									<li>
										<div class="til">
											<span class="red">*</span>用户名：
										</div>
										<div class="info">
											<textarea name="userName" id="textarea" readonly="readonly" cols="45" rows="5" class="border fl mr10 yw_w5"><%if (letter.userNames != null) {for (String s : letter.userNames) {%><%=s+"\n"%><%}}%></textarea>
											<a href="<%=controller.getURI(request, ExportLetter.class)%>?id=<%=letter.id %>" class="btn3 tc">导出</a>
										</div>
										<div class="clear"></div>
									</li>
									<li>
										<div class="til">
											<span class="red">*</span>站内信标题：
										</div>
										<div class="info">
											<label> <%
											 	StringHelper.filterHTML(out, letter.title);
											 %>
											</label>
										</div>
										<div class="clear"></div>
									</li>
									<li>
										<div class="til">
											<span class="red">*</span>站内信内容：
										</div>
										<div class="info orange">
											<textarea name="content" readonly="readonly" cols="80" rows="9" style="width:700px;height:200px;visibility:hidden;"><%StringHelper.filterHTML(out, letter.content);%></textarea>
										</div>
										<div class="clear"></div>
									</li>
								</ul>
								<div class="tc w220 pt20">
									<input type="button" onclick="location.href='<%=controller.getURI(request, LetterList.class) %>'" class="btn4" value="返回" />
								</div>
								<div class="clear"></div>
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
	<script type="text/javascript">
	KindEditor.ready(function(K) {
		var editor1 = K.create('textarea[name="content"]', {
			readonlyMode : true,
			resizeType : 1,
			allowPreviewEmoticons : false,
			allowImageUpload : false,
			items : [
				'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 'italic', 'underline',
				'removeformat', '|', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
				'insertunorderedlist', '|', 'emoticons', 'link'],
		});
		prettyPrint();
	});
	
	</script>
</body>
</html>