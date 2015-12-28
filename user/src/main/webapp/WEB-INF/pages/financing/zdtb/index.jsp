<%@page import="com.dimeng.p2p.S51.entities.T5124"%>
<%@page import="com.dimeng.p2p.modules.base.front.service.CreditLevelManage"%>
<%@page import="com.dimeng.p2p.user.servlets.financing.zdtb.Zztb"%>
<%@page import="com.dimeng.p2p.user.servlets.financing.zdtb.Yjtb"%>
<%@page import="com.dimeng.p2p.user.servlets.financing.zdtb.Close"%>
<%@page import="com.dimeng.p2p.common.enums.AutoSetStatus"%>
<%@page import="com.dimeng.p2p.S61.entities.T6101"%>
<%@page import="com.dimeng.p2p.account.user.service.entity.UserInfo"%>
<%@page import="com.dimeng.p2p.account.user.service.UserInfoManage"%>
<%@page import="com.dimeng.p2p.modules.bid.user.service.entity.AutoBidSet"%>
<%@page import="com.dimeng.p2p.modules.bid.user.service.ZdtbManage"%>
<%@page import="com.dimeng.p2p.user.servlets.Index"%>
<%@page import="com.dimeng.p2p.variables.defines.SystemVariable"%>
<%@include file="/WEB-INF/include/authenticatedSession.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>自动投标工具-<%configureProvider.format(out,SystemVariable.SITE_NAME); %></title>
<%@include file="/WEB-INF/include/meta.jsp" %>
<%@include file="/WEB-INF/include/style.jsp" %>
</head>
<body>
<%@include file="/WEB-INF/include/header.jsp" %>
<%
	CURRENT_CATEGORY = "LCGL";
	CURRENT_SUB_CATEGORY = "ZDTBGJ";
