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
</head>

<body>
<%@include file="/WEB-INF/include/header.jsp"%>
<%
		BankCardManage  bankCardManage = serviceSession.getService(BankCardManage.class);
		//BankCard[] card = bankCardManage.getBankCars(BankCardStatus.QY.name());
		BankCard[] card = bankCardManage.bankCards();
		String iserror="";
		TxManage manage = serviceSession.getService(TxManage.class);
		if(!manage.getnewVerifyStatus()){
			iserror = "1";
		}
		UserManage usrManage = serviceSession.getService(UserManage.class);
		String usrCustId = usrManage.getUsrCustId();
		boolean tg = BooleanParser.parse(configureProvider.getProperty(SystemVariable.SFZJTG));
		tg=false;
		CURRENT_CATEGORY = "WDWDW";
		CURRENT_SUB_CATEGORY = "WDWDW";
%>

<div class="w994 pb5"><span class="f16">我的<%=configureProvider.getProperty(SystemVariable.SITE_NAME) %></span> &gt; 账户管理  &gt; 银行卡管理</div>
<div class="contain clearfix">
<div class="user_top"></div>
   <div class="about">
     <%@include file="/WEB-INF/include/menu.jsp"%>
     <div class="container fr">
         <div class="p15">
       	   <div><div class="user_lsjt mb20">银行卡管理</div></div>
       	   <%if(tg && StringHelper.isEmpty(usrCustId)){ %>
       	   		<div class="f16 mt30 pt50 pb50 tc ml30 mr30" style="background:#f3f3f3;">
		            	 您需要在第三方托管平台上进行注册，才可申请充值提现！请<a target="_blank" href="<%=configureProvider.format(URLVariable.ESCROW_URL_USERREGISTER) %>" class="red">立即注册</a>！
		        </div>
       	   <%}else{ %>
            <ul class="yhgl_li tc mb30">
            <%
            if(card !=null){
            	
            
            for(BankCard b : card){ %>
            <li class="mb10">
            <p><span class="f18 ln30"><%StringHelper.filterHTML(out, b.Bankname);%></span><br/>
            <%StringHelper.filterHTML(out, b.BankNumber.substring(0, 4)+" *** *** "+b.BankNumber.substring(b.BankNumber.length()-4,b.BankNumber.length()));%></p>
	            <a href="javascript:void(-1);"  onclick="updateCard('<%=b.id%>');" class="mr40 blue">修改</a>
	            <%if(tg){ %>
	            	<a href="<%=configureProvider.format(URLVariable.ESCROW_URL_UNBINDCARD) %>?id=<%=b.id %>" class="blue">删除</a>
	            <%}else{ %>
	            	<a href="javascript:void(-1);" onclick="deletecard(<%=b.id %>);" class="blue">删除</a>
           		<%} %>
            </li>
            <%}} %>
            <%
            if(card != null){
            if(card.length<IntegerParser.parse(configureProvider.getProperty(SystemVariable.MAX_BANKCARD_COUNT))){%>
	            <%if(tg){ %>
	            	<li>
	            		<a target="_blank" href="<%=configureProvider.format(URLVariable.ESCROW_URL_BINDCARD) %>" class="ico"></a>
	            		<a target="_blank" href="<%=configureProvider.format(URLVariable.ESCROW_URL_BINDCARD) %>" class="blue">添加银行卡</a>
	            	</li>
				<%}else{ %>
					<li><a href="javascript:void(-1);" class="ico" onclick="addCard(0);"></a><a href="javascript:void(-1);" onclick="addCard(0);"  class="blue">添加银行卡</a></li>
				<%} %>
            <%}}else{%>
            <li><a href="javascript:void(-1);" class="ico" onclick="addCard(0);"></a><a href="javascript:void(-1);" onclick="addCard(0);"  class="blue">添加银行卡</a></li>
            <%} %>
            <div class="clear"></div>
           </ul>
           <%} %>
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
					location.href="<%=controller.getViewURI(request, Bankcardlist.class)%>";
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
