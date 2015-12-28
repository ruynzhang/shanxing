<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.service.TasteActivityManage"%>
<%@page import="com.dimeng.p2p.front.servlets.Region"%>
<%@page import="com.dimeng.p2p.S62.entities.T6211"%>
<%@page import="com.dimeng.p2p.modules.bid.front.service.BidWillManage"%>
<%@page import="com.dimeng.p2p.common.enums.IntentionType"%>
<%@page import="com.dimeng.p2p.front.servlets.credit.Dkyx"%>
<%@page  import="com.dimeng.p2p.account.front.service.UserManage"%>
<%@page import="com.dimeng.p2p.S61.entities.Rewarduser"%>
<%@page import="java.util.List"%>
<%
TasteActivityManage manage=serviceSession.getService(TasteActivityManage.class);
int userId=0;
try{
	userId=serviceSession.getSession().getAccountId();
}catch(Exception e){
	
}

%>
<%-- <%@include file="/WEB-INF/include/authenticatedSession.jsp" %> --%>
<html>
<head>
<title><%=configureProvider.getProperty(SystemVariable.SITE_TITLE)%></title>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
<link rel="stylesheet" type="text/css" href="<%=controller.getStaticPath(request)%>/css/inside.css" />
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/jquery-1.11.0.min.js"></script>
</head>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
        <!--banner-->
<div class="zq_banner">
<div class="banner5"></div>
</div>
<!--banner-->
    <!--------积分-------->
<div class="sx_normal_box sx_gradebox">
   <div class="sx_grade_sc">
      <div class="sx_grade_sleft">
         <div class="sx_grade_t1">VIP成长体系 
         <span><%if(userId>0){%>用户名：<%=manage.getUserName(userId)%>&nbsp;&nbsp;<b id="jfid">0分</b><%}else{ %>
        	 <a href="/user/login.html" class="blueLink">登录</a><%} %><a target="_blank" href="http://www.myshanxing.com/clubvip.html" class="sx_pinkLink">兑换</a>
         </span>
         </div>
         <img src="/images/grade01.jpg" alt="" />
      </div>
      <div class="sx_grade_sright">
           <div class="sx_grade_t1">新晋VIP会员</div>
           <div class="sx_grade_new">
         <div id="sx_view_grade">
         <ul id="sx_view1_grade">  
          <li><span>恭喜ted**</span><span>成功升至<b>VIP1</b></span></li>
          <li><span>恭喜vvhd**</span><span>成功升至<b>VIP2</b></span></li>
          <li><span>恭喜lj1330**</span><span>成功升至<b>VIP3</b></span></li>
          <li><span>恭喜dts**</span><span>成功升至<b>VIP2</b></span></li>
          <li><span>恭喜myco**</span><span>成功升至<b>VIP1</b></span></li>
          <li><span>恭喜oper**</span><span>成功升至<b>VIP1</b></span></li>
         </ul> 
        <div id="sx_view2_grade"></div>
         </div>
      <script type="text/javascript"> 
	  var speed=40 
	  var demo=document.getElementById("sx_view_grade"); 
	  var demo2=document.getElementById("sx_view2_grade"); 
	  var demo1=document.getElementById("sx_view1_grade"); 
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
	  var jf_url="/user/queryJf.htm";
		$(document).ready(function(){
			$.ajax({
				   type: "post",
				   url: jf_url,
				   cache:false,
				   success: function(data){
					   $("#jfid").html(data+"分");
				   }
			});
		});
      </script>
      </div>
      <img src="/images/grade02.jpg" alt="" />
      </div>
      <div class="clear"></div>
   </div>
   <div class="sx_grade_sc">
     <div class="sx_grade_t1">会员增值服务</div>
     <table width="100%" border="0" cellspacing="0" cellpadding="0" class="sx_grade_tabx1">
     <thead>
      <tr>
        <td>会员增值服务</td>
        <td>普通会员</td>
        <td>铜牌会员</td>
        <td>银牌会员</td>
        <td>金牌会员</td>
        <td>白金会员</td>
        <td>钻石会员</td>
      </tr>
     </thead>
     <tbody>
      <tr>
        <td class="tl">会员资讯</td>
        <td><span class="sx_grade_true"></span></td>
        <td><span class="sx_grade_true"></span></td>
        <td><span class="sx_grade_true"></span></td>
        <td><span class="sx_grade_true"></span></td>
        <td><span class="sx_grade_true"></span></td>
        <td><span class="sx_grade_true"></span></td>
      </tr>
      <tr>
        <td class="tl">积分兑换</td>
        <td><span class="sx_grade_true"></span></td>
        <td><span class="sx_grade_true"></span></td>
        <td><span class="sx_grade_true"></span></td>
        <td><span class="sx_grade_true"></span></td>
        <td><span class="sx_grade_true"></span></td>
        <td><span class="sx_grade_true"></span></td>
      </tr>
      <tr>
        <td class="tl">会员狂欢节</td>
        <td>&nbsp;</td>
        <td>每月8号</td>
        <td>每月8号</td>
        <td>每月8号</td>
        <td>每月8号</td>
        <td>每月8号</td>
      </tr>
      <tr>
        <td class="tl">会员专享标的</td>
        <td>&nbsp;</td>
        <td><span class="sx_grade_true"></span></td>
        <td><span class="sx_grade_true"></span></td>
        <td><span class="sx_grade_true"></span></td>
        <td><span class="sx_grade_true"></span></td>
        <td><span class="sx_grade_true"></span></td>
      </tr>
      <tr>
        <td class="tl">专享品牌</td>
        <td colspan="6">针对不同等级会员享受不同品牌的优惠</td>
        </tr>
      <tr>
        <td class="tl">专享活动</td>
        <td colspan="6">针对不同等级会员专享不同类型的活动</td>
        </tr>
      <tr>
        <td class="tl">生日双倍积分</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td><span class="sx_grade_true"></span></td>
        <td><span class="sx_grade_true"></span></td>
      </tr>
      <tr>
        <td class="tl">贵宾服务专线</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td><span class="sx_grade_true"></span></td>
      </tr>
      <tr>
        <td class="tl">新人礼包</td>
        <td><span class="sx_grade_true"></span></td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
  </tbody>
