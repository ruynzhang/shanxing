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
<style type="text/css">
.sx_tyj_btng {position:absolute; width:1020px; height:40px; top:615px; left:50%; margin-left:-510px;}
.sx_tyj_btng span {display:inline-block; background:url(images/tyj_btn.png) -864px 0px no-repeat; width:8px; height:8px; margin:15px 30px; float:left;}
.sx_tyj_btng a {display:inline-block; float:left; background:url(images/tyj_btn.png) -2px 0px no-repeat; width:201px; height:40px;}
.sx_tyj_btng a.tyj_b2 {background-position:-205px 0px; }
.sx_tyj_btng a.tyj_b3 {background-position:-408px 0px; }
.sx_tyj_btng a.tyj_b4 {background-position:-611px 0px; }
.sx_act_tyj {padding:15px 40px 30px; color:#515151; position:relative;}
.sx_act_tyj ul {list-style-type:none;}
.sx_act_tyj li {margin-bottom:10px;}
.sx_act_tyj span {float:left; color:#ff5809;}
.sx_act_tyj p {margin-left:75px;}
.sx_tyj_pic {position:absolute; top:50px; }
.sx_tyj_btng .tyj_bt {position:absolute; width:106px; height:35px; display:block; top:-150px; left:65px; background-image:none; z-index:100; float:none; }
.sx_tyj_btng .r2 {top:-95px;}
.sx_tyj_btng .r3 {left:837px; top:-130px; width:118px; height:32px;}
.sx_tyj_btng .r4 {left:540px; top:-157px; width:200px; height:38px;}
.purpleBt {background:#9104cc; padding:5px 30px; display:inline-block; margin-right:20px; color:#fff; font-size:18px; line-height:150%; border-radius:20px; -webkit-border-radius:20px; -moz-border-radius:20px; -ms-border-radius:20px; }
.purpleBt:hover {color:#fff; background:#9d0fd9;}
</style>
</head>
<body>
	<%@include file="/WEB-INF/include/header3.jsp"%>
    <div class="sx_activebox2" style="background:#f9f7be; padding-bottom:20px;">
    
    <div class="sx_act_head2" style="height:671px; position:relative; background:url(/images/sx_game01.jpg) top center no-repeat;">
    </div>
    <div class="sx_act_item" style="width:1010px;  margin: 30px auto 50px; color:#515151; position:relative;">
    <div class="sx_act_tyj">
      <ul>
      <li><span>活动主题：</span><p>步步高升，秒秒抢金。</p></li>
      <li><span>活动时间：</span><p>5月21日-6月21日</p></li>
      <li><span>活动规则：</span><p>1.活动期间，用户通过手机扫描游戏二维码，参与互动小游戏，所得游戏分数即可领取对应金额的体验金，能拿多少，自己玩了算；<br />
               2. 游戏体验金仅限领取一次，用户若对游戏分数不满意，可重玩直至达到自己满意的分数再领取，游戏分数不累加；<br />
               3.嫌拿的少？玩完60秒分享朋友圈或发送微信好友，呼叫朋友发力再帮玩60秒，n个被邀请人中，第一个注册并实名认证朋友的体验金同时计入邀请人体验金账户。</p></li>
      <li><span>领取步骤：</span><p>扫描游戏二维码 → 参与互动游戏 → 领取体验金。</p></li>
      <li><span>游戏玩法：</span><p>点击“开始”进入游戏 → 左右滑动屏幕，操作游戏 → 时间到，游戏结束 → 选择重玩/领取体验金。</p></li>
      <li style="padding-left:75px; padding-top:20px;"><img src="/images/sx_game02.jpg" alt="" /></li>
      </ul>
    </div>
</div>
</div>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
</body>
