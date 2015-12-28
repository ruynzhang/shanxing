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
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/work.js"></script>
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/plugins/echarts/build/dist/echarts.js"></script>
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/plugins/echarts/doc/asset/js/codemirror.js"></script>
<style type="text/css">
.sx_rank_data {border:5px solid #d3e3ea; background:#edf4f7; border-radius:10px; -webkit-border-radius:10px; -moz-border-radius:10px; -ms-border-radius:10px; padding:20px 0px 20px 15px;}
.sx_rank_data ul {list-style-type:none;}
.sx_rank_data li {float:left; border-right:5px solid #d3e3ea; padding:0px 20px; text-align:center;}
.sx_rank_data li.rd1 {width:300px;}
.sx_rank_data li.rd2 {width:235px;}
.sx_rank_data li.rd3 {border-right:none;}
.sx_rank_data li p b {color:#fc8800; font-size:24px; line-height:1.5; font-weight:normal;padding-left:10px;}
.sx_rank_data li p span {color:#fc8800; font-size:40px; line-height:1.9;}
.sx_rank_data li .rd_desc {font-size:20px; color:#62757f; padding-top:20px;}
.sx_rank_data li .rd_date b {background:#62757f; color:#fff; font-size:32px; line-height:1.5; border-radius:3px; -webkit-border-radius:3px; -moz-border-radius:3px; -ms-border-radius:3px; font-weight:normal; display:inline-block; width:50px; height:50px;}
.sx_rank_data li .rd_date span {font-size:20px; line-height:1.5; padding:0px 5px;}
.sx_rank_data li .rd_date {margin-bottom:16px; padding-top:10px;}
.sx_rank_nav {position: relative; margin:0px 0px 30px; width:1010px;  text-align:center; z-index:10; height:60px; left:50%; margin-left:-505px; top:0;}
.sx_rank_nav p {position:absolute; top:0; left:0; width:100%; z-index:50;}
.sx_rank_nav a {display:inline-block; padding:20px 0px 12px; margin:0px 50px; color:#fff; font-size:16px; line-height:1.5;}
.sx_rank_nav a:hover,.sx_rank_nav a.chose {border-bottom:3px solid #fcff00; color:#fcff00; transition:0.2s linear; -webkit-transition:0.2s linear; -moz-transition:0.2s linear; -ms-transition:0.2s linear;}
.sx_rank_nav .rank_nav_bg {background:#46687a; opacity:0.7; filter:alpha(opacity=70); width:100%; height:100%; position:absolute; left:0; border-radius:3px; -webkit-border-radius:3px; -moz-border-radius:3px; -ms-border-radius:3px; height:60px;}
.rankBox {padding:50px 0px 0px;}
.rank_title {color:#0281c4; font-size:40px; line-height:1.5; text-align:center; padding-bottom:20px;}
.rank_tab {padding-bottom:20px;}
.rankTabList {width:485px; border:1px solid #d3e3ea; border-radius:3px; -webkit-border-radius:3px; -moz-border-radius:3px; -ms-border-radius:3px;}
.rankTabList h2,.rankTabList h3  {font-size:18px; line-height:1.5; padding:10px;}
.rankTabList h3 {color:#fc8800;} 
.rankTabList table td {padding:8px 10px; text-align:center;}
.rankTabList table thead td {background:#e9f2f6;}
.rankTabList table .it_n1,.rankTabList table .it_n {display:inline-block; width:22px; height:22px; background:#fc8800; border-radius:15px; -webkit-border-radius:15px; -moz-border-radius;15px; -ms-border-radius:15px; color:#fff;}
.rankTabList table .it_n {background:#62757f;}
.rankTabList table .it_m {color:#fc8800;}
.rank_leftbox {float:left;}
.rank_rightbox {float:right;}
.rank_memo {font-size:13px; line-height:1.5; padding:10px 0px;}
.rank_subData {border:1px solid #d3e3ea; border-radius:3px; -webkit-border-radius:3px; -moz-border-radius:3px; -ms-border-radius:3px; padding:0px 0px 0px 15px; margin-bottom:40px;}
.rank_subData ul {list-style-type:none;}
.rank_subData li {float:left; border-right:1px solid #d3e3ea; padding:0px 20px; text-align:center;}
.rank_subData li p b {color:#fc8800; font-size:24px; line-height:1.5; font-weight:normal;padding-left:10px;}
.rank_subData li p span {color:#fc8800; font-size:40px; line-height:1.7;}
.rank_subData li .rd_desc {font-size:14px; line-height:1.5; color:#62757f; padding:5px 0px 10px;}
.rank_subData li.rd1 {width:250px;}
.rank_subData li.rd2 {width:250px;}
.rank_subData li.rd3 {border-right:none; padding:0px 0px 0px 20px; width:390px;}
.rank_subData li.rd3 a {padding:10px 30px; border-radius:3px; -webbkit-border-radius:3px; -moz-border-radius:3px; -ms-border-radius:3px; color:#fff; margin-top:30px; display:inline-block; font-size:18px; line-height:1.5; margin-right:20px;}
.rank_subData li.rd3 a.rank_BlueBt {background:#0281c3;}
.rank_subData li.rd3 a.rank_OrangeBt {background:#fc8800;}
.rank_ad {margin:20px 0px 30px;}
.rank_rule {padding:20px; border:1px solid #d3e3ea; border-radius:3px; -webkit-border-radius:3px; -moz-border-radius:3px; -ms-border-radius:3px; background:#e9f2f6; line-height:1.8;}
.rank_rule p.pr {padding-left:15px;}
.tyj_popup {width:500px; background:#fff; position:fixed; top:50%; left:50%; margin-top:-60px; margin-left:-250px;
   border-radius:2px;
   -webkit-border-radius:2px;
   -moz-border-radius:2px;
   -ms-border-radius:2px;
	box-shadow:0px 1px 5px #5b5b5b; 
	-webkit-box-shadow:0px 1px 5px #5b5b5b; 
	-moz-box-shadow:0px 1px 5px #5b5b5b;  
	-ms-box-shadow:0px 1px 5px #5b5b5b; 
   text-align:center;	
   display:none;
   z-index:100;
   animation:mypop 0.4s;
   -webkit-animation:mypop 0.4s;
   -moz-animation:mypop 0.4s;
   -ms-animation:mypop 0.4s;
}
@keyframes mypop {
	0% {opacity:0; transform: scale(0.7,0.7);}
	70% {opacity:1; transform: scale(1.1,1.1);}
	100% {opacity:1; transform: scale(1,1);}
}
@-webkit-keyframes mypop {
	0% {opacity:0; -webkit-transform: scale(0.7,0.7);}
	70% {opacity:1; -webkit-transform: scale(1.1,1.1);}
	100% {opacity:1; -webkit-transform: scale(1,1);}
}
@-moz-keyframes mypop {
	0% {opacity:0; -moz-transform: scale(0.7,0.7);}
	70% {opacity:1; -moz-transform: scale(1.1,1.1);}
	100% {opacity:1; -moz-transform: scale(1,1);}
}
@-ms-keyframes mypop {
	0% {opacity:0; -ms-transform: scale(0.7,0.7);}
	70% {opacity:1; -ms-transform: scale(1.1,1.1);}
	100% {opacity:1; -ms-transform: scale(1,1);}
}
.tyj_popup .tyj_close {width:25px; height:25px; line-height:25px; background:#fff; color:#354f66; position:absolute; top:10px; right:9px; z-index:100; display:block; cursor:pointer;
   border-radius:20px; -webkit-border-rarius:20px; -moz-border-radius:20px; -ms-border-radius:20px;
}
.tyj_popup a { padding:4px 10px; display:inline-block; color:#fff; font-size:16px; line-height:150%; margin-right:10px; border-radius:4px; -webkit-border-radius:4px; -moz-border-radius:4px; -ms-border-radius:4px;}
.tyj_popup a.btg_1 {background:#ff313b;}
.tyj_popup a.btg_1:hover {background:#ff525a;}
.tyj_popup .tyj_main {
  padding:0px;
}
.tyj_popup .sx_tiptitle {
   padding:15px;
   font-size:16px;
   background:#354f66;
   color:#fff;
   text-align:left;
}
.tyj_popup .tyj_ctbox {
   padding:20px 10px;
   font-size:16px;
}
.tyj_popup .tyj_ctbox b {
   color:#ff313b;	
}
.tyj_popup .tyj_gbox {
   padding:0px 10px 15px;	
}
.CodeMirror{display:none;}
</style>
</head>
<body>
	<%@include file="/WEB-INF/include/header3.jsp"%>
    <div class="sx_activebox2" style="background:#fff; padding-bottom:20px;">
    <div class="sx_act_head2" style="height:580px; position:relative; background:url(/images/rank01.jpg) top center no-repeat;">
    </div>
    <div class="sx_act_item" style="width:1010px;  margin: 50px auto 50px; color:#62757f; position:relative;">
      <div class="sx_rank_data">
          <ul>
            <li class="rd1">
               <p><span><%=map.get("yfsTyj") %></span><b>元</b></p>
               <div class="rd_desc">已发送体验金</div>
            </li>
            <li class="rd2">
               <p><span><%=map.get("hdCyrs") %></span><b>人</b></p>
               <div class="rd_desc">活动参与人数</div>
            </li>
            <li class="rd3">
               <div class="rd_date"><b id="daySpan">0</b><span>天</span><b id="hourSpan">0</b><span>时</span><b id="minuteSpan">0</b><span>分</span><b id="secondSpan">0</b><span>秒</span></div>
               <div class="rd_desc">剩余活动时间</div>
            </li>
          </ul>
          <div class="clear"></div>
      </div>
     <div class="sx_rank_nav" id="rank_nav">
          <p><a href="#tyj_ranklist1">体验金收益总榜</a><a href="#tyj_ranklist2">游戏排行榜</a><a href="#tyj_ranklist3">抢口令排行榜</a><a href="#tyj_ranklist4">土豪投资排行榜</a></p>
          <div class="rank_nav_bg"></div>
     </div>
     
     <div id="tyj_ranklist1" class="rankBox">
         <h1 class="rank_title">体验金收益总榜</h1>
         <div class="rank_tab">
             <div class="rankTabList rank_leftbox">
                <h2>收益周榜<%=map.get("dayStartStr") %>（周一0点至周日11:59:59） </h2>
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <thead>
                <tr>
                  <td width="16%">排名</td>
                  <td width="57%">总体验金 </td>
                  <td width="27%">用户</td>
                </tr>
                </thead>
                <tbody>
                <% 
                List<Rank> listRanks = (List<Rank>)map.get("dayBang");
                for(int i=0;i<listRanks.size();i++){
                	Rank rank = listRanks.get(i);
               	%>
	               	<tr>
	                  <td><span class="it_n<%if(i<3){%>1<%}%>"><%=(i+1)%></span></td>
	                  <td><span class="it_m"><%=rank.money%><%=rank.tjyZc%></span></td>
	                  <td><%=rank.userName%></td>
	                </tr>
               	<%
                }
                %>
                </tbody>
              </table>
             </div>
             <div class="rankTabList rank_rightbox">
                <h3>收益总榜</h3>
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <thead>
                <tr>
                  <td width="16%">排名</td>
                  <td width="57%">总体验金 </td>
                  <td width="27%">用户</td>
                </tr>
                </thead>
                <tbody>
                <% 
                List<Rank> listRankZbs = (List<Rank>)map.get("totalBang");
                for(int i=0;i<listRankZbs.size();i++){
                	Rank rankZb = listRankZbs.get(i);
               	%>
	               	<tr>
	                  <td><span class="it_n<%if(i<3){%>1<%}%>"><%=(i+1)%></span></td>
	                  <td><span class="it_m"><%=rankZb.money%><%=rankZb.tjyZc%></span></td>
	                  <td><%=rankZb.userName%></td>
	                </tr>
               	<% 
                }
                %>
                </tbody>
              </table>
             </div>
             <div class="clear"></div>
             <p class="rank_memo">注：总体验金 (游戏体验金+抢口令体验金+其他体验金) </p>
         </div>
     </div>
     <div id="tyj_ranklist2" class="rankBox">
         <h1 class="rank_title">游戏排行榜</h1>
         <div class="rank_subData">
            <ul>
               <li class="rd1">
               <p><span><%=map.get("yxZtyj") %></span><b>元</b></p>
               <div class="rd_desc">游戏玩家获得总体验金</div>
            </li>
            <li class="rd2">
               <p><span><%=map.get("yxCyrs") %></span><b>人</b></p>
               <div class="rd_desc">游戏总参与人数</div>
            </li>
            <li class="rd3">
              <a href="javascript:void();" class="rank_BlueBt" id="game">马上开始游戏</a><a href="http://www.myshanxing.com/active/tyjgame.html" class="rank_OrangeBt" target="_blank">了解游戏规则</a>
            </li>
            </ul>
            <div class="clear"></div>
         </div>
         <div class="rank_tab">
             <div class="rankTabList rank_leftbox">
                <h2>游戏收益周榜<%=map.get("dayStartStr")%>（周一0点至周日11:59:59） </h2>
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <thead>
                <tr>
                  <td width="16%">排名</td>
                  <td width="57%">体验金收益</td>
                  <td width="27%">用户</td>
                </tr>
                </thead>
                <tbody>
                <% 
                List<Rank> listRankYxs = (List<Rank>)map.get("yxDayBang");
                for(int i=0;i<listRankYxs.size();i++){
                	Rank rankYx = listRankYxs.get(i);
               	%>
	               	<tr>
	                  <td><span class="it_n<%if(i<3){%>1<%}%>"><%=(i+1)%></span></td>
	                  <td><span class="it_m"><%=rankYx.money%></span></td>
	                  <td><%=rankYx.userName%></td>
	                </tr>
               	<%
                }
                %>
                </tbody>
              </table>
             </div>
             <div class="rankTabList rank_rightbox">
                <h3>游戏收益总榜</h3>
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <thead>
                <tr>
                  <td width="16%">排名</td>
                  <td width="57%">体验金收益</td>
                  <td width="27%">用户</td>
                </tr>
                </thead>
                <tbody>
                <% 
                List<Rank> listRankYxZbs = (List<Rank>)map.get("yxTotalBang");
                for(int i=0;i<listRankYxZbs.size();i++){
                	Rank rankYxZb = listRankYxZbs.get(i);
               	%>
	               	<tr>
	                  <td><span class="it_n<%if(i<3){%>1<%}%>"><%=(i+1)%></span></td>
	                  <td><span class="it_m"><%=rankYxZb.money%></span></td>
	                  <td><%=rankYxZb.userName%></td>
	                </tr>
               	<%
                }
                %>
                </tbody>
              </table>
             </div>
             <div class="clear"></div>
         </div>
     </div>
     <div id="tyj_ranklist3" class="rankBox">
         <h1 class="rank_title">抢口令排行榜</h1>
         <div class="rank_subData">
            <ul>
               <li class="rd1">
               <p><span><%=map.get("klDfTyj")%></span><b>元</b></p>
               <div class="rd_desc">待发口令体验金</div>
            </li>
            <li class="rd2">
               <p><span><%=map.get("klYfTyj")%></span><b>元</b></p>
               <div class="rd_desc">已发口令体验金</div>
            </li>
            <li class="rd3">
              <a href="http://www.shanlinhui.com/forum.php" class="rank_BlueBt" target="_blank">马上开始抢口令</a>
            </li>
            </ul>
            <div class="clear"></div>
         </div>
         <div class="rank_tab">
           <div class="clear"></div>
           <div id="echartDiv" style="height:400px;width:500px; float:left;"></div>
           <textarea id="echartCode" name="code" style="display:none">
		option = {
			tooltip : {
				trigger : 'item',
				formatter : "{a} <br/>{b} : {c} ({d}%)"
			},
			legend : {
				orient : 'vertical',
				x : 'left',
				data : [ '待发口令体验金<%=map.get("klDfTyj") %>', '已发口令体验金<%=map.get("klYfTyj") %>' ],
				textStyle : {
					fontSize : '13'
				}
			},
			calculable : true,
			series : [ {
				name : '发放情况:',
				type : 'pie',
				radius : [ '50%', '70%' ],
				itemStyle : {
					normal : {
						label : {
							show : false
						},
						labelLine : {
							show : false
						}
					},
					emphasis : {
						label : {
							show : true,
							position : 'center',
							textStyle : {
								fontSize : '16',
								fontWeight : 'bold'
							}
						}
					}
				},
				data : [ {
					value : <%=map.get("klDfTyj") %>,
					name : '待发口令体验金<%=map.get("klDfTyj") %>'
				}, {
					value : <%=map.get("klYfTyj") %>,
					name : '已发口令体验金<%=map.get("klYfTyj") %>'
				} ]
			} ]
		};
		</textarea>
		<div style="float:right;padding-top: 35px;"><img src="/images/rank03.png" alt="" /></div>
		<div class="clear"></div>
       </div>
     </div>
     <div id="tyj_ranklist4" class="rankBox">
         <h1 class="rank_title">土豪投资排行榜</h1>
         <div class="rank_tab">
             <div class="rankTabList rank_leftbox">
                <h2>投资周榜<%=map.get("dayStartStr")%>（周一0点至周日11:59:59） </h2>
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <thead>
                <tr>
                  <td width="16%">排名</td>
                  <td width="57%">投资金额</td>
                  <td width="27%">用户</td>
                </tr>
                </thead>
                <tbody>
                <% 
                List<Rank> listRankTzs = (List<Rank>)map.get("tzDayBang");
                for(int i=0;i<listRankTzs.size();i++){
                	Rank rankTz = listRankTzs.get(i);
               	%>
	               	<tr>
	                  <td><span class="it_n<%if(i<3){%>1<%}%>"><%=(i+1)%></span></td>
	                  <td><span class="it_m"><%=rankTz.moneyTz%></span></td>
	                  <td><%=rankTz.userName%></td>
	                </tr>
               	<%
                }
                %>
                </tbody>
              </table>
             </div>
             <div class="rankTabList rank_rightbox">
                <h3>投资总榜</h3>
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <thead>
                <tr>
                  <td width="16%">排名</td>
                  <td width="57%">投资金额</td>
                  <td width="27%">用户</td>
                </tr>
                </thead>
                <tbody>
                <% 
                List<Rank> listRankTzZbs = (List<Rank>)map.get("tzTotalBang");
                for(int i=0;i<listRankTzZbs.size();i++){
                	Rank rankTzZb = listRankTzZbs.get(i);
               	%>
	               	<tr>
	                  <td><span class="it_n<%if(i<3){%>1<%}%>"><%=(i+1)%></span></td>
	                  <td><span class="it_m"><%=rankTzZb.moneyTz%></span></td>
	                  <td><%=rankTzZb.userName%></td>
	                </tr>
               	<%
                }
                %>
                </tbody>
              </table>
             </div>
             <div class="clear"></div>
         </div>
     </div>
     <div class="rank_ad">
       <a href="http://www.myshanxing.com/active/tyjactive.html" target="_blank"><img src="/images/rank02.jpg" alt="" /></a>
     </div>
     <div class="rank_rule">
        <p>1.活动时间：2015年5月21日-6月21日。</p>
<p>2.活动对象：活动期间所有投资用户。</p>
<p>3.活动简介：活动期间，用户能通过多种活动形式获取不同金额的体验金，获得的体验金虽不是真实货币，但可以用于虚拟理财，且所得收益可以以真实货币<br />&nbsp;&nbsp;&nbsp;形式直接提现到账。</p>
<p>4.活动内容：注册送体验金；实名认证送体验金；微信游戏得体验金；抢口令得体验金；老客户回馈，短信口令/链接领取体验金。</p>
<p>5.排名顺序：活动期间，用户若抢得体验金一致或投资金额一致，则按照注册时间先后顺序排列。</p>
<p>6.活动规则：</p>
    <p class="pr">6.1活动期间所获体验金仅限用于活动有效期内体验专区体验标的的投资，无法对真实标的进行投资，体验标也不接受现金投资。</p>
    <p class="pr">6.2体验金自获取即日到活动结束内有效，到期后未进行投资系统将自动回收体验金。</p>
    <p class="pr">6.3体验金虚拟投资产生收益后收益以真实货币形式直接到账平台账户，不算入在体验金额度，放款通过时系统自动收回体验本金。 </p>
<p>7.若有其他疑问请拨打客服热线：400-166-277。</p>
<p>8.本次活动最终解释权归善行创投所有。</p>
     </div>
    </div>
</div>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
    <div class="sx_overlay"></div>
<div class="tyj_popup">
   <div class="tyj_close">X</div>
   <div class="tyj_main">
     <div class="sx_tiptitle">扫描二维码</div>
     <div class="tyj_ctbox">手机扫描游戏二维码，参与互动游戏，<br />赢取更多体验金！<br /><br />
       <p><img src="/images/game2ma.jpg" alt="" /></p>
     </div>
   </div>
</div>
<script type="text/javascript"> 
$("#rank_nav").capacityFixed();
$("#rank_nav a").click(function(){
	for(var i=0; i<4; i++)
	  {
	   $("#rank_nav a").eq(i).removeClass("chose");
	  }
    $(this).addClass("chose");
})
</script>
<script type="text/javascript">
   $(".tyj_popup").css("width","320px");
   $(".tyj_popup").css("margin-left","-160px");
   $(".tyj_popup").css("margin-top","-180px");
   $(".tyj_close").click(function(){
	     $(".tyj_popup").css("display","none");
		 $(".sx_overlay").css("display","none");
   })
   $(".sx_overlay").click(function(){
	     $(".tyj_popup").css("display","none");
		 $(this).css("display","none");
   })
   $("#game").click(function(){
	     $(".tyj_popup").css("display","block");
		 $(".sx_overlay").css("display","block");
   })
</script>
</body>

<input type="textarea" id="timeLeft" name="left" size="35" style="text-align: center" />  
<script LANGUAGE="javascript">  
fresh();
setInterval(fresh,1000);
function fresh(){
 var endtime = new Date(("2015-06-21 00:00:00").replace(/-/g, "\/"));
 var nowtime = new Date();
 var leftsecond=parseInt((endtime.getTime()-nowtime.getTime())/1000);
 if(leftsecond<0){leftsecond=0;}
 d=parseInt(leftsecond/3600/24);
 h=parseInt((leftsecond/3600)%24);
 m=parseInt((leftsecond/60)%24);
 s=parseInt(leftsecond%60);
 
 if (h.toString().length < 2) {h = "0" + h;}if (m.toString().length < 2) {m = "0" + m;}if (s.toString().length < 2) {s = "0" + s;}
	
 all=d+"天 "+h+"时"+m+"分"+s+"秒";
 
 document.getElementById("daySpan").innerHTML=d;
 document.getElementById("hourSpan").innerHTML=h;
 document.getElementById("minuteSpan").innerHTML=m;
 document.getElementById("secondSpan").innerHTML=s;
}
</script>

<!-- 图表 -->
<script type="text/javascript">
var myChart = null;

// 路径配置
require.config({
	paths : {
		echarts : "/plugins/echarts/build/dist"
	}
});

// 使用柱状图就加载bar模块,按需加载
require([ "echarts", "/plugins/echarts/src/theme/macarons", "echarts/chart/pie" ], function(ec) {

	// 基于准备好的dom,初始化echarts图表
	myChart = ec.init(document.getElementById("echartDiv"));

	var editor = CodeMirror.fromTextArea(document.getElementById("echartCode"), {});
	
	// 定义option变量(相当于new Function(option=...)),因为文本域内容为option...
	(new Function(editor.doc.getValue()))();
	
	// 设置属性
	myChart.setTheme("macarons");
	myChart.setOption(option, true);
});
</script>