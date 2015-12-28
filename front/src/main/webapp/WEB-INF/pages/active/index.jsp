<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.front.servlets.Region"%>
<%@page import="com.dimeng.p2p.S62.entities.T6211"%>
<%@page import="com.dimeng.p2p.modules.bid.front.service.BidWillManage"%>
<%@page import="com.dimeng.p2p.common.enums.IntentionType"%>
<%@page import="com.dimeng.p2p.front.servlets.credit.Dkyx"%>
<%@page  import="com.dimeng.p2p.account.front.service.UserManage"%>
<%@page import="com.dimeng.p2p.S61.entities.Rewarduser"%>
<%@page import="java.util.List"%>
<%-- <%@include file="/WEB-INF/include/authenticatedSession.jsp" %> --%>
<html>
<head>
<title><%=configureProvider.getProperty(SystemVariable.SITE_TITLE)%></title>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
<link rel="stylesheet" type="text/css" href="<%=controller.getStaticPath(request)%>/css/inside.css" />
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/jquery-1.11.0.min.js"></script>
</head>
<%
String ermsg = controller.getPrompt(request, response,PromptLevel.ERROR);

%>
<body>
	<%@include file="/WEB-INF/include/header3.jsp"%>
   <div class="sx_activebox">
    <div class="sx_act_head">
    </div>
    <div class="sx_act_f1 sx_act_border">
      <div class="sx_act_logo"><a href="http://www.myshanxing.com/"><img src="/images/white_logo.png" alt="" width="190"/></a></div>
      <div class="sx_act_show">您还有<b>
        <%  UserManage userManage =serviceSession.getService(UserManage.class);
           int msaward = userManage.getCountAward();
           out.print(msaward);
        %>
      </b>次机会抽奖哦！<a href="<%configureProvider.format(out,URLVariable.ACTIVITY_URL);%>" class="sx_act_bt3" target="_blank">抽奖</a></div>
      <div class="sx_act_show2"><a href="<%configureProvider.format(out,URLVariable.USER_NCIIC);%>" class="sx_act_bt3 sx_act_rebBt" target="_blank">实名认证抽肾6</a><a href="<%configureProvider.format(out,URLVariable.FINANCING_SBTZ);%>" class="sx_act_bt3 sx_act_blueBt" target="_blank">预约投标</a><div class="sx_act_tip">实名认证后自动跳转到肾6抽奖页面（包括身份证、邮箱、提现密码认证）<span></span></div></div>      
      <img src="/images/active_02.jpg" alt="" />
      <img src="/images/active_07.png" alt="" class="sx_act_awardList"/>
      <div class="sx_act_showAward">
         <a class="toReg2"><img id="redux66"  src="/images/award_active.jpg" alt="" width="372" height="212"/></a>
         <a href="<%configureProvider.format(out,URLVariable.REGISTER);%>" class="sx_act_bt1" target="_blank">注册抽奖</a>
      </div>
      <div class="sx_act_getAward">
         <div id="sx_view" style="overflow:hidden; height:230px; width:190px;">
         <ul id="sx_view1">  
         <li>mde_r**获三星平板电脑</li>
         <li>rhi5**获10话费</li>
         <li>mfi3_r**获360wifi</li>
          <li>dtas**获50元话费</li>
         <% 
           int activetype = 1;
		   List<Rewarduser> list = userManage.selectlistwarduser(activetype);
		   for(int i=0;i<list.size();i++){
	        	 Rewarduser rewarduser=list.get(i);
         %>
           <li><%=rewarduser.login_name.substring(0,4)+"**" %>获<%=rewarduser.reward.refood%></li>
         <% } %>
          <li>mdke_r**获亚马逊kindle</li>
          <li>g33_b**获20话费</li>
          <li>sgi3_r**获电影票</li>
          <li>abbd**获电影票</li>
          <li>wszj**获电影票</li>
          <li>comm**获360wifi</li>
          <li>sgi3**获50元话费</li>
          <li>ohtg**获20话费</li>
          <li>rrca**获20话费</li>
          <li>vna9**获50元话费</li>          
         </ul> 
        <div id="sx_view2"></div>
         </div>
      </div>
    </div>
    <div class="sx_act_f2 sx_act_border">
      <img src="/images/active_03.jpg" alt="" />
      <a href="<%configureProvider.format(out,URLVariable.WYTG);%>" class="sx_act_bt4" target="_blank">获取推广链接</a>
    </div>
    <div class="sx_act_f3 sx_act_border">
      <img src="/images/active_04.jpg" alt="" />
      <a href="<%configureProvider.format(out,URLVariable.USER_SAFETY_MSG);%>" class="sx_act_bt4" target="_blank">我要实名认证</a>
    </div>
    <div class="sx_act_f4 ">
      <img src="/images/active_05.jpg" alt="" />
      <a href="<%configureProvider.format(out, URLVariable.FINANCING_SBTZ);%>" class="sx_act_bt4" target="_blank">我要预约</a>
    </div>
    <div class="sx_act_f5">
      <img src="/images/active_06.png?version=20141205" alt="" />
    </div><br />
</div>

     
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
	<script type="text/javascript"> 
		  var speed=40 
		  var demo=document.getElementById("sx_view"); 
		  var demo2=document.getElementById("sx_view2"); 
		  var demo1=document.getElementById("sx_view1"); 
		  demo2.innerHTML=demo1.innerHTML 
		  function Marquee(){ 
		  if(demo2.offsetTop-demo.scrollTop<=0) 
			demo.scrollTop-=demo1.offsetHeight 
		  else{ 
			demo.scrollTop++ 
		  } 
		  } 
		  var MyMar=setInterval(Marquee,speed) 
		  demo.onmouseover=function() {clearInterval(MyMar);} 
		  demo.onmouseout=function() {MyMar=setInterval(Marquee,speed)} 
      </script>
  <script type="text/javascript"> 
   $(".toReg2").click(function(){
	    $(".overlay").show();
		$(".sx_popup").css("display","block");
	  })
  $(".sx_act_rebBt").mouseover(function(){
	    $(".sx_act_tip").show();
	})
	$(".sx_act_rebBt").mouseout(function(){
	    $(".sx_act_tip").hide();
	})
 </script>
</body>
</html>