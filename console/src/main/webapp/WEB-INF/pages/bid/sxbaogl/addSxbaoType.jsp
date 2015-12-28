<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.console.servlets.bid.sxbaogl.SxbaoTypeList"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F13"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.sxbaogl.AddSxbaoType"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.sxbaogl.UpdateSxbaoType"%>
<%@page import="com.dimeng.p2p.S62.entities.SxbaoType"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="com.dimeng.p2p.console.servlets.Region"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%
		CURRENT_CATEGORY="YWGL";
		CURRENT_SUB_CATEGORY="SXBAOTYPEGL";
		SxbaoType sxbaoType = (SxbaoType)request.getAttribute("sxbaoType");
	%>
<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="w_main">
		<div class="main clearfix">
			<div class="wrap">
				<div class="r_main">
					<div class="home_main">
						<div class="box box1 mb15">
							<div class="atil">
								<h3><%=sxbaoType!=null?"修改":"新增"%>善行宝类型信息</h3>
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
							<form action="<%=controller.getURI(request, sxbaoType!=null?UpdateSxbaoType.class:AddSxbaoType.class)%>" method="post" id="form1" class="form1">
								<input type="hidden" name="flag" id="flag" />
								<input type="hidden" name="id" value="<%=sxbaoType!=null?sxbaoType.id:""%>"/>
								<div class="border p30 Men_bt no_table yw_dl" id="con_one_1">
									<div class="mb20">
										<div class="yw_jcxx">
											<ul class="cell noborder">
												<li>
													<div class="til">
														<span class="red">*</span>名称：
													</div>
													<div class="info">
														<input type="text" class="text yhgl_ser required max-length-20" name="name" value="<%=sxbaoType!=null?sxbaoType.name:""%>" />
														<p tip></p>
														<p errortip class="" style="display: none"></p>
													</div>
													<div class="clear"></div>
												</li>
												<li>
													<div class="til">
														<span class="red">*</span>状态：
													</div>
													<div class="info">
														<select class="text yhgl_ser" name="sellStatus" id="hkfs">
															<option value="F" <%=sxbaoType!=null?(sxbaoType.sellStatus == T6230_F13.F?"selected=\"selected\"":""):"selected=\"selected\""%>>停售</option>
															<option value="S" <%=sxbaoType!=null?(sxbaoType.sellStatus == T6230_F13.S?"selected=\"selected\"":""):""%>>发售</option>
														</select>
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
		window.location.href="<%=controller.getURI(request, SxbaoTypeList.class)%>";
	}
	
	</script>
</body>
</html>