</table>
   <div class="sx_grade_memo">
     <span>注:</span><p>
     1、会员级别共分为6个等级，分别为：注册会员、铜牌会员、银牌会员、金牌会员、白金会员、钻石会员；<br />
    2、会员级别由系统自动处理，无需申请；<br />
    3、会员级别根据累积积分计算，累积积分越高会员等级越高，享受到的增值服务越多；<br />
    4、善行创投将陆续调整各级会员对应权益，增加更多会员服务内容，敬请期待.	
     </p>
   </div>
   </div>
   <div class="sx_grade_sc">
     <div class="sx_grade_t1">举例</div>
     <table width="100%" border="0" cellspacing="0" cellpadding="0" class="sx_grade_tabx2">
     <thead>
  <tr>
    <td>投资金额/元</td>
    <td>投资期限/天</td>
    <td>积分/分</td>
    <td>积分计算公式</td>
  </tr>
    </thead>
    <tbody>
  <tr>
    <td>7000</td>
    <td>91</td>
    <td>17.5</td>
    <td>投资积分=（投资金额/100）*（投资天数/365）</td>
  </tr>
    </tbody>
</table>
<br />
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="sx_grade_tabx2">
  <tr>
    <td><span class="sx_blue">会员等级</span></td>
    <td><span class="sx_pink">普通会员</span></td>
    <td><span class="sx_pink">铜牌会员</span></td>
    <td><span class="sx_pink">银牌会员</span></td>
    <td><span class="sx_pink">金牌会员</span></td>
    <td><span class="sx_pink">白金会员</span></td>
    <td><span class="sx_pink">钻石会员</span></td>
  </tr>
  <tr>
    <td><span class="sx_blue">一年的标的累计投资额可达 (单位：万元)</span></td>
    <td>0</td>
    <td>5</td>
    <td>20</td>
    <td>50</td>
    <td>100</td>
    <td>200</td>
  </tr>

</table>

   </div>
</div>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
</body>
