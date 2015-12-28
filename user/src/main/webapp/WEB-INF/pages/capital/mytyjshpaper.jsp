<%@page import="com.dimeng.p2p.service.TasteActivityManage"%>
<%@page import="com.dimeng.p2p.account.user.service.entity.Safety"%>
<%@page import="com.dimeng.p2p.S61.enums.T6141_F04"%>
<%@page import="com.dimeng.p2p.account.user.service.SafetyManage"%>
<%@page import="com.dimeng.p2p.user.servlets.capital.Mytyjshpaper"%>
<%@page import="com.dimeng.p2p.user.servlets.capital.Mytyjklpaper"%>
<%@page import="com.dimeng.p2p.user.servlets.capital.AlerMytyjpaper"%>
<%@page import="com.dimeng.p2p.user.servlets.capital.Mytyjpaperend"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>我的<%
	configureProvider.format(out,SystemVariable.SITE_NAME);
%>_体验金
</title>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<%
SafetyManage userManage = serviceSession.getService(SafetyManage.class);
Safety data = userManage.get();
boolean flag=!StringHelper.isEmpty(data.isIdCard) && data.isIdCard.equals(T6141_F04.TG.name());
TasteActivityManage tasteActivityManage=serviceSession.getService(TasteActivityManage.class);
int userId=serviceSession.getSession().getAccountId();
int count=tasteActivityManage.recordCount(userId,"LYH");//看是否存在记录
%>
<script type="text/javascript">
	function addCard(){
		if(!<%=flag%>){
			$("#smrz").show();
			return false;
		}
	}
	function hidebg(id) {
		$("#" + id).hide();
	}
</script>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<%
		//CURRENT_CATEGORY = "WDHB";
		CURRENT_SUB_CATEGORY = "WDTYJ";
			//CURRENT_SUB_CATEGORY = "DDCX";
	%>
	<div class="w994 pb5">
		<span class="f16">
		<a href="<%=controller.getViewURI(request, com.dimeng.p2p.user.servlets.Index.class)%>">我的<%
			configureProvider.format(out,SystemVariable.SITE_NAME);
		%></a>
		</span> &gt; <a href="javascript:void(0)">资金管理</a>&gt; 我的体验金
	</div>
	<div class="contain clearfix">
		<div class="user_top"></div>
		<div class="about">
			<%@include file="/WEB-INF/include/menu.jsp"%>
			<div class="container fr">
			  <div class="sx_tyj_head">
			  <% UserInfoManage manage = serviceSession.getService(UserInfoManage.class); %>
                   <ul>
                     <li>已使用体验金：<b>￥<%=Formater.formatAmount(manage.useexpemoney())%></b></li>
                     <li>未使用体验金：<b>￥<%=Formater.formatAmount(manage.getbalance())%></b></li>
                   </ul>
                   <div class="clear"></div>
			       <p class="pt10">体验金有效日期为体验金活动的开始日期和结束日期之内，一切解析权归善行创投所有</p>
			  </div>
				<div class="p15">
					<div class="ln30 Men_bt">
						<div class="Menubox">                   
		                     <ul>
                                <li><a href="<%=controller.getViewURI(request, AlerMytyjpaper.class)%>">已投标的</a></li>
		                        <li><a href="<%=controller.getViewURI(request, Mytyjpaper.class)%>">体验金来源</a></li>
                                <li><a href="<%=controller.getViewURI(request, Mytyjklpaper.class)%>">体验金口令兑换</a></li>
                                <li class="hover">体验金序号兑换</li>
		                     </ul>
	                    </div>
                        <div class="clear"></div>
					</div>
				</div>
				<form action="<%=controller.getURI(request, Mytyjshpaper.class)%>" method="post" onsubmit="return addCard();">
                <div class="sx_tyj_ctbox">
			       <%{String errorMessage = (String)request.getAttribute("msg");if (!StringHelper.isEmpty(errorMessage)) {%>
			    		<b class="sx_pinkColor"><%StringHelper.filterHTML(out, errorMessage);%></b><br/> 
			        <%}}%>
			       <%if(count<1){%>
                   <p class="sx_tyj_checkbox">请输入体验金序号<input type="text" name="randNo" onKeyUp="" autocomplete="off" maxlength="9" class="text yhgl_ser tyj_txt mr20 ml20" /><input type="submit" style="cursor: pointer;" value="赠送体验金" class="sx_bigBlueBt" /></p>
                   <%}else{ %>
                   		<b class="sx_pinkColor">每个账户只能兑换一次哦，这么好的事情不介绍朋友怎么行</b><br/> 
                   <%} %>
                   <p class="blue_ls pb10">体验金序号规则</p>
                   <p> 
                     <b>活动时间：</b><br />
                     2015年3月24日10:00-4月21日10:00<br />
                     <b>活动内容：</b><br />
                         用户户在活动期间用体验卡序号领取体验金且进行投资赚收益。<br />
                     <b>活动形式：</b><br />
                         用户的每张体验卡都有赠送1000元体验金的专属序号，每个账户名只能使用体验金序号兑换一次体验金，用户扫描二维码进入领取页面，也可以登录官方平台进入个人中心领取，用户使用体验金投标赚取收益。<br />
                     <b>获取步骤：</b><br />
                     手机端：扫二维码→完成注册/登陆→输入序号领取体验金→体验金到账<br />
                     手机端：扫二维码→完成注册/登陆→实名认证→输入序号领取体验金→体验金到账
                   </p>
                </div>
                </form>
			</div>
			<div class="clear"></div>
		</div>
	</div>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
	<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/charge.js"></script>
	<div id="smrz" style="display: none;">
	         <div class="popup_bg"></div>
	         <div class="dialog w510 thickpos" style="margin:-80px 0 0 -255px;" >
			  <div class="dialog_close fr" onclick="hidebg('smrz');">
			  	<a href="javascript:void(-1);"></a>
			  </div>
			  <div class="con clearfix">
			    <div class="d_error fl"></div>
			    <div class="info fr">
			   
			     	<p class="f20 gray33">领取体验金必须<span class="red">实名认证</span>,请前往<a href="<%=configureProvider.format(URLVariable.USER_NCIIC)%>" class="blue">实名认证</a>进行认证。</p>
			    </div>
			    <div class="clear"></div>
			  </div>
			</div>
         </div>
</body>
</html>