%>
<div class="contain clearfix">
<div class="user_top"></div>
   <div class="about">
      <%@include file="/WEB-INF/include/menu.jsp"%>
    <div class="container fr bor1">
         <div class="p15">
          <p class="title1"><b>自动投标</b></p>
           
         	<%
       					ZdtbManage autoUtilFinacingManage = serviceSession.getService(ZdtbManage.class);
						CreditLevelManage creditLevelManage = serviceSession.getService(CreditLevelManage.class);
       	         		AutoBidSet autoBidSet =	autoUtilFinacingManage.search();
       	         		
       	         		UserInfoManage userInfoManage = serviceSession.getService(UserInfoManage.class);
       	         		T6101 userInfo = userInfoManage.search();
       	       			if(userInfo == null){
       	       				response.sendError(HttpServletResponse.SC_NOT_FOUND);
       	       				return;
       	       			}
       	         		if(autoBidSet != null &&  autoBidSet.autoSetStatus == AutoSetStatus.QY){
             %>
         	
         <div class="mb20 pb30">
           <div>
               <ul class="zdtb mb30">
               <li class="f24 mb20">
                   <div class="til">自动投标状态：</div>
                   <div class="info">开启状态</div>
                   <div class="clear"></div>
               </li>
               <li>
                   <div class="til">账户可用余额：</div>
                   <div class="info"><%=Formater.formatAmount(userInfo.F06) %> 元</div>
                   <div class="clear"></div>
               </li>
               <li>
                   <div class="til">每次投标金额：</div>
                   <div class="info"><%=Formater.formatAmount(autoBidSet.timeMoney) %>元</div>
                   <div class="clear"></div>
               </li>
               <li>
                   <div class="til">利息范围：</div>
                   <div class="info"><%=Formater.formatRate(autoBidSet.rateStart) %>-<%=Formater.formatRate(autoBidSet.rateEnd)  %></div>
                   <div class="clear"></div>
               </li>
               <li>
                   <div class="til">借款期限：</div>
                   <div class="info"><%=autoBidSet.jkqxStart %>月-<%=autoBidSet.jkqxEnd %>月</div>
                   <div class="clear"></div>
               </li>
               <li>
                   <div class="til">账户保留金额：</div>
                   <div class="info"><%=Formater.formatAmount(autoBidSet.saveMoney) %>元</div>
                   <div class="clear"></div>
               </li>
               </ul>
           </div>
           <div class="clear"></div>
           <div style="width:150px; margin:auto" class="tc"><a href="<%=controller.getURI(request, Close.class) %>" class="btn06 fl mr20">关闭自动投标</a></div>
           <div class="clear"></div>
           </div>
         	<%	
         		}else{
         	%>
         	<div class="bom mb20 pb30 tc">
         	<div class="f24 pb20">自动投标状态：关闭状态</div>
         	<div class=" mb20 pb30 tc mt40">
           <div style="width:360px; margin:auto">
           	<a id="yjtb" href="javascript:void(0)" class="btn06 fl mr50" >开启一键式自动投标</a>
           	<a id="zztb" href="javascript:void(0)"  class="btn07 fl">开启自助式自动投标</a>
           </div>
           </div>
           <div class="clear"></div>
           </div>
           <div class="ln30 pl20 mb40">
            <p class="blue_ls">自动投标工具说明：</p>
            <p>借款进入招标中<%=configureProvider.getProperty(SystemVariable.AUTO_BIDING_START_TIME) %>分钟后，才会启动自动投标。</p>
            <p>投标进度达到<%=DoubleParser.parse(configureProvider.getProperty(SystemVariable.AUTO_BIDING_END_PROGRESS))*100 %>%时停止自动投标。若投标后投标进度超过<%=DoubleParser.parse(configureProvider.getProperty(SystemVariable.AUTO_BIDING_END_PROGRESS))*100 %>%，则投达到<%=DoubleParser.parse(configureProvider.getProperty(SystemVariable.AUTO_BIDING_END_PROGRESS))*100 %>%的剩余金额。</p>
            <p>单笔投标金额若超过该标借款总额的<%=DoubleParser.parse(configureProvider.getProperty(SystemVariable.AUTO_BIDING_MAX_PERCENT))*100 %>%，则按照该标借款总额的<%=DoubleParser.parse(configureProvider.getProperty(SystemVariable.AUTO_BIDING_MAX_PERCENT))*100 %>%金额投标。</p>
            <p>满足自动投标规则的金额小于设定的每次投标金额，也会进行自动投标。</p>
            <p>借款用户在获得借款时会自动关闭自动投标，以避免借款被用作自动投标资金。</p>
            <p>投标排序规则如下：</p>
            <p>a）投标序列按照开启自动投标的时间先后进行排序。</p>
            <p>b）每个用户每个标仅自动投标一次，投标后，排到队尾。</p>
            <p>c）轮到用户投标时没有符合用户条件的标，也视为投标一次，重新排队。</p>
            <br>
           </div>
           <%	
         		}
         	%>
       	           
           </div>  
       	 </div><div class="clear"></div>
   </div>
   </div>
   
   
  <div class="popup_bg"  style="display: none;"></div>
   <div class="dialog d_error w510 thickpos" id="yjtb_dialog" style="margin:-150px 0 0 -255px; display: none;">
	  		<div class="dialog_close fr" id="yjtb_close"><a></a></div>
			  <div class="con clearfix">
			    <div class="clearfix">
			    <form action="<%=controller.getURI(request, Yjtb.class) %>" method="post">
			      <table width="100%" border="0" cellspacing="0" class="tab_bom">
			        <tr>
			          <td>账户可用余额：</td>
			          <td><span class="red"><%=userInfo.F06 %></span>元（大于等于<span class="red">1000</span>元才可开启自动投标工具）</td>
			        </tr>
			        <tr>
			          <td>每次投标金额：</td>
			          <td><span class="red"><input type="hidden"  name="timeMoney" value="<%=configureProvider.getProperty(SystemVariable.AUTO_BIDING_PER_AMOUNT) %>">
			          			<%=Formater.formatAmount(new BigDecimal(configureProvider.getProperty(SystemVariable.AUTO_BIDING_PER_AMOUNT)))  %></span>元</td>
			        </tr>
			        <tr>
			          <td>利息范围：</td>
			          <td><input type="hidden" name="rateStart" value="<%=configureProvider.getProperty(SystemVariable.AUTO_BIDING_RATE_START) %>">
			          	  <input type="hidden" name="rateEnd" value="<%=configureProvider.getProperty(SystemVariable.AUTO_BIDING_RATE_END) %>">
			          <%=Formater.formatRate(DoubleParser.parse(configureProvider.getProperty(SystemVariable.AUTO_BIDING_RATE_START))) %>-
			          <%=Formater.formatRate(DoubleParser.parse(configureProvider.getProperty(SystemVariable.AUTO_BIDING_RATE_END))) %></td>
			        </tr>
			        <tr>
			          <td>借款期限：</td>
			          <td>
			          <input type="hidden" name="jkqxStart" value="<%=configureProvider.getProperty(SystemVariable.AUTO_BIDING_PERIOD_START) %>">
			          <input type="hidden" name="jkqxEnd" value="<%=configureProvider.getProperty(SystemVariable.AUTO_BIDING_PERIOD_END) %>">
			          <%=configureProvider.getProperty(SystemVariable.AUTO_BIDING_PERIOD_START) %>月-<%=configureProvider.getProperty(SystemVariable.AUTO_BIDING_PERIOD_END) %>月</td>
			        </tr>
			        <tr>
			          <td>账户保留金额：</td>
			          <td><span class="red">
			          <input type="hidden" name="saveMoney" value="<%=configureProvider.getProperty(SystemVariable.AUTO_BIDING_USER_ACCOUNT_REMAIN) %>">
			          <%=Formater.formatAmount(new BigDecimal(configureProvider.getProperty(SystemVariable.AUTO_BIDING_USER_ACCOUNT_REMAIN))) %></span>元</td>
			        </tr>
			      </table>
			    	<div class="dialog_btn">
			    		<% if(userInfo.F06.doubleValue()>=1000){ %>
			    			<input type="submit" class="btn btn001" style="cursor: pointer;" value="开启投标">
			    		<% }else{ %>
			    			<div class="btn04" style="width:88px; margin:auto;">开启投标</div>			    		
			    		<% } %>
			    	</div>
			      </form>
			    </div>
			    <div class="clear"></div>
			  </div>
			</div>
			
	<div class="dialog d_error w510 thickpos" id="zztb_dialog"  style="margin:-200px 0 0 -255px;display: none;">
		<div class="dialog_close fr" id="zztb_close"><a></a></div>
		  <div class="con clearfix">
		    <div class="clearfix">
		  	 <form action="<%=controller.getURI(request, Zztb.class) %>" onSubmit="return checkRate();" class="form1" method="post" id="zdtbForm">
		      <table width="100%" border="0" cellspacing="0" class="ta_lin">
		        <tr>
		          <td valign="top">账户可用余额：</td>
		          <td><span class="red"><%=userInfo.F06 %></span>元（大于等于<span class="red">
		          	<%=configureProvider.format(SystemVariable.AUTO_BIDING_MUST_AMOUNT) %></span>元才可开启自动投标工具）</td>
		        </tr>
		        <tr>
		          <td rowspan="2" valign="top">每次投标金额：</td>
		          <td>
						<input name="timeMoney" type="text" 
							class="yhgl_ser border required isint mulriple-<%=configureProvider.format(SystemVariable.AUTO_BIDING_MULT_AMOUNT) %> 
							min-size-<%=configureProvider.format(SystemVariable.AUTO_BIDING_MIN_AMOUNT) %> max-size-<%=userInfo.F06 %>"
							value="0.00" />元
						<p tip>（该数值须不小于<span class="red"><%=configureProvider.format(SystemVariable.AUTO_BIDING_MIN_AMOUNT) %></span>元，
							且为<%=configureProvider.format(SystemVariable.AUTO_BIDING_MULT_AMOUNT) %>的倍数）</p>
						<p errortip class="" style="display: none"></p>
		          </td>
		        </tr>
		        <tr>
		          <td></td>
		        </tr>
		        <tr>
		          <td rowspan="2" valign="top">利息范围：</td>
		          <td>
		          		<input id="rateStart" name="rateStart" type="text" 
							class="yhgl_ser w70 border required max-size-99.999" mtest="/^\d*(\d|(\.[0-9]{2}))$/" mtestmsg="只能有两位小数"
							value="" />
		          %-
		            <input id="rateEnd" name="rateEnd" type="text" 
							class="yhgl_ser w70 border required max-size-99.999" mtest="/^\d*(\d|(\.[0-9]{2}))$/" mtestmsg="只能有两位小数"
							value="" />
		          %
					<p tip>利率精确到小数点后两位且小于100</p>
					<p errortip class="" style="display: none"></p>		          
					</td>
		        </tr>
		        <tr>
		          <td></td>
		        </tr>
		        <tr>
		          <td valign="top">借款期限：</td>
		          <td><select name="jkqxStart" class="yhgl_ser required">
		          	<%
					for(int i=1;i<=36;i++)
					{
					%>
					<option value="<%=i %>" <%if(i==1) {%> selected="selected" <%} %>><%=i %></option>
					<%} %>
		          </select>
		          月-
		          <select name="jkqxEnd" class="yhgl_ser required">
	                <%
					for(int i=1;i<=36;i++)
					{
					%>
					<option value="<%=i %>" <%if(i==36) {%> selected="selected" <%} %>><%=i %></option>
					<%} %>
		          </select>
		          月</td>
		        </tr>
		        <tr>
		          <td rowspan="2" valign="top">账户保留金额：</td>
		          <td><input type="text"  name="saveMoney" class="yhgl_ser border required isint  max-size-<%=userInfo.F06 %>" value="0.00"/>元
		          	<p tip>（您可填写一个金额，这部分钱不会加入自动投标）</p>
						<p errortip class="" style="display: none"></p>
		          </td>
		        </tr>
		        <tr>
		          <td></td>
		        </tr>
		      </table>
		      <div class="dialog_btn">
		      			<% if(userInfo.F06.doubleValue()>=Integer.parseInt(configureProvider.format(SystemVariable.AUTO_BIDING_MUST_AMOUNT))){ %>
			    			<input type="button"  class="btn btn001" style="cursor: pointer;" value="开启投标" id="startTbBtn">
			    		<% }else{ %>
			    			<div class="btn04" style="width:88px; margin:auto;">开启投标</div>			    		
			    		<% } %>
		      </div>
		      </form>
		    </div>
		    <div class="clear"></div>
	  </div>
	</div>
<%@include file="/WEB-INF/include/footer.jsp" %>
<%@include file="/WEB-INF/include/script.jsp" %>
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/validation.js"></script>
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/financing/zdtb.js"></script>
<script type="text/javascript">
		function checkRate(){
			$rateStart = $("#rateStart");
			$rateEnd = $("#rateEnd");
			var rs = $rateStart.val();
			var re = $rateEnd.val();
			if(rs && re && parseFloat(rs) <= parseFloat(re)){
				return true;
			}
			var $error = $rateEnd.nextAll("p[errortip]");
			var $tip = $rateEnd.nextAll("p[tip]");
			$error.addClass("error_tip");
			$error.html("请输入正确的利息范围，如：1%-10%");
			$error.show();
			$tip.hide();
			return false;
		}
		$("#startTbBtn").click(function(){
			$("#zdtbForm").submit();
		});
	</script>
</body>
</html>