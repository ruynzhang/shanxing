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
.sx_tyj_btng {position:absolute; width:1020px; height:40px; top:610px; left:50%; margin-left:-510px;}
.sx_tyj_btng span {display:inline-block; background:url(/images/tyj_btn.png) -864px 0px no-repeat; width:8px; height:8px; margin:15px 30px; float:left;}
.sx_tyj_btng a {display:inline-block; float:left; background:url(/images/tyj_btn.png) -2px 0px no-repeat; width:201px; height:40px;}
.sx_tyj_btng a.tyj_b2 {background-position:-205px 0px; }
.sx_tyj_btng a.tyj_b3 {background-position:-408px 0px; }
.sx_tyj_btng a.tyj_b4 {background-position:-611px 0px; }
.sx_act_tyj {padding:15px 40px 30px; color:#fff; position:relative;}
.sx_act_tyj ul {list-style-type:none;}
.sx_act_tyj li {margin-bottom:10px;}
.sx_act_tyj span {float:left; color:#fee436;}
.sx_act_tyj p {margin-left:75px;}
.sx_tyj_pic {position:absolute; top:50px; }
.sx_tyj_btng .tyj_bt {position:absolute; width:106px; height:35px; display:block; top:-150px; left:65px; background-image:none; z-index:100; float:none; }
.sx_tyj_btng .r2 {top:-95px;}
.sx_tyj_btng .r3 {left:837px; top:-130px; width:118px; height:32px;}
.sx_tyj_btng .r4 {left:540px; top:-137px; width:200px; height:58px;}
.purpleBt {background:#9104cc; padding:5px 30px; display:inline-block; margin-right:20px; color:#fff; font-size:18px; line-height:150%; border-radius:20px; -webkit-border-radius:20px; -moz-border-radius:20px; -ms-border-radius:20px; }
.purpleBt:hover {color:#fff; background:#9d0fd9;}
.sx_tyj_notice {color:#fff; padding:0px 40px 30px;}
.sx_tyj_notice span {background:none; width:85px; height:auto; margin:0;}
.sx_tyj_notice p {padding-left:10px; font-weight:normal;}
.rank_Bt {position:absolute; top:-150px; right:0; font-size:30px; background:#ffd949; color:#4a3b00; border:1px solid #f9b603; border-radius:3px; -webkit-border-radius:3px; -moz-border-radius:3px; -ms-border-radius:3px; padding:10px 20px; font-weight:bold;}
.rank_Bt:hover {background:#fffc00;}
</style>
</head>
<body>
	<%@include file="/WEB-INF/include/header3.jsp"%>
    <div class="sx_activebox2" style="background:#f05050; padding-bottom:20px;">
    <div class="sx_act_head2" style="height:892px; position:relative; background:url(/images/tyj_head.jpg) top center;">
        <div class="sx_tyj_btng">
           <a href="https://www.myshanxing.com/register.html" class="tyj_b1" target="_blank"></a><span></span>
           <a href="https://www.myshanxing.com/user/login.html" class="tyj_b2" target="_blank"></a><span></span>
           <a href="https://www.myshanxing.com/user/capital/mytyjklpaper.html" class="tyj_b3" target="_blank"></a><span></span>
           <a href="http://www.myshanxing.com/financing/sbtz/tyblb.html" class="tyj_b4" target="_blank"></a>
           <a href="https://www.myshanxing.com/register.html" class="tyj_bt r1" target="_blank"></a>
           <a href="https://www.myshanxing.com/user/login.html" class="tyj_bt r2" target="_blank"></a>
           <a href="https://www.myshanxing.com/user/capital/mytyjklpaper.html" class="tyj_bt r3" target="_blank"></a>
           <a href="http://www.myshanxing.com/clubforum.html?mod=forumdisplay&fid=2" class="tyj_bt r4" target="_blank"></a>
           
        </div>
    </div>
    <div class="sx_act_item" style="width:1008px; background:url(/images/tyj_04.jpg) top center repeat-y; margin-bottom:50px; color:#fff; position:relative;">
    <a href="/active/rank.html" class="rank_Bt" target="_blank">体验金投资风云榜</a>
    <p><img src="/images/tyj_01.jpg" alt="" /></p>
    <div class="sx_tyj_notice"><span>【活动简介】</span><p>活动期间，用户能通过多种活动形式获取不同金额的体验金，获得的体验金虽不是真实货币，但可以用于虚拟理财，且所得收益可以以真实货币形式直接提现到账。</p></div>
    <p><img src="/images/tyj_02.jpg" alt="" /></p>
    <div class="sx_act_tyj">
       <img src="/images/tyj_08.jpg" alt="" class="sx_tyj_pic" style="left:50px; top:0;"/>
      <ul>
      <li style="padding-left:250px;"><span>活动时间：</span><p>5月21日-6月21日</p></li>
      <li style="padding-left:250px;"><span>活动内容：</span><p>活动期间凡注册用户即可获得200元体验金，实名认证再获800元体验金。</p></li>
      <li style="padding-left:250px;"><span>领取步骤：</span><p>立即注册→实名认证→成功领取体验金</p></li>
      <li style="padding-left:250px;"><a href="https://www.myshanxing.com/register.html" class="purpleBt" target="_blank">立即注册</a><a href="https://www.myshanxing.com/user/login.html" class="purpleBt" target="_blank">立即登陆</a></li>
      </ul>
      <br /><br />
    </div>
    <p><img src="/images/tyj_03.jpg" alt="" /></p>
    <div class="sx_act_tyj">
       <img src="/images/tyj_07.jpg" alt="" class="sx_tyj_pic" style="top:0px; right:80px;"/>
      <ul>
      <li><span>活动时间：</span><p>5月21日-6月21日</p></li>
      <li style="padding-right:250px;"><span>活动内容：</span><p>活动期间，用户通过手机扫描善行创投公众号二维码，参与趣味互动小游戏。所得游戏分数可领取对应金额的体验金，能拿多少，自己玩了算？嫌拿的少？玩完60秒分享微信朋友圈/发送微信好友，呼朋唤友再帮玩60秒，玩后第一个注册并实名认证的朋友的体验金与邀请人双算！</p></li>
      <li><span>领取步骤：</span><p>手机扫描关注善行创投公众号→体验金→体验金游戏→玩游戏，赢取体验金</p></li>
      <li style="padding-right:250px;"><a href="/active/tyjgame.html" class="purpleBt" target="_blank">了解更多</a></li>
      </ul>
      <br /><br /><br />
    </div>
    <p><img src="/images/tyj_05.jpg" alt="" /></p>
    <div class="sx_act_tyj">
       <img src="/images/tyj_09.jpg" alt="" class="sx_tyj_pic" style="right:110px; top:20px;"/>
      <ul>
      <li style="padding-right:250px;"><span>活动时间：</span><p>5月21日-6月21日</p></li>
      <li style="padding-right:250px;"><span>活动内容：</span><p>活动期间，坛主在善林荟活动专区不定时发布体验金口令帖，用户通过抢到的口令在善行创投个人中心输入口令抢取体验金。</p></li>
      <li style="padding-right:250px;"><span>领取步骤：</span><p>善林荟活动专区→获取口令→注册/登陆善行创投→点击“领取体验金” →输入口令，抢取体验金</p></li>
      <li style="padding-right:250px;"><a href="http://www.myshanxing.com/clubforum.html?mod=forumdisplay&fid=2" class="purpleBt" target="_blank">立即抢口令</a></li>
      </ul>
      <br />
    </div>
    <p><img src="/images/tyj_06.jpg" alt="" /></p>
    <div class="sx_act_tyj">
       <img src="/images/tyj_10.jpg" alt="" class="sx_tyj_pic" style="left:80px; top:0px;"/>
      <ul>
      <li style="padding-left:250px;"><span>活动时间：</span><p>5月21日-6月21日</p></li>
      <li style="padding-left:250px;"><span>活动内容：</span><p>活动期间，善行创投向活动前已注册的老用户发送体验金口令激活短信，用户按短信提示操作即可领取1000元体验金</p></li>
      <li style="padding-left:250px;"><span>领取步骤：</span><p>领取方法一：短信口令链接→登录（未实名认证则认证）→领取体验金<br />领取方法二：短信口令→电脑登录个人中心（未实名认证则实名认证）→输入口令→领取体验金
</p></li>
      </ul>
    </div>
    <br /><br />
</div>
</div>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
    <script type="text/javascript">
	$(".sx_showPlay").css("display","block");
	</script>
</body>
