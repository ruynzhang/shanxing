<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.console.servlets.offline.SetViewPic"%>
<%@page import="com.dimeng.p2p.console.servlets.offline.OfflineLoanList"%>
<%@page import="com.dimeng.p2p.console.servlets.offline.DetailAuthentication"%>
<%@page import="com.dimeng.p2p.console.servlets.offline.ViewHkRecord"%>
<%@page import="com.dimeng.p2p.console.servlets.offline.ViewRecord"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="com.dimeng.p2p.modules.bid.console.service.entity.WzAnnex"%>
<%@page import="com.dimeng.p2p.console.servlets.offline.NotThrough"%>
<%@page import="com.dimeng.p2p.console.servlets.offline.Check"%>
<%@page import="com.dimeng.p2p.console.servlets.offline.AdjustCredit"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F20"%>
<%@page import="com.dimeng.p2p.S62.entities.T6233"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F13"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F11"%>
<%@page import="com.dimeng.p2p.console.servlets.offline.ViewAnnexMsk"%>
<%@page import="com.dimeng.p2p.S62.entities.T6230"%>
<%@page import="com.dimeng.p2p.S61.enums.T6110_F06"%>
<%@page import="com.dimeng.p2p.console.servlets.offline.ViewAnnexWz"%>
<%@page import="com.dimeng.p2p.console.servlets.offline.ViewEnterprise"%>
<%@page import="com.dimeng.p2p.console.servlets.offline.ViewGuarantee"%>
<%@page import="com.dimeng.p2p.console.servlets.offline.DetailAnnexMsk"%>
<%@page import="com.dimeng.p2p.console.servlets.offline.ViewDyw"%>
<%@page import="com.dimeng.p2p.console.servlets.offline.ViewUserInfo"%>
<%@page import="com.dimeng.p2p.console.servlets.offline.ViewProject"%>
<%@page import="com.dimeng.p2p.common.enums.LoanType"%>
<%@page import="com.dimeng.p2p.S60.enums.T6216_F05"%>
<%@page import="com.dimeng.p2p.console.servlets.offline.DelAnnexMsk"%>
<%@page import="com.dimeng.p2p.S60.enums.T6216_F03"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%
		CURRENT_CATEGORY="YWGL";
		CURRENT_SUB_CATEGORY="XXZQGL";
		WzAnnex[] t6233s =ObjectHelper.convertArray(request.getAttribute("t6233s"), WzAnnex.class);
		T6110_F06 userType=EnumParser.parse(T6110_F06.class, request.getAttribute("userType").toString());
		T6230 t6230=ObjectHelper.convert(request.getAttribute("t6230"), T6230.class);
		int loanId=IntegerParser.parse(request.getParameter("loanId"));
		int userId=IntegerParser.parse(request.getParameter("userId"));
		BigDecimal creditAmount=ObjectHelper.convert(request.getAttribute("creditAmount"), BigDecimal.class);
	%>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="w_main">
		<div class="main clearfix">
			<div class="wrap">
				<div class="r_main">
					<div class="home_main">
						<div class="box box1 mb15">
							<div class="atil">
								<h3>查看借款信息</h3>
							</div>
						</div>
						<div class="newsbox">
							<div class="til clearfix">
							<a href="<%=controller.getURI(request, OfflineLoanList.class)%>"
									class="btn4 tc" style="float: right" >返回</a>
								<div class="Menubox">
									<ul>
										<li><a href="<%=controller.getURI(request, ViewProject.class)%>?loanId=<%=loanId%>&userId=<%=userId%>">项目信息</a></li>
										<%
											if(userType==T6110_F06.ZRR)
																			{
										%>
										<li><a href="<%=controller.getURI(request, ViewUserInfo.class)%>?loanId=<%=loanId%>&userId=<%=userId%>">个人信息</a></li>
										<li><a href="<%=controller.getURI(request, DetailAuthentication.class)%>?loanId=<%=loanId%>&userId=<%=userId%>">个人认证信息</a></li>
										<%
											}
										%>
										<%
											if(userType==T6110_F06.FZRR)
																			{
										%>
										<li><a href="<%=controller.getURI(request, ViewEnterprise.class)%>?loanId=<%=loanId%>&userId=<%=userId%>">企业信息</a></li>
										<%
											}
										%>
										<%
											if(T6230_F13.S==t6230.F13){
										%>
										<li><a href="<%=controller.getURI(request, ViewDyw.class)%>?loanId=<%=loanId%>&userId=<%=userId%>">抵押物信息</a></li>
										<%} %>
										<%
											if(T6230_F11.S==t6230.F11)
											{
										%>
										<li><a href="<%=controller.getURI(request, ViewGuarantee.class)%>?loanId=<%=loanId%>&userId=<%=userId%>">担保信息</a></li>
										<%} %>
										<li><a href="<%=controller.getURI(request, DetailAnnexMsk.class)%>?loanId=<%=loanId%>&userId=<%=userId%>">附件(马赛克)</a></li>
										<li class="hover">附件(完整版)</li>
										<%
										if(t6230.F20!=T6230_F20.SQZ&&t6230.F20!=T6230_F20.DSH&&t6230.F20!=T6230_F20.DFB&&t6230.F20!=T6230_F20.YFB)
											{
										%>
										<li><a href="<%=controller.getURI(request, ViewRecord.class)%>?loanId=<%=loanId%>&userId=<%=userId%>">投资记录</a></li>
										<li><a href="<%=controller.getURI(request, ViewHkRecord.class)%>?loanId=<%=loanId%>&userId=<%=userId%>">还款计划</a></li>
										<%} %>
									</ul>
								</div>
							</div>
							<div class="border p30 Men_bt no_table">
								<div class="mb20">
									<div class="yw_jcxx">
										<table width="100%" border="0" cellspacing="0" cellpadding="3" class="yhgl_table tc">
											<tr class="hsbg">
												<td>序号</td>
												<td>附件名称</td>
												<td>附件大小</td>
												<td>附件格式</td>
												<td>上传人</td>
												<td>附件类型</td>
												<td>上传时间</td>
												<td>操作</td>
											</tr>
											<%
												if(t6233s!=null)
												{int i=1;
												for(WzAnnex t6233:t6233s)
												{	if(t6233==null){continue;}
											%>
											<tr>
												<td><%=i++%></td>
												<td>
													<%
														StringHelper.filterHTML(out, t6233.F04);
													%>
												</td>
												<td><%=t6233.F05/1000%>kb</td>
												<td>
													<%
														StringHelper.filterHTML(out, t6233.F07);
													%>
												</td>
												<td>
													<%
														StringHelper.filterHTML(out, t6233.name);
													%>
												</td>
												<td><%
														StringHelper.filterHTML(out, t6233.annexName);
													%></td>
												<td><%=DateTimeParser.format(t6233.F08)%></td>
												<td>
												<a href="<%=controller.getURI(request, SetViewPic.class)%>?loanId=<%=loanId%>&userId=<%=userId%>&id=<%=t6233.F01%>">设为图标</a>
												<a href="<%=controller.getURI(request, ViewAnnexWz.class)%>?id=<%=t6233.F01%>" target="_blank">查看</a></td>
											</tr>
											<%}} %>
										</table>
									</div>
								</div>
								<%
								if(t6230.F20==T6230_F20.DSH)
								{
								%>
									<div class="tc w350 pt20">
										<%if(creditAmount.compareTo(t6230.F05)>=0){%>
										<a href="<%=controller.getURI(request, Check.class) %>?loanId=<%=loanId %>&userId=<%=userId %>" class="btn4 mr10">审核通过</a>&nbsp;&nbsp;
										<a href="javascript:void(0)" onclick="showSh()" class="btn5">审不核通过</a>
										<%}else{ %>
										<a href="javascript:void(0)" class="btn5 mr10">审核通过</a>
										<a href="javascript:void(0)" onclick="showSh()" class="btn4 mr10">审不核通过</a>
										<%} %>
									</div>
			                    	<%if(creditAmount.compareTo(t6230.F05)<0){%>
			                    	<span style="color: red">用户信用额度小于借款金额,<a href="<%=controller.getURI(request, XyList.class)%>">调整</a></span>
			                    	<%} %>
			                    <%} %>
								<div class="clear"></div>
							</div>
						</div>
						<div class="clear"></div>
					</div>
				</div>
			</div>
			<%@include file="/WEB-INF/include/left.jsp"%>
		</div>
	</div>
	<div class="w440 thickbox thickpos" id="sh" style="margin:-100px 0 0 -220px;display: none;">
			  <div class="tit"><span class="fr pr15 close" onclick="javascript:document.getElementById('sh').style.display='none';return false;"><a href="javascript:void(0);" >关闭</a></span> </div>
			  <form action="<%=controller.getURI(request, NotThrough.class) %>" id="shForm" method="post" class="form1">
			  	<input type="hidden" name="loanId" value="<%=loanId %>"/>
			  	<input type="hidden" name="useId" value="<%=userId %>"/>
			    <div class="info clearfix">
			      <div class="mb10">
			        <div id="u303">
			          <p><i class="red">*</i>审核处理结果描述（50字以内）</p>
			        </div>
			      </div>
			      <div class="cell clearfix">
			       <textarea name="des" id="textarea2"  cols="45" rows="5" class="area required max-length-50" style="width:100%"></textarea>
			       <p tip></p>
					<p errortip class="" style="display: none"></p>
			      </div>
			      <div class="clear"></div>
			      <div class="dialog_btn">
			      <input name="button" type="submit" onclick="shbtg()"  class="btn4 fl sumbitForme" id="button3" fromname="form1" value="确认"/>
			      <input type="button" id="button2" value="取消" onclick="javascript:document.getElementById('sh').style.display='none';return false;"  class="btn5 fl mr10 sumbitForme" fromname="form1"/>
			      </div>      
			    </div>
			  </form>
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
	<%@include file="/WEB-INF/include/dialog.jsp"%>
	<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/validation.js"></script>
	<script type="text/javascript">
		function tcc(evn, tid, url, titl) {
			global_art = art.dialog.open(url, {
				id : tid,
				title : titl,
				opacity : 0.1,
				width : 783,
				height : 500,
				lock : true,
				close : function() {
					var iframe = this.iframe.contentWindow;
					var isupload = iframe.document.getElementById('isupload');
					if (isupload == null || "" == isupload
							|| "undefind" == isupload) {

					}
					if (isupload.value == "1") {

						$(evn).parent().parent().before(
								'<dt class="ico14"></dt>');
					}
				}
			}, false);
		}
		function showSh()
		{
			$("#sh").show();
		}
	</script>
</body>
</html>