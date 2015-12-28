<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.common.enums.TermType"%>
<%@page import="com.dimeng.p2p.common.enums.CreditType"%>
<%@page import="com.dimeng.p2p.front.servlets.Region"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F17"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F12"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F16"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F15"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F14"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F13"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F11"%>
<%@page import="com.dimeng.p2p.account.front.service.UserInfoManage"%>
<%@page import="com.dimeng.p2p.S62.enums.T6211_F03"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F10"%>
<%@page import="com.dimeng.p2p.S62.entities.T6211"%>
<%@page import="com.dimeng.p2p.modules.bid.front.service.BidWillManage"%>
<%@page import="java.util.logging.Level"%>
<%@page import="com.dimeng.p2p.front.servlets.credit.xjd.Showcredit"%>
<%@page import="com.dimeng.p2p.front.servlets.Term"%>
<%@page import="com.dimeng.p2p.front.servlets.credit.xjd.Basemessage"%>
<%@page import="com.dimeng.p2p.front.servlets.credit.xjd.Index"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<%@page import="com.dimeng.p2p.front.servlets.credit.xjd.AddCredit"%>
<%@page import="java.math.BigDecimal"%>
<%@include file="/WEB-INF/include/authenticatedSession.jsp" %>
<html>
<head>
<title><%=configureProvider.getProperty(SystemVariable.SITE_TITLE)%></title>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<%
	int id = 0;
	UserInfoManage mge = serviceSession.getService(UserInfoManage.class);
	if(!mge.isSmrz()){
		//跳转到实名认证页面
		controller.sendRedirect(request, response, controller.getViewURI(request, Index.class)+"?erd=2");
		return ;
	}
	if(mge.isYuqi().equals("Y")){
		//当前用户存在逾期不能借款
		controller.sendRedirect(request, response, controller.getViewURI(request, Index.class)+"?erd=4");
		return;
	}
	if(mge.isBid()){
		//当前用户存在逾期不能借款
		controller.sendRedirect(request, response, controller.getViewURI(request, Index.class)+"?erd=1");
		return;
	}
	String errmes = controller.getPrompt(request, response,PromptLevel.ERROR);
	T6211[] bidTypes = serviceSession.getService(BidWillManage.class).getBidTypeAll();
	
