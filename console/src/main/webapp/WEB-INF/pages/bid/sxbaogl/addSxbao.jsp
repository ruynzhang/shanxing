<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.S62.entities.SxbaoType"%>
<%@page import="java.util.List"%>
<%@page import="com.dimeng.p2p.service.SxbaoManage"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F10"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.sxbaogl.UpdateSxbao"%>
<%@page import="com.dimeng.p2p.S62.entities.SxbaoConfig"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.sxbaogl.SxbaoList"%>
<%@page import="com.dimeng.p2p.console.servlets.Region"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.sxbaogl.AddSxbao"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%
		CURRENT_CATEGORY="YWGL";
		CURRENT_SUB_CATEGORY="SXBAOGL";
		SxbaoConfig sxbaoConfig = (SxbaoConfig)request.getAttribute("sxbaoConfig");
	%>
<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="w_main">
		<div class="main clearfix">
			<div class="wrap">
				<div class="r_main">
					<div class="home_main">
						<div class="box box1 mb15">
							<div class="atil">
								<h3><%=sxbaoConfig!=null?"修改":"新增"%>善行宝信息</h3>
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
							<form action="<%=controller.getURI(request, sxbaoConfig!=null?UpdateSxbao.class:AddSxbao.class)%>" method="post" id="form1" class="form1">
								<input type="hidden" name="flag" id="flag" />
								<input type="hidden" name="id" value="<%=sxbaoConfig!=null?sxbaoConfig.id:""%>"/>
								<div class="border p30 Men_bt no_table yw_dl" id="con_one_1">
									<div class="mb20">
										<div class="yw_jcxx">
											<ul class="cell noborder">
												<li>
													<div class="til">
														<span class="red">*</span>借款账户：
													</div>
													<div class="info">
														<input type="text" class="text yhgl_ser required max-length-20" name="loanerName" value="<%=sxbaoConfig!=null?sxbaoConfig.loanerName:""%>" />
														<p tip></p>
														<p errortip class="" style="display: none"></p>
													</div>
													<div class="clear"></div>
												</li>
												<li>
													<div class="til">
														<span class="red">*</span>善行宝类型：
													</div>
													<div class="info">
														<select class="text yhgl_ser" name="typeId">
														<%SxbaoManage sxbaoManage = serviceSession.getService(SxbaoManage.class); 
														List<SxbaoType> sxbaoTypes = sxbaoManage.findAllType();
														for(SxbaoType sxbaoType : sxbaoTypes){%>
															<option value="<%=sxbaoType.id%>" <%=sxbaoConfig!=null?(sxbaoType.name.equals(sxbaoConfig.type.name)?"selected=\"selected\"":""):""%>><%=sxbaoType.name%></option>
														<%}%>
														</select>
													</div>
													<div class="clear"></div>
												</li>
												<li>
													<div class="til">
														<span class="red">*</span>借款标题：
													</div>
													<div class="info">
														<input type="text" class="text yhgl_ser required max-length-200" name="title" value="<%=sxbaoConfig!=null?sxbaoConfig.title:""%>"/>
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
														<input id="jkqx" type="text" class="text yhgl_ser required min-size-1" mtest="/^\d+$/" mtestmsg="必须为数字" name="loanPeriod" value="<%=sxbaoConfig!=null?sxbaoConfig.loanPeriod.toString():""%>"/>个月
														<p errortip class="" style="display: none"></p>
													</div>
													<div class="clear"></div>
												</li>
												<li>
													<div class="til">
														<span class="red">*</span>年利率：
													</div>
													<div class="info">
														<input type="text" class="text yhgl_ser required max-size-99.999" mtest="/^\d*(\d|(\.[0-9]{1}|\.[0-9]{2}))$/" mtestmsg="只能有两位小数" name="rate" value="<%=sxbaoConfig!=null?sxbaoConfig.rate.multiply(new BigDecimal(100)).setScale(2).toString():""%>"/> %
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
														<select class="text yhgl_ser" name="mode" id="hkfs">
															<option value="YCFQ" <%=sxbaoConfig!=null?(sxbaoConfig.mode == T6230_F10.YCFQ?"selected=\"selected\"":""):"selected=\"selected\""%>>本息到期一次付清</option>
															<option value="MYFX" <%=sxbaoConfig!=null?(sxbaoConfig.mode == T6230_F10.MYFX?"selected=\"selected\"":""):""%>>每月付息,到期还本</option>
														</select>
													</div>
													<div class="clear"></div>
												</li>
												<li>
													<div class="til">
														<span class="red">*</span>最低投资金额： <br />
													</div>
													<div class="info">
														<input type="text" class="text yhgl_ser"  class="text yhgl_ser required min-size-1" mtest="/^\d+$/" mtestmsg="必须为数字" name="investFloor" value="<%=sxbaoConfig!=null?sxbaoConfig.investFloor!=null?sxbaoConfig.investFloor.setScale(0).toString():"":""%>"/>元
														<p tip></p>
														<p errortip class="" style="display: none"></p>
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
	<script type="text/javascript" src="<%=controller.getURI(request, Region.class)%>"></script>
	<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/validation.js"></script>
	<script type="text/javascript">
	 //返回
	function returnCon(){
		window.location.href="<%=controller.getURI(request, SxbaoList.class)%>";
	}
	
	</script>
</body>
</html>