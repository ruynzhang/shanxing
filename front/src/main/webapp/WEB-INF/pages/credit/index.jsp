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
<title>网上贷款-P2P贷款-善行创投</title>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
<link rel="stylesheet" type="text/css" href="<%=controller.getStaticPath(request)%>/css/inside.css" />
<link rel="stylesheet" type="text/css" href="<%=controller.getStaticPath(request)%>/css/style.css" />
</head>
<%
    String erd = "";
    int id = 0;
    UserInfoManage mge = serviceSession.getService(UserInfoManage.class);
    if(!mge.isSmrz()){
	    //跳转到实名认证页面
	    erd = "2";
    }
    if(mge.isYuqi().equals("Y")){
	    //当前用户存在逾期不能借款
    	erd = "4";
    }
    if(mge.isBid()){
	    //当前用户存在逾期不能借款
    	erd = "1";
    }
    String errmes = controller.getPrompt(request, response,PromptLevel.ERROR);
    T6211[] bidTypes = serviceSession.getService(BidWillManage.class).getBidTypeAll();  

%>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<!--内容-->
<!--banner-->
<div class="jk_banner">
	<div class="w1002"><img src="../images/jk_banner.jpg"  /></div>
</div>
<!--banner-->

<!--借款申请流程-->
<div style="background:#edeeef" class="all100">
	<div class="w1002">
    	<div class="jk_title">借款申请流程</div>
        <div class="tc"><img src="../images/jk_img01.jpg" width="976" height="396" /></div>
    </div>
</div>
<!--借款申请流程-->

