<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.S62.enums.T6231_F21"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.jkgl.ViewAuthentication"%>
<%@page import="com.dimeng.p2p.S62.entities.T6238"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.jkgl.AddEnterpriseXq"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.jkgl.AddUserInfoXq"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.jkgl.ViewEnterprise"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.jkgl.ViewUserInfo"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F17"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F12"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F16"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F15"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.jkgl.LoanList"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F14"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F10"%>
<%@page import="com.dimeng.p2p.S62.entities.T6211"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F13"%>
<%@page import="com.dimeng.p2p.S61.enums.T6110_F06"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F11"%>
<%@page import="com.dimeng.p2p.S62.entities.T6231"%>
<%@page import="com.dimeng.p2p.S62.entities.T6230"%>
<%@page import="com.dimeng.p2p.S60.enums.T6036_F11"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.jkgl.UpdateProject"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.jkgl.AddAnnexWz"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.jkgl.AddAnnexMsk"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.jkgl.AddGuaranteeXq"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.jkgl.AddDyw"%>
<%@page import="com.dimeng.p2p.common.enums.LoanType"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.jkgl.AddProjectXq"%>
<%@page import="com.dimeng.p2p.S60.enums.T6010_1_F02"%>
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
			CURRENT_SUB_CATEGORY="BDGL";
			T6230 info = ObjectHelper.convert(request.getAttribute("loan"), T6230.class);
			T6231 t6231=ObjectHelper.convert(request.getAttribute("t6231"), T6231.class);
			T6230 t6230=ObjectHelper.convert(request.getAttribute("t6230"), T6230.class);
			T6110_F06 userType=EnumParser.parse(T6110_F06.class, request.getAttribute("userType").toString());
			T6211[] t6211s=ObjectHelper.convertArray(request.getAttribute("t6211s"), T6211.class);
			T6238 t6238=ObjectHelper.convert(request.getAttribute("t6238"), T6238.class);
			String userName=ObjectHelper.convert(request.getAttribute("userName"), String.class);
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
								<h3>修改借款信息</h3>
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
								<div class="border p30 Men_bt no_table yw_dl" id="con_one_1">
									<div class="mb20">
										<div class="yw_jcxx">
											<ul class="cell noborder">
												<li>
													<div class="til">
														<span class="red">*</span>借款账户：
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
														<p tip></p>
														<p errortip class="" style="display: none"></p>
													</div>
													<div class="clear"></div>
												</li>
												<li>
													<div class="til">
														<span class="red">*</span>标的类型：
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
														<span class="red">*</span>项目所在区域：
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
														<span class="red">*</span>借款标题：
													</div>
													<div class="info">
														<input type="text" class="text yhgl_ser required max-length-200" name="F03" value="<%StringHelper.filterHTML(out, info.F03);%>" />
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
														<input type="text" class="text yhgl_ser"  maxlength="15" mtest="/^((([1-9][0-9]*)|0)|((([1-9][0-9]*)|0)\.[0-9]{1,2}))$/" mtestmsg="必须为数字格式(且是两位小数)"  name="F05" value="<%=info.F05%>" />元
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
														<input id="ydb" type="checkbox" name="F11" value="S" <%if(info.F11==T6230_F11.S){ %> checked="checked" <%} %>/>有担保
														<input type="checkbox" name="F13" value="S" <%if(info.F13==T6230_F13.S){ %> checked="checked" <%} %>/>有抵押
														<input type="checkbox" name="F14" value="S" <%if(info.F14==T6230_F14.S){ %> checked="checked" <%} %>/>有实地认证
														<%-- <input type="checkbox" name="F15" value="S" <%if(info.F15==T6230_F15.S){ %> checked="checked" <%} %> id="autoFk"/>是否自动放款--%>
													</div>
													<div class="clear"></div>
												</li>
												<li id="dbfa">
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
														<input type="text" class="text yhgl_ser required max-length-100" name="jkyt" value="<%=t6231.F08%>" />
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
														<%
														int dayOrMonth = 0;
														if(T6230_F10.YCFQ == info.F10 && T6231_F21.S == t6231.F21){
															dayOrMonth = t6231.F22;
														} else { dayOrMonth = info.F09;}%>
														<input type="text" class="text yhgl_ser required min-size-1" mtest="/^\d+$/" mtestmsg="必须为数字" name="F09" value="<%=dayOrMonth %>"/>
														月/天
														<p tip>除本息到期一次付清可选按天计算外，其他皆以月为单位</p>
														<p errortip class="" style="display: none"></p>
													</div>
													<div class="clear"></div>
												</li>
												<li>
													<div class="til">
														<span class="red">*</span>年利率：
													</div>
													<div class="info">
														<input type="text" class="text yhgl_ser required max-size-99.999" mtest="/^\d*(\d|(\.[0-9]{1}|\.[0-9]{2}))$/" mtestmsg="只能有两位小数" name="F06"
															value="<%=Formater.formatRate(info.F06,false)%>" /> %
														<p tip>利率精确到小数点后两位位且小于100</p>
														<p errortip class="" style="display: none"></p>
													</div>
													<div class="clear"></div>
												</li>
													<!-- 增加鼓励奖 -->
											   <li>
												   <div class="til">选择你想增加的惊喜奖项:</div>
												   <div class="info">
												   &nbsp;&nbsp;&nbsp;&nbsp;
												   <input class="tjbtnan" value="+" type="button" style="color:blue;width:120px;height:30px;font-size:16px;">
												   <p class="apreapward"  style="display: none; color: #ff0000"></p></div>
												   <div class="clear"></div>
												 </li>
												 <div class="tjsinline">
												<%SURPRISE_NAME[] arr = SURPRISE_NAME.values(); 
											for(int i=0, len=arr.length; i< len; i++){%>
										<li ><div class="til"><select style="width:120px;" class="text yhgl_ser" name="SURPRISE_NAME">
											<%for(int j=0; j< len; j++){%>
												<option value="<%=arr[j].name()%>" <%=i==j?"selected=\"selected\"":""%>><%=arr[j].getChineseName()%></option>
											<%} %>
		                              </select></div>
		                              <div class="info">
		                              &nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="surpriseRate" class="text yhgl_ser required max-size-99.999" mtest="/^\d*(\d|(\.[0-9]+))$/" mtestmsg="请输入有效的数字" value="<%=arr[i].getRate()%>"/>
		                              &nbsp;&nbsp;<input type="button" class="scbtnan" onclick="sldelinfin(this)" value="-" style="color:blue;size:14px;width:40px;height:30px;" />
		                              <p errortip class="" style="display: none"></p>
		                              </div><div class="clear"></div></li>      
											<%}%>
												 </div>
												<!-- end -->
												<li>
													<div class="til">
														<span class="red">*</span>额外奖励：
													</div>
													<div class="info">
														<input type="text" class="text yhgl_ser required max-size-99.999" mtest="/^\d*(\d|(\.[0-9]{1}|\.[0-9]{1}))$/" mtestmsg="只能有一位小数" name="bonus"
															value="<%=info.bonus%>" /> %
														<p tip>额外奖励只做辅助显示作用</p>
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
														<span id="_accDay">
															<%T6231_F21 accDay = t6231.F21; %>
															<input id="accDay_S" type="radio" name="accDay" value="S" <%if(T6231_F21.S == (accDay)){ %> checked<%} %>/>按天
															<input id="accDay_F" type="radio" name="accDay" value="F" <%if(T6231_F21.F == (accDay)){ %> checked<%} %>/>按月
														</span>
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
														<span class="red">*</span>借款描述：
													</div>
													<div class="info orange">
                        	                              <textarea name="jkms" cols="100" rows="8" style="width:700px;height:500px;visibility:hidden;"><%StringHelper.format(out,t6231.F09, fileStore); %></textarea>
                       		                             <p id="errorContent">&nbsp;</p>
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
										<a href="<%=controller.getURI(request, LoanList.class) %>" class="btn5 tc">取消</a>
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
	<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/region.js"></script>
	<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/validation.js"></script>
	<script type="text/javascript">
	var editor1;
	KindEditor.ready(function(K) {
		editor1 = K.create('textarea[name="jkms"]', {
			uploadJson : '<%=controller.getURI(request, Upload.class)%>?type=<%=FileType.ARTICLE_ATTACHMENT.ordinal()%>',
			allowFileManager : false,
			formatUploadUrl: false,
			afterBlur:function(){
				this.sync();
				if(this.count('text')=='')
				{
					$("#errorContent").addClass("red");
					$("#errorContent").html("借款描述内容不能为空");	
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
		$("#ydb").click(function()
				{
					var ydb=$("#ydb").attr("checked");
					if(ydb=='checked')
					{
						$("#dbfa").show();
					}else
					{
						$("#dbfa").hide();	
					}
				});
		$(function() {
			var hkfs=$("#hkfs").attr("value");
			var ydb=$("#ydb").attr("checked");
			if(ydb=='checked')
			{
				$("#dbfa").show();	
			}else
			{
				$("#dbfa").hide();	
			}
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
					
					accDay(hkfs);
				});
		
		function accDay(hkv) {
			if("YCFQ" == hkv) {
				$("#_accDay").show();
			} else {
				$("#_accDay").hide();
			}
		}
		
		window.onload = loadPage();
		function loadPage() {
			var hkfs=$("#hkfs").attr("value");
			accDay(hkfs);
			
		}
		
		//奖励
		var mfrnum = 0;
		
		$(document).ready(function(){
             $(".tjbtnan").click(function(){
            		
            	 if(mfrnum<5){
            		 var comtent ="<li ><div class='til'><select style='width:120px;' class='text yhgl_ser' name='SURPRISE_NAME'>";
            		    comtent +="<option value='SBJ'>首投奖</option>";
            		    comtent +="<option value='XRJ'>新人奖</option>";
            		    comtent +="<option value='THJ'>土豪奖</option>";
            		    comtent +="<option value='MXJ'>秒杀奖</option>"; 
                        comtent +="<option value='SGJ'>收官奖</option>";
		             comtent +="</select></div>";
		             comtent +="<div class='info'>";
		             comtent +="&nbsp;&nbsp;&nbsp;&nbsp;<input type='text' name='surpriseRate' class='text yhgl_ser required max-size-99.999' mtest='/^\d*(\d|(\.[0-9]{1}|\.[0-9]{2}))$/'  value='输入额外奖励奖的百分比'/>";
		             comtent +="&nbsp;&nbsp;<input type='button' class='scbtnan' onclick='sldelinfin(this)' value='-' style='color:blue;size:14px;width:40px;height:30px;' />";
		             comtent +="<p errortip class='' style='display: none'></p>";
		             comtent +="</div><div class='clear'></div></li>";
            		 $(".tjsinline").append(comtent);
            		 mfrnum++;
            		
            		     
            		 }
            	 
             });//*添加*//
		});									  
												     
           function sldelinfin(obj){
        	      
        	        mfrnum--;
        	        var tr=obj.parentNode.parentNode;
        	        //tr.remove();
        	        tr.parentNode.removeChild(tr);  
              }
										     								
		//end
	</script>
</body>
</html>