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
Map<String,Object> map = manage.statisticsPhbByDuan();
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
.sx_duan_box {color:#323232; line-height:2; font-size:14px;}
.sx_duan_box h1 {display:block ; width:148px; height:48px; background:url(/images/duan02.png) no-repeat; color:#fff; font-size:22px; line-height:1.5; padding:20px 0px 0px 50px; font-weight:normal; margin-bottom:10px;}
.sx_duan_box p {padding-left:10px;}
.sx_duan_v1 {float:right; width:450px;}
ul.sx_duan_rank {list-style-type:none; padding:50px 0px;}
ul.sx_duan_rank li {width:50%; float:left;}
ul.sx_duan_rank li h2 {width:430px; height:10px; background:url(/images/duan04.png) no-repeat; margin:0 auto;}
ul.sx_duan_rank li table {padding-bottom:10px;}
ul.sx_duan_rank li table td {padding:10px 0px; text-align:center;}
ul.sx_duan_rank li table.t1 {width:400px; background:#ffffd7; margin:0 auto; border:5px solid #e5dccd; border-top:none; border-bottom:none;}
ul.sx_duan_rank li table.t1 td span {display:inline-block; padding:2px 10px; background:#5b9231; border-radius:3px; -webkit-border-radius:3px; -moz-border-radius:3px; -ms-border-radius:3px; color:#fff; line-height:1.5;}
ul.sx_duan_rank li table.t2 {width:400px; background:#ffffd7; margin-left:60px; border:5px solid #a99364;}
ul.sx_duan_rank li table.t2 td span {width:20px; height:20px; background:#5b9231; border-radius:10px; -webki-border-radius:10px; -moz-border-radius:10px; -ms-border-radius:10px; display:inline-block; color:#fff; line-height:20px;}
ul.sx_duan_rank li tr.rowhead {background:#dbd7af; font-size:16px; line-height:1.5; font-weight:bold; }
ul.sx_duan_rank li tr.rowhead td {padding:5px 0px;}
.sx_actCT_bg {background:url(/images/duan_bg.jpg) #e9e7ce bottom center no-repeat; min-height:1270px;}
.sx_duan_Btbox {padding:30px 0px; text-align:center;}
.sx_duan_Btbox a {display:inline-block; width:180px; padding:10px 0px; color:#63973a; border:1px solid #63973a; border-radius:3px; -webkit-border-radius:3px; -moz-border-radius:3px; -ms-border-radius:3px; margin:0px 20px; font-size:24px; line-height:1.4;}
.sx_duan_Btbox a:hover,.sx_duan_Btbox a.green_Bt {background:#63973a; color:#fff;}
</style>
</head>
<body>
	<%@include file="/WEB-INF/include/header3.jsp"%>
    <div class="sx_activebox2" style="background:#e9e7ce;">
    <div class="sx_act_head2" style="height:589px; position:relative; background:url(/images/duan01.jpg) top center no-repeat;">
    </div>
    <div class="sx_actCT_bg">
    <div class="sx_act_item" style="width:970px;  margin: 30px auto 0px; padding:0px 20px; color:#515151;">
    <div class="sx_duan_box">
       <h1>前&nbsp;&nbsp;言</h1>
       <p>异乡客地，愈是没有年节的气氛，愈是怀念旧时代的年节情景。端午是个大节，也是很多母亲大忙特忙、大显身手的好时光。在外奋斗的许多游子想起她那灵活的双手，裹着四角玲珑的粽子，就好像马上闻到那股粽子香了，这个端午，善行创投要为无法品尝到母亲亲手包扎的浓香粽子、身处异乡的你送上一份别具温度的节日礼物。</p><br /> 
       <img src="/images/duan03.png" alt="" style="float:left;"/>
       <div class="sx_duan_v1">
       <h1>活动内容</h1>
       <p>活动期间，用户在平台进行投资，投资总额在平台排名前5名的用户，即能获得由平台赠送的别具温度的浓情端午粽子礼包。礼包除了美味的手工粽子还包含由善行创投倾情书写的手工贺卡，希望通过这种方式给你的端午节带来不一
样的幸福感。</p>
       </div><br />
       <div class="clear"></div>
       <ul class="sx_duan_rank">
         <li>
           <div class="sx_duan_awardbox">
             <h2></h2>
             <table width="100%" border="0" cellspacing="0" cellpadding="0" class="t1">
              <tr>
                <td width="172" height="25"></td>
                <td width="218"></td>
              </tr>
              <tr class="rowhead">
                <td>[ 奖项 ]</td>
                <td>[ 礼品 ]</td>
              </tr>
              <tr>
                <td><span>第一名</span></td>
                <td>好运粽（9个装）</td>
              </tr>
              <tr>
                <td><span>第二名</span></td>
                <td>好运粽（8个装）</td>
              </tr>
              <tr>
                <td><span>第三名</span></td>
                <td>好运粽（6个装）</td>
              </tr>
              <tr>
                <td><span>第四名</span></td>
                <td>好运粽（4个装）</td>
              </tr>
              <tr>
                <td><span>第五名</span></td>
                <td>好运粽（3个装）</td>
              </tr>
            </table>
            <h2></h2>
           </div>
         </li>
         <li>
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="t2">
              <tr>
                <td height="25" colspan="3" style="text-align:left; padding:10px 20px; font-size:18px; line-height:1.9; color:#5b9231; font-weight:bold;">实时投资榜 6月12日-6月19日</td>
              </tr>
              <tr class="rowhead">
                <td width="89">排名</td>
                <td width="146">投资金额</td>
                <td width="155">用户</td>
              </tr>
              <% 
               List<Rank> listRankTzs = (List<Rank>)map.get("tzDayBang");
               for(int i=0;i<listRankTzs.size();i++){
                Rank rankTz = listRankTzs.get(i);
               %>
                <tr>
                  <td><span><%=(i+1)%></span></td>
                  <td><%=rankTz.moneyTz%></td>
                  <td><%=rankTz.userName%></td>
                </tr>
               <%
               }
               %>
            </table>
         </li>
         <div class="clear"></div>
       </ul>
        <h1>活动规则</h1>
       <p>1、奖励仅针对在6月12日0:00-6月19日0:00投资总额在平台排名前5名的用户<br />
2、奖品将在活动结束后的7个工作日内由平台工作人员联系中奖用户后寄出，邮寄费用由善行创投承担。<br />
3、粽子皆在正规商家采购，请用户在保质期内放心食用<br />
4、活动的最终解释权归善行创投所有</p>
       <div class="sx_duan_Btbox"><a href="/financing/sbtz/" class="green_Bt">立即投资</a><a href="/user/login.html" target="_blank">登录</a><a href="/register.html" target="_blank">注册</a></div>
    </div>
    </div>
    </div> 
</div>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
</body>
