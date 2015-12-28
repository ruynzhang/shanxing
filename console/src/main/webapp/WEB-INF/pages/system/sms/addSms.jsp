<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.console.servlets.system.sms.AddSms"%>
<%@page import="com.dimeng.p2p.console.servlets.system.sms.ImportSms"%>
<%@page import="com.dimeng.p2p.common.enums.SendType"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%
		String[] mobiles = ObjectHelper.convertArray(
					request.getAttribute("mobiles"), String.class);
		String sendType=request.getParameter("sendType");
		if(StringHelper.isEmpty(sendType))
		{
			sendType=SendType.ZDR.name();
		}
	%>
	<%
		CURRENT_CATEGORY = "XTGL";
			CURRENT_SUB_CATEGORY = "DXTG";
	%>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="w_main">
		<div class="main clearfix">
			<div class="wrap">
				<div class="r_main">
					<div class="home_main">
						<div class="box box1 mb15">
						<div class="atil">
	              				<h3>短信推广</h3>
	           				 </div>
							<div class="con">
								<div class="clear"></div>
								<form action="<%=controller.getURI(request, AddSms.class)%>" method="post" class="form1">
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
												<input type="radio" value="<%=type.name()%>" name="sendType" onchange="showSms('<%=type %>')" <%if(type.name().equals(sendType)) {%> checked="checked" <%} %>/><%=type.getName() %>
												<%} %>
											</div>
											<div class="clear"></div>
										</li>
										<li id="smsLi">
											<div class="til">
												<span class="red">*</span>电话号码：
											</div>
											<div class="info">
												<textarea name="mobile" id="sms" cols="45" rows="5" class="border fl mr10 yw_w5 required"><%if (mobiles != null) {for (String s : mobiles) {%><%=s+"\n"%><%}}%></textarea>
												<p tip></p>
												<p errortip class="" style="display: none"></p>
												<a href="javascript:void(0)" id="importMobile" class="btn3 tc">导入号码</a>
											</div>
											<div class="clear"></div>
										</li>
										<div id="drsm" style="padding-left: 169px;">支持导入csv、txt格式数据</div>
										<li>
											<div class="til">
												<span class="red">*</span>短信内容：
											</div>
											<div class="info orange">
												<textarea rows="7" cols="45" maxlength="200" name="content" class="border required max-length-200"></textarea>
												<p tip></p>
												<p errortip class="" style="display: none"></p>
											</div>
											<div class="clear"></div>
										</li>
									</ul>
									<div class="tc w220 pt20">
										<input type="submit" class="btn4 mr30 sumbitForme" fromname="form1" value="确认" /><input type="button" onclick="location.href='<%=controller.getURI(request, SmsList.class) %>'" class="btn4" value="返回" />
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
			<div class="w440 thickbox thickpos" style="margin:-80px 0 0 -220px;" id="showDiv">
		      <div class="info clearfix">
		      <form action="<%=controller.getURI(request, ImportSms.class)%>" method="post" enctype="multipart/form-data">
		        <div class="clearfix">
						导入手机:<input type="file" name="file" value="导入手机" />
		        </div>
		        <div class="dialog_btn">
		       <input type="submit" value="提交" class="btn3 mr10"/>
		       <input type="button" name="button2" onclick="$('#import').hide()" value="取消"  class="btn5"/>
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
		$("#importMobile").click(function() {
			$("#import").show();
		});
		$("#close").click(function() {
			$("#import").hide();
		});
		function showSms(type)
		{
			if(type=='<%=SendType.ZDR%>')
			{
				$("#smsLi").show();	
				$("#sms").attr("value","");
				$("#drsm").show();
			}else if(type=='<%=SendType.SY%>')
			{
				$("#smsLi").hide();
				$("#sms").attr("value","all");
				$("#drsm").hide();
			}
		}
	</script>
</body>
</html>