<!--快速提交借款信息-->
<div style="background:#dadee1; padding-top:0" class="all100">
<form action="<%=controller.getURI(request, AddCredit.class)%>" id="form1" class="form1" method="post">
<input type="hidden" name="ltype"
			value="<%=CreditType.XJD.name()%>">
	<div class="w1002">
    	<div class="jk_jantou1"></div>
    	<div class="jk_title">借款申请流程</div>
    	<span style="color: red;"><%StringHelper.filterHTML(out, errmes);%></span>
        <div class="jk_li">
        	<ul>
            <li>
            	<div class="f24 mb10">1、填写个人资料</div>
                <div>姓名</div>
                <div class="mt10"><input name="" type="text" class="inp" value=""/></div>
                <div class="mt15">联系电话</div>
                <div class="mt10"><input name="" type="text" class="inp" value=""/></div>
                <div class="mt15">借款类型</div>
                <div class="mt10"><span><input checked="checked" name="daikuanway" type="radio" value="" class="mr5" />薪金贷</span><span class="ml15"><input name="daikuanway" type="radio" onclick="jk(2)" value="" class="mr5" />个人</span><span class="ml15"><input name="daikuanway" type="radio" onclick="jk(3)" value="" class="mr5" />企业</span></div>
                <div class="mt15">性别</div>
                <div class="mt10"><span><input name="sex" checked="checked" type="radio" value="" class="mr5" />男</span><span class="ml15"><input name="sex" type="radio" value="" class="mr5" />女</span></div>
                <div class="mt15">年龄（岁）</div>
                <div class="mt10"><input name="" type="text" class="inp" value=""/></div>
            </li>
            
            <li>
            	<div class="f24 mb10">2、填写借款需求</div>
                <div><span class="red">*</span>&nbsp;借款标题</div>
                <div class="mt10">
                  <input name="F03" type="text" class="put required max-length-14 inp"/>
				  <p tip>不超过14个字</p>
				  <p errortip class="" style="display: none"></p>
                </div>
                <div class="mt15">借款用途</div>
                <div class="mt10">
                  <select name="t6231_f08" class="sel inp">
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
                <div class="mt15"><span class="red">*</span>&nbsp;所在城市</div>
                <div class="mt10">
                  <select name="sheng" style="width:76px;" class="sel inp mr10"></select> 
				  <select name="shi" style="width:76px;" class="sel inp mr10"></select>
				  <select name="xian" style="width:76px;" class="sel required inp"></select>
				  <p tip></p>
				  <p errortip class="" style="display: none"></p>
                </div>
                <div class="mt15">借款标类型</div>
                  <div class="mt10">
                    <select name="F04" class="sel inp">
									 <%if(bidTypes != null){ 
										for(T6211 type :bidTypes){%>
									<option value="<%=type.F01 %>"><%StringHelper.filterHTML(out, type.F02); %></option>
									<%}} %> 
					</select>
                </div>
                <div class="mt15"><span class="red">*</span>&nbsp;借款金额</div>
                <div class="mt10">
                  <input name="F05" type="text" class="put01 required isint mulriple-<%=configureProvider.format(SystemVariable.AUTO_BIDING_MULT_AMOUNT)%> min-size-3000 max-size-500000 jejs inp"/>元
				  <p tip>借款金额范围3000-500000，且为<%=configureProvider.format(SystemVariable.AUTO_BIDING_MULT_AMOUNT)%>的倍数</p>
				  <p errortip class="" style="display: none"></p>
                </div>
                <div class="mt15">借款期限</div>
                  <div class="mt10">
                    <select name="F09" class="sel jejs inp">
					<%
							for(int i=1;i<=36;i++)
							{
					%>
					            <option value="<%=i %>"><%=i %>个月</option>
					      <%} %>
					</select>
					<p class="mt10">
					  <input name="isread" checked="checked" type="checkbox" value="1" class="mr10" />我已阅读并同意签署<a class="blue" target="_blank" href="<%=controller.getPagingItemURI(request, Term.class, TermType.XYRZBXY.name())%>">《借款协议》</a>
					</p>
                </div>
                
            </li>
            <li style="margin-right:0">
            	<div class="f24 mb10">3、填写抵押物资料</div>
                <div>筹款期限</div>
                <div class="mt10">
                  <select name="F08" class="sel jejs inp">
				    <%
					    for(int i=1;i<=31;i++)
						{
					%>
					        <option value="<%=i %>"><%=i %>天</option>
					  <%} %>
				  </select>              
				</div>
                <div class="mt15"><span class="red">*</span>&nbsp;年利率</div>
                <div class="mt10">
                  <input name="F06" type="text" class="put01 required minf-size-10 maxf-size-24 jejs inp"  mtest="/^\d+(\d|(\.[0-9]{1}))$/" mtestmsg="只能有一位小数" />%
								<p tip>利率精确到小数点后一位，范围10%-24%之间</p>
								<p errortip class="" style="display: none"></p>
								<p>借款最低利率由您的借款期限确定，一般来说借款利率越高，筹款速度越快。</p>
                </div>
                <div class="mt15">还款方式</div>
                  <div class="mt10">
                    <select name="F10" class="sel inp" id="hkfs">
						<%for(T6230_F10 t:T6230_F10.values()){ %>
						    <option value="<%StringHelper.filterHTML(out, t.name()); %>"><%StringHelper.filterHTML(out, t.getChineseName()); %></option>
						<%} %>
					</select>
                </div>
                <div class="mt15">付息方式</div>
                  <div class="mt10">
                    <%
									T6230_F17 fxfs = EnumParser.parse(T6230_F17.class,
									configureProvider.getProperty(SystemVariable.FXFS));
					%>
					<input class="mr5" type="radio" name="F17" value="ZRY" <%if(fxfs==T6230_F17.ZRY){ %> checked="checked" <%} %> id="zry"/>自然月
					<input class="mr5" type="radio" name="F17" value="GDR" <%if(fxfs==T6230_F17.GDR){ %> checked="checked" <%} %> id="gdr"/>固定日
                </div>
                
                <div class="mt15"><span class="red">*</span>&nbsp;还款来源</div>
                <div class="mt10">
                  <input name="t6231_f16" type="text" class="put required max-length-30 inp"/>
				  <p tip>不超过30个字</p>
				  <p errortip class="" style="display: none"></p>
                </div>
                
                <div class="mt15"><span class="red">*</span>&nbsp;借款描述</div>
                <div class="mt10">
                  <textarea name="t6231_f09" cols="" rows="" style="height:120px;" class="area required min-length-20 max-length-500 inp"></textarea>
					<p tip>输入20-500个字</p>
					<p errortip class="" style="display: none"></p>
                </div>
            </li>
            </ul>
        </div>
        <div class="clear"></div>
        <div style="width:200px; margin:auto;">
            <input type="submit" class="jk_btn  sumbitForme" fromname="form1"  value="提交申请"/>
        </div>  
    </div>
    </form>
</div>
<!--快速提交借款信息-->

<!--相关问题答疑-->
<div style="background:#e3e3e3; padding-top:0" class="all100">
  <div class="w1002">
   	  <div class="jk_jantou2"></div>
    	<div class="jk_title">相关问题答疑</div>
        <div class="jk_problem">
        	<ul>
            <li>
            <div class="ico_wen">为什么只受理广东本地借款申请？</div>
            <div class="ico_da">由于温商贷网站的性质属于为投资人与融资方搭建提供保障服务的平台，其核心竞争力还是控制风险的能力，为让自身的本金保障承诺具备可行性，更
