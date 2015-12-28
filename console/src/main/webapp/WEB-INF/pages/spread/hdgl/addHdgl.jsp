<%@page import="com.dimeng.p2p.console.servlets.spread.hdgl.AddHdgl"%>
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
		CURRENT_CATEGORY = "TGGL";
		CURRENT_SUB_CATEGORY = "HDGL";
	%>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="w_main">
		<div class="main clearfix">
			<div class="wrap">
				<div class="r_main">
					<div class="home_main">
						<div class="box box1 mb15">
							<div class="atil">
								<h3>添加活动</h3>
							</div>
							<div class="con">
								<div class="clear"></div>
								<form name="example" method="post"
									action="<%=controller.getURI(request, AddHdgl.class)%>"
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
												<span class="red">*</span>活动名称：
											</div>
											<div class="info">
												<input type="text" name="title"
													class="text yhgl_ser required max-length-15"
													value="" />
												<div class="clear"></div>
												<p tip>不能为空</p>
												<p errortip class="" style="display: none"></p>
											</div>
											<div class="clear"></div>
										</li>
										<li>
											<div class="til">
												<span class="red">*</span>金额：
											</div>
											<div class="info">
												<input type="text" name="money"
													class="text yhgl_ser required"
													mtest="/^((([1-9][0-9]*)|0)|((([1-9][0-9]*)|0)\.[0-9]{1,2}))$/"
													mtestmsg="必须为金额格式(且是两位有效数字)" value="" />元
												<div class="clear"></div>
												<p tip>不能为空</p>
												<p errortip class="" style="display: none"></p>
											</div>
											<div class="clear"></div>
										</li>
										<li>
											<div class="til">
												<span class="red">*</span>开始时间：
											</div>
											<div class="info">
												<input type="text" name="startTime" readonly="readonly"
													id="datepicker1" class="yhgl_ser date required"
													value="" />
												<div class="clear"></div>
												<p tip>不能为空</p>
												<p errortip class="" style="display: none"></p>
											</div>
											<div class="clear"></div>
										</li>
										<li>
											<div class="til">
												<span class="red">*</span>结束时间：
											</div>
											<div class="info">
												<input type="text" name="endTime" readonly="readonly"
													id="datepicker2" class="yhgl_ser date required"
													value="" />
												<p id="endTimeError"></p>
												<div class="clear"></div>
												<p tip>不能为空</p>
												<p errortip class="" style="display: none"></p>
											</div>
											<div class="clear"></div>
										</li>
										<li>
											<div class="til">
												<span class="red">*</span>优惠券生效时间：
											</div>
											<div class="info">
												<input type="text" name="couponStartTime"
													readonly="readonly" id="datepicker3"
													class="yhgl_input mr5 date"
													value="" />
												<p id="endTimeError"></p>
												<div class="clear"></div>
												<p tip>不能为空</p>
												<p errortip class="" style="display: none"></p>
											</div>
											<div class="clear"></div>
										</li>
										<li>
											<div class="til">
												<span class="red">*</span>优惠券失效时间：
											</div>
											<div class="info">
												<input type="text" name="couponEndTime" readonly="readonly"
													id="datepicker4" class="yhgl_input mr5 date"
													value="" />
												<p id="endTimeError"></p>
												<div class="clear"></div>
												<p tip>不能为空</p>
												<p errortip class="" style="display: none"></p>
											</div>
											<div class="clear"></div>
										</li>
										<li>
											<div class="til">
												<span class="red">*</span>发放数量：
											</div>
											<div class="info">
												<input type="text" maxlength="9" name="amount" class="text yhgl_ser required isint" value=""/>
												<div class="clear"></div>
												<p tip>不能为空</p>
												<p errortip class="" style="display: none"></p>
											</div>
											<div class="clear"></div>
										</li>
										<li>
										<li>
											<div class="til">
												<span class="red">*</span>最低充值金额：
											</div>
											<div class="info">
												<input type="text" name="leastRecharge"
													class="text yhgl_ser required"
													mtest="/^((([1-9][0-9]*)|0)|((([1-9][0-9]*)|0)\.[0-9]{1,2}))$/"
													mtestmsg="必须为金额格式(且是两位有效数字)" value="" />元
												<div class="clear"></div>
												<p tip>不能为空</p>
												<p errortip class="" style="display: none"></p>
											</div>
											<div class="clear"></div>
										</li>
										<li>
											<div class="til">
												<span class="red">*</span>最低投资金额：
											</div>
											<div class="info">
												<input type="text" name="leastInvest"
													class="text yhgl_ser required"
													mtest="/^((([1-9][0-9]*)|0)|((([1-9][0-9]*)|0)\.[0-9]{1,2}))$/"
													mtestmsg="必须为金额格式(且是两位有效数字)" value="" />元
												<div class="clear"></div>
												<p tip>不能为空</p>
												<p errortip class="" style="display: none"></p>
											</div>
											<div class="clear"></div>
										</li>
										<li>
											<div class="til">
												<span class="red">*</span>推广人数：
											</div>
											<div class="info">
												<input type="text" name="spreadPersons"
													class="text yhgl_ser required" value="">
											</div>
											<div class="clear"></div>
										</li>
									</ul>
									<div class="tc w220 pt20">
										<input type="submit" class="btn4 mr30 sumbitForme"
											style="cursor: pointer;" fromname="form1" value="确认发布" /> <a
											href="<%=controller.getURI(request, SearchHdgl.class)%>"
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
			$('#datepicker1').datetimepicker({
				timeFormat : 'HH:mm:ss',
				dateFormat : 'yy-mm-dd'

			});
			$('#datepicker2').datetimepicker({
				timeFormat : 'HH:mm:ss',
				dateFormat : 'yy-mm-dd'

			});
			$("#datepicker3").datepicker({inline: true});
		    $('#datepicker3').datepicker('option', {dateFormat:'yy-mm-dd'});
		    $("#datepicker4").datepicker({inline: true});
		    $('#datepicker4').datepicker('option', {dateFormat:'yy-mm-dd'});
		});
		
		var endTime = false;
		$("#datepicker2").blur(function(){
			var datepicker1 = $("#datepicker1").val();
			var datepicker2 = $("#datepicker2").val();
			if(datepicker1>datepicker2){
				$("#endTimeError").html("结束时间不能小于开始时间");
				$("#endTimeError").addClass("error_tip");
				$("#endTimeError").show();
				endTime = false;
			}else{
				$("#endTimeError").hide();
				endTime = true;
			}
		});
		
		function onSubmit(){
			$("#datepicker2").trigger("blur");
			return endTime;
		}
	</script>
</body>
</html>