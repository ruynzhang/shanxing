<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.math.BigDecimal"%>
<%@page import="com.dimeng.p2p.console.servlets.Region"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<%@page import="com.itextpdf.tool.xml.pipeline.ctx.ObjectContext"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.tyjgl.AddProjectTyj"%>
<%@page import="com.dimeng.p2p.console.servlets.AbstractConsoleServlet"%>
<%@page import="com.dimeng.p2p.console.servlets.info.aqbz.bxdb.UpdateBxdb"%>
<%@page import="com.dimeng.p2p.variables.FileType"%>
<%@page import="com.dimeng.p2p.console.servlets.upload.Upload"%> 
<%@page import="com.dimeng.util.ObjectHelper"%>
<%@page import="com.dimeng.p2p.S62.enums.SURPRISE_NAME"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%
		CURRENT_CATEGORY="YWGL";
		CURRENT_SUB_CATEGORY="TYJGL";
	%>
<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="w_main">
		<div class="main clearfix">
			<div class="wrap">
				<div class="r_main">
					<div class="home_main">
						<div class="box box1 mb15">
							<div class="atil">
								<h3>新增体验金借款信息</h3>
							</div>
						</div>
						<div class="newsbox">
							<div class="til clearfix">
								<div class="Menubox">
									<ul>
										<li class="hover">项目信息</li>
									</ul>
								</div>
							</div>
							<form action="<%=controller.getURI(request, AddProjectTyj.class)%>" method="post" id="form1" class="form1">
								<input type="hidden" name="flag" id="flag" />
								<div class="border p30 Men_bt no_table yw_dl" id="con_one_1">
									<div class="mb20">
										<div class="yw_jcxx">
											<ul class="cell noborder">
												<li>
													<div class="til">
														<span class="red">*</span>借款账户：
													</div>
													<div class="info">
														<input type="text" class="text yhgl_ser required max-length-20" name="name" value="" />
														<p tip></p>
														<p errortip class="" style="display: none"></p>
													</div>
													<div class="clear"></div>
												</li>
												<li>
													<div class="til">
														<span class="red">*</span>借款标题：
													</div>
													<div class="info">
														<input type="text" class="text yhgl_ser required max-length-200" name="F03" value=""/>
														<p tip></p>
														<p errortip class="" style="display: none"></p>
													</div>
													<div class="clear"></div>
												</li>
												<li>
													<div class="til">
														<span class="red">*</span>借款金额： <br />
													</div>
													<div class="info">
														<input type="text" class="text yhgl_ser"  maxlength="15" mtest="/^((([1-9][0-9]*)|0)|((([1-9][0-9]*)|0)\.[0-9]{1,2}))$/" mtestmsg="必须为数字格式(且是两位小数)"  name="F05" value=""/>元
														<p tip></p>
														<p errortip class="" style="display: none"></p>
													</div>
													<div class="clear"></div>
												</li>
												<li>
													<div class="til">
														<span class="red">*</span>借款期限：
													</div>
													<div class="info">
														<input id="jkqx" type="text" class="text yhgl_ser required min-size-1" mtest="/^\d+$/" mtestmsg="必须为数字" name="F09" value="10"/>天
														<p errortip class="" style="display: none"></p>
													</div>
													<div class="clear"></div>
												</li>
												<li>
													<div class="til">
														<span class="red">*</span>年利率：
													</div>
													<div class="info">
														<input type="text" class="text yhgl_ser required max-size-99.999" mtest="/^\d*(\d|(\.[0-9]{1}|\.[0-9]{2}))$/" mtestmsg="只能有两位小数" name="F06" value="12"/> %
														<span tip>&nbsp;(利率精确到小数点后两位且小于100)</span>
														<p errortip class="" style="display: none"></p>
													</div>
													<div class="clear"></div>
												</li>
												<li>
													<div class="til">
														<span class="red">*</span>还款方式：
													</div>
													<div class="info">
														<select class="text yhgl_ser" name="F10" id="hkfs">
															<option value="YCFQ" selected="selected">利息到期一次付清</option>
														</select>
													</div>
													<div class="clear"></div>
												</li>
												<li>
													<div class="til">
														<span class="red">*</span>筹款期限：
													</div>
													<div class="info">
														<select class="text yhgl_ser" name="F08">
															<%int cbqx = IntegerParser.parse(request.getParameter("F08")); %>
															<%
																for(int i=1;i<=31;i++)
																{
															%>
															<option value="<%=i %>" <%if(cbqx==i){ %>selected="selected"<%} %>><%=i %></option>
															<%} %>
														</select>天
													</div>
													<div class="clear"></div>
												</li>
												<li>
													<div class="til">
														<span class="red">*</span>抵押物信息：
													</div>
													<div class="info orange">
                   	                              <textarea name="dywxx" cols="100" rows="8" style="width:700px;height:500px;visibility:hidden;"><%StringHelper.format(out, request.getParameter("dywxx"), fileStore); %></textarea>
                  		                             <p id="errorContent">&nbsp;</p>
                                                 </div>
													<div class="clear"></div>
												</li>
												<li>
													<div class="til">
														<span class="red">*</span>体验标详情：
													</div>
													<div class="info orange">
                   	                              <textarea name="detail" cols="100" rows="8" style="width:700px;height:500px;visibility:hidden;"><%StringHelper.format(out, request.getParameter("detail"), fileStore); %></textarea>
                  		                             <p id="errorContent2">&nbsp;</p>
                                                 </div>
													<div class="clear"></div>
												</li>
											 </ul>
									 </div>
										<div class="clear"></div>
									</div>
									<div class="tc w350">
										<input type="submit" class="btn4 mr30 sumbitForme" fromname="form1" value="保存" />
										<input type="button" class="btn4 mr30" fromname="form1" value="返回" onclick="returnCon()"/>
									</div>
									<div class="clear"></div>
								</div>
							</form>
						</div>
					</div>
					<div class="clear"></div>
				</div>
			</div>
			<%@include file="/WEB-INF/include/left.jsp"%>
		</div>		
	</div>
	<%
		String warringMessage=controller.getPrompt(request, response, PromptLevel.WARRING);
		if(!StringHelper.isEmpty(warringMessage))
		{
	%>
	<div class="w440 thickbox thickpos" style="margin:-80px 0 0 -220px;" id="showDiv">
      <div class="info clearfix">
        <div class="clearfix">
            <span class="fl tips"><%StringHelper.filterHTML(out, warringMessage); %></span>
        </div>
        <div class="dialog_btn"><input type="button" name="button2" onclick="$('#showDiv').hide()" value="确认"  class="btn4 ml50"/></div> 
      </div>
	</div>
	<%} %>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
	<%@include file="/WEB-INF/include/kindeditor.jsp" %>
	<%@include file="/WEB-INF/include/datepicker.jsp"%>
	<script type="text/javascript" src="<%=controller.getURI(request, Region.class)%>"></script>
	<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/validation.js"></script>
	<script type="text/javascript">
	 //返回
	function returnCon(){
		window.location.href="<%=controller.getURI(request, TyjglList.class)%>";
	}
	
	</script>
</body>

<script type="text/javascript">
		var editor1;
		KindEditor.ready(function(K) {
			editor1 = K.create('textarea[name="dywxx"]', {
				uploadJson : '<%=controller.getURI(request, Upload.class)%>?type=<%=FileType.ARTICLE_ATTACHMENT.ordinal()%>',
				allowFileManager : false,
				formatUploadUrl: false,
				afterBlur:function(){
					this.sync();
					if(this.count('text')=='')
					{
						$("#errorContent").addClass("red");
						$("#errorContent").html("抵押物信息不能为空");	
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
		var editor2;
		KindEditor.ready(function(K) {
			editor2 = K.create('textarea[name="detail"]', {
				uploadJson : '<%=controller.getURI(request, Upload.class)%>?type=<%=FileType.ARTICLE_ATTACHMENT.ordinal()%>',
				allowFileManager : false,
				formatUploadUrl: false,
				afterBlur:function(){
					this.sync();
					if(this.count('text')=='')
					{
						$("#errorContent2").addClass("red");
						$("#errorContent2").html("体验标详情不能为空");	
					}
					else
					{
						$("#errorContent2").removeClass("red");
						$("#errorContent2").html("&nbsp;");
					}
				}
			});
			prettyPrint();
		});
	</script>
</html>