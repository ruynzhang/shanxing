    <!DOCTYPE HTML>
        <%@page import="com.dimeng.p2p.modules.base.front.service.DistrictManage"%>
        <%@page import="org.joda.time.Period"%>
        <%@page import="org.joda.time.Interval"%>
        <%@page import="java.math.BigDecimal"%>
        <%@page import="java.util.Calendar"%>
        <%@page import="java.util.Date"%>
        <%@page import="java.util.List"%>
        <%@page import="java.util.Map"%>
        <%@page import="java.text.DecimalFormat"%>
        <%@page import="java.text.SimpleDateFormat"%>
        <%@page import="com.dimeng.p2p.S62.entities.T6230"%>
        <%@page import="com.dimeng.p2p.FeeCode"%>
        <%@page import="com.dimeng.p2p.S61.entities.T6110"%>
        <%@page import="com.dimeng.p2p.S50.entities.T5019"%>
        <%@page import="com.dimeng.p2p.S62.entities.T6250"%>
        <%@page import="com.dimeng.p2p.S61.enums.T6110_F06"%>
        <%@page import="com.dimeng.p2p.account.front.service.UserInfoManage"%>
        <%@page import="javax.servlet.http.HttpServletRequest"%>
        <%@page import="javax.servlet.http.HttpServletResponse"%>
        <%@page import="org.joda.time.DateTime"%>
        <%@page import="com.dimeng.framework.service.ServiceSession"%>
        <%@page import="com.dimeng.p2p.S62.enums.T6252_F09"%>
        <%@page import="com.dimeng.p2p.S62.entities.SurpriseConfig"%>
        <%@page import="com.dimeng.p2p.S62.entities.SurpriseLucre"%>
        <%@page import="com.dimeng.p2p.S61.entities.T6110"%>
        <%@page import="com.dimeng.p2p.S62.entities.T6231"%>
        <%@page import="com.dimeng.p2p.S62.enums.T6231_F21"%>
        <%@page import="com.dimeng.p2p.S62.enums.T6230_F20"%>
        <%@page import="com.dimeng.p2p.service.MobileManage"%>
        <%@page import="com.dimeng.p2p.modules.bid.front.service.IndexManage"%>
        <%@page import="com.dimeng.p2p.front.servlets.financing.AbstractFinancingServlet"%>
        <%@page import="com.dimeng.p2p.modules.bid.front.service.BidManage"%>
        <%@page import="com.dimeng.p2p.modules.bid.front.service.entity.Mbxx"%>
        <%@page import="com.dimeng.p2p.modules.bid.front.service.entity.Bdxq"%>
        <html lang="zh-cn">
        <head>
        <title>善行创投</title>
        <%@include file="/WEB-INF/pages/mobile/meta.jsp" %>
        <%@include file="/WEB-INF/pages/mobile/style.jsp" %>
        <script src="/js/jquery-1.11.0.min.js" type="text/javascript" ></script>
        <link rel="stylesheet" type="text/css" href="/mobile/css/bidDetail.css" />
        <link rel="stylesheet" type="text/css" href="<%=controller.getStaticPath(request)%>/mobile/css/cs-select.css" />
        <script>
        $(document).ready(function(){
        $(".back_top").click(function(){$('body,html').animate({scrollTop:0},600);});
        var mW=$("#sx_m_main").width();
        $(".sx_input").css("width", mW -60+"px");
        $(".toReg2").mousemove(function(){$(".overlay").show();$(".sx_popup").css("display","block");event.preventDefault();});
        $(".sx_err_btn").click(function(){$(".sx_popup").css("display","none");$(".overlay").hide();});
        $(".sx_reg_word2").click(function(){$(".overlay").show();$(".sx_m_showShare").css("display","block");});
        $(".sx_m_showShare").click(function(){$(this).css("display","none");$(".overlay").hide();});
        $(".sx_m_showbox").css("height", screen.height*0.6+"px");
        $(".toReg").click(function(event){	event.preventDefault();$('html,body').animate({scrollTop:$(this.hash).offset().top-40},1000);});
        $(".showText").click(function(){$(".sx_m_showbox").fadeIn();$(".overlay").show();$(".sx_m_close").show();});
        $(".sx_m_close").click(function(){$(".sx_m_showbox").fadeOut();$(".overlay").hide();$(this).hide();	});$("#redux").css("width",mW*0.8+"px");$(".container").css("height", mW*0.8*0.52+"px");
        });
        </script>

        <link rel="shortcut icon" href="favicon.ico"/>
        <link rel="apple-touch-icon" href="icon.png"/>
        <link rel="apple-touch-icon" sizes="72×72" href="touch-icon-ipad.png" />
        <link rel="apple-touch-icon" sizes="114×114" href="touch-icon-iphone4.png" />

        <script type="text/javascript" src="/mobile/js/jquery.js"></script>
        <script src="/js/jquery.tabs.js"></script>
        <script src="<%=controller.getStaticPath(request)%>/mobile/js/selectFx.js" type="text/javascript" ></script>
            <%
