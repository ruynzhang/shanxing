<%@page import="com.dimeng.p2p.service.TasteActivityManage"%>
<%@page import="com.dimeng.p2p.utlis.JfUtil"%>
<%@page import="com.dimeng.p2p.user.servlets.capital.Mytyjshpaper"%>
<%@page import="com.dimeng.p2p.user.servlets.capital.Mytyjklpaper"%>
<%@page import="com.dimeng.p2p.account.user.service.UserInfoManage"%>
<%@page import="com.dimeng.p2p.user.servlets.capital.AlerMytyjpaper"%>
<%@page import="com.dimeng.p2p.user.servlets.capital.Mytyjpaperend"%>
<%@page import="com.dimeng.p2p.common.Userexpemony2"%>
<%@page import="java.util.List"%>
<%@page import="com.dimeng.p2p.common.enums.userexpe_source"%>
<%@include file="/WEB-INF/include/authenticatedSession.jsp"%>
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
response.setStatus(HttpServletResponse.SC_MOVED_PERMANENTLY);
String newLocn = "/user/index.html";
response.setHeader("Location",newLocn);
%>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<%
		//CURRENT_CATEGORY = "WDHB";
		CURRENT_SUB_CATEGORY = "WDTYJ";
			//CURRENT_SUB_CATEGORY = "DDCX";
	%>
    <div class="user_adbox"><a href="/active/tyjactive.html" target="_blank"></a></div>
	<div class="w994 pb5 pt5">
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
			  <% UserInfoManage manage = serviceSession.getService(UserInfoManage.class); 
			  BigDecimal balance = manage.getbalance();
			  %>
                   <ul>
                     <li>已使用体验金：<b>￥<%=Formater.formatAmount(manage.useexpemoney())%></b></li>
                     <li>未使用体验金：<b>￥<%=Formater.formatAmount(balance)%></b></li>
                   </ul>
                   <div class="clear"></div>
			  </div>
				<div class="p15">
					<div class="ln30 Men_bt">
						<div class="Menubox">                   
		                     <ul>
                                <li><a href="<%=controller.getViewURI(request, AlerMytyjpaper.class)%>">已投标的</a></li>
		                        <li><a href="<%=controller.getViewURI(request, Mytyjpaper.class)%>">体验金来源</a></li>
                                <li class="hover">领取体验金</li>
		                     </ul>
	                    </div>
                        <div class="clear"></div>
					</div>
				</div>
				<form action="<%=controller.getURI(request, Mytyjklpaper.class)%>" method="post">
				<div class="sx_tyj_ctbox">
			      <%{String errorMessage = (String)request.getAttribute("msg");if (!StringHelper.isEmpty(errorMessage)) {%>
			           <div id="overMess" class="sx_overlay"></div>
			           <div id="mess" class="tyj_popup">
	                      <div class="tyj_close">X</div>
	                          <div class="tyj_main">
	   	                            <div class="sx_tiptitle">温馨提示</div>
	                                       	 <div class="tyj_ctbox"><%StringHelper.filterHTML(out, errorMessage);%></div>
	                           </div>
                         </div>
			        <%}}%>
                   <p class="sx_tyj_checkbox">请输入口令<input type="text" name="randNo" onKeyUp="" autocomplete="off" maxlength="9" class="text yhgl_ser tyj_txt mr20 ml20" /><input type="submit" style="cursor: pointer;" value="领取体验金" class="sx_bigBlueBt" /></p>
                  <p class="sx_tyj_btg">
                  <%boolean [] hint = uManage.getTyjHint(); %>
                  <a target="_blank" href="http://www.myshanxing.com/financing/sbtz/tyblb.html" class="btg_1">体验金直接投标</a>
                  <%if(hint[2] == false){%>
                  <a href="javascript:void();" class="btg_2">玩游戏获取更多体验金</a>
                  <%} %>
                  <%if(hint[3] == true){%>
                  <a href="http://www.myshanxing.com/clubforum.html?mod=forumdisplay&fid=2" class="btg_3" target="_blank">戳我抢口令</a>
                  <%} %>
                  </p></br>
                   <p class="blue_ls pb10">温馨提醒：</p>
                   <p>
                   	 1.	活动期间所获得的体验金可用于体验标投资，所得收益可直接用于提现；<br />
                     2.	关注官方微信<b>myshanxing</b>参与互动小游戏可以赢取更多体验金<br />
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
<div class="sx_overlay"></div>
<div class="tyj_popup">
   <div class="tyj_close">X</div>
   <div class="tyj_main">
     <div class="sx_tiptitle">扫描二维码</div>
     <div class="tyj_ctbox">手机扫描游戏二维码，参与互动游戏，<br />赢取更多体验金！<br /><br />
       <p><img src="<%=controller.getStaticPath(request)%>/images/game2ma.jpg" alt="" /></p>
     </div>
   </div>
</div>
<script type="text/javascript">
	function hidebg(id) {
		$("#" + id).hide();
	}
</script>
<%
String msg=controller.getPrompt(request,response,PromptLevel.INFO);
if (!StringHelper.isEmpty(msg) && msg.equals("未实名认证")){%>
<script>$("#smrz").show();</script>
<%}%>
<script type="text/javascript">
   $(".tyj_popup").css("width","320px");
   
   $(".tyj_popup").css("margin-left","-160px");
   $(".tyj_popup").css("margin-top","-180px");
   $(".tyj_close").click(function(){
	     $(".tyj_popup").css("display","none");
		 $(".sx_overlay").css("display","none");
   })
   $(".btg_2").click(function(){
	     $(".tyj_popup").css("display","block");
		 $(".sx_overlay").css("display","block");
   })
</script>
<script type="text/javascript">
$("#mess").css("height","180px");
$("#mess").css("display","block");
$("#overMess").css("display","block");
</script>
</body>
</html>