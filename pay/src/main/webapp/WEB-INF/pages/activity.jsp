<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Date"%>
<%@page import="com.dimeng.p2p.S61.entities.Rewarduser"%>
<%@page import="com.dimeng.p2p.pay.servlets.Activity"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<%@page import="com.dimeng.p2p.S61.entities.Reward"%>
<%@page  import="com.dimeng.p2p.modules.account.pay.service.UserManage"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>善行创投土豪驾到！点我抽ipad Air2等各种好礼~</title>
<meta name="description" content="善行创投" />
<meta name="keywords" content="善行创投" />
<meta name="author" content="shanLin" />
<meta name="copyright" content="ShanLin all Right Reserved" />
<link href="<%=controller.getStaticPath(request)%>/mobile/css/web.css" rel="stylesheet" type="text/css" media="screen">
<link rel="shortcut icon" href="favicon.ico"/>
<script src="<%=controller.getStaticPath(request)%>/mobile/js/jquery-1.11.0.min.js" type="text/javascript" ></script>
<script src="<%=controller.getStaticPath(request)%>/mobile/js/common2.js" type="text/javascript" ></script>
<script type='text/javascript' src='<%=controller.getStaticPath(request)%>/mobile/js/jquery.eraser2.js'></script>
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
	if(reward == null){
		controller.sendRedirect(request, response, configureProvider.format(URLVariable.USER_AWARD));
	}
%>
var smscommend = '<%=reward == null? "" : reward.smscommend%>';
</script>
</head>
<body>
<div id="sx_m_header">
    <div class="sx_m_logo"><a href="<%configureProvider.format(out,URLVariable.USER_AWARD);%>"><img src="<%=controller.getStaticPath(request)%>/mobile/images/white_logo.png" alt="" width="198"/></a></div><div class="sx_m_btBox sx_f21">100%的中奖率，你还在等什么！！！</div>
</div>
<div class="sx_award_menu">
   <div class="sx_award_share"><div class="bshare-custom"><span class="sx_blueColor sx_phone">客服电话: 4000-166-277</span><a title="分享到微信" class="bshare-weixin"></a><a title="分享到QQ空间" class="bshare-qzone"></a><a title="分享到新浪微博" class="bshare-sinaminiblog"></a><a title="分享到人人网" class="bshare-renren"></a><a title="分享到腾讯微博" class="bshare-qqmb"></a></div>
   <script type="text/javascript" charset="utf-8" src="http://static.bshare.cn/b/buttonLite.js#style=-1&amp;uuid=&amp;pophcol=3&amp;lang=zh">
   </script><script type="text/javascript" charset="utf-8" src="http://static.bshare.cn/b/bshareC0.js"></script></div>
   <div class="sx_a_menubox"><a href="<%configureProvider.format(out,URLVariable.USER_AWARD);%>">返回首页</a><a href="<%=configureProvider.format(URLVariable.USER_INDEX) %>">会员中心</a><a href="javascript:void(0);" class="current">抽奖</a></div>
</div>
<div id="sx_m_main">
     <!--block1-->
    <div class="sx_m_block1" style="padding-bottom:0px;">
       <div class="sx_m_text"><p><span class="sx_orangeColor">恭喜您成为我们的会员，获得一次抽奖机会，用您的指尖兴奋地刮吧！</span></p></div>
         <div class="container">
         <input type="hidden" id="mdbs" name="mdbs" value='<%=reward.id%>'/>
	     <input type="hidden" id="user_Url" value='<%=configureProvider.format(URLVariable.USER_INDEX)%>'/>
	      <input type="hidden" id="urlajax" value='<%=controller.getURI(request, Activity.class) + "?ddd=" + new Date().getTime()%>'/>
	      <input type="hidden" id="userName" name="userName" value='<%=request.getAttribute("accountName") %>'/>
	      <input type="hidden" id="code" name="code" value='<%=request.getAttribute("code") %>'/>
	     <img id="robot" src="<%=controller.getStaticPath(request)%>/mobile/images/<%=reward.jpgname%>" width="332" height="172"/>
	     <img id="redux" src="<%=controller.getStaticPath(request)%>/mobile/images/awardweb2.jpg" />
        </div><br /><br />
        <div class="sx_tc">凡在<span class="sx_redColor">12月10号10点到1月3号24点前</span>投资总额<span class="sx_redColor">前十名</span>的伙伴们更有神秘大奖哦</div>
        <div class="sx_m_bt1 sx_m_desc sx_tc"> <p class="sx_redColor">没中奖？邀请好友再抽奖，无上限哦</p></div>
        <p><a href="<%configureProvider.format(out,URLVariable.WYTG);%>" class="sx_blueBt">点击获取推广链接</a></p>
        <div class="sx_act_show sx_tc">您还有<b>
        <%  UserManage userManage =serviceSession.getService(UserManage.class);
           int msaward = userManage.getCountAward();
           out.print(msaward);
        %>
      </b>次机会抽奖哦！<a href="<%configureProvider.format(out,URLVariable.ACTIVITY_URL);%>" class="sx_act_bt3" target="_blank">抽奖</a></div>
        <p class="sx_reg_word2"><a href="<%configureProvider.format(out,URLVariable.USER_SAFETY_MSG);%>" class="sx_blueBt">实名认证抽肾6</a></p>
        <%--<div class="sx_m_bt1 sx_tc"> <p>即将可以预约标，2014年12月6号10点准点预约！</p></div> --%>
        <p class="sx_tc">想要投标点预约，抢到好标赚收益</p>
        <p><a href="<%configureProvider.format(out,URLVariable.FINANCING_SBTZ);%>" class="sx_orangeBt2">我要预约赚收益</a></p>
        
       
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
   <P class="sx_err_tip">请先注册！</P>
   <p><a href="<%configureProvider.format(out,URLVariable.USER_AWARD);%>" class="sx_err_btn">确定</a></p>
</div>
</body>
</html>
