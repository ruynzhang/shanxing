<%@page import="com.dimeng.p2p.S71.enums.T7166_F04"%>
<%@page import="com.dimeng.p2p.S71.enums.T7166_F03"%>
<%@page import="com.dimeng.p2p.console.servlets.spread.khgh.Add"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
<link href="<%=controller.getStaticPath(request)%>/css/hhmmss.css"
	rel="stylesheet">
</head>
<body>
	<%
		CURRENT_CATEGORY = "XTGL";
		CURRENT_SUB_CATEGORY = "KHGH";
	%>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="w_main">
		<div class="main clearfix">
			<div class="wrap">
				<div class="r_main">
					<div class="home_main">
						<div class="box box1 mb15">
							<div class="atil">
								<h3>新增客户关怀</h3>
							</div>
							<div class="con">
								<div class="clear"></div>
								<form name="example" method="post"
									action="<%=controller.getURI(request, Add.class)%>"
									class="form1" onsubmit="return onSubmit();">
									<ul class="cell yw_jcxx ">
										<li>
											<div class="til">
												<span class="red">&nbsp;</span>
											</div>
											<div class="info orange">
												<%
													StringHelper.filterHTML(out, controller.getPrompt(request, response, PromptLevel.ERROR));
												%>
											</div>
											<div class="clear"></div>
										</li>
										<li>
											<div class="til">
												<span class="red">*</span>关怀类型：
											</div>
											<div class="info">
												<select id="typeSelected" name="type" onchange="changeType(this.value);">
													<%T7166_F03[] t7166_F03s = T7166_F03.values(); if(t7166_F03s != null && t7166_F03s.length > 0){for(T7166_F03 t7166_F03:t7166_F03s ){ %>
														<option value="<%=t7166_F03.name() %>"><%StringHelper.filterHTML(out, t7166_F03.getChineseName()); %></option>
													<%}} %>
												</select>
												<p errortip class="" style="display: none"></p>
											</div>
											<div class="clear"></div>
										</li>
										<li>
											<div class="til">
												<span class="red">*</span>关怀形式：
											</div>
											<div class="info">
												<select name="channel">
													<%T7166_F04[] t7166_F04s = T7166_F04.values(); if(t7166_F04s != null && t7166_F04s.length > 0){for(T7166_F04 t7166_F04:t7166_F04s){ %>
														<option value="<%=t7166_F04.name() %>"><%StringHelper.filterHTML(out, t7166_F04.getChineseName()); %></option>
													<%}} %>
												</select>
												<p errortip class="" style="display: none"></p>
											</div>
											<div class="clear"></div>
										</li>
										<li id="sendTimeLi">
											<div class="til">
												<span class="red">*</span>关怀发送时间：
											</div>
											<div class="info">
												<input type="text" name="sendTime" readonly="readonly" id="datepicker1" class="yhgl_ser date required" value="<%=SQLDateParser.format(new java.sql.Date(System.currentTimeMillis())) %>" />
												<p errortip class="" style="display: none"></p>
											</div>
											<div class="clear"></div>
										</li>
										<li>
										<div class="til">
											<span class="red">*</span>关怀标题：
										</div>
										<div class="info">
											<input type="text" name="title" maxlength="30" class="text yhgl_ser yw_w5 required" />
											<p tip></p>
											<p errortip class="" style="display: none"></p>
										</div>
										<div class="clear"></div>
									</li>
									<li>
										<div class="til">
											<span class="red">*</span>关怀内容：
										</div>
										<div class="info">
											<textarea name="content" cols="80" rows="9" style="width:700px;height:200px;"></textarea>
											<p class="" style="display: none;"></p>
										</div>
										<div class="clear"></div>
									</li>
									</ul>
									<div class="tc w220 pt20">
										<input type="submit" class="btn4 mr30 sumbitForme"
											style="cursor: pointer;" fromname="form1" value="确认" /> <a
											href="<%=controller.getURI(request, Search.class)%>"
											class="btn4">返回</a>
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
			<%@include file="/WEB-INF/include/left.jsp"%>
		</div>
	</div>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
	<script type="text/javascript"
		src="<%=controller.getStaticPath(request)%>/js/validation.js"></script>
	<%@include file="/WEB-INF/include/datepicker.jsp"%>
	<script type="text/javascript"
		src="<%=controller.getStaticPath(request)%>/js/jquery-ui-1.10.4/js/time.js"></script>
	<script type="text/javascript">
		$(function() {
			$("#datepicker1").datepicker({inline: true});
		    $('#datepicker1').datepicker('option', {dateFormat:'yy-mm-dd'});
		});
		
		function changeType(v) {
			var li = document.getElementById('sendTimeLi');
			if(v == 'SR'){
				li.style.display='none';
			} else {
				li.style.display='';
			}
		}
		
		var typeSelected = document.getElementById('typeSelected').value;
		window.onload = changeType(typeSelected);
	</script>
</body>
</html>