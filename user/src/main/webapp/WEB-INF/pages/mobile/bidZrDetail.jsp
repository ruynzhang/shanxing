<!DOCTYPE HTML>

<%@page import="com.dimeng.util.filter.HTMLFilter"%>
<%@page import="com.dimeng.p2p.account.user.service.UserManage"%>
<%@page import="org.joda.time.Period"%>
<%@page import="org.joda.time.Interval"%>
<%@page import="org.joda.time.Days"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.dimeng.p2p.S62.entities.T6230"%>
<%@page import="com.dimeng.p2p.FeeCode"%>
<%@page import="com.dimeng.p2p.S62.entities.T6251"%>
<%@page import="com.dimeng.p2p.S62.entities.T6260"%>
<%@page import="com.dimeng.p2p.S61.entities.T6110"%>
<%@page import="com.dimeng.p2p.S62.entities.T6250"%>
<%@page import="com.dimeng.p2p.S61.enums.T6110_F06"%>
<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpServletResponse"%>
<%@page import="org.joda.time.DateTime"%>
<%@page import="com.dimeng.framework.service.ServiceSession"%>
<%@page import="com.dimeng.p2p.S62.enums.T6252_F09"%>
<%@page import="com.dimeng.p2p.S62.entities.SurpriseConfig"%>
<%@page import="com.dimeng.p2p.S62.entities.SurpriseLucre"%>
<%@page import="com.dimeng.p2p.modules.bid.user.service.DzxyManage"%>
<%@page import="com.dimeng.p2p.S61.entities.T6110"%>
<%@page import="com.dimeng.p2p.S62.entities.T6231"%>
<%@page import="com.dimeng.p2p.S62.enums.T6231_F21"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F20"%>
<%@page import="com.dimeng.p2p.service.MobileManage"%>

<html lang="zh-cn">
<head>
<title>善行创投</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="description" content="善行创投" />
<meta name="keywords" content="善行创投" />
<meta name="author" content="shanLin" />
<meta name="copyright" content="ShanLin all Right Reserved" />
<meta name="viewport" content="width=320; initial-scale=1.0; maximum-scale=1.0; user-scalable=0;" />
<meta name="apple-touch-fullscreen" content="YES" />
<meta name="apple-mobile-web-app-capable" content="yes">
<script src="/js/jquery-1.11.0.min.js" type="text/javascript" ></script>
<link rel="stylesheet" type="text/css" href="/mobile/css/bidDetail.css" />
<link rel="stylesheet" type="text/css" href="/mobile/css/style.css" />
<script>
$(document).ready(function(){
    $(".back_top").click(function(){$('body,html').animate({scrollTop:0},600);})
    var mW=$("#sx_m_main").width();$(".sx_input").css("width", mW -60+"px");
	$(".toReg2").mousemove(function(){ $(".overlay").show();$(".sx_popup").css("display","block");event.preventDefault();})
	$(".sx_err_btn").click(function(){$(".sx_popup").css("display","none");$(".overlay").hide();})
	$(".sx_reg_word2").click(function(){ $(".overlay").show();$(".sx_m_showShare").css("display","block");})
	$(".sx_m_showShare").click(function(){$(this).css("display","none");$(".overlay").hide();})		
	$(".sx_m_showbox").css("height", screen.height*0.6+"px");
	$(".toReg").click(function(event){	event.preventDefault();$('html,body').animate({scrollTop:$(this.hash).offset().top-40},1000);});
	$(".showText").click(function(){$(".sx_m_showbox").fadeIn();$(".overlay").show();$(".sx_m_close").show();})
	$(".sx_m_close").click(function(){$(".sx_m_showbox").fadeOut();$(".overlay").hide();$(this).hide();	})
	$("#redux").css("width",mW*0.8+"px");
	$(".container").css("height", mW*0.8*0.52+"px");
})
</script>

<link rel="shortcut icon" href="favicon.ico"/>
<link rel="apple-touch-icon" href="icon.png"/>
<link rel="apple-touch-icon" sizes="72×72" href="touch-icon-ipad.png" />
<link rel="apple-touch-icon" sizes="114×114" href="touch-icon-iphone4.png" />

<script type="text/javascript" src="/mobile/js/jquery.js"></script>
<script src="/js/jquery.tabs.js"></script>

<%
String path = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath();

// 返回的是否成功标志
String resMessage = "";
// String resMessage = controller.getPrompt(request,response,PromptLevel.INFO);
String errMessage = controller.getPrompt(request,response,PromptLevel.ERROR);
boolean isSuccess = false;
if(resMessage!=null){
  if(resMessage.equals("恭喜你，购买成功")){
   isSuccess = true;
  }
  serviceSession.getSession().removeAttribute("isSuccess");
}


