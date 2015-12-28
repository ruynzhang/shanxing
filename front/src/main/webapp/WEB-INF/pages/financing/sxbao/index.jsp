<%@page import="com.dimeng.p2p.utlis.Format"%>
<%@page import="com.dimeng.p2p.S61.entities.T6101"%>
<%@page import="com.dimeng.p2p.S62.entities.SxbaoConfig"%>
<%@page import="java.util.List"%>
<%@page import="com.dimeng.p2p.service.SxbaoManage"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<title>善行创投</title>
<link rel="icon" href="<%=controller.getStaticPath(request)%>/favicon.ico">
<link href="<%=controller.getStaticPath(request)%>/css/common.css" rel="stylesheet" type="text/css">
<link href="<%=controller.getStaticPath(request)%>/css/style_sx.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/zzsc1016.js"></script>
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/jquery.lazyload.min.js"></script> 
<script src="<%=controller.getStaticPath(request)%>/js/public.min.js" type="text/javascript" ></script>

<script>
$(function(){
	$("img.lazy").lazyload({effect : "fadeIn",threshold : 200});
});
</script> 
</head>
<body>
<!--------顶部栏-------->
<%@include file="/WEB-INF/include/header.jsp"%>
<%
SxbaoManage sxbaoManage = serviceSession.getService(SxbaoManage.class);
int id = IntegerParser.parse(request.getParameter("id"));
List<SxbaoConfig> sxConfigList = sxbaoManage.findActivityConfigListByType((long)id);
if(sxConfigList.size() == 0){
	response.sendError(HttpServletResponse.SC_NOT_FOUND);
	return;
}
String usrCustId = null;
String isYuqi = null;
boolean isSmrz = false;
%>
<div class="wrapper">
<link href="<%=controller.getStaticPath(request)%>/css/owl.carousel.css" rel="stylesheet" type="text/css">
<link href="<%=controller.getStaticPath(request)%>/css/owl.theme.css" rel="stylesheet" type="text/css">
 <div class="Middle">
        		<div class="wanto"><a href="<%configureProvider.format(out,URLVariable.INDEX);%>">首页</a>&nbsp;&gt;&nbsp;<a href="<%configureProvider.format(out,URLVariable.FINANCING_SBTZ);%>">我要投资</a>&nbsp;&gt;&nbsp;善行宝</div>	
                <div class="Investmentlist">
		        	<ul>
		          		<li><a href="<%configureProvider.format(out,URLVariable.FINANCING_SBTZ);%>">散标投资</a></li> 
		          		<li class="inenow"><a href="javascript:void(0);">善行宝</a></li> 
		         		<li><a href="<%=controller.getViewURI(request, com.dimeng.p2p.front.servlets.financing.sbtz.Zqzrlb.class)%>">债权转让</a></li>
		          	</ul>
		        </div>
                <div class="sxbao_box">
                <form id="form1" action="/pay/sxbaoInvest.htm" method="post">
                <input type="hidden" id="sbSucc" name="sbSucc" value="<%configureProvider.format(out, URLVariable.USER_ZQTBZ);%>">
                   <div class="sxbao_ele">
                       <ul>
                         <li><span>购买金额：</span><input type="text" id="amount" name="amount" maxlength="10" class="sxbao_inp1" onKeyUp="value=(parseInt((value=value.replace(/\D/g,''))==''?'0':value,10))" onkeydown='if(event.keyCode==13) return false;'></li>
                         <li><span>购买期限：</span>
                           <select name="cid" id="cid" class="sxbao_select">
                           <option value="0">请选择</option>
                           <%for(SxbaoConfig sxBaoConfig : sxConfigList){%>
                        	   <option value="<%=sxBaoConfig.id%>" loanPeriod="<%=sxBaoConfig.loanPeriod%>" rate="<%=sxBaoConfig.rate.setScale(4)%>" modeCh="<%=sxBaoConfig.mode.getChineseName()%>" mode="<%=sxBaoConfig.mode.toString()%>" investFloor="<%=sxBaoConfig.investFloor%>"><%=sxBaoConfig.title%>，<%=sxBaoConfig.loanPeriod%>个月，年收益率<%=Formater.formatRate(sxBaoConfig.rate)%></option>
                           <%}%>
                           </select>
                         </li>
                       </ul>
                       <div class="clear"></div>
                       <table width="100%" border="0" cellspacing="0" cellpadding="0" class="sxbao_tab">
                       <thead>
                        <tr>
                          <td>购买金额</td>
                          <td>期限</td>
                          <td>年化收益</td>
                          <td>还款方式</td>
                          <td>纯收益</td>
                        </tr>
                        </thead>
                        <tbody id="xianshi">
                        </tbody>
                      </table>
                   </div>
                   <div class="balance">
                      <%if(dimengSession != null && dimengSession.isAuthenticated()){
                    	  UserManage userManage = serviceSession.getService(UserManage.class);
                    	  UserInfoManage userInfoManage = serviceSession.getService(UserInfoManage.class);
                    	  isSmrz = userInfoManage.isSmrz();
                    	  T6101 userInfo = userInfoManage.search();
			        	  usrCustId = userManage.getUsrCustId();
			        	  isYuqi = userInfoManage.isYuqi();
			        	  %>
			        	<input type="hidden" name="kyMoney" id="kyMoney" value="<%=userInfo.F06%>">
			        	<input type="hidden" id="charge" name="charge" value="<%configureProvider.format(out,URLVariable.USER_CHARGE);%>">
                          <div class="baltit">可用余额</div>
                          <div class="balnub">￥<%=Formater.formatAmount(userInfo.F06)%>元</div>
                          <div class="btn1" id="ljsg"><a href="###">立即投资</a></div><div class="btn2"><a href="/user/capital/charge.html">充值</a></div>
                          <div class="clear"></div>
                       <%}else {%>
			          	<div class="show_loginBox">请先&nbsp;<a href="<%configureProvider.format(out,URLVariable.LOGIN);%>">登录</a>&nbsp;或&nbsp;<a href="<%configureProvider.format(out,URLVariable.REGISTER);%>">注册</a></div>
			          <%}%>
                   </div>
                   <div class="clear"></div>  
                </form>
               </div>
        </div>