BidManage investManage = serviceSession.getService(BidManage.class);
DistrictManage districtManage = serviceSession.getService(DistrictManage.class);

String resMessage = controller.getPrompt(request,response,PromptLevel.INFO);
boolean isSuccess = false;
if(resMessage!=null){
  if(resMessage.equals("恭喜你，投标成功")){
	  isSuccess = true;
  }
  serviceSession.getSession().removeAttribute("isSuccess");
}

String errMessage = controller.getPrompt(request,response,PromptLevel.ERROR);

String statusButtonTemp = null;
BidManage manage = serviceSession.getService(BidManage.class);

String id = request.getParameter("id");
Bdxq creditInfo = investManage.get(Integer.parseInt(id));

T5019 t5019 = null;

if (id != null && !id.trim().equals("")) {
 int bidId = Integer.parseInt(id);
 
 // 获取Bid
 T6230 bid = manage.getT6230(bidId);
 T6231 bidExtend = manage.getExtra(bidId);
 T6110 userAccount = manage.getT6110(bidId);
 DateTime publishTime = new DateTime(bid.F22);
 
 if(bidExtend.F21 == T6231_F21.S){
  request.setAttribute("endTime", publishTime.plusDays(bidExtend.F22).toDate());
  request.setAttribute("loanPeriodType", "天");
 } else {
  request.setAttribute("endTime", publishTime.plusMonths(bid.F09).toDate());
  request.setAttribute("loanPeriodType", "个月");
 }
 
 request.setAttribute("loanAccount", userAccount.F02.substring(0, 4)+"***");
 request.setAttribute("findEndTime", publishTime.plusDays(bid.F08).toDate());
 request.setAttribute("countInvest", manage.countByBidIdAndIsCancel(bidId));
 request.setAttribute("totalInvest", manage.findAllBuyingPriceByBid(bidId));
 request.setAttribute("surpriseLucreList", manage.findSurpriseLucreByBid(bidId));
 request.setAttribute("surpriseConfigList", manage.findSurpriseConfigByBid(bidId));
 
 // 获取标的还款计划
 List<Object[]> repaymentPlanList = manage.findRepaymentPlanByBid(bidId);
 if(repaymentPlanList != null && repaymentPlanList.size() > 0){
  request.setAttribute("repaymentPlanList", repaymentPlanList);
 }
 
 request.setAttribute("bid", bid);
 request.setAttribute("bidExtend", bidExtend);
}

T6230 bid = (T6230)request.getAttribute("bid");
T6231 bidExtend = (T6231)request.getAttribute("bidExtend");
List<SurpriseLucre> surpriseLucreList = (List<SurpriseLucre>)request.getAttribute("surpriseLucreList");
List<SurpriseConfig> surpriseConfigList = (List<SurpriseConfig>)request.getAttribute("surpriseConfigList");
boolean surpriseStatus = bid.surpriseStatus!=null && !bid.surpriseStatus.name().equals("WPZ");
String path = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath();
boolean isLogin = false;
if(dimengSession!=null&& dimengSession.isAuthenticated()){
	isLogin = true;
}

T6230_F20 status = bid.F20;
if(status == T6230_F20.TBZ || status == T6230_F20.DFK){
 if(new DateTime(bid.F22).plusDays(bid.F08).getMillis() - System.currentTimeMillis() <= 0){
  statusButtonTemp = "已完结";
 }else if(status == T6230_F20.DFK){
  statusButtonTemp = status.getChineseName();
 }else{
  statusButtonTemp = "立即投资";
 }
}else{
 statusButtonTemp = status.getChineseName();
}

T6250[] t6250s= investManage.getRecord(Integer.parseInt(id));

