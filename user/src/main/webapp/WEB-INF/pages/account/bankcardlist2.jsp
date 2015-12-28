<%@page import="com.dimeng.p2p.account.user.service.SafetyManage"%>
<%@page import="com.dimeng.p2p.account.user.service.TxManage"%>
<%@page import="com.dimeng.p2p.S61.enums.T6141_F04"%>
<%@page import="com.dimeng.p2p.account.user.service.entity.Safety"%>
<%@page import="com.dimeng.p2p.account.user.service.entity.BankCard"%>
<%@page import="com.dimeng.p2p.account.user.service.BankCardManage"%>
<%@page import="com.dimeng.p2p.user.servlets.account.Bankcardlist"%>
<%@page import="com.dimeng.p2p.user.servlets.account.Deletebankcard"%>
<%@page import="com.dimeng.p2p.user.servlets.account.Editbankcard"%>
<%@page import="com.dimeng.p2p.user.servlets.account.Addbankcard"%>
<%@page import="com.dimeng.p2p.common.enums.BankCardStatus"%>
<%@include file="/WEB-INF/include/authenticatedSession.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title><%=configureProvider.getProperty(SystemVariable.SITE_NAME)%></title>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
<link href="<%=controller.getStaticPath(request)%>/css/login.css" rel="stylesheet" type="text/css" media="screen">
</head>

<body>
<%@include file="/WEB-INF/include/header.jsp"%>
<%
		BankCardManage  bankCardManage = serviceSession.getService(BankCardManage.class);
		BankCard[] card = bankCardManage.bankCards();
		String iserror = "";
		TxManage manage = serviceSession.getService(TxManage.class);
		if(!manage.getnewVerifyStatus()){
			iserror = "1";
		}
		SafetyManage safeManage = serviceSession.getService(SafetyManage.class);
		Safety data = safeManage.get();
		if(StringHelper.isEmpty(data.txpassword)){
			controller.sendRedirect(request, response, "safetypwd.html");
			return;
		}
		if(card != null && card.length > 0){
			controller.sendRedirect(request, response, "safetyemail.html");
			return;
		}
		
		boolean tg = false;
		CURRENT_CATEGORY = "ZHGL";
		CURRENT_SUB_CATEGORY = "YHKXX";
%>
<div class="sx_normal_box sx_user_outline">
    <div class="sx_user_step">
        <ul class="sx_user_reg4">
          <li class="r_1"><i>1</i>实名认证</li>
          <li class="r_2"><i>2</i>第三方注册</li>
          <li class="r_3"><i>3</i>提现密码</li>
          <li class="r_4"><i>4</i>绑定银行卡</li>
          <li class="r_5"><i>5</i>绑定邮箱</li>
        </ul>
        <div class="clear"></div>
        </div>
<div class="user_top"></div>
   <div class="about">
     <div class="sx_group">
         <div class="p15">
       	   <div><div class="user_lsjt mb20">银行卡管理</div></div>
            <ul class="yhgl_li tc mb30">
            <li><a href="javascript:void(-1);" class="ico" onclick="addCard(0);"></a><a href="javascript:void(-1);" onclick="addCard(0);"  class="blue">添加银行卡</a></li>
            <div class="clear"></div>
           </ul>
         </div>   
          <div id="smrz" style="display: none;">
	         <div class="popup_bg"></div>
	         <div class="dialog w510 thickpos" style="margin:-80px 0 0 -255px;" >
			  <div class="dialog_close fr" onclick="hidebg('smrz');">
			  	<a href="javascript:void(-1);"></a>
			  </div>
			  <div class="con clearfix">
			    <div class="d_error fl"></div>
			    <div class="info fr">
			   
			     	<p class="f20 gray33">添加银行卡必须先<span class="red">实名认证、设置提现密码</span>,请前往<a href="<%=configureProvider.format(URLVariable.USER_NCIIC)%>" class="blue">安全信息</a>进行认证。</p>
			    </div>
			    <div class="clear"></div>
			  </div>
			</div>
         </div>
		<div class="sx_g_bt"><a href="safetyemail.html" class="sx_pinkBt" >下一步</a></div>
        <div class="ln30 pl20 mb40">
						<p class="blue f16">温馨提示：</p>
						1、如果您填写的开户支行不正确，可能将无法成功提现，由此产生的提现费用将不予返还<br>
						2、如果您不确定开户行支行名称，可打电话到所在地银行的营业网店询问或上网查询<br>
                        3、不支持提现至信用卡账户<br>
					</div>	
   	 </div><div class="clear"></div>
   </div>
</div>
<%@include file="/WEB-INF/include/footer.jsp"%>
<%@include file="/WEB-INF/include/script.jsp"%>
<%@include file="/WEB-INF/include/dialog.jsp"%>
<script type="text/javascript"
		src="<%=controller.getStaticPath(request)%>/js/validation.js"></script>
<script type="text/javascript">
	function deletecard(id){
		var r=confirm("是否确认删除！");	
		   if(!r){
	          return false;   
	  		 }
	 		var data={"value":id};
			$.ajax({
				type:"post",
				dataType:"html",
				url:"<%=controller.getURI(request, Deletebankcard.class)%>",
				data:data,
				success:function(data){
					window.location.reload();
				}
			});
	}
	
	function addCard(id) {
		if("1" == "<%=iserror%>"){
			$("#smrz").show();
			return false;
		}
		
		global_art = art.dialog.open("<%=controller.getViewURI(request, Addbankcard.class)%>",{
			id : 'addCard',
			title : '添加银行卡',
			opacity : 0.1,
			width : 783,
			height : 500,
			lock : true,
			close : function() {
				window.location.reload();
			}

		}, false);
	}
	
	function updateCard(id) {
		if("1" == "<%=iserror%>"){
			$("#smrz").show();
			return false;
		}
		
		global_art = art.dialog.open("<%=controller.getViewURI(request, Editbankcard.class)%>?id="+id,{
			id : 'addCard',
			title : '修改银行卡',
			opacity : 0.1,
			width : 783,
			height : 500,
			lock : true,
			close : function() {
				window.location.reload();
			}

		}, false);
	}
	
	function hidebg(id) {
		$("#" + id).hide();
	}
	
</script>
</body>
</html>