%>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<form action="<%=controller.getURI(request, AddCredit.class)%>" class="form1" method="post">
	<div class="contain clearfix">
		<div class="w1002 top_title">
			<span class="fl"><a href="<%configureProvider.format(out,URLVariable.CREDIT_CENTER);%>">我要借款</a> &gt; <a href="<%configureProvider.format(out,URLVariable.CREDIT_XJD);%>">薪金贷</a> &gt;
				填写借款申请</span>
		</div>
		<input type="hidden" name="ltype"
			value="<%=CreditType.XJD.name()%>">
		<div class="contain_main clearfix">
			<div class="ui_step ui_one"></div>
		</div>

		<div class="contain_main clearfix">
			<div class="pub_title">填写借款申请</div>
			<span style="color: red;"><%StringHelper.filterHTML(out, errmes);%></span>
				<div class="loan_con ">
					<ul>
						<li>
							<div class="tit"><i class="red">*</i>借款标题：</div>
							<div class="info">
								<input name="F03" type="text"
									class="put required max-length-14"/>
								<p tip>不超过14个字</p>
								<p errortip class="" style="display: none"></p>
							</div>

						</li>
						<li>
							<div class="tit"><i class="red">*</i>借款用途：</div>
							<div class="info">
								<select name="t6231_f08" class="sel">
									<option value="短期周转">短期周转</option>
									<option value="购房借款">购房借款</option>
									<option value="购车借款">购车借款</option>
									<option value="装修借款">装修借款</option>
									<option	value="婚礼筹备">婚礼筹备</option>
									<option value="教育培训">教育培训</option>
									<option value="投资创业">投资创业</option>
									<option value="医疗支出">医疗支出</option>
									<option value="其他借款">其他借款</option>
									<option value="个人消费">个人消费</option>
								</select>
							</div>
						</li>
						  <li>
				               <div class="tit"><i class="red">*</i>所在城市</div>
				               <div class="info">
				               <select name="sheng" style="width:150px;" class="sel">
								</select> 
								<select name="shi" style="width:200px;" class="sel">
								</select>
								<select name="xian" style="width:200px;" class="sel required">
								</select>
								 <p tip></p>
							    <p errortip class="" style="display: none"></p>
				               </div>
				            </li>
						 <li>
							<div class="tit"><i class="red">*</i>借款标类型：</div>
							<div class="info">
								<select name="F04" class="sel">
									<%if(bidTypes != null){ 
										for(T6211 type :bidTypes){%>
									<option value="<%=type.F01 %>"><%StringHelper.filterHTML(out, type.F02); %></option>
									<%}} %>
								</select>
							</div>
						</li> 
						
						
						<li>
							<div class="tit"><i class="red">*</i>借款金额：</div>
							<div class="info">
								<input name="F05" type="text"
									class="put01 required isint mulriple-<%=configureProvider.format(SystemVariable.AUTO_BIDING_MULT_AMOUNT)%> min-size-3000 max-size-500000 jejs"
									 />元
								<p tip>借款金额范围3000-500000，且为<%=configureProvider.format(SystemVariable.AUTO_BIDING_MULT_AMOUNT)%>的倍数</p>
								<p errortip class="" style="display: none"></p>
							</div>
						</li>
						<li>
							<div class="tit"><i class="red">*</i>借款期限：</div>
							<div class="info">
								<select name="F09" class="sel jejs">
									<%
										for(int i=1;i<=36;i++)
										{
									%>
										<option value="<%=i %>"><%=i %>个月</option>
									<%} %>
								</select>
							</div>
						</li>
						<li>
							<div class="tit"><i class="red">*</i>筹款期限：</div>
							<div class="info">
								<select name="F08" class="sel jejs">
									<%
										for(int i=1;i<=31;i++)
										{
									%>
										<option value="<%=i %>"><%=i %>天</option>
									<%} %>
								</select>
							</div>
						</li>
						<%-- <li>
							<div class="tit">&nbsp;</div>
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
								<input type="checkbox" name="F11" value="S" <%if(t6230_F11==T6230_F11.S){ %> checked="checked" <%} %>/>有担保
								<input type="checkbox" name="F13" value="S" <%if(t6230_F13==T6230_F13.S){ %> checked="checked" <%} %>/>有抵押
								<input type="checkbox" name="F14" value="S" <%if(t6230_F14==T6230_F14.S){ %> checked="checked" <%} %>/>有实地认证
								<input type="checkbox" name="F15" value="S" <%if(t6230_F15==T6230_F15.S||sfzdfk==T6230_F15.S){ %> checked="checked" <%} %>/>是否自动放款
								<input type="checkbox" name="F16" value="S" <%if(t6230_F16==T6230_F16.S||sfyxlb==T6230_F16.S){ %> checked="checked" <%} %>/>是否允许流标
							</div>
						</li>
						 <li>
							<div class="tit">担保方案：</div>
							<div class="info">
								<select class="sel jejs" name="F12">
								<%
								T6230_F12 dbfa=EnumParser.parse(T6230_F12.class,configureProvider.getProperty(SystemVariable.DBFA));
									for(T6230_F12 t6230_F122:T6230_F12.values())
										{
								%>
								<option value="<%=t6230_F122.name() %>" <%if(dbfa==t6230_F122){ %>selected="selected"<%} %>><%=t6230_F122.getChineseName() %></option>
								<%} %>
								</select>
							</div>
						</li>
						 --%>
						<li>
							<div class="tit"><i class="red">*</i>年利率：</div>
							<div class="info">
								<input name="F06" type="text" class="put01 required minf-size-10 maxf-size-24 jejs"  mtest="/^\d+(\d|(\.[0-9]{1}))$/" mtestmsg="只能有一位小数" />%
								<p tip>利率精确到小数点后一位，范围10%-24%之间</p>
								<p errortip class="" style="display: none"></p>
								<p>借款最低利率由您的借款期限确定，一般来说借款利率越高，筹款速度越快。</p>
							</div>
						</li>
						<li>
							<div class="tit"><i class="red">*</i>还款方式：</div>
							<div class="info">
								<select name="F10" class="sel" id="hkfs">
									<%for(T6230_F10 t:T6230_F10.values()){ %>
									<option value="<%StringHelper.filterHTML(out, t.name()); %>"><%StringHelper.filterHTML(out, t.getChineseName()); %></option>
									<%} %>
								</select>
							</div>
						</li>
						<li>
							<div class="tit">
								<i class="red">*</i>付息方式：
							</div>
							<div class="info">
								<%
									T6230_F17 fxfs = EnumParser.parse(T6230_F17.class,
									configureProvider.getProperty(SystemVariable.FXFS));
								%>
								<input type="radio" name="F17" value="ZRY" <%if(fxfs==T6230_F17.ZRY){ %> checked="checked" <%} %> id="zry"/>自然月
								<input type="radio" name="F17" value="GDR" <%if(fxfs==T6230_F17.GDR){ %> checked="checked" <%} %> id="gdr"/>固定日
							</div>
							<div class="clear"></div>
						</li>
						<li>
							<div class="tit"><i class="red">*</i>还款来源：</div>
							<div class="info">
								<input name="t6231_f16" type="text"
									class="put required max-length-30"/>
								<p tip>不超过30个字</p>
								<p errortip class="" style="display: none"></p>
							</div>

						</li>
						<li>
							<div class="tit"><i class="red">*</i>借款描述：</div>
							<div class="info">
								<textarea name="t6231_f09" cols="" rows=""
									class="area required min-length-20 max-length-500"></textarea>
								<p tip>输入20-500个字</p>
								<p errortip class="" style="display: none"></p>
								<p class="mt10">
									<input name="isread" checked="checked" type="checkbox" value="1" class="mr10" />我已阅读并同意签署<a class="blue" target="_blank" href="<%=controller.getPagingItemURI(request, Term.class, TermType.XYRZBXY.name())%>">《借款协议》</a>
								</p>
							</div>
						</li>
						<li>
							<div class="tit">&nbsp;</div>
							<div class="info">
								<input type="submit" class="btn btn01 sumbitForme" fromname="form1" value="提交" />
							</div>
						</li>
					</ul>
				</div>
		</div>
	</div>