request.setAttribute("addPersonNum", t6250s == null ?0 :t6250s.length);// 加入人次
%>

        </head>
        <body>
        <div class="alert_bg"> </div>
        <form method="post" class="form1" action="<%=path %>/pay/mobile/mobileBid.htm">
        <input type="hidden" id="path" value="<%=path %>" />
        <input type="hidden" id="isSuccess" value="<%=isSuccess %>" />
        <input type="hidden" id="errMessage" value="<%=errMessage %>" />
        <input type="hidden" id="isLogin" value="<%=isLogin %>" />
        <input type="hidden" id="bidId" value="<%=bid.F01 %>" />
        <input type="hidden" id="bidType" value="<%=bid.F04 %>" />

        <%@ include file="header.jsp"%>

        <div id="sx_m_main">
        <div class="sx_app_outlinebox">
        <div class="sx_app_wrap">
            <%
        Date findEndTime = (Date)request.getAttribute("findEndTime");
        long sytime = findEndTime.getTime() - System.currentTimeMillis();
        boolean isGq = statusButtonTemp.equals("投标中") && sytime <=0;// 是否已过期
        pageContext.setAttribute("sytime", sytime);
        %>
        <h1 class="sx_app_t1"><%=bid.F03%></h1>

        <div class="sx_task_situation"><span class="<%=bid.F20.equals("TBZ")&&sytime>0?"sx_app_blueBt":"sx_app_greyBt" %>">
            <%=bid.F20.name().equals("TBZ")?(sytime > 0?bid.F20.getChineseName():"已完结"):bid.F20.getChineseName()%>
        </span>
        <span class="sx_app_whiteBt">
            <%=bid.F04==1?"车辆周转":(bid.F04==2?"房产周转":"信用周转")%>
        </span>
            <%if(surpriseStatus){ %>
        <span class="sx_app_pinkBt">惊喜奖</span>
            <%}%>
        </div>
        </div>
        <div class="sx_task_subbox">
        <ul>
        <li class="sx_app_item_main">
        <div>
        <p><span class="sx_app_orange sx_app_f21">
            <%BigDecimal temp = bid.F06.multiply(new BigDecimal(100)).subtract(bid.bonus); %>
            <%=new DecimalFormat("#0.00").format(temp) %>
        </span>
        <span class="sx_app_orange sx_app_f12">%</span>
        </p>
        <p class="sx_app_f12">年化收益</p>
        </div>
            <%
                   BigDecimal bonus = bid.bonus;
                 %>
            <% if(bonus != null && bonus.compareTo(BigDecimal.ZERO) > 0){%>
        <div class="sx_app_item_middle">
        <p><span class="sx_app_black sx_app_f21"><%=bonus %></span><span class="sx_app_f12">%</span></p>
        <p class="sx_app_f12">投资奖励</p>
        </div>
            <%} %>
        <div>
        <p><span class="sx_app_black sx_app_f21"><%=bid.F09!=0?bid.F09:bidExtend.F22%></span>
        <span class="sx_app_f12"><%=request.getAttribute("loanPeriodType")%></span></p>
        <p class="sx_app_f12">投资期限</p>
        </div>
        <p class="clear"></p>
        </li>
        <li><i>项目规模</i><span class="sx_app_item_content sx_app_f16">
            <%=bid.F05.compareTo(new BigDecimal(10000))==1 ?(bid.F05.divide(new BigDecimal(10000))):bid.F05%>
        </span><b>&nbsp;<%=bid.F05.compareTo(new BigDecimal(10000))==1?"万元":"元"%></b></li>
        <li><i>已融金额</i><span class="sx_app_item_content sx_app_orange sx_app_f18"><%=bid.F05.subtract(bid.F07)%></span><b>&nbsp;元</b></li>
        <li><i>可投金额</i><span class="sx_app_item_content sx_app_orange sx_app_f18"><%=bid.F07%></span><b>&nbsp;元</b></li>

            <%
              if(bid.F20.equals("YFB")){
              %>
        <li><i>发布日期</i><span class="sx_app_item_content">
            <%=new SimpleDateFormat("yyyy-MM-dd HH点mm分").format(bid.F22) %>即将开始</span></li>
            <%}else{ %>
        <li><i>发布日期</i><span class="sx_app_item_content">
            <%=new SimpleDateFormat("yyyy-MM-dd").format(bid.F22) %></span></li>
            <%} %>

        <li><i>完结日期</i><span class="sx_app_item_content">
            <%=new SimpleDateFormat("yyyy-MM-dd").format(request.getAttribute("endTime")) %>
        </span></li>

            <%if(bid.F20.equals("TBZ")&&sytime>0) {%>
            <%
              	long hm=3600000*24;
				long day=sytime/hm;
				long hour=(sytime-day*hm)/3600000;
				long min=(sytime-day*hm-hour*3600000)/60000;					
			   %>
        <li><i>剩余时间</i><span class="sx_app_item_content"><%=day<0?0:day %>&nbsp;天&nbsp;<%=hour<0?0:hour %>&nbsp;时&nbsp;<%=min<0?0:min %>&nbsp;分</span></li>
            <%} %>

            <% if(bid.F20.equals("YJQ")){%>
        <li><i>结清日期</i><span class="sx_app_item_content">
            <%=new SimpleDateFormat("yyyy-MM-dd").format(bidExtend.F13) %></span></li>
            <% }%>
        <li class="noborder"><i>还款方式</i><span class="sx_app_item_content"><%=bid.F10.getChineseName()%></span></li>
        </ul>
        </div>
        </div>

        <!-- 金额输入框 -->
            <%
    String isYuqi = "";
    BigDecimal balance=new BigDecimal(0); %>
        <style>
        .jineDiv{width: 100%;}
        .jineDiv .subDiv0{float:left;width:80%;height:27px; padding-left: 10px;}
        .jineDiv .subDiv1{float:left;width: 70%;padding-left: 10px;}
        .jineDiv .subDiv1 input{border:1px solid #ccc; font-size: 18px;}
        .jineDiv .subDiv2 a{margin-left:2%;float: left;background-color: #3E8CE1;width:24.8%;height: 44px;line-height: 44px;text-align: center;font-size: 16px; padding: 0;border-radius: 4px;color:#fff;}
        .jineDiv .subDiv2 .disabled{background-color:#ccc;}
        .jineDiv .loginBuDiv{ margin: 0 10px;}
        .jineDiv .loginBuDiv span{border-radius: 4px;float: left; margin: 0;background-color: #3E8CE1;width:100%;height: 44px;line-height: 44px;text-align: center;font-size: 16px; padding: 0;color:#fff;}
        </style>
        <div class="jineDiv">
            <%if(!isLogin){ %>
        <script>$(".jineDiv").height("54px");</script>
        <a href="/pay/mobile/mwebLogin.htm?_z=/mobile/bidDetail.html?id=<%=id%>" ><div class="subDiv2 loginBuDiv"><span style="font-size:16px;">立即登录</span></div></a>
            <%}else{ %>
            <%
      MobileManage mobileManage = serviceSession.getService(MobileManage.class); 
      isYuqi =  mobileManage.isYuqi();
      Map<String,Object> map = mobileManage.getUserBaseInfo();
      balance = (BigDecimal)map.get("balance");
      
      UserInfoManage userInfoManage = serviceSession.getService(UserInfoManage.class);
      T6110 t6110_1 = userInfoManage.getUserInfo(serviceSession.getSession().getAccountId());

      boolean isZrr = false;// 是否为自然人
      boolean isKtb = false;// 是否可投标
      if(t6110_1.F06 == T6110_F06.ZRR){
      	isZrr = true;
      }
      if(creditInfo.investName==null || creditInfo.investName.equals(t6110_1.F02)){
      	isKtb = true;
      }
      %>
            <%if(statusButtonTemp.equals("立即投资")){ %>
            <%if(isZrr&&isKtb){ %>
        <div class="subDiv0 "><span>账户余额：</span><span class="sx_app_orange" ><%=balance %></span>&nbsp;元</div>
        <div class="subDiv1"><input type="text" value="" name="amount" id="amount" placeholder="请输入金额"/></div>
        <div class="subDiv2"><a href="javascript:checkBid();"><%=statusButtonTemp%></a></div>
            <%}else{ %>
        <script>$(".jineDiv").height("20px");</script>
        <div class="subDiv1">仅预约户可投</div>
            <%} %>
            <%}else{ %>

            <%if (statusButtonTemp.equals("还款中")) {%>
        <div class="fr w280 payfrom ui_full ui_plan_bj ui_pay_bj" style="float:left !important;">
        <ul class="paylist">
            <% Mbxx mbxx = investManage.getMbxx(Integer.parseInt(id)); %>
        <li><span class="mr10">待还本息（元）</span> <span class="f20">￥<%=Formater.formatAmount(mbxx.dhje)%></span></li>
        <li><span class="mr10">剩余期数（期）</span> <span class="f20"><%=bidExtend.F03%></span></li>
        </ul>
        </div>
        <div class="plan_given_btn">
        <i class="ui_pay ui_plan_bj"></i>
        </div>
            <%
          // 已过期的情况
          } else if (statusButtonTemp.equals("投标中") && sytime <=0) {
         %>
        <div style="float:left !important;width: 100%;">
        <ul class="fulist" >
            <%
 	      Calendar calendar = Calendar.getInstance();
 	      calendar.setTime(creditInfo.F22);
 	      if(bidExtend.F21 == T6231_F21.S){
 	    	  calendar.add(Calendar.DAY_OF_MONTH, bidExtend.F22);
 	      }else{
 	    	  calendar.add(Calendar.MONTH, creditInfo.F09);
 	      }
       
           long hm=1000*3600*24;
           long time = calendar.getTimeInMillis();
           long day=time/hm;
           long hour=(time-day*hm)/(1000*3600);
           long min=(time-day*hm-hour*1000*3600)/(1000*60);
           long ss=(time-day*hm-hour*1000*3600-min*1000*60)/(1000);
          %>
        <li><span class="mr10">满标用时</span> <span class="f14"><%=day %>天<%=hour %>时<%=min %>分<%=ss %>秒</span></li>
        <li class="floatR"><span class="mr10">加入人次</span> <span class="f14"><%=request.getAttribute("addPersonNum")%></span></li>
        </ul>
        </div>
        <div class="plan_given_btn">
        <i class="ui_full ui_plan_bj"></i>
        </div>
            <%
          } else if (creditInfo.F20 == T6230_F20.DFK) {
         %>
        <div  class="fr w280 floodmark ui_full">
        <ul class="fulist">
            <%
           long hm=1000*3600*24;
           long time = (bidExtend.F11!=null?bidExtend.F11.getTime():creditInfo.F22.getTime())-creditInfo.F22.getTime();
           long day=time/hm;
           long hour=(time-day*hm)/(1000*3600);
           long min=(time-day*hm-hour*1000*3600)/(1000*60);
           long ss=(time-day*hm-hour*1000*3600-min*1000*60)/(1000);
          %>
        <li><span class="mr10">满标用时</span> <span class="f14"><%=day %>天<%=hour %>时<%=min %>分<%=ss %>秒</span></li>
        <li><span class="mr10">加入人次</span> <span class="f14"><%=request.getAttribute("addPersonNum")%></span></li>
        </ul>
        </div>
        <div class="plan_given_btn">
        <i class="ui_full ui_plan_bj" style="border-left:0px;"></i>
        </div>
            <%
          } else if (creditInfo.F20 == T6230_F20.YJQ || creditInfo.F20 == T6230_F20.YDF) {
         %>
        <div class="fr w280 ui_payoff_bj ui_full" style="float:left !important;">
        <p class="payoff_info">
        还清时间<br /> <br /> <span class="pt20 f18"><%=creditInfo.F20 == T6230_F20.YDF?DateParser.format(bidExtend.F14):DateParser.format(bidExtend.F13)%></span>
        </p>
        </div>
        <div class="plan_given_btn">
        <i class="ui_paid ui_plan_bj"></i>
        </div>
            <%
          } else if (creditInfo.F20 == T6230_F20.YLB) {
         %>
        <div class="fr w280 floodmark ui_full"></div>
            <%
          }else if(creditInfo.F20 == T6230_F20.YFB){
         %>
        <div class="fr submission w240" style="width:100%;min-height:60px;">
        <div class="text bom pt10">
            <%
         Period period = new Interval(new DateTime().getMillis(),creditInfo.F22.getTime()).toPeriod();
         %>
        <p>剩余时间：<span id="tian"><%=period.getDays()%>天<%=period.getHours()%>时<%=period.getMinutes()%>分</span>
        </p>
        <div class="time"></div>
        <p class="details_input">敬请期待</p>
        </div>
        </div>
            <%} %>

            <%} %>
            <%} %>
        </div>
        <div id="info"></div>
        <div class="popup_bg"  style="display: none;"></div>
        <input type="hidden" id="isYuqi" name="isYuqi" value="<%=isYuqi%>">
        <input type="hidden" id="charge" name="charge" value="<%=path %>/user/capital/charge.html">
        <input type="hidden" name="kyMoney" id="kyMoney" value=<%=balance %>>
        <input type="hidden" name="loanId" id="loanId" value=<%=bid.F01 %>>
        <input type="hidden" name="hbId" id="hbId" value=0>
        <input type="hidden" name="isActivity" id="isActivity" value="<%=bid.isActivity%>">
        <input type="hidden" name="syje" id="syje" value=<%=bid.F07%>>
        <input type="hidden" name="minBid" id="minBid" value=<%configureProvider.format(out, SystemVariable.MIN_BIDING_AMOUNT);%>>

        <div class="dialog" style="display: none;">
        <div class="con clearfix">
        <div class="info fr" id="div_confirm" style="clear:both;">
        <p class="f20 gray33">投标购买确认</p>您此次购买金额为<i class="red"><span id="zxMoney">12</span></i>元
        </div>
        <div id="selectDiv" style="clear:both;"></div>
        <div class="clear"></div>
        <div class="dialog_btn"><a href="javascript:void(0);" id="ok" class="btn btn01">确 定</a><a href="javascript:void(0)" id="cancel" class="btn btn05">取 消</a></div>
        </div>
        </div>

        <div class="sx_app_listbox">

            <%if(surpriseStatus){ %>
        <ul class="tab_menu">
        <li class="current"><span>标的详情</span></li>
        <li><span>还款计划</span></li>
        <li onclick="onclickInvestRecord()"><span>投资记录</span></li>
        <li><span>获奖记录</span></li>
        </ul>
            <% }else{%>
        <ul class="tab_menu">
        <li style="width:33%;" class="current"><span>标的详情</span></li>
        <li style="width:34%;"><span>还款计划</span></li>
        <li onclick="onclickInvestRecord()" style="width:33%;"><span>投资记录</span></li>
        </ul>
            <%} %>

        <div class="tab_box">
        <div>
        <div class="sx_app_wrap">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
        <td width="40%">融资方</td>
        <td width="60%"><%
                           String loanAccount =""; 
                            Object loanAccountObj = request.getAttribute("loanAccount");
                      %><%=loanAccountObj %></td>
        </tr>
        <tr>
        <td>本期融资金额</td>
        <td><%=bid.F05.compareTo(new BigDecimal(10000))==1?(bid.F05.divide(new BigDecimal(10000))):bid.F05 %><%= bid.F05.compareTo(new BigDecimal(10000))==1?"万元":"元" %></td>
        </tr>
        <tr>
        <td>项目区域</td>
        <td><%StringHelper.filterHTML(out, districtManage.getShengName(bidExtend.F07).F06);%></td>
        </tr>
        <tr>
        <td>年化利率</td>
        <td><%=new DecimalFormat("#0.00%").format(bid.F06) %></td>
        </tr>

            <%if(bidExtend.F06!=null){ %>
        <tr>
        <td>还款日期</td>
        <td>
            <%=new SimpleDateFormat("yyyy-MM-dd").format(bidExtend.F06) %>
        </td>
        </tr>
            <% }%>
        <tr>
        <td>截止日期</td>
        <td>
            <%
                      Date findEndTimeTemp = (Date)request.getAttribute("findEndTime");
                      %>
            <%=new SimpleDateFormat("yyyy-MM-dd HH:mm").format(findEndTimeTemp) %>
        </td>
        </tr>
        <tr>
        <td>借款用途</td>
        <td><%=bidExtend.F08 %></td>
        </tr>
        <tr valign="top">
        <td>还款来源</td>
        <td><%=bidExtend.F16%></td>
        </tr>
        </table><br />
        </div>
        <div class="sx_app_wrap">
        <h2 class="sx_app_t2">借款描述</h2>
        <p><%=bidExtend.F09%></p>
        </div>
        </div>
        <div class="hide">
        <h2 class="sx_app_t2">还款计划</h2>
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="sx_app_invest_tab">

            <%
                      List repaymentPlanList = (List)request.getAttribute("repaymentPlanList");
                     %>

            <%
                     if(repaymentPlanList!=null){
                     %>
        <tr>
        <td width="25%">合约还款日期</td>
            <%
                           for(int i=0;i<repaymentPlanList.size();i++){
                            Object[] objs = (Object[])repaymentPlanList.get(i);
                            String hyhkri = objs[1]==null?"":new SimpleDateFormat("yyyy-MM-dd").format(objs[1]);
                           %>
        <td width="25%"><%=hyhkri%></td>
            <% }%>
        </tr>
        <tr>
        <td>状态</td>
            <%
                           for(int i=0;i<repaymentPlanList.size();i++){
                        	   Object[] objs = (Object[])repaymentPlanList.get(i);
                           %>
        <td><%=((T6252_F09)objs[2]).getChineseName()%></td>
            <% }%>
        </tr>
        <tr>
        <td>科目</td>
            <%
	                      List planList = (List)request.getAttribute("repaymentPlanList");
	                      String[] feeCodes = new String[planList.size()];
	                      for(int i = 0, len=planList.size(); i < len; i++){
	                    	  feeCodes[i] = FeeCode.getChineseName(((Integer)((Object[]) planList.get(i))[4]));
	                      }
	                      for(String feeCode : feeCodes){%>
        <td><%=feeCode%></td>
            <%}%>
        </tr>
        <tr>
        <td>金额（元）</td>
            <%
                           for(int i=0;i<repaymentPlanList.size();i++){
                        	   Object[] objs = (Object[])repaymentPlanList.get(i);
                           %>
        <td><%=objs[0]%></td>
            <% }%>
        </tr>
        <tr>
        <td>实际还款日期</td>
            <%
                           for(int i=0;i<repaymentPlanList.size();i++){
                        	   Object[] objs = (Object[])repaymentPlanList.get(i);
                               String sjhkri = objs[3]==null?"--":new SimpleDateFormat("yyyy-MM-dd").format(objs[3]);
                           %>
        <td><%=sjhkri %></td>
            <% }%>
        </tr>
            <%}else{ %>
        <tr>
        <td width="30%">合约还款日期</td>
        </tr>
        <tr>
        <td>状态</td>
        </tr>
        <tr>
        <td>科目</td>
        </tr>
        <tr>
        <td>金额（元）</td>
        </tr>
        <tr>
        <td>实际还款日期</td>
        </tr>
            <%} %>
        </table>
        </div>
        <div class="hide">
        <h2 class="sx_app_t2">投标记录</h2>
        <p>加入人次 <span class="sx_app_orange sx_app_f21">
            <%=request.getAttribute("addPersonNum")==null?0:request.getAttribute("addPersonNum")%>
        </span></p>
        <p>投标总额 <span class="sx_app_orange sx_app_f21">
            <%=new DecimalFormat("#,##,##0.00").format(request.getAttribute("totalInvest")) %>
        </span>元</p>
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="sx_app_invest_tab invest_table">
        <tr>
        <td><b>投标人</b></td>
        <td><b>投标金额</b></td>
        <td><b>投标时间</b></td>
        </tr>
        </table>
        <a id="loadMore" onclick="loadInvestRecord()" class="sx_moreload" style="display: none;">加载更多</a>
        <p id="loading" style="text-align: center; padding: 5px 0px; display: none;"><img src='/images/loading.gif' /></p>
        </div>
            <% if(surpriseStatus){%>
        <div class="hide">
        <h2 class="sx_app_t2">获奖记录</h2>
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="sx_app_invest_tab sx_tab_bg">
        <tr>
        <td width="50%"><b>获奖人</b></td>
        <td width="50%"><b>奖项</b></td>
        </tr>
            <%for(int i=0;i<surpriseLucreList.size();i++){ %>
        <tr>
        <td><%
                       
                       String configName = surpriseLucreList.get(i).config.name.getChineseName();
                       String accountNameDe = surpriseLucreList.get(i).accountName;
                       if(accountNameDe==null){
                    	   accountNameDe = "";
                       }else{
                    	   accountNameDe = accountNameDe.substring(0,4)+"***";
                       }
                       %><%=accountNameDe %></td>
        <td><%=configName%></td>
        </tr>
            <% }%>
        </table><br />
        <p>惊喜奖是标的满标回款后按照您预期收益的奖励百分比直接转账到您账户，投资金额越大，返现越多。例：您投了1000元，年化收益为12%，预期收益则为120元，你中了土豪奖，10%收益返现为12元直接打到您账户，可作提现</p><br/>
            <% for(int i=0;i<surpriseConfigList.size();i++){ %>
        <p class="sx_app_orange sx_app_f21"><%=surpriseConfigList.get(i).name.getChineseName()%></p>
        <p>面向对象：<%=surpriseConfigList.get(i).name.getDesc() %></p>
        <p>额外奖励：本标预期收益的
            <%=new DecimalFormat("#0.00%").format(surpriseConfigList.get(i).rate) %>返现</p><br/>
            <%} %>
        </div>
            <% }%>
        </div>
        </div>

        <!-- 底部 -->
        <div id="bottomDivId" class="bottomDiv" style='display: none'><a class="bottomDiv" id="touzhiA" href="javascript:;"><span id="bottomSpan"></span></a></div>

        </div>
        </form>
        <script type="text/javascript">
        $(function(){
        $('.sx_app_listbox').Tabs({
        event:'click'
        });


        var isSuccess = $("#isSuccess").val();
        if(isSuccess=="true"){
        showSuccInfo("恭喜，投标成功");
        $("#info").html(showSuccInfo("恭喜，投标成功"));
        $("div.popup_bg").show();
        $("body").addClass("add_body_class");
        }

        var errMessage = $.trim($("#errMessage").val());
        if(!reg_NULL(errMessage)&&errMessage!='null'){
        $("#info").html(showSuccInfo(errMessage));
        $("div.popup_bg").show();
        }
        });
        var bidPk = document.getElementById("bidId").value;
        var page = 1;
        var hasNext = true;
        var onclickStatus = false;
        function onclickInvestRecord(){
        if(onclickStatus)
        return;
        if(hasNext)
        loadInvestRecord();
        }
        function loadInvestRecord(){
        $("#loadMore").hide();
        if(!hasNext)
        return;
        $('#loading').show();

        var url = $("#path").val()+"/proxy/app/financing/investRecord.action";

        $.ajax({
        type : "POST",
        url : url,
        data : {"id":bidPk, "size":10, "page":page},
        success : function(data){
        if(data.sc != 200)
        return;
        $('#loading').hide();
        var investTab = $(".invest_table");
        page+=1;
        hasNext = data.body.hasNext;
        $.each(data.body.content, function(i, n){
        investTab.append(
        "<tr class=\"investrecord\">"
        +"<td>"+n[0]+"</td>"
        +"<td>"+n[1]+"</td>"
        +"<td>"+n[2]+"</td>"
        +"</tr>");
        });
        onclickStatus = true;
        if(hasNext)
        $("#loadMore").show();
        }
        });
        }

        function reg_NULL(str) {
        if (str == undefined || str == "" || str.length == 0) {
        return true;
        }
        return false;
        }

        // 判断必须为数字
        function reg_Sz(str) {
        if (reg_NULL(str)) {
        return true;
        }
        var reg = /^(-?\d+)(\.\d+)?$/;
        return reg.test(str);
        }

        // 判断必须为数字(非空)
        function reg_Sz2(str) {
        if (reg_NULL(str)) {
        return false;
        }
        return reg_Sz(str);
        }

        function checkBid(){
        $('.alert_bg').css('display','block');
        $("body").addClass("add_body_class");
        $(".wx_top").css("position","absolute");
        var amount=$("#amount").val();
        if(!reg_Sz2(amount)){
        $("#info").html(showDialogInfo("请输入购买金额","perfect"));
        $("div.popup_bg").show();
        return;
        }

        var kyMoney=$("#kyMoney").val();
        if(parseInt(kyMoney) < parseInt(amount)){
        var url=$("#charge").val();
        $("#info").html(showForwardInfo('您的账户余额不足进行本次投标 ，请在网页端充值。',"perfect",url,false));
        $("div.popup_bg").show();
        return;
        }
        var syje= $("#syje").val();
        if(parseInt(syje) < parseInt(amount)){
        $("#info").html(showDialogInfo("您的投标金额大于标的剩余金额","perfect"));
        $("div.popup_bg").show();
        return;
        }

        var minBid = $("#minBid").val();
        if(parseInt(amount) < parseInt(minBid)){
        $("#info").html(showDialogInfo("您的投标金额小于投标最低金额","perfect"));
        $("div.popup_bg").show();
        return;
        }

        if(parseInt(syje) - parseInt(amount) <  parseInt(minBid) &&  parseInt(syje) - parseInt(amount) >  0){
        $("#info").html(showDialogInfo("剩余可投金额不能小于"+parseInt(minBid),"perfect"));
        $("div.popup_bg").show();
        return;
        }


        var isYuqi= $("#isYuqi").val();

        if(isYuqi == "Y"){
        $("#info").html(showDialogInfo("您有逾期未还的贷款，还完才能进行投标操作","perfect"));
        $("div.popup_bg").show();
        return;
        }
        $("#zxMoney").text(amount);

        var isActivity=0;
        if($("#isActivity").val()=='S'){
        isActivity=1;
        }

        $.ajax({
        type: "POST",
        datatype:"text",
        url: $("#path").val()+"/financing/sbtz/hbList.htm",
        data: "amount="+amount+"&useActivity="+isActivity,
        success: function(msg){
        $("#hb_div").remove();

        $("#selectDiv").after(msg);
        $("#hb_div").addClass("iceDivStyle");
        $("#hb_select").addClass("hbSelectStyle");

        [].slice.call( document.querySelectorAll( 'select.cs-select' ) ).forEach( function(el) {
        new SelectFx(el);

        } );
        if($( 'select.cs-select option' ).length<=2){
        $('.cs-select .cs-options').css("height","120px");
        }else{
        $('.cs-select .cs-options').css("height","150px");
        }

        }
        });

        $("div.popup_bg").show();
        $("div.dialog").show();
        }

        $(function(){
        $("div.dialog_close").click(function(){
        $("#info").html("");
        $("div.popup_bg").hide();
        $("div.dialog").hide();
        });

        $("#cancel").click(function(){
        $("div.dialog").hide();
        $("div.popup_bg").hide();
        $(".alert_bg").css("display","none");
        $("body").removeClass("add_body_class");
        $(".wx_top").css("position","fixed");
        });

        $("#ok").click(function(){
        var value=$(":input[name='hb_id']").val();
        $("#hbId").val(value);
        var form = document.forms[0];
        form.submit();
        $("body").removeClass("add_body_class");
        });
        });

        //封装信息消息文本.
        function showDialogInfo(msg,type){
        return   '<body class="add_body_class">'+'<div class="alert_bg" style="display:block">'+'</div>'+'<div class="dialog w510 thickpos" >'+
        '<div class="dialog_close fr" onclick="closeInfo()"><a></a></div>'+
        '<div class="con clearfix">'+
        '<div class="d_'+type+' fl"></div>'+
        '<div class="info fr">'+
        '<p class="f20 gray33">'+msg+'</p>'+
        '</div>'+
        '<div class="clear2"></div>'+
        '<div class="dialog_btn dl_close_btn"><a onclick="closeInfo()" class="btn btn01">关闭</a></div>'+
        '</div>'+
        '</div>'+'</body>';
        }

        function showForwardInfo(msg,type,url,isIncludeQd){
        var qzHtml ="";
        if(isIncludeQd){
        qzHtml = '<a href="'+url+'" class="btn btn01">确 定</a>';
        }
        return  '<body class="add_body_class">'+'<div class="alert_bg" style="display:block">'+'</div>'+'<div class="dialog w510" >'+
        '<div class="dialog_close fr" onclick="closeInfo()"><a></a></div>'+
        '<div class="con clearfix">'+
        ' <div class="d_'+type+' fl"></div>'+
        '<div class="info fr"><p class="f20 gray33">'+msg+'</p></div>'+
        ' <div class="dialog_btn dl_close_btn">'+qzHtml+'<a onclick="closeInfo()" class="btn btn01">确定</a></div> '+
        ' </div>'+
        '</div>'+'</body>';
        }

        function showSuccInfo(msg,type,url){
        return  '<body class="add_body_class">'+'<div class="alert_bg" style="display:block">'+'</div>'+'<div class="dialog w510" >'+
        '<div class="dialog_close fr" onclick="closeInfo()"><a></a></div>'+
        '<div class="con clearfix">'+
        ' <div class="d_'+type+' fl"></div>'+
        '<div class="info"><p class="f20 gray33">'+msg+'</p></div>'+
        ' <div class="dialog_btn dl_close_btn"><a href="javascript:closeInfo();" class="btn btn01">确 定</a></div> '+
        ' </div>'+
        '</div>'+'</body>';
        }

        function closeInfo(){
        $("#info").html("");
        $("div.popup_bg").hide();
        $(".alert_bg").css('display','none');
        $("body").removeClass("add_body_class");
        $(".wx_top").css("position","fixed");
        }
        </script>

        </body>
        </html>