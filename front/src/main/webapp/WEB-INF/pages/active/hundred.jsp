<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.front.servlets.Region"%>
<%@page import="com.dimeng.p2p.S62.entities.T6211"%>
<%@page import="com.dimeng.p2p.modules.bid.front.service.BidWillManage"%>
<%@page import="com.dimeng.p2p.common.enums.IntentionType"%>
<%@page import="com.dimeng.p2p.front.servlets.credit.Dkyx"%>
<%@page  import="com.dimeng.p2p.account.front.service.UserManage"%>
<%@page import="com.dimeng.p2p.S61.entities.Rewarduser"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>

<%@page import="com.dimeng.p2p.S62.entities.Rank"%>
<%@page import="com.dimeng.p2p.service.RankActivityManage"%>
<%
RankActivityManage manage = serviceSession.getService(RankActivityManage.class);
Map<String,Object> map = manage.statisticsPhb();
%>

<%-- <%@include file="/WEB-INF/include/authenticatedSession.jsp" %> --%>
<html>
<head>
<title><%=configureProvider.getProperty(SystemVariable.SITE_TITLE)%></title>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
<link rel="stylesheet" type="text/css" href="<%=controller.getStaticPath(request)%>/css/inside.css" />
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/jquery-1.11.0.min.js"></script>
<style type="text/css">
.hu_b1 {background:#fcf2db;}
.sx_act_showbox {width:1010px; margin:0 auto; line-height:2; position:relative;}
.hu_b2 {background:#eceaea; border:1px solid #d3d3d3;}
.hu_rule {padding:0px 0px 0px 40px; position:relative;}
.hu_p1 {background:url(/images/hundred_icon.png) 0 -145px no-repeat; width:193px; height:294px; position:absolute; top:-50px; right:0;}
.hu_itemList {padding-bottom:30px; position:relative;}
.hu_itemList ul {list-style-type:none; }
.hu_itemList li {float:left; width:152px; height:199px; border:1px solid #e7e7e7; margin-left:35px; border-radius:3px; -webkit-border-radius:3px; -moz-border-radius:3px; -ms-border-radius:3px; text-align:center; background:#f6f6f6; cursor:pointer;}
.hu_itemList li .hu_nbox { border:1px solid #e7e7e7; border-right:none; border-left:none; padding:10px 0px;}
.hu_itemList li:hover,.hu_itemList li.current {background:#e6580b; border:1px solid #fc8a4c; color:#fff; transition:0.2s linear; -webkit-transition:0.2s linear; -moz-transition:0.2s linear; -ms-transition:0.2s linear;}
.hu_itemList li:hover .hu_nbox,.hu_itemList li.current .hu_nbox { border:1px solid #fc8a4c; border-right:none; border-left:none;}
.hu_itemList li p.hu_money {padding:8px 0px; font-size:16px; line-height:1.5;}
.hu_itemList li span {width:104px; height:104px; display:block; margin:0 auto; background:url(/images/hundred_icon.png)}
.hu_itemList li span.hu_icon1 {background-position:0 -1px;}
.hu_itemList li span.hu_icon2 {background-position:-105px -1px;}
.hu_itemList li span.hu_icon3 {background-position:-210px -1px;}
.hu_itemList li span.hu_icon4 {background-position:-315px -1px;}
.hu_itemList li span.hu_icon5 {background-position:-420px -1px;}
.hu_angle {background:url(/images/hundred_icon.png) -549px -38px no-repeat; width:21px; height:26px; position:absolute; bottom:-9px; left:100px;}
.hu_introPic {float:left; text-align:center; margin-right:50px;}
.hu_intro_left {position:relative;}
.hu_invite_2d {position:absolute; top:10px; right:20px;}
.hu_intro_left a {padding:5px 20px; background:#ed8b56; width:100px; display:inline-block; border-radius:3px; -webkit-border-radius:3px; -moz-border-radius:3px; -ms-border-radius:3px; font-size:16px; line-height:1.5; color:#fff; margin-top:5px; text-align:center;}
.hu_intro_left a:hover {color:#fff;}
.hu_Btbox {padding:40px 0px; text-align:center;}
.hu_Btbox a {display:inline-block; background:#e6580b; color:#fff; font-size:24px; line-height:1.5; padding:10px 100px; margin:0 20px; border-radius:3px; -webkit-border-radius:3px; -moz-border-radius:3px; -ms-border-radius:3px;}
.hu_Btbox a:hover {background:#f47733; transition:0.2s linear; -webkit-transition:0.2s linear; -moz-transition:0.2s linear; -ms-transition:0.2s linear;}
</style>
</head>
<body>
	<%@include file="/WEB-INF/include/header3.jsp"%>
    <div class="sx_activebox2" style="background:#fff; padding-bottom:20px; position:relative; color:#8c8c8c;">
    <div class="sx_act_head2" style="height:403px; position:relative; background:url(/images/hundred01.jpg) #e8590b top center no-repeat;">
    </div>
    <div class="hu_b1">
       <div class="sx_act_showbox">
          <p><img src="/images/hundred02.jpg" alt="" /></p>
       </div>
    </div>
    <div class="sx_act_showbox">
       <p><img src="/images/hundred03.jpg" alt="" /></p>
       <div class="hu_itemList">
          <ul>
            <li class="current">
              <p class="hu_money">现金5元返利</p>
              <div class="hu_nbox">
                 <span class="hu_icon1"></span>
              </div>
              <p class="hu_nDesc">关注公众微信号</p>
            </li>
            <li>
              <p class="hu_money">现金5元返利</p>
              <div class="hu_nbox">
                 <span class="hu_icon2"></span>
              </div>
              <p class="hu_nDesc">加入官方QQ交流群</p>
            </li>
            <li>
              <p class="hu_money">现金5元返利</p>
              <div class="hu_nbox">
                 <span class="hu_icon3"></span>
              </div>
              <p class="hu_nDesc">关注官方微博</p>
            </li>
            <li>
              <p class="hu_money">现金5元返利</p>
              <div class="hu_nbox">
                 <span class="hu_icon4"></span>
              </div>
              <p class="hu_nDesc">邀请好友注册</p>
            </li>
            <li>
              <p class="hu_money">现金5元返利</p>
              <div class="hu_nbox">
                 <span class="hu_icon5"></span>
              </div>
              <p class="hu_nDesc">邀请好友投资</p>
            </li>
          </ul>
          <div class="hu_angle"></div>
          <div class="clear"></div>
       </div>
    </div>
    <div class="hu_b2">
        <div class="sx_act_showbox" style="padding:40px; width:930px; display:block; height:200px;" id="v0">
            <div class="hu_introPic">
              <img src="/images/wechat_shanxing.png" width="170" height="170" alt="" />
              <p>扫描二维码关注</p>
            </div>
            <div class="hu_intro_left"><br />1.成功投资≥100元<br />
2.扫描左侧二维码，关注微信订阅号（myshanxing）<br />
3.在微信公众平台回复消息：#平台账号+手机号码#  (例：#feit123456+1350000000#）<br />
4.获得5元返利（自动于7个工作日内内存于平台账户中） 
            </div> 
            <div class="clear"></div>
       </div>
       <div class="sx_act_showbox" style="padding:40px; width:930px; display:none; height:200px;" id="v1">
            <div class="hu_introPic">
              <a href="http://qm.qq.com/cgi-bin/qm/qr?k=tNDaYLzeTm6TmqbLe_dD9eyO5iwd1qRs" target="_blank"><img src="/images/hundred_qq.png" width="170" height="170" alt="" /></a>
            </div>
            <div class="hu_intro_left"><br />1.成功投资≥100元<br />
2.点击下侧按钮，加入善行创投官方QQ交流群； 或直接输入群号查找加入：223270771（善行创投投资交流群 ）<br />
3.进群后发送回复消息给群主（群主ID：善行创投），发送消息格式为#平台账号+手机号码<br />（例：#feit123456+1350000000#）<br />
4.获得在5元返利（（自动于7个工作日内内存于平台账户中）） <br /><a href="http://qm.qq.com/cgi-bin/qm/qr?k=tNDaYLzeTm6TmqbLe_dD9eyO5iwd1qRs" target="_blank">申请入群</a>
            </div> 
            <div class="clear"></div>
       </div>
       <div class="sx_act_showbox" style="padding:40px; width:930px; display:none; height:200px;" id="v2">
            <div class="hu_introPic">
              <a href="http://qm.qq.com/cgi-bin/qm/qr?k=tNDaYLzeTm6TmqbLe_dD9eyO5iwd1qRs" target="_blank"><img src="/images/hundred_weibo.png" width="170" height="170" alt="" /></a>
              <p>点击关注官方微博</p>
            </div>
            <div class="hu_intro_left"><br />1.成功投资≥100元<br />
2.点击下侧按钮进入善行创投官方微博地址，点击关注微博。<br />
3.发送私信，私信格式为：#平台账号+手机号码#（例：#feit123456+1350000000#）<br />
4.获得在5元返利（（自动于7个工作日内内存于平台账户中）<br /><a href="http://qm.qq.com/cgi-bin/qm/qr?k=tNDaYLzeTm6TmqbLe_dD9eyO5iwd1qRs" target="_blank">关注官方微博</a>
            </div> 
            <div class="clear"></div>
       </div>
       <div class="sx_act_showbox" style="padding:40px; width:930px; display:none; height:200px;" id="v3">
            <div class="hu_introPic">
              <img src="/images/hundred_invite.png" width="170" height="170" alt="" />
            </div>
            <div class="hu_intro_left">
             <div class="hu_invite_2d"><img src="/images/game2ma.jpg" width="100" height="100" alt="" /></div>
            <br />1.成功投资≥100元<br />
2.推广码邀请好友注册，发送个人专属推广链接<br />
http://www.myshanxing.com/pay/slaward.html?code=13544112654<br />
备注好友注册时，需要输入邀请码：13467638121（通过邀请人链接进入注册页面，默认已添加邀请人邀请码）<br />
3.被邀请人点击链接注册成功后，您获得5元返利（（自动于7个工作日内内存于平台账户中）<br />
4.此返利奖励仅可领取一次，多个好友满足条件不叠加。
            </div> 
            <div class="clear"></div>
       </div>
       <div class="sx_act_showbox" style="padding:40px; width:930px; display:none; height:200px;" id="v4">
            <div class="hu_introPic">
              <img src="/images/hundred_finace.png" width="170" height="170" alt="" />
            </div>
            <div class="hu_intro_left"><br />1.邀请好友注册成功后，被邀请好友在活动时间内成功投资≥100元。<br />
2.您获得5元返利（（自动于7个工作日内内存于平台账户中）<br />
3.此返利奖励仅可领取一次，多个好友满足条件不叠加。
            </div> 
            <div class="clear"></div>
       </div>
    </div>
    <div class="sx_act_showbox">
       <br />
       <p><img src="/images/hundred04.jpg" alt="" /></p>
       <div class="hu_rule">
       <div class="hu_p1"></div>
        1.此活动仅对首次投资用户开放。<br />
        2.此次活动，用户最高返利上限为15元，完成更多不叠加。<br />
        3.返利方式4和5仅各自对一位好友有效（可以是不同好友）。<br />
        4.返利将于返利任务完成时间7个工作日内自动打入用户平台账户，用户可以按照平台流程正常体现。<br />
        5.所有返利均为真实人民币货币。<br />
        6.投资收益金额与奖励金额可叠加。<br />
        7.此活动最终解释权归善行创投所有。
     <div class="clear"></div>
</div>
    </div>
    <div class="sx_act_showbox hu_Btbox">
       <a href="/user/login.html">登&nbsp;&nbsp;&nbsp;&nbsp;录</a><a href="register.html">注&nbsp;&nbsp;&nbsp;&nbsp;册</a>
    </div>
</div>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
<script type="text/javascript"> 
$(".hu_itemList li").hover(function(){
	for(var i=0; i<5; i++) {
	  	$(".hu_itemList li").eq(i).removeClass("current");
		$("#v"+i).css("display","none");
	}
	$(this).addClass("current");
	var a=$(this).index();
	$("#v"+a).css("display","block");
	$(".hu_angle").animate({
		"left": 100+190*a+"px"
	},150);
	
})
</script>

</body>

