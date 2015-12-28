<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.console.servlets.offline.OfflineLoanList"%>
<%@page import="com.dimeng.p2p.console.servlets.offline.ViewAuthentication"%>
<%@page import="com.dimeng.p2p.S62.entities.T6240"%>
<%@page import="com.dimeng.p2p.S62.entities.T6238"%>
<%@page import="com.dimeng.p2p.console.servlets.offline.AddEnterpriseXq"%>
<%@page import="com.dimeng.p2p.console.servlets.offline.AddUserInfoXq"%>
<%@page import="com.dimeng.p2p.console.servlets.offline.ViewEnterprise"%>
<%@page import="com.dimeng.p2p.console.servlets.offline.ViewUserInfo"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F17"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F12"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F16"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F15"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F14"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F10"%>
<%@page import="com.dimeng.p2p.S62.entities.T6211"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F13"%>
<%@page import="com.dimeng.p2p.S61.enums.T6110_F06"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F11"%>
<%@page import="com.dimeng.p2p.S62.entities.T6231"%>
<%@page import="com.dimeng.p2p.S62.entities.T6230"%>
<%@page import="com.dimeng.p2p.S60.enums.T6036_F11"%>
<%@page import="com.dimeng.p2p.console.servlets.offline.UpdateProject"%>
<%@page import="com.dimeng.p2p.console.servlets.offline.AddAnnexWz"%>
<%@page import="com.dimeng.p2p.console.servlets.offline.AddAnnexMsk"%>
<%@page import="com.dimeng.p2p.console.servlets.offline.AddGuaranteeXq"%>
<%@page import="com.dimeng.p2p.console.servlets.offline.AddDyw"%>
<%@page import="com.dimeng.p2p.common.enums.LoanType"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<%@page import="com.dimeng.p2p.console.servlets.offline.AddProjectXq"%>
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
			CURRENT_SUB_CATEGORY="XXZQGL";
			T6230 info = ObjectHelper.convert(request.getAttribute("loan"), T6230.class);
			T6231 t6231=ObjectHelper.convert(request.getAttribute("t6231"), T6231.class);
			T6230 t6230=ObjectHelper.convert(request.getAttribute("t6230"), T6230.class);
			T6110_F06 userType=EnumParser.parse(T6110_F06.class, request.getAttribute("userType").toString());
			T6211[] t6211s=ObjectHelper.convertArray(request.getAttribute("t6211s"), T6211.class);
			T6238 t6238=ObjectHelper.convert(request.getAttribute("t6238"), T6238.class);
			T6240 t6240=ObjectHelper.convert(request.getAttribute("t6240"), T6240.class);
			String userName=ObjectHelper.convert(request.getAttribute("userName"), String.class);
			String zqrName=ObjectHelper.convert(request.getAttribute("zqrName"), String.class);
			if(info==null)
			{
		response.sendError(HttpServletResponse.SC_NOT_FOUND);
			}
			int loanId=IntegerParser.parse(request.getParameter("loanId"));
			int userId=IntegerParser.parse(request.getParameter("userId"));
			int shengId=0;
			int shiId=0;
			int xianId=0;
			final int regionId = t6231.F07;
			if (regionId % 10000 < 100) {
		            shengId = regionId;
		        } else if (regionId % 100 < 1) {
		            shengId = regionId / 10000 * 10000;
		            shiId = regionId;
		        } else {
		            shengId = regionId / 10000 * 10000;
		            shiId = regionId / 100 * 100;
		            xianId = regionId;
		       }
	%>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="w_main">
		<div class="main clearfix">
			<div class="wrap">
				<div class="r_main">
					<div class="home_main">
						<div class="box box1 mb15">
							<div class="atil">
								<h3>修改线下债权转让信息</h3>
							</div>
						</div>
						<div class="newsbox">
							<div class="til clearfix">
								<div class="Menubox">
									<ul>
										<li class="hover">项目信息</li>
										<%
											if(userType==T6110_F06.ZRR)
																			{
										%>
										<li><a href="<%=controller.getURI(request, AddUserInfoXq.class)%>?loanId=<%=loanId%>&userId=<%=userId%>">个人信息</a></li>
										<li><a href="<%=controller.getURI(request, ViewAuthentication.class)%>?loanId=<%=loanId%>&userId=<%=userId%>">个人认证信息</a></li>
										<%
											}
										%>
										<%
											if(userType==T6110_F06.FZRR)
																			{
										%>
										<li><a href="<%=controller.getURI(request, AddEnterpriseXq.class)%>?loanId=<%=loanId%>&userId=<%=userId%>">企业信息</a></li>
										<%
											}
										%>
										<%
											if(T6230_F13.S==t6230.F13){
										%>
										<li><a href="<%=controller.getURI(request, AddDyw.class)%>?loanId=<%=loanId%>&userId=<%=userId%>">抵押物信息</a></li>
										<%} %>
										<%
											if(T6230_F11.S==t6230.F11)
											{
										%>
										<li><a href="<%=controller.getURI(request, AddGuaranteeXq.class)%>?loanId=<%=loanId%>&userId=<%=userId%>">担保信息</a></li>
										<%} %>
										<li><a href="<%=controller.getURI(request, AddAnnexMsk.class)%>?loanId=<%=loanId%>&userId=<%=userId%>">附件(马赛克)</a></li>
										<li><a href="<%=controller.getURI(request, AddAnnexWz.class)%>?loanId=<%=loanId%>&userId=<%=userId%>">附件(完整版)</a></li>
									</ul>
								</div>
							</div>
							<input id="shengId" value="<%=shengId%>" type="hidden" /> <input id="shiId" value="<%=shiId%>" type="hidden" /> <input id="xianId" value="<%=xianId%>" type="hidden" />
							<form action="<%=controller.getURI(request, UpdateProject.class)%>" method="post" class="form1" id="form1">
								<input type="hidden" name="flag" id="flag" /> 
								<input type="hidden" name="userId" value="<%=userId%>"> 
								<input type="hidden" name="userType" value="<%=userType%>"> 
								<input type="hidden" name="loanId" value="<%=loanId%>">
								<input type="hidden" name="zqrId" value="<%=zqrName %>"/>
								<div class="border p30 Men_bt no_table yw_dl" id="con_one_1">
									<div class="mb20">
										<div class="yw_jcxx">
											<ul class="cell noborder">
												<li>
													<div class="til">
														<span class="red">*</span>转让标题：
													</div>
													<div class="info">
														<input type="text" class="text yhgl_ser required max-length-200" name="zrbt" value="<%StringHelper.filterHTML(out, t6240.F05); %>"/>
														<p tip></p>
														<p errortip class="" style="display: none"></p>
													</div>
													<div class="clear"></div>
												</li>
												<li>
													<div class="til">
														<span class="red">*</span>剩余期限：
													</div>
													<div class="info">
														<input type="text" name="syqx" class="text yhgl_ser required isint" value="<%=t6240.F03%>"/>天
														<p tip></p>
														<p errortip class="" style="display: none"></p>
													</div>
													<div class="clear"></div>
												</li>
												<%-- <li>
													<div class="til">
														<span class="red">*</span>债权价值：
													</div>
													<div class="info">
														<input type="text" class="text yhgl_ser required" mtestmsg="必须为金额格式(且是两位有效数字)" mtest="/^((([1-9][0-9]*)|0)|((([1-9][0-9]*)|0)\.[0-9]{1,2}))$/" name="zqjz" value="<%=t6240.F04 %>"/> 元 
														<p tip></p>
														<p errortip class="" style="display: none"></p>
													</div>
													<div class="clear"></div>
												</li> --%>
												<%--
												<li>
													<div class="til">
														<span class="red">*</span>预计收益：
													</div>
													<div class="info">
														<input type="text" class="text yhgl_ser required" mtestmsg="必须为金额格式(且是两位有效数字)" mtest="/^((([1-9][0-9]*)|0)|((([1-9][0-9]*)|0)\.[0-9]{1,2}))$/" name="yjsy" value="<%=t6240.F06 %>"/>元
														<p tip></p>
														<p errortip class="" style="display: none"></p>
													</div>
													<div class="clear"></div>
												</li>
												 --%>
												<li>
													<div class="til">
														<span class="red">*</span>债权人：
													</div>
													<div class="info">
														<%
															String zqr=request.getParameter("zqr");
														%>
														<%
															if(t6240.F02>0)
															{
														%>
														<input type="text" class="text yhgl_ser" name="zqr" disabled="disabled" value="<%StringHelper.filterHTML(out, zqrName); %>"/>
														<%}else{ %>
														<input type="text" class="text yhgl_ser required max-length-20" name="zqr" <%if(!StringHelper.isEmpty(zqr)){ %>  value="<%StringHelper.filterHTML(out, request.getParameter("zqr"));%>" <%}else { %> value="<%StringHelper.filterHTML(out, zqrName); %>" <%} %>/>
														<%} %>
														<p tip></p>
														<p errortip class="" style="display: none"></p>
													</div>
													<div class="clear"></div>
												</li>
												<li>
													<div class="til">
														<span class="red">*</span>原始投资金额：
													</div>
													<div class="info">
														<input type="text" class="text yhgl_ser"  maxlength="15" mtest="/^((([1-9][0-9]*)|0)|((([1-9][0-9]*)|0)\.[0-9]{1,2}))$/" mtestmsg="必须为数字格式(且是两位小数)" name="ystzje" value="<%=t6240.F07 %>"/>
														<p tip></p>
														<p errortip class="" style="display: none"></p>
													</div>
													<div class="clear"></div>
												</li>
												<li>
													<div class="til">
														<span class="red">*</span>债务人：
													</div>
													<div class="info">
														<%
															String name=request.getParameter("name");
														%>
														<%
															if(userId>0)
															{
														%>
														<input type="text" class="text yhgl_ser" name="name" disabled="disabled" value="<%StringHelper.filterHTML(out, userName); %>"/>
														<%}else{ %>
														<input type="text" class="text yhgl_ser required max-length-20" name="name" <%if(!StringHelper.isEmpty(name)){ %>  value="<%StringHelper.filterHTML(out, request.getParameter("name"));%>" <%}else { %> value="<%StringHelper.filterHTML(out, userName); %>" <%} %>/>
														<%} %>
													</div>
													<div class="clear"></div>
												</li>
												<li>
													<div class="til">
														<span class="red">*</span>债权类型：
													</div>
													<div class="info">
														<select id="select" class="text yhgl_ser" name="F04">
														<%int type =info.F04; %>
															<%
															if(t6211s!=null){
																for(T6211 t6211:t6211s)
																{
																	if(t6211==null)
																	{
																		continue;
																	}
															%>
															<option value="<%=t6211.F01 %>" <%if(type==t6211.F01){ %>selected="selected"<%} %>><%StringHelper.filterHTML(out, t6211.F02); %></option>
															<%}} %>
														</select>
													</div>
													<div class="clear"></div>
												</li>
												<li>
													<div class="til">
														<span class="red">*</span>债权所在地：
													</div>
													<div class="info"></div>
													<div class="info">
														<select name="sheng" class="sel01">
														</select> <select name="shi" class="sel01">
														</select> <select name="xian" class="sel01 required">
														</select>
														<p tip></p>
														<p errortip class="" style="display: none"></p>
													</div>
													<div class="clear"></div>
												</li>
												<li>
													<div class="til">
														<span class="red">*</span>债权金额： <br />
													</div>
													<div class="info">
														<input type="text" class="text yhgl_ser"  maxlength="15" mtest="/^((([1-9][0-9]*)|0)|((([1-9][0-9]*)|0)\.[0-9]{1,2}))$/" mtestmsg="必须为数字格式(且是两位小数)" name="F05" value="<%=info.F05%>" />元
														<p tip></p>
														<p errortip class="" style="display: none"></p>
													</div>
													<div class="clear"></div>
												</li>
												<li>
													<div class="til">
														<span class="red"></span><br />
													</div>
													<div class="info">
														<input type="hidden" name="F11" value="S"/>
														<input type="checkbox" checked="checked" disabled="disabled"/>有担保
														<input type="checkbox" name="F13" value="S" <%if(info.F13==T6230_F13.S){ %> checked="checked" <%} %>/>有抵押
														<input type="checkbox" name="F14" value="S" <%if(info.F14==T6230_F14.S){ %> checked="checked" <%} %>/>有实地认证
														<%--<input type="checkbox" name="F15" value="S" <%if(info.F15==T6230_F15.S){ %> checked="checked" <%} %> id="autoFk"/>是否自动放款  --%>
													</div>
													<div class="clear"></div>
												</li>
												<li>
													<div class="til">
														<span class="red">*</span>担保方案：
													</div>
													<div class="info">
														<select class="text yhgl_ser" name="F12">
															<%
																for(T6230_F12 t6230_F122:T6230_F12.values())
																{
															%>
															<option value="<%=t6230_F122.name() %>" <%if(info.F12==t6230_F122){ %>selected="selected"<%} %>><%=t6230_F122.getChineseName() %></option>
															<%} %>
														</select>
													</div>
													<div class="clear"></div>
												</li>
												<li>
													<div class="til">
														<span class="red">*</span>借款用途：
													</div>
													<div class="info">
														<input type="text" class="text yhgl_ser required max-length-100" name="jkyt" value="<%if(t6231.F08!=null){StringHelper.filterHTML(out, t6231.F08);} %>" />
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
														<select class="text yhgl_ser" name="F09">
															<%
																int jkqx = info.F09;
															%>
															<%
																for(int i=1;i<=36;i++)
																{
															%>
															<option value="<%=i %>" <%if(jkqx==i){ %>selected="selected"<%} %>><%=i %></option>
															<%} %>
														</select>月
													</div>
													<div class="clear"></div>
												</li>
												<li>
													<div class="til">
														<span class="red">*</span>年利率：
													</div>
													<div class="info">
														<input type="text" class="text yhgl_ser required max-size-99.999" mtest="/^\d*(\d|(\.[0-9]{1}))$/" mtestmsg="只能有一位小数" name="F06"
															value="<%=Formater.formatRate(info.F06,false)%>" /> %
														<p tip>利率精确到小数点后两位位且小于100</p>
														<p errortip class="" style="display: none"></p>
													</div>
													<div class="clear"></div>
												</li>
												<li>
													<div class="til">
														<span class="red">*</span>成交服务费率：
													</div>
													<div class="info">
														<input type="text" class="text yhgl_ser required" mtest="/^\d*(\d|(\.[0-9]+))$/" mtestmsg="请输入有效的数字" name="cjfwfl" value="<%=t6238.F02.doubleValue()%>"/>
														<p tip></p>
														<p errortip class="" style="display: none"></p>
													</div>
													<div class="clear"></div>
												</li>
												<li>
													<div class="til">
														<span class="red">*</span>投资管理费率：
													</div>
													<div class="info">
														<input type="text" class="text yhgl_ser required" mtest="/^\d*(\d|(\.[0-9]+))$/" mtestmsg="请输入有效的数字" name="tzglfl" value="<%=t6238.F03.doubleValue()%>"/>
														<p tip></p>
														<p errortip class="" style="display: none"></p>
													</div>
													<div class="clear"></div>
												</li>
												<li>
													<div class="til">
														<span class="red">*</span>逾期罚息利率：
													</div>
													<div class="info">
														<input type="text" class="text yhgl_ser required" mtest="/^\d*(\d|(\.[0-9]+))$/" mtestmsg="请输入有效的数字" name="yqflfl" value="<%=t6238.F04.doubleValue()%>"/>
														<p tip></p>
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
															<%T6230_F10 hkfs = info.F10;%>
															<option value="DEBX" <%if(hkfs==T6230_F10.DEBX){ %>selected="selected"<%} %>>等额本息</option>
															<option value="MYFX" <%if(hkfs==T6230_F10.MYFX){ %>selected="selected"<%} %>>每月还息，到期还本</option>
															<option value="YCFQ" <%if(hkfs==T6230_F10.YCFQ){ %>selected="selected"<%} %>>本息到期一次付清</option>
															<option value="DEBJ" <%if(hkfs==T6230_F10.DEBJ){ %>selected="selected"<%} %>>等额本金</option>
														</select>
													</div>
													<div class="clear"></div>
												</li>
												<li>
													<div class="til">
														<span class="red">*</span>还款来源： <br />
													</div>
													<div class="info">
														<input type="text" class="text yhgl_ser required" name="hkly" value="<%StringHelper.filterHTML(out, t6231.F16);%>"/>
														<p tip></p>
														<p errortip class="" style="display: none"></p>
													</div>
													<div class="clear"></div>
												</li>
												<li>
													<div class="til">
														<span class="red">*</span>付息方式：
													</div>
													<div class="info">
														<input type="radio" name="F17" value="ZRY" <%if(info.F17==T6230_F17.ZRY){ %> checked="checked" <%} %> id="zry"/>自然月
														<input type="radio" name="F17" value="GDR" <%if(info.F17==T6230_F17.GDR){ %> checked="checked" <%} %> id="gdr"/>固定日
													</div>
													<div class="clear"></div>
												</li>
												<li id="fxr" style="display: none;">
													<div class="til">
														<span class="red">*</span>付息日：
													</div>
													<div class="info">
														<select class="text yhgl_ser" name="F18">
															<%
																for(int i=1;i<=28;i++)
																{
															%>
															<option value="<%=i %>" <%if(i==info.F18){ %>selected="selected"<%} %>><%=i %>号</option>
															<%} %>
														</select>
													</div>
													<div class="clear"></div>
												</li>
												
												<li>
													<div class="til">
														<span class="red">*</span>起息日：
													</div>
													<div class="info">
														<select class="text yhgl_ser" name="F19">
															<option value="0" <%if(info.F19==0){ %>selected="selected"<%} %>>当日计息</option>
															<option value="1" <%if(info.F19==1){ %>selected="selected"<%} %>>次日计息</option>
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
															<%int cbqx = info.F08; %>
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
														<span class="red">*</span>债权描述：
													</div>
													<div class="info">
														<textarea name="jkms" cols="45" rows="5" class="border w490 mb10 required min-length-20 max-length-500"><%StringHelper.format(out,t6231.F09, fileStore); %></textarea>
														<p tip>20-500字</p>
														<p errortip class="" style="display: none"></p>
													</div>
													<div class="clear"></div>
												</li>
											</ul>
										</div>
										<div class="clear"></div>
									</div>
									<div class="tc w350">
										<input type="submit" class="btn4 mr30 sumbitForme" fromname="form1" value="保存" onclick="save()" />
										<input type="submit" class="btn4 mr30 sumbitForme" fromname="form1" value="保存并继续" onclick="saveCon()"/>
										<a href="<%=controller.getURI(request, OfflineLoanList.class) %>" class="btn5 tc">取消</a>
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
	<%@include file="/WEB-INF/include/datepicker.jsp"%>
	<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/region.js"></script>
	<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/validation.js"></script>
	<script type="text/javascript">
		$("#zry").click(function(){
			$("#fxr").hide();
		});
		$("#gdr").click(function(){
			$("#fxr").show();
		});
		function save() {
			$("#flag").attr("value", "0");
		}
		function saveCon() {
			$("#flag").attr("value", "1");
		}
		$(function() {
			var hkfs=$("#hkfs").attr("value");
			if(hkfs=='YCFQ'||hkfs=='DEBX')
			{
				$("#gdr").attr("disabled","disabled");
				$("#gdr").attr("checked",false);
				$("#zry").attr("checked",true);
			}
			else
			{
				$("#gdr").attr("disabled",false);	
			}
			var gdr=$("#gdr").attr("checked");
			if(gdr=='checked')
			{
				$("#fxr").show();
			}
		});
		$("#hkfs").click(function()
				{
					var hkfs=$("#hkfs").attr("value");
					if(hkfs=='YCFQ'||hkfs=='DEBX')
					{
						$("#gdr").attr("disabled","disabled");
						$("#gdr").attr("checked",false);
						$("#zry").attr("checked",true);
					}
					else
					{
						$("#gdr").attr("disabled",false);	
					}
				});
	</script>
</body>
</html>