</form>

	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
	<script type="text/javascript"
		src="<%=controller.getStaticPath(request)%>/js/validation.js"></script>
	<script type="text/javascript">
	$(".jejs").change( function() {
		var $envs = $(".jejs");
		var toal = $envs.eq(0).val();
	  	var money = 100;
	  	var size = toal/money;
	  	//借款期限
	  	var month = $envs.eq(1).val();
	  	//借款年利率
	  	var year = $envs.eq(2).val();
	  	
	  	if(money == "" || month == ""){
	  		return false;
	  	}
	  	
  	  var $creaa = $("#creaa");
	  var $crea =  $("#crea");
	  var $creb =  $("#creb");
	  var $crec =  $("#crec");
	  var $cred =  $("#cred");
	  var $cree =  $("#cree");
	  var $crehr =  $("#crehr");
	  $creaa.html((parseInt(money)*parseFloat($creaa.attr("fl"))*size).toFixed(2));
	  $crea.html((parseInt(money)*parseFloat($crea.attr("fl"))*size).toFixed(2));
	  $creb.html((parseInt(money)*parseFloat($creb.attr("fl"))*size).toFixed(2));
	  $crec.html((parseInt(money)*parseFloat($crec.attr("fl"))*size).toFixed(2));
	  $cred.html((parseInt(money)*parseFloat($cred.attr("fl"))*size).toFixed(2));
	  $cree.html((parseInt(money)*parseFloat($cree.attr("fl"))*size).toFixed(2));
	  $crehr.html((parseInt(money)*parseFloat($crehr.attr("fl"))*size).toFixed(2));
	  	
	  	if(money == "" || month == "" || year == ""){
	  		return false;
	  	}
	   var mln = (parseFloat(year)/12/100);
	   //月还本息
	   
	   var s = ((parseFloat(parseInt(money)*mln*Math.pow((1+mln),month))/(Math.pow((1+mln),month)-1)));
	   var j = ((money*parseFloat(<%=configureProvider.format(SystemVariable.LMONEY_SUCCESS_RATION)%>)));
	   $("#ms").html(parseFloat(((s).toFixed(2))*size).toFixed(2));
	   $("#mj").html(parseFloat(((j).toFixed(2))*size).toFixed(2));
	  
	   
	});
	
	
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
			<script type="text/javascript"
		src="<%=controller.getURI(request, Region.class)%>"></script>
</body>
</html>