好的控制资金风险，我们目前只受理广东本地三个区的借款申请，后期将根据业务发展情况，在其他城市开发借款服务，请关注公告。</div>
            </li>
            <li>
            <div class="ico_wen">提交借款申请后会有人跟我联系吗？</div>
            <div class="ico_da">由于审核部门每天要对大量的借款信息做审核工作，因此我们仅对通过初审的借款申请进行电话回访，并告知接下来的借款流程。</div>
            </li>
            <li>
            <div class="ico_wen">借款资金由温商贷提供吗？</div>
            <div class="ico_da">温商贷只为投资人与融资方搭建提供保障服务的平台，本身并不提供任何资金，所有资金均来自温商贷的注册投资理财用户。</div>
            </li>	
            </ul>
        </div>
    <div class="clear"></div>
	</div>
	
	<div id="smrz" <%if(StringHelper.isEmpty(erd) || !"2".equals(erd)){%>
			style="display: none;" <%}%>>
			<div class="popup_bg"></div>
			<div class="dialog w510" style="margin:-150px 0 0 -255px;">
				<div class="dialog_close fr" onclick="hidebg('smrz');"><a href="javascript:void(-1);"></a></div>
			    <div class="con clearfix">
			      <div class="d_error fl"></div>
			      	<div class="info">尚未完成<span class="red">实名认证设置</span>，请前往<a href="<%=configureProvider.format(URLVariable.USER_NCIIC)%>" class="blue">安全信息</a>进行认证。</div>
			    </div>
			</div>
		</div>
		<div id="txmm" <%if(StringHelper.isEmpty(erd) || !"3".equals(erd)){%>
			style="display: none;" <%}%>>
			<div class="popup_bg"></div>
			<div class="dialog w510" style="margin:-150px 0 0 -255px;">
				<div class="dialog_close fr" onclick="hidebg('txmm');"><a href="javascript:void(-1);"></a></div>
			    <div class="con clearfix">
			      <div class="d_error fl"></div>
			      <div class="info">尚未完成<span class="red">实名认证设置</span>，请前往<a href="<%=configureProvider.format(URLVariable.USER_NCIIC)%>" class="blue">安全信息</a>进行认证。</div>
			    </div>
			</div>
		</div>
		
		<div id="yqts" <%if(StringHelper.isEmpty(erd) || !"4".equals(erd)){%>
			style="display: none;" <%}%>>
			<div class="popup_bg"></div>
			<div class="dialog w510" style="margin:-150px 0 0 -255px;">
				<div class="dialog_close fr" onclick="hidebg('yqts');"><a href="javascript:void(-1);"></a></div>
			    <div class="con clearfix">
			      <div class="d_error fl"></div>
			      <div class="info">您存在借款逾期，请先进行还款！</div>
			    </div>
			</div>
		</div>

		<div id="yycp" <%if(StringHelper.isEmpty(erd) || !"1".equals(erd)){%>
			style="display: none;" <%}%>>
			<div class="popup_bg"></div>
			<div class="dialog d_error w510" style="margin: -150px 0 0 -255px;">
				<div class="dialog_close fr" onclick="hidebg('yycp');">
					<a href="javascript:hidebg('yycp');"></a>
				</div>
				<div class="con clearfix">
					<div class="borrowing clearfix"></div>
					<div class="borrowing clearfix">
						<p>您已申请过其他产品，不能再申请此产品！</p>
					</div>
					<div class="clear"></div>
					<div class="dialog_btn">
						<a href="javascript:hidebg('yycp');" class="btn btn05">关闭</a>
					</div>
				</div>
			</div>
		</div>
		<a href="<%configureProvider.format(out,URLVariable.CREDIT_DKYX);%>"><span id="dkyxBtn"></span></a>
		<a href="<%configureProvider.format(out,URLVariable.CREDIT_QYDKYX);%>"><span id="qydkyxBtn"></span></a>
</div>
<!--相关问题答疑-->

<!--内容-->
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
	<script type="text/javascript"
		src="<%=controller.getStaticPath(request)%>/js/validation.js"></script>
	<script type="text/javascript">
	
	 function jk(key){
			switch (key) {
	        case 2:
	        	$("#dkyxBtn").click();
				break;
	        case 3:
	        	$("#qydkyxBtn").click();
				break;
			}
		} 
		function hidebg(id) {
			$("#" + id).hide();
		}
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
	
	/* $("#sumbitBtn").click(function()
	{
		$("#form1").submit();
	}); */
	
	</script>
			<script type="text/javascript"
		src="<%=controller.getURI(request, Region.class)%>"></script>
	
</body>
</html>