<div id="dsftg" style="display: none;">
	<div class="popup_bg"></div>
	<div id="dsftg_ch" class="dialog w510 thickpos" style="margin:-80px 0 0 -255px;" >
		<div class="dialog_close fr" onclick="hidebg('dsftg');">
			<a href="javascript:void(-1);"></a>
		</div>
		<div class="con clearfix">
	    	<div class="d_succeed fl"></div>
	    	<div class="info fr">
	          <p class="f20 gray33">善行宝购买确认</p>
	                  您此次购买金额为<i class="red"><span id="sgje"></span></i>元，需支付金额<i class="red"><span id="sgje2"></span></i>,确认购买？
	      	</div>  
	      	<div class="clear" ></div>
	      	<div class="dialog_btn">
	      	<a href="javascript:void(0)" id="ok" class="btn btn01">确 定</a>
	      	<a href="javascript:hidebg('dsftg')" id="cancel" class="btn btn05">取 消</a></div>
	  	</div>
	</div>
</div>
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/dialog.js"></script>
<script type="text/javascript">
$(function(){
	$('#ljsg').click(function(){
		var amount = $('#amount').val();
		var option = $('#cid option:selected');
		if(amount == 0 || amount.length==0){
			$("#info").html(showDialogInfo("请输入购买金额","perfect"));	
			$("div.popup_bg").show();
			return;
		}
		if(option.val() == '0'){
			$("#info").html(showDialogInfo("请选择购买期限","perfect"));	
			$("div.popup_bg").show();
			return;
		}
		if(<%=!isSmrz || StringHelper.isEmpty(usrCustId)%>){
			$("#info").html(showForwardInfo('您需要先进行安全认证，才可购买！，点击"确定"，跳到安全认证页面，点击"取消"返回当前页面',"perfect", "/user/account/safetymsg2.html"));	
			$("div.popup_bg").show();
			return;		
		}
		var kyMoney=$("#kyMoney").val();
		if(parseInt(kyMoney) < parseInt(amount)){
			var url=$("#charge").val();
			$("#info").html(showForwardInfo('您的账户余额不足进行本次投标 ，请充值，点击"确定"，跳到充值页面，点击"取消"返回当前页面',"perfect",url));	
			$("div.popup_bg").show();
			return;
		}
		var minBid = option.attr('investFloor');
		if(parseInt(amount) < parseInt(minBid)){
			$("#info").html(showDialogInfo("您的投标金额小于投标最低金额","perfect"));	
			$("div.popup_bg").show();
			return;
		}
		var isYuqi= "<%=isYuqi%>";
		if(isYuqi == "Y"){
			$("#info").html(showDialogInfo("您有逾期未还的贷款，还完才能进行投标操作","perfect"));	
			$("div.popup_bg").show();
			return;
		}
		$('#sgje').html(amount);$('#sgje2').html(amount);
		$('#dsftg').show();
		$('#dsftg_ch').show();
		$("div.popup_bg").show();
	});
	$('#ok').click(function(){$("#form1").submit();});
	$('#amount').blur(function(){xianshi();});
	$('#cid').change(function(){xianshi();});
});
function xianshi(){
	var amount = $('#amount').val();
	var option = $('#cid option:selected');
	if(/\d/.test(amount) && option){
		if(option.val() == '0')
			return;
		var rate = option.attr('rate');
		var loanPeriod = option.attr('loanPeriod');
		var mode = option.attr('modeCh');
		var sy = (amount*rate/12*loanPeriod).toFixed(2);
		$('#xianshi').html('<td>'+amount+'元</td><td>'+loanPeriod+'个月</td><td>'+(rate*100).toFixed(2)+'%</td><td>'+mode+'</td><td>'+sy+'元</td>');		
	}
}
function hidebg(id){
	$('#' + id).hide();
	$("div.popup_bg").hide();
}
</script>
<div id="info"></div>
<%@include file="/WEB-INF/include/footer.jsp"%>
	<%
		String message = controller.getPrompt(request, response , PromptLevel.INFO);
			if (!StringHelper.isEmpty(message)) {
	%>
	<script type="text/javascript">
		$("#info").html(showSuccInfo("<%=message%>","succeed",$("#sbSucc").val()));	
		$("div.popup_bg").show();
	</script>
	<%
		}
	%>
	
	<%
		String errorMessage = controller.getPrompt(request, response , PromptLevel.ERROR);
			if (!StringHelper.isEmpty(errorMessage)) {
				
	%>
	<script type="text/javascript">
		$("#info").html(showDialogInfo("<%=errorMessage%>","error"));	
		$("div.popup_bg").show();
	</script>
	<%
		}
	%>
	
	<%
		String warnMessage = controller.getPrompt(request, response , PromptLevel.WARRING);
			if (!StringHelper.isEmpty(warnMessage)) {
	%>
	<script type="text/javascript">
		$("#info").html(showDialogInfo("<%=warnMessage%>","perfect"));	
		$("div.popup_bg").show();
	</script>
	<%
		}
	%>
</body>
</html>