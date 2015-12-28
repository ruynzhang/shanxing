<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.S62.entities.T6230"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F15"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F16"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F17"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F12"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F14"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F13"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F11"%>
<%@page import="com.dimeng.p2p.console.servlets.Region"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<%@page import="com.itextpdf.tool.xml.pipeline.ctx.ObjectContext"%>
<%@page import="com.dimeng.p2p.S62.entities.T6211"%>
<%@page import="com.dimeng.p2p.S61.enums.T6110_F06"%>
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
		T6110_F06 userType=EnumParser.parse(T6110_F06.class, request.getParameter("userType"));
		int userId=IntegerParser.parse(request.getParameter("userId"));
		int loanId=IntegerParser.parse(request.getAttribute("loanId")==null?request.getParameter("loanId"):request.getAttribute("loanId"));
		String userName=ObjectHelper.convert(request.getAttribute("userName"), String.class);
		T6211[] t6211s=ObjectHelper.convertArray(request.getAttribute("t6211s"), T6211.class);
	%>
<%@ include file="/WEB-INF/include/header.jsp"%>
	<div class="w_main">
		<div class="main clearfix">
			<div class="wrap">
				<div class="r_main">
					<div class="home_main">
						<div class="box box1 mb15">
							<div class="atil">
								<h3>新增借款信息</h3>
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
							<input id="shengId" value="<%=request.getParameter("sheng")%>" type="hidden" /> 
							<input id="shiId" value="<%=request.getParameter("shi")%>" type="hidden" /> 
							<input id="xianId" value="<%=request.getParameter("xian")%>" type="hidden" />
							<form action="<%=controller.getURI(request, AddProjectXq.class)%>" method="post" id="form1" class="form1">
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
														<span class="red"></span>预约用户名： <br />
													</div>
													<div class="info">
														<input type="text" class="text yhgl_ser" name="investName" value="<%StringHelper.filterHTML(out, request.getParameter("investName"));%>"/>
														<span tip>&nbsp;请填写预约客户用户名，如不填写为非预约标</span>
														<p tip></p>
														<p errortip class="" style="display: none"></p>
													</div>
													<div class="clear"></div>
												</li>
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
														<span class="red">*</span>借款标题：
													</div>
													<div class="info">
														<input type="text" class="text yhgl_ser required max-length-200" name="F03" value="<%StringHelper.filterHTML(out, request.getParameter("F03"));%>"/>
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
														<%int type = IntegerParser.parse(request.getParameter("F04")); %>
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
															<%}}%>
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
														<span class="red">*</span>借款金额： <br />
													</div>
													<div class="info">
														<input type="text" class="text yhgl_ser"  maxlength="15" mtest="/^((([1-9][0-9]*)|0)|((([1-9][0-9]*)|0)\.[0-9]{1,2}))$/" mtestmsg="必须为数字格式(且是两位小数)"  name="F05" value="<%StringHelper.filterHTML(out, request.getParameter("F05"));%>"/>元
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
														<%
														T6230_F11 t6230_F11=EnumParser.parse(T6230_F11.class, request.getParameter("F11"));
														T6230_F13 t6230_F13=EnumParser.parse(T6230_F13.class, request.getParameter("F13"));
														T6230_F14 t6230_F14=EnumParser.parse(T6230_F14.class, request.getParameter("F14"));
														T6230_F15 t6230_F15=EnumParser.parse(T6230_F15.class, request.getParameter("F15"));
														T6230_F16 t6230_F16=EnumParser.parse(T6230_F16.class, request.getParameter("F16"));
														T6230_F15 sfzdfk=EnumParser.parse(T6230_F15.class, configureProvider.getProperty(SystemVariable.SFZDFK));
														T6230_F16 sfyxlb=EnumParser.parse(T6230_F16.class, configureProvider.getProperty(SystemVariable.SFYXLB));
														%>
														<input type="checkbox" name="F11" value="S" <%if(t6230_F11==T6230_F11.S){ %> checked="checked" <%} %> id="ydb"/>有担保
														<input type="checkbox" name="F13" value="S" <%if(t6230_F13==T6230_F13.S){ %> checked="checked" <%} %>/>有抵押
														<input type="checkbox" name="F14" value="S" <%if(t6230_F14==T6230_F14.S){ %> checked="checked" <%} %>/>有实地认证
														<%-- <input type="checkbox" name="F15" value="S" <%if(t6230_F15==T6230_F15.S||sfzdfk==T6230_F15.S){ %> checked="checked" <%} %> id="autoFk"/>是否自动放款
												        --%> 
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
															T6230_F12 dbfa=EnumParser.parse(T6230_F12.class,configureProvider.getProperty(SystemVariable.DBFA));
															if(!StringHelper.isEmpty(request.getParameter("F12"))){
																dbfa = EnumParser.parse(T6230_F12.class,request.getParameter("F12"));
															}
															%>
															<%
																for(T6230_F12 t6230_F122:T6230_F12.values())
																{
															%>
															<option value="<%=t6230_F122.name() %>" <%if(dbfa==t6230_F122){ %>selected="selected"<%} %>><%=t6230_F122.getChineseName() %></option>
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
														<input type="text" class="text yhgl_ser required max-length-100" name="jkyt" value="<%StringHelper.filterHTML(out, request.getParameter("jkyt"));%>" />
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
														<input id="jkqx" type="text" class="text yhgl_ser required min-size-1" mtest="/^\d+$/" mtestmsg="必须为数字" name="F09" value="<%StringHelper.filterHTML(out, request.getParameter("F09"));%>"/>
														月/天
														<span tip>&nbsp;(除本息到期一次付清可选按天计算外，其他皆以月为单位)</span>
														<p errortip class="" style="display: none"></p>
													</div>
													<div class="clear"></div>
												</li>
												<li>
													<div class="til">
														<span class="red">*</span>年利率：
													</div>
													<div class="info">
														<input type="text" class="text yhgl_ser required max-size-99.999" mtest="/^\d*(\d|(\.[0-9]{1}|\.[0-9]{2}))$/" mtestmsg="只能有两位小数" name="F06" value="<%StringHelper.filterHTML(out, request.getParameter("F06"));%>"/> %
														<span tip>&nbsp;(利率精确到小数点后两位且小于100)</span>
														<p errortip class="" style="display: none"></p>
													</div>
													<div class="clear"></div>
												</li>
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
														<input type="text" class="text yhgl_ser required max-size-99.999" mtest="/^\d*(\d|(\.[0-9]{1}|\.[0-9]{1}))$/" mtestmsg="只能有一位小数" name="bonus" value="<%StringHelper.filterHTML(out, request.getParameter("bonus"));%>"/> %
														<span tip>&nbsp;额外奖励只做辅助显示作用</span>
														<p errortip class="" style="display: none"></p>
													</div>
													<div class="clear"></div>
											</li>
												<li>
													<div class="til">
														<span class="red">*</span>成交服务费率：
													</div>
													<div class="info">
														<%
														BigDecimal cjfwfl=BigDecimalParser.parse(configureProvider.getProperty(SystemVariable.SUCCESS_BMONEY_RATE));
														if(!StringHelper.isEmpty(request.getParameter("cjfwfl"))){
															cjfwfl=BigDecimalParser.parse(request.getParameter("cjfwfl"));
														}
														%>
														<input type="text" class="text yhgl_ser required" mtest="/^\d*(\d|(\.[0-9]+))$/" mtestmsg="请输入有效的数字" name="cjfwfl" value="<%=cjfwfl%>"/>
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
													<%
														BigDecimal tzfwfl=BigDecimalParser.parse(configureProvider.getProperty(SystemVariable.SUCCESS_TZ_RATE));
														if(!StringHelper.isEmpty(request.getParameter("tzglfl"))){
															 tzfwfl=BigDecimalParser.parse(request.getParameter("tzglfl"));
														}
														%>
														<input type="text" class="text yhgl_ser required" mtest="/^\d*(\d|(\.[0-9]+))$/" mtestmsg="请输入有效的数字" name="tzglfl" value="<%=tzfwfl%>"/>
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
														<%
														BigDecimal yqfxfl=BigDecimalParser.parse(configureProvider.getProperty(SystemVariable.YU_QI_FAXI_RATE));
														if(!StringHelper.isEmpty(request.getParameter("yqflfl"))){
															yqfxfl=BigDecimalParser.parse(request.getParameter("yqflfl"));
														}
														%>
														<input type="text" class="text yhgl_ser required" mtest="/^\d*(\d|(\.[0-9]+))$/" mtestmsg="请输入有效的数字" name="yqflfl" value="<%=yqfxfl%>"/>
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
															<%String hkfs =  request.getParameter("F10"); %>
															<option value="DEBX" <%if(!StringHelper.isEmpty(hkfs)&&hkfs.equals("DEBX")){ %>selected="selected"<%} %>>等额本息</option>
															<option value="MYFX" <%if(!StringHelper.isEmpty(hkfs)&&hkfs.equals("MYFX")){ %>selected="selected"<%} %>>每月还息，到期还本</option>
															<option value="YCFQ" <%if(!StringHelper.isEmpty(hkfs)&&hkfs.equals("YCFQ")){ %>selected="selected"<%} %>>本息到期一次付清</option>
															<option value="DEBJ" <%if(!StringHelper.isEmpty(hkfs)&&hkfs.equals("DEBJ")){ %>selected="selected"<%} %>>等额本金</option>
														</select>
														<span id="_accDay">
															<%String accDay = request.getParameter("accDay"); %>
															<input id="accDay_S" type="radio" name="accDay" value="S" <%if("S".equals(accDay)){ %> checked<%} %>/>按天
															<input id="accDay_F" type="radio" name="accDay" value="F" <%if("F".equals(accDay) || StringHelper.isEmpty(accDay)){ %> checked<%} %>/>按月
														</span>
													</div>
													<div class="clear"></div>
												</li>
												<li>
													<div class="til">
														<span class="red">*</span>还款来源： <br />
													</div>
													<div class="info">
														<input type="text" class="text yhgl_ser required" name="hkly" value="<%StringHelper.filterHTML(out, request.getParameter("hkly"));%>"/>
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
														<%
															T6230_F17 fxfs = EnumParser.parse(T6230_F17.class,
															configureProvider.getProperty(SystemVariable.FXFS));
														if(!StringHelper.isEmpty(request.getParameter("F17"))){
															fxfs = EnumParser.parse(T6230_F17.class,request.getParameter("F17"));
														}
														%>
														<input type="radio" name="F17" value="ZRY" <%if(fxfs==T6230_F17.ZRY){ %> checked="checked" <%} %> id="zry"/>自然月
														<input type="radio" name="F17" value="GDR" <%if(fxfs==T6230_F17.GDR){ %> checked="checked" <%} %> id="gdr"/>固定日
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
															<option value="<%=i %>" <%if((i+"").equals(request.getParameter("F18"))){ %>selected="selected"<%} %>><%=i %>号</option>
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
															<%
																int qxr=IntegerParser.parse(request.getParameter("F19"));
															%>
															<option value="0" <%if(qxr==0){ %>selected="selected"<%} %>>当日计息</option>
															<option value="1" <%if(qxr==1){ %>selected="selected"<%} %>>次日计息</option>
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
														<span class="red">*</span>借款描述：
													</div>
													  <div class="info orange">
                        	                              <textarea name="jkms" cols="100" rows="8" style="width:700px;height:500px;visibility:hidden;"><%StringHelper.format(out, request.getParameter("jkms"), fileStore); %></textarea>
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