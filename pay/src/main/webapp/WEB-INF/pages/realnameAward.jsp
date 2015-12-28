<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.dimeng.p2p.S61.entities.Rewarduser"%>
<%@page import="com.dimeng.p2p.pay.servlets.RealnameAwardServlet"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<%@page import="com.dimeng.p2p.S61.entities.Reward"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>善行创投土豪驾到！点我抽iphone6等各种好礼~</title>
<meta name="description" content="善行创投" />
<meta name="keywords" content="善行创投" />
<meta name="author" content="shanLin" />
<meta name="copyright" content="ShanLin all Right Reserved" />
<link href="<%=controller.getStaticPath(request)%>/mobile/css/web.css" rel="stylesheet" type="text/css" media="screen">
<link rel="shortcut icon" href="favicon.ico"/>
<script src="<%=controller.getStaticPath(request)%>/mobile/js/jquery-1.11.0.min.js" type="text/javascript" ></script>
<script src="<%=controller.getStaticPath(request)%>/mobile/js/common2.js" type="text/javascript" ></script>
<script type='text/javascript' src='<%=controller.getStaticPath(request)%>/mobile/js/jquery.erasername.js'></script>
<script type = "text/javascript">
addEventListener( "load", init, true );
function init( event ) {
	$("#redux").eraser();
}
function reset(event) {
	$("#redux").eraser('reset');
	event.preventDefault();
}
function grow(event) {
	$("#redux").eraser("size",150);		/* 橡皮擦大小 */
	event.preventDefault();
}
<%
	Reward reward = (Reward)request.getAttribute("reward");
%>
var smscommend = '<%=reward.smscommend%>';
var userAwardUrl = '<%configureProvider.format(out,URLVariable.USER_AWARD);%>';
</script>
</head>
<body>
<div id="sx_m_header" style="background:#ed4a11;">
    <div class="sx_m_logo"><img src="<%=controller.getStaticPath(request)%>/mobile/images/white_logo.png" alt="" width="198"/></div>
</div>
<div class="sx_award_menu">
   <div class="sx_award_share"><div class="bshare-custom"><span class="sx_blueColor sx_phone">客服电话: 4000-166-277</span></div>
   </div>
   <div class="sx_a_menubox"><a href="<%configureProvider.format(out,URLVariable.INDEX);%>">返回首页</a><a href="<%=configureProvider.format(URLVariable.USER_INDEX) %>">会员中心</a><a href="javascript:void(0);" class="current">抽奖</a></div>
</div>
<div id="sx_m_main">
     <!--block1-->
    <div class="sx_m_block1" style="padding-bottom:0px;">
       <div class="sx_m_text"><p><span class="sx_orangeColor">恭喜您成为我们的会员，获得一次抽奖机会，用您的指尖兴奋地刮吧！</span></p></div>
         <div class="container">
         <input type="hidden" id="mdbs" name="mdbs" value='<%=reward.id%>'/>
	     <input type="hidden" id="user_Url" value='<%=configureProvider.format(URLVariable.USER_INDEX)%>'/>
	      <input type="hidden" id="urlajax" value='<%=controller.getURI(request, RealnameAwardServlet.class) %>'/>
	      <input type="hidden" id="userName" name="userName" value='<%=request.getAttribute("accountName") %>'/>
	      <input type="hidden" id="code" name="code" value='<%=request.getAttribute("code") %>'/>
	     <img id="robot" src="<%=controller.getStaticPath(request)%>/mobile/images/<%=reward.jpgname%>" width="332" height="172"/>
	     <img id="redux" src="<%=controller.getStaticPath(request)%>/mobile/images/awardweb2.jpg" />
        </div><br /><br />
        <div class="sx_tc">凡在<span class="sx_redColor">12月10号10点到1月3号24点前</span>投资总额<span class="sx_redColor">前十名</span>的伙伴们更有神秘大奖哦</div>
        <div class="sx_m_bt1 sx_m_desc sx_tc"> <p class="sx_redColor">没中奖？邀请好友再抽奖，无上限哦</p></div>
        <p><a href="<%configureProvider.format(out,URLVariable.WYTG);%>" class="sx_blueBt">点击获取推广链接</a></p>
        <p class="sx_reg_word2">分享给好友，一起赢大奖！</p>
        <p class="sx_tc">想要投标点预约，抢到好标赚收益</p>
        <p><a href="<%configureProvider.format(out,URLVariable.FINANCING_SBTZ);%>" class="sx_orangeBt2">我要预约赚收益</a></p>
        <%-- <p class="sx_tc">想要投标点预约，抢到好标赚收益</p>
        <p><a href="" class="sx_orangeBt2">我要预约赚收益</a></p>
        --%>
    </div>
    <div class="sx_m_block5">
    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="sx_show_award">
        <thead>
        <tr>
          <td width="20%">奖项</td>
          <td width="50%">奖品名称</td>
          <td width="30%">人数</td>
        </tr>
        </thead>
        <tbody>
          <%
         List<Reward> listward = (List)request.getAttribute("listward");

         for(int i=0;i<listward.size();i++){
        	 Reward rewar=listward.get(i);
       %>
        <tr>
          <td><%=rewar.remeno %></td>
          <td><%=rewar.refood %></td>
          <td><%=rewar.countNumber %></td>
        </tr>
        <%} %>
        </tbody>
      </table>
      <table width="100%" border="0" cellspacing="0" cellpadding="0" class="sx_show_award sx_show_people">
        <thead>
        <tr>
          <td width="20%">用户名</td>
          <td width="25%">电话号码</td>
          <td width="25%">奖项</td>
          <td width="30%">中奖日期</td>
        </tr>
        </thead>
        <tbody>
         <%
         List<Rewarduser> list = (List)request.getAttribute("winUserList");
         for(int i=0 ;i < list.size(); i++){
        	 Rewarduser rewarduser=list.get(i);
        %>
        <tr>
          <td><%=rewarduser.login_name.substring(0,4)+"*****" %></td>
          <td><%=rewarduser.mobile.substring(0,3)+"****"+rewarduser.mobile.substring(rewarduser.mobile.length()-4,rewarduser.mobile.length()) %></td>
          <td>
            <%=rewarduser.reward.remeno%> 
          </td>
          <td><%=rewarduser.redate%></td>
        </tr>
      <%}%>
        </tbody>
      </table>
     </div>
</div>
<div class="overlay"></div>
     <div class="sx_popup">
   <P class="sx_err_tip"></P>
   <p><a href="###" class="sx_err_btn">确定</a></p>
</div>
</body>
<script type="text/javascript">
	$(".overlay").show();
	$(".sx_popup .sx_err_tip").html('请不要刷新或离开抽奖页面，否则会失去本次抽奖机会');
	$(".sx_popup").css("display","block");
	$(".sx_popup .sx_err_btn").css("display","block");
</script>
</html>