String zqApplyId = request.getParameter("zqApplyId");// 债权申请Id
DzxyManage dzxyManage = serviceSession.getService(DzxyManage.class);

T6251 t6251 = null;
T6230 bid = null;
T6260 record = null;
T6231 bidExtend = null;
Map<String, Object> zqMap = null;

if (zqApplyId != null && !zqApplyId.trim().equals("")) {
 int zqApplyIdInt = Integer.parseInt(zqApplyId);// 债权Id
 record = dzxyManage.selectT6260(zqApplyIdInt);
 if (record == null)
	  throw new Exception("债权记录不存在");
 
 t6251 = dzxyManage.selectT6251(record.F02);
 
 bid = dzxyManage.getT6230(t6251.F03);
 bidExtend = dzxyManage.getExtra(t6251.F03);
 
 zqMap = new HashMap<String, Object>();
 zqMap.put("zqApplyId", record.F01);// 债权申请Id
 zqMap.put("creditNumber", t6251.F02);

 zqMap.put("holdPrice", Formater.formatAmount(t6251.F07) + "元");
 
 zqMap.put("dsbx", Formater.formatAmount(dzxyManage.getDsbx(t6251.F01)) + "元");
 
 zqMap.put("price", Formater.formatAmount(record.F03) + "元");
 zqMap.put("priceBig", record.F03);
 zqMap.put("issueNum", bidExtend.F03 + "/" + bidExtend.F02 + "个月");
 zqMap.put("repaymentWay", bid.F10.getChineseName());
 
 zqMap.put("rate", Formater.formatRate(bid.F06));
 zqMap.put("title", bid.F03);
 zqMap.put("bidType", dzxyManage.getBidType(bid.F04));
}

// 是否已登录
boolean isLogin = false;
if(dimengSession!=null&& dimengSession.isAuthenticated()){
	isLogin = true;
}

%>
</head>

<body>
<div class="alert_bg"></div>
<form method="post" class="form1" action="<%=path %>/mobile/mobileZqzr.htm">
<input type="hidden" id="path" value="<%=path %>" />
<input type="hidden" id="isSuccess" value="<%=isSuccess %>" />
<input type="hidden" id="isLogin" value="<%=isLogin %>" />
<input type="hidden" id="errMessage" value="<%=errMessage %>" />
<input type="hidden" id="bidId" value="<%=bid.F01 %>" />
<input type="hidden" id="bidType" value="<%=bid.F04 %>" />
<div class="wx_top">
    <a class="wx_top_logo" href="/mobile/index.html"></a>
    <div class="wx_top_btn">
    <%String accountName = null;
	   if (dimengSession == null || !dimengSession.isAuthenticated()) {%>
       		<a href="/mobile/register.html">免费注册</a>
        	<a href="/user/mobile/login.html">登录</a>
        <%} else { accountName = serviceSession.getService(UserManage.class).getAccountName();%>
       		<a  title="<%=accountName%>" href="/user/mobile/myWealth.htm">您好：<%StringHelper.truncation(new HTMLFilter(out), accountName, 8);%></a>
			<%--<a href="/user/mobile/myWealth.htm">我的财富</a>
			<a href="/user/mobile/loginout.html">安全退出</a> --%>
		<%}%>
    </div>
