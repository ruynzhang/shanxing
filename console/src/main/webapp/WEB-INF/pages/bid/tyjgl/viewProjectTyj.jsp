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
<%@page import="com.dimeng.p2p.common.Expemonyinfo"%>
<%@page import="com.dimeng.p2p.S62.enums.T6231_F21"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F10"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F17"%>
<%@page import="com.dimeng.p2p.modules.bid.console.service.entity.BidCheck"%>
<%@page import="com.dimeng.p2p.S62.entities.T6238"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F20"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F15"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F16"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F14"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F13"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F11"%>
<%@page import="com.dimeng.p2p.S62.entities.T6211"%>
<%@page import="com.dimeng.p2p.S61.enums.T6110_F06"%>
<%@page import="com.dimeng.p2p.S62.entities.T6231"%>
<%@page import="com.dimeng.p2p.S62.entities.T6230"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.tyjgl.DetailAnnexMskTest"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.tyjgl.DetailAnnexWz"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<%@page import="com.dimeng.p2p.common.enums.LoanType"%>
<%@page import="com.dimeng.p2p.S60.enums.T6010_1_F02"%>
<%@page import="com.dimeng.p2p.console.servlets.AbstractConsoleServlet"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%
		CURRENT_CATEGORY="YWGL";
			CURRENT_SUB_CATEGORY="TYJGL";
			Expemonyinfo loan = ObjectHelper.convert(request.getAttribute("loan"), Expemonyinfo.class);
			
			if(loan==null)
			{
		     response.sendError(HttpServletResponse.SC_NOT_FOUND);
			}
			
			int loanId = request.getParameter("loanId")==null?0:Integer.parseInt(request.getParameter("loanId"));
	%>
<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="w_main">
		<div class="main clearfix">
			<div class="wrap">
				<div class="r_main">
					<div class="home_main">
						<div class="box box1 mb15">
							<div class="atil">
								<h3>查看体验金借款信息</h3>
							</div>
						</div>
						<div class="newsbox">
							<div class="til clearfix">
								<div class="Menubox">
									<ul>
										<li class="hover">项目信息</li>
										<li><a href="<%=controller.getURI(request, DetailAnnexMskTest.class)%>?loanId=<%=loanId%>">附件</a></li>
									</ul>
								</div>
							</div>
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
														<%StringHelper.filterHTML(out, loan.account_name); %>
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
														<%StringHelper.filterHTML(out, loan.title); %>
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
														<%=Formater.formatAmount(loan.borrmoney)%>元
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
														<%StringHelper.filterHTML(out, ""+loan.borrterm); %>天
														<p errortip class="" style="display: none"></p>
													</div>
													<div class="clear"></div>
												</li>
												<li>
													<div class="til">
														<span class="red">*</span>年利率：
													</div>
													<div class="info">
														<%=Formater.formatAmount(loan.borrint)%>%
														<p errortip class="" style="display: none"></p>
													</div>
													<div class="clear"></div>
												</li>
												<li>
													<div class="til">
														<span class="red">*</span>还款方式：
													</div>
													<div class="info">
														利息到期一次付清
													</div>
													<div class="clear"></div>
												</li>
												<li>
													<div class="til">
														<span class="red">*</span>筹款期限：
													</div>
													<div class="info">
														<%StringHelper.filterHTML(out, ""+loan.fundraterm); %>天
													</div>
													<div class="clear"></div>
												</li>
												<li>
													<div class="til">
														<span class="red">*</span>抵押物信息：
													</div>
													<div class="info">
														<textarea name="dywxx" cols="100" rows="8" style="width:700px;height:500px;visibility:hidden;"><%=loan.mortinfo %></textarea>
													</div>
													<div class="clear"></div>
												</li>
												<li>
													<div class="til">
														<span class="red">*</span>体验标详情：
													</div>
													<div class="info">
														<textarea name="detail" cols="100" rows="8" style="width:700px;height:500px;visibility:hidden;"><%=loan.detail %></textarea>
													</div>
													<div class="clear"></div>
												</li>
											 </ul>
									 </div>
										<div class="clear"></div>
									</div>
									<div class="tc w350">
										<input type="button" class="btn4 mr30" fromname="form1" value="返回" onclick="returnCon()"/>
									</div>
									<div class="clear"></div>
								</div>
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
</body>
</html>