</div>
<div id="sx_m_main">
    <div class="sx_app_outlinebox">
        <div class="" style="clear: both;margin-top: 40px;text-align: center;"><%=bid.F03%>
        </div>
        <div class="sx_task_subbox">
            <ul>
              <li><i>债权编号</i><span class="sx_app_item_content sx_app_f16"><%=zqMap.get("creditNumber") %></span></li>
              <li><i>债权价值</i><span class="sx_app_item_content sx_app_orange sx_app_f18"><%=zqMap.get("holdPrice")%></span><b></b></li>
              <li><i>待收本息</i><span class="sx_app_item_content sx_app_orange sx_app_f18"><%=zqMap.get("dsbx")%></span><b></b></li>
              <li><i>转让价格</i><span class="sx_app_item_content sx_app_orange sx_app_f18"><%=zqMap.get("price")%></span><b></b></li>
              <li><i>剩余期限</i><span class="sx_app_item_content  sx_app_f18"><%=zqMap.get("issueNum")%></span></li>
              <li><i>还款方式</i><span class="sx_app_item_content  sx_app_f18"><%=zqMap.get("repaymentWay")%></span></li>
              <li><i>年化利率</i><span class="sx_app_item_content  sx_app_f18"><%=zqMap.get("rate")%></span><b></b></li>
              <li><i>债权类型</i><span class="sx_app_item_content  sx_app_f18"><%=zqMap.get("bidType")%></span></li>
              <li class="noborder"><i>状态</i><span class="sx_app_item_content">转让中</span></li>
            </ul>
        </div>
    </div>
    
    <!-- 金额输入框 -->
    <% 
    BigDecimal balance=new BigDecimal(0);
    MobileManage mobileManage = serviceSession.getService(MobileManage.class); 
    String isYuqi="";
    Map<String,Object> map=null;
    if(isLogin){
    	isYuqi =  mobileManage.isYuqi();
    	map = mobileManage.getUserBaseInfo();
    	balance = (BigDecimal)map.get("balance");
    }
    %>
    <style>
    .jineDiv{height:80px;padding:0 10px;}
    .jineDiv .subDiv0{float:left;width:80%;height:27px;}
    .jineDiv .subDiv1{float:left;width:80%;height:40px;}
    .jineDiv .subDiv1 input{border:1px solid #ccc;font-size:24px;}
	.jineDiv .subDiv2 a{margin-left:2%;float: right;margin-top: -38px;background-color: #3E8CE1;width:24.8%;height: 44px;line-height: 44px;text-align: center;font-size: 16px; padding: 0;border-radius: 4px;color:#fff;}
    .jineDiv .subDiv2 .disabled{background-color:#ccc;}

    </style>
    <div class="jineDiv">
     <%if(!isLogin){ %>
      <script>$(".jineDiv").height("54px");</script>
      <div class="subDiv1"><input type="text" value="<%=zqMap.get("priceBig") %>" style="border:0px;" name="amount" id="amount" readonly="readonly"/></div>
      <div class="subDiv2"><a href="/user/mobile/login.html" style="">立即登录</a></div>
     <%}else{ %>
      <% 
      boolean isKtb = true;// 是否可投标
      %>
       <%if(isKtb){ %>
       <div class="subDiv0 "><span>账户余额：</span><span class="sx_app_orange" ><%=balance %></span>&nbsp;元</div>
       <div class="subDiv1"><input type="text" value="<%=zqMap.get("priceBig") %>" style="border:0px;" name="amount" id="amount" readonly="readonly" /></div>
       <div class="subDiv2"><a href="javascript:checkBid();">立即投资</a></div>
       <%}else{ %> 
        <script>$(".jineDiv").height("20px");</script>
        <div class="subDiv1">仅预约户可投</div>
       <%} %>
      <%} %>
    </div>
    <div id="info"></div>
    <div class="popup_bg"  style="display: none;"></div>
    
  
    <input type="hidden" id="isYuqi" name="isYuqi" value="<%=isYuqi%>">
    <input type="hidden" id="charge" name="charge" value="<%=path %>/user/capital/charge.html">
    <input type="hidden" name="kyMoney" id="kyMoney" value=<%=balance %>>
    <input type="hidden" name="loanId" id="loanId" value=<%=bid.F01 %>>
    <input type="hidden" name="zqzrId" id="zqzrId" value=<%=zqApplyId %>>
    <input type="hidden" name="hbId" id="hbId" value=0>
    <input type="hidden" name="syje" id="syje" value=<%=bid.F07%>>
    <input type="hidden" name="minBid" id="minBid" value=<%configureProvider.format(out, SystemVariable.MIN_BIDING_AMOUNT);%>>
    
 <div class="dialog d_error w510" style=" display: none;">
    <div class="con clearfix">
      <div class="info fr" id="div_confirm" style="clear:both;">
       <p class="f20 gray33">投标购买确认</p>您此次购买金额为<i class="red"><span id="zxMoney">12</span></i>
      </div>
      <div id="selectDiv" style="clear:both;"></div>
      <div class="clear"></div>
      <div class="dialog_btn"><a href="javascript:void(0);" id="ok" class="btn btn01">确 定</a><a href="javascript:void(0)" id="cancel" class="btn btn05">取 消</a></div> 
    </div>
</div>

  <!-- 底部 -->
  <div id="bottomDivId" class="bottomDiv" style='display: none'><a class="bottomDiv" id="touzhiA" href="javascript:;"><span id="bottomSpan"></span></a></div>
  
</div>
</form>
<script type="text/javascript">
$(function(){
	$('.sx_app_listbox').Tabs({
		event:'click'
	});
	
	
	var isSuccess = $("#isSuccess").val();
	if(isSuccess=="true"){
		showSuccInfo("恭喜，投标成功");
		$("#info").html(showSuccInfo("恭喜，投标成功"));	
		$("div.popup_bg").show();
	}
	
	var errMessage = $.trim($("#errMessage").val());
	if(!reg_NULL(errMessage)&&errMessage!='null'){
		$("#info").html(showSuccInfo(errMessage));	
		$("div.popup_bg").show();
	}
	
	
});
var bidPk = document.getElementById("bidId").value;
var page = 1;
var hasNext = true;
function onclickInvestRecord(){
	if(hasNext)
		loadInvestRecord();
}
function loadInvestRecord(){
	$("#loadMore").hide();
	if(!hasNext)
		return;
	$('#loading').show();
	
	var url = $("#path").val()+"/proxy/app/investRecord.action";
	 
	$.ajax({
		type : "POST",
		url : url,
		data : {"id":bidPk, "size":10, "page":page},
		success : function(data){
			if(data.sc != 200)
				return;
			$('#loading').hide();
			var investTab = $(".invest_table");
			page+=1;
			hasNext = data.body.hasNext;
			$.each(data.body.content, function(i, n){
				investTab.append(
				"<tr class=\"investrecord\">"
				+"<td>"+n[0]+"</td>"
				+"<td>"+n[1]+"</td>"
				+"<td>"+n[2]+"</td>"
				+"</tr>");
			});
			if(hasNext)
				$("#loadMore").show();
		}
	});
}

function reg_NULL(str) {
	if (str == undefined || str == "" || str.length == 0) {
		return true;
	}
	return false;
}

// 判断必须为数字
function reg_Sz(str) {
	if (reg_NULL(str)) {
		return true;
	}
	var reg = /^(-?\d+)(\.\d+)?$/;
	return reg.test(str);
}

// 判断必须为数字(非空)
function reg_Sz2(str) {
	if (reg_NULL(str)) {
		return false;
	}
	return reg_Sz(str);
}

function checkBid(){
	$('.alert_bg').css('display','block');
	$("body").addClass("add_body_class");
	var amount=$("#amount").val();
	var kyMoney=$("#kyMoney").val();
	if(parseInt(kyMoney) < parseInt(amount)){
		var url=$("#charge").val();
		$("#info").html(showForwardInfo('您的账户余额不足进行本次投标 ，请在网页端充值。',"perfect",url,false));	
		$("div.popup_bg").show();
		return;
	}
	
	var isYuqi= $("#isYuqi").val();
	
	if(isYuqi == "Y"){
		$("#info").html(showDialogInfo("您有逾期未还的贷款，还完才能进行投标操作","perfect"));	
		$("div.popup_bg").show();
		return;
	}
	$("#zxMoney").text(amount);
	
	 $("div.popup_bg").show();
	 $("div.dialog").show();
}

$(function(){	

	$("#cancel").click(function(){
		$("div.dialog").hide();
		$("div.popup_bg").hide();
	  $(".alert_bg").css("display","none");
	$("body").removeClass("add_body_class");
	});
	
	$("#ok").click(function(){
		var form = document.forms[0];
		form.submit();
	$("body").removeClass("add_body_class");
	});
});

//封装信息消息文本.
function showDialogInfo(msg,type){
	return   '<body class="add_body_class">'+'<div class="alert_bg" style="display:block">'+'</div>'+'<div class="dialog w510 thickpos" >'+
		  '<div class="con clearfix">'+
		    '<div class="d_'+type+' fl"></div>'+
		    '<div class="info fr">'+
		      '<p class="f20 gray33">'+msg+'</p>'+
		    '</div>'+
		    '<div class="clear2"></div>'+
		    '<div class="dialog_btn"><a onclick="closeInfo()" class="btn btn01">关闭</a></div>'+
		  '</div>'+
		'</div>'+'</body>';
}

function showForwardInfo(msg,type,url,isIncludeQd){
	var qzHtml ="";
	if(isIncludeQd){
		qzHtml = '<a href="'+url+'" class="btn btn01">确 定</a>';
	}
	return  '<body class="add_body_class">'+'<div class="alert_bg" style="display:block">'+'</div>'+'<div class="dialog w510" >'+
    '<div class="con clearfix">'+
     ' <div class="d_'+type+' fl"></div>'+
      '<div class="info fr"><p class="f20 gray33">'+msg+'</p></div>'+
     ' <div class="dialog_btn dl_close_btn">'+qzHtml+'<a onclick="closeInfo()" class="btn btn01">确 定</a></div> '+
   ' </div>'+
'</div>'+'</body>';
}

function showSuccInfo(msg,type,url){
	return '<body class="add_body_class">'+'<div class="alert_bg" style="display:block">'+'</div>'+'<div class="dialog w510" >'+
    '<div class="con clearfix">'+
     ' <div class="d_'+type+' fl"></div>'+
      '<div class="info"><p class="f20 gray33">'+msg+'</p></div>'+
     ' <div class="dialog_btn dl_close_btn"><a href="javascript:closeInfo();" class="btn btn01">确 定</a></div> '+
   ' </div>'+
'</div>'+'</body>';
}

function closeInfo(){
	$("#info").html("");
	$("div.popup_bg").hide();
	$(".alert_bg").css('display','none');
	$("body").removeClass("add_body_class");
}
</script>
</body>
</html>