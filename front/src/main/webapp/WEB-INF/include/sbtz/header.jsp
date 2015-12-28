	<%@page import="com.dimeng.p2p.S62.enums.SURPRISE_STATUS"%>
		<%@page import="com.dimeng.p2p.S62.enums.T6231_F21"%>
		<%@page import="java.util.Calendar"%>
		<%@page import="com.dimeng.p2p.account.front.service.UserManage"%>
		<%@page import="com.dimeng.p2p.S62.enums.T6230_F10"%>
		<%@page import="com.dimeng.p2p.S61.entities.T6110"%>
		<%@page import="com.dimeng.p2p.S61.enums.T6110_F06"%>
		<%@page import="com.dimeng.p2p.account.front.service.EnterpriseInfoManage"%>
		<%@page import="com.dimeng.p2p.S62.enums.T6230_F13"%>
		<%@page import="com.dimeng.p2p.S62.entities.T6250"%>
		<%@page import="com.dimeng.p2p.modules.bid.front.service.entity.Mbxx"%>
		<%@page import="com.dimeng.p2p.S61.entities.T6101"%>
		<%@page import="com.dimeng.p2p.account.front.service.UserInfoManage"%>
		<%@page import="com.dimeng.p2p.S62.entities.T6231"%>
		<%@page import="com.dimeng.p2p.S62.enums.T6230_F20"%>
		<%@page import="com.dimeng.p2p.S62.enums.T6230_F14"%>
		<%@page import="com.dimeng.p2p.common.enums.TermType"%>
		<%@page import="com.dimeng.p2p.front.servlets.Term"%>
		<%@page import="com.dimeng.p2p.S62.enums.T6230_F11"%>
		<%@page import="com.dimeng.p2p.FeeCode"%>
		<%@page import="com.dimeng.p2p.S62.entities.T6230"%>
		<%@page import="com.dimeng.p2p.modules.bid.front.service.BidManage"%>
		<div class="w1002 top_title">
		<a href="<%configureProvider.format(out,URLVariable.INDEX);%>" class="w_home">首页</a>&nbsp;&gt;&nbsp;<a href="<%configureProvider.format(out,URLVariable.FINANCING_SBTZ);%>">我要投资</a>&nbsp;&gt;&nbsp;标的详情
		</div>
			<%
	BidManage investManage = serviceSession.getService(BidManage.class);
	int id = IntegerParser.parse(request.getParameter("id"));
	com.dimeng.p2p.modules.bid.front.service.entity.Bdxq creditInfo = investManage.get(id);
	if(creditInfo==null){
		response.sendError(HttpServletResponse.SC_NOT_FOUND );
		return;
	}
	T6231 t6231 = investManage.getExtra(id);
	BigDecimal zxMoney = new BigDecimal(0);
	UserInfoManage userInfoManage = serviceSession.getService(UserInfoManage.class);
	T6110 t6110 = userInfoManage.getUserInfo(creditInfo.F02);
	boolean isXgwj = investManage.isXgwj(id);
%>
		<div class="contain_main clearfix">
		<div class="pub_title clearfix"> <span style="display:inline-block;" title="<%StringHelper.filterHTML(out, creditInfo.F03);%>"><%StringHelper.filterHTML(out, StringHelper.truncation(creditInfo.F03, 20));%> </span>
			<%boolean tag = true;
     if(creditInfo.F22 != null && creditInfo.F22.getTime() == 1418176800000l && tag){tag = false; %>
		<span class="sx_li_showAward">首发奖</span>
			<%}else{ %>
			<%if(creditInfo.bonus.compareTo(BigDecimal.ZERO)==1){%><span class="sx_li_showAward">鼓励奖</span><%} %>
			<%} %>

		<span class="sx_li_showAward">累计限投10万</span>

		</div>
		<div class="plan_given clearfix">

		<div class="details_image mt10 fl mr30"><img src="<%if(StringHelper.isEmpty(creditInfo.F21)){%><%=controller.getStaticPath(request)%>/images/details_image.jpg<%}else{%><%=fileStore.getURL(creditInfo.F21) %><%}%>"  /></div>
		<%if(creditInfo.bonus.compareTo(BigDecimal.ZERO)==1){ %>
		<div class="reward_info">
		 <p class="reward_invest"><% out.print("投资奖励 "); %></p>
		 <p class="reward_per"><% out.print("+"+creditInfo.bonus+"% "); %></p>
		</div>
		<% }%>
		
		<ul class="tender w650 mt30 fl clearfix yxlc_li">
		<li>
		<div class="tc mb5 ">
		<p><span class="f18 grey1">项目规模</span></p>
		</div>
		<div class="tc">
		<p><span class="f18 grey1">年化收益</span></p>
		</div>
		<div class="tc">
		<p><span class="f18 grey1">项目期限</span></p>
		</div>
		</li>
		<li>
		<div class="tc mt10">
		<p class="f24 mb5 bold project_scale"><%
					  if(creditInfo.F20 == T6230_F20.YJQ || creditInfo.F20 == T6230_F20.HKZ || creditInfo.F20 == T6230_F20.YDF){
						  creditInfo.F05 = creditInfo.F05.subtract(creditInfo.F07);
					  }
					  if(creditInfo.F05.doubleValue()>10000){%><%=Formater.formatAmount(creditInfo.F05.doubleValue()/10000)%>万<span class="f16 bold">元</span><%}else{ %><%=creditInfo.F05%>元<%} %></p>
		</div>
		<div class="tc mt10">
		<p class="orange f24 mb5 tc bold"><%=Formater.formatRate(creditInfo.F06.subtract(creditInfo.bonus.divide(new BigDecimal("100"))),true)%></p>
		</div>
		<div class="tc mt10">
		<p class="f24 mb5 bold"><%if(T6231_F21.S == t6231.F21){ out.print(t6231.F22 + "天");}else{ out.print(creditInfo.F09+"个月");} %></p>
		</div>

		</li>
		<li class="pay_way mt20"><span >还款方式：<%=creditInfo.F10.getChineseName()%></span>
		<span ></span>
			<%
	      Calendar calendar = Calendar.getInstance();
	      calendar.setTime(creditInfo.F22);
	      if(t6231.F21 == T6231_F21.S){
	    	  calendar.add(Calendar.DAY_OF_MONTH, t6231.F22);
	      }else{
	    	  calendar.add(Calendar.MONTH, creditInfo.F09);
	      }
      %>
		<span>发布日期：<%=TimestampParser.format(creditInfo.F22,"yyyy-MM-dd") %></span></li>
			<%if(creditInfo.F11 == T6230_F11.S){ %>
		<!--
		<li>担保机构<span class="item"><%=investManage.getDB(id) == null?"":investManage.getDB(id).F06%></span></li>
		<li>保障方式<span class="item"><%=creditInfo.F12.getChineseName() %></span></li>
		-->
			<%} %>
		<!--
		<li><span>还款方式</span><span class="item"><%=creditInfo.F10.getChineseName()%></span>
		<div class="tips_content">
		<span class="ui_plan_bj ui_i_tips ml5 mt5" id="tips1"></span>
		<div class="ui-pop-con" style="padding: 12px 0 0 20px; display: none;" id="tips1Msg">
		<div class="fl ui-pop-pic"></div>
		<div class="ui-pop-info">
			<%if(creditInfo.F10 == T6230_F10.DEBX){%>
		等额本息还款法是在还款期内，每月偿还同等数额的借款（包括本金和利息）。借款人每月还款额中的本金比重逐月递增、利息比重逐月递减。
			<%}else if(creditInfo.F10 == T6230_F10.MYFX){%>
		到期还本：按月付息、到期还本是指每月偿还相同额度的利息，借款到期日一次性归还借款本金。
			<%}else if(creditInfo.F10 == T6230_F10.YCFQ){%>
		一次还本付息是指在借款期内不是按月偿还本息，而是借款到期后一次性归还本金和利息。
			<%}else if(creditInfo.F10 == T6230_F10.DEBJ){%>
		等额本金还款法是指在还款期内把借款总额等分，每月偿还同等数额的本金和剩余借款在该月所产生的利息，每月的还款本金额固定，而利息越来越少。
			<%} %>
		</div>
		</div>
		</div>
		</li>
		-->
			<%
        		long sytime = 0;
			if(creditInfo.jsTime != null){
				sytime = creditInfo.jsTime.getTime()-System.currentTimeMillis();
			}
				if (creditInfo.F20 == T6230_F20.TBZ && sytime>0) {
			%>
		<li class="mt15 remain_time">
		<span class="f24 grey1">剩余时间:</span><span class="item" id="levitime">
			
		</span>
		</li>
			<%
				}
			%>
		</ul>
		<!--左侧-->
		<form method="post" class="form1" action="<%configureProvider.format(out,URLVariable.PAY_BID_URL);%>">
		<input type="hidden" id="sbSucc" name="sbSucc" value="<%configureProvider.format(out, URLVariable.USER_ZQTBZ);%>">
			<%
			if (creditInfo.F20 == T6230_F20.TBZ && sytime>0) {

		%>
		<div class="fr submission mt50">
			<%if(dimengSession!=null && dimengSession.isAuthenticated()){
				T6101 userInfo= userInfoManage.search();
				String isYuqi =  userInfoManage.isYuqi();
				UserManage userManage = serviceSession.getService(UserManage.class);
				String usrCustId = userManage.getUsrCustId();
				boolean tg = BooleanParser.parse(configureProvider.getProperty(SystemVariable.SFZJTG));
				T6110 t6110_1 = userInfoManage.getUserInfo(serviceSession.getSession().getAccountId());
			%>
			<%if(tg && StringHelper.isEmpty(usrCustId)){ %>
		<div class="mt30 mb30 f16">
		您需要在第三方托管平台上进行注册，才可申请投标！
		<a target="_blank" href="/user/account/safetymsg2.html" class="red">立即注册</a>
		</div>
			<%}else{ %>
		<div class="text f18">
		<span class="grey1">可投金额：</span>
		<span class="f20 ">￥<%=Formater.formatAmount(creditInfo.F07)%></span><br/>
		</div>
		<input type="hidden" id="isYuqi" name="isYuqi" value="<%=isYuqi%>">
		<input type="hidden" id="charge" name="charge" value="<%configureProvider.format(out,URLVariable.USER_CHARGE);%>">
		<input type="hidden" name="kyMoney" id="kyMoney" value="<%=userInfo.F06%>">
		<input type="hidden" name="loanId" id="loanId" value="<%=id%>">
		<input type="hidden" name="hbId" id="hbId" value="0">
		<input type="hidden" name="isActivity" id="isActivity" value="<%=creditInfo.isActivity%>">
		<input type="hidden" name="syje" id="syje" value="<%=creditInfo.F07%>">
		<input type="hidden" name="minBid" id="minBid" value="<%configureProvider.format(out, SystemVariable.MIN_BIDING_AMOUNT);%>">
		<div class="text">
		<!--
		<h4 class="mb5" style="height:18px;display:block;">
		<span class="fl">余额:<%=Formater.formatAmount(userInfo.F06) %></span><a href="<%configureProvider.format(out,URLVariable.USER_CHARGE);%>" class="blue fr">充值</a>
		</h4>
		-->
		<div class="fen">元</div>
		<p>
		<input name="amount" maxlength="10" type="text" class="input_border w202" id="amount" onKeyUp="value=(parseInt((value=value.replace(/\D/g,''))==''?'0':value,10))" oninput="chmodint()" onpropertychange="chmodint()" value="100" />
		<input type="button" class="all_invest" value="全投" onclick="subgo()"/>
		</p>
		<div class="clear"></div>
		<!--
		<p class="text">
		你可以购买： <em class="orange">
			<%if(userInfo.F06.compareTo(creditInfo.F07)>0){%>
			<%=creditInfo.F07%>
			<%}else{%>
			<%=userInfo.F06%>
			<%}%>
		</em> 元
		</p>

		<p ><span class="fl">起投金额 <em class="orange">100</em>元</span><span class="fr">纯收益<em class="orange"> 18.00</em>元</span></p>
		-->
		<div class="f18  mt10 grey1">
		<span>预期收益:</span>
		<span class="f20 orange" id="scinvest">0.00</span><br/>
		</div>
		<div class="f18 mb50 mt10">
		<span class="fl"><span class="grey1">帐号余额:</span><span class="ml5 f20"><%=Formater.formatAmount(userInfo.F06) %>元</span></span><a href="<%configureProvider.format(out,URLVariable.USER_CHARGE);%>" class="blue fr mr10">充值</a>
		</div>

		<p class="mt15">
			<%if(t6110_1.F06 == T6110_F06.ZRR) {if(creditInfo.investName==null || creditInfo.investName.equals(t6110_1.F02)){%>
		<button type="button" id="tbButton"  style="cursor: pointer;" fromname="form1" class="btn sumbitForme">投 标</button>
			<%}else{%>
		<button type="button" id="tbButton11" onclick="javascript:void(0);"  style="cursor: pointer;background: gray;" fromname="form1" class="btn sumbitForme">仅预约户可投</button>
			<%} }%>
		</p>
		</div>
			<%} %>
			<%}else{ %>
		<div class="text">
		<span class="f20">剩余金额</span>
		<span class="f30">￥<%=creditInfo.F07%></span>
		</div>
		<div class="mt30 mb30 ml50 f16">请<a href="<%configureProvider.format(out,URLVariable.LOGIN);%>?_z=/financing/sbtz/bdxq/<%=id%>.html" class="blue mr5 ml5">立即登录</a>或<a href="<%configureProvider.format(out,URLVariable.REGISTER);%>" class="blue mr5 ml5">注册</a></div>
			<%}%>
		</div>
		</form>
			<%} else if (creditInfo.F20 == T6230_F20.HKZ) {%>
		<div class="fr w280 payfrom ui_full ui_plan_bj ui_pay_bj">
		<ul class="paylist f18">
			<% Mbxx mbxx=investManage.getMbxx(id); %>
		<li><span class="mr10">待还本息（元）</span> <span class="f20">￥<%=Formater.formatAmount(mbxx.dhje)%></span></li>
		<li><span class="mr10">剩余期数（期）</span> <span class="f20"><%=t6231.F03%></span></li>
		</ul>
		</div>
		<div class="plan_given_btn" >
		<i class="ui_pay ui_plan_bj"></i>
		</div>
			<%
			} else if (creditInfo.F20 == T6230_F20.TBZ && sytime <=0) {
		%>
		<div class="fr w280 floodmark ui_full">
		<ul class="fulist f18">
			<%
				long hm=1000*3600*24;
				long time =	calendar.getTimeInMillis();
				long day=time/hm;
				long hour=(time-day*hm)/(1000*3600);
				long min=(time-day*hm-hour*1000*3600)/(1000*60);
				long ss=(time-day*hm-hour*1000*3600-min*1000*60)/(1000);
				T6250[] t6250s= investManage.getRecord(id);
			%>
		<li><span class="mr10">满标用时</span> <span><%=hour %>时<%=min %>分<%=ss %>秒</span></li>
		<li><span class="mr10 ">加入人次</span> <span><%=t6250s == null ?0 :t6250s.length %></span></li>
		</ul>
		</div>
		<div class="plan_given_btn" >
		<i class="ui_full ui_plan_bj"></i>
		</div>
			<%
			} else if (creditInfo.F20 == T6230_F20.DFK) {
		%>
		<div class="fr w280 floodmark ui_full">
		<ul class="fulist f18">
			<%
				long hm=1000*3600*24;
				long time =	(t6231.F11!=null?t6231.F11.getTime():creditInfo.F22.getTime())-creditInfo.F22.getTime();
				long day=time/hm;
				long hour=(time-day*hm)/(1000*3600);
				long min=(time-day*hm-hour*1000*3600)/(1000*60);
				long ss=(time-day*hm-hour*1000*3600-min*1000*60)/(1000);
				T6250[] t6250s= investManage.getRecord(id);
			%>
		<li><span class="mr10">满标用时</span> <span><%=day %>天<%=hour %>时<%=min %>分<%=ss %>秒</span></li>
		<li><span class="mr10">加入人次</span> <span><%=t6250s == null ?0 :t6250s.length %></span></li>
		</ul>
		</div>
		<div class="plan_given_btn">
		<i class="ui_full ui_plan_bj"></i>
		</div>
			<%
			} else if (creditInfo.F20 == T6230_F20.YJQ || creditInfo.F20 == T6230_F20.YDF) {
		%>
		<div class="fr w280 ui_payoff_bj ui_full">
		<p class="payoff_info">
		还清时间<br /> <br /> <span class="pt20 f18"><%=creditInfo.F20 == T6230_F20.YDF?DateParser.format(t6231.F14):DateParser.format(t6231.F13)%></span>
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
		<div class="fr submission w240">
		<div class="text bom pt10">
			<%if(!(dimengSession!=null && dimengSession.isAuthenticated())){%>
		<p class="mb30 f16">请先<span class="orange"><a href="<%configureProvider.format(out,URLVariable.LOGIN);%>">登录</a></span></p>
			<%} %>
		<p class="mb30">可投金额：<span class="f20 orange"><%if(creditInfo.F05.doubleValue()>10000){%><%=Formater.formatAmount(creditInfo.F05.doubleValue()/10000)%>万<%}else{ %><%=Formater.formatAmount(creditInfo.F05)%>元<%} %></span></p>
		<p>开放投资倒计时...<span id="tian"></span></p>
		<div class="time"> </div>
		<p class="details_input">敬请期待</p>
		</div>
		</div>
			<%} %>

		</div>
		<!--右侧-->
		</div>


	<script type="text/javascript">
		var endTime =<%=creditInfo.F22.getTime()- System.currentTimeMillis()%>;
		var clearTime = null;
	function time() {
		var leftsecond = parseInt(endTime / 1000);
		if (leftsecond <= 0) {
		clearInterval(clearTime);
		location.reload(true);
		}
		var day = Math.floor(leftsecond/ (60 * 60 * 24)) < 0 ? 0 : Math.floor(leftsecond / (60 * 60 * 24));
		var hour = Math.floor((leftsecond - day * 24 * 60 * 60) / 3600) < 0 ? 0: Math.floor((leftsecond - day * 24 * 60 * 60) / 3600);
		var minute = Math.floor((leftsecond - day* 24 * 60 * 60 - hour * 3600) / 60) < 0 ? 0: Math.floor((leftsecond - day* 24 * 60 * 60 - hour * 3600) / 60);
		var second = Math.floor(leftsecond - day* 24 * 60 * 60 - hour * 3600- minute * 60) < 0 ? 0 : Math.floor(leftsecond - day * 24 * 60* 60 - hour * 3600 - minute* 60);
		if(hour<10)
		{
		hour="0"+hour;
		}
		if(minute<10)
		{
		minute="0"+minute;
		}
		if(second<10)
		{
		second="0"+second;
		}
		$("#tian").html("    ("+day+'天)');
		$(".time").html('<p class="orange mt10"><span class="details_bg">'+hour+'</span><span class="details_ico"></span><span class="details_bg">'+minute+'</span><span class="details_ico"></span><span class="details_bg">'+second+'</span><div class="clear"></div></p>');

   }
	
	//剩余时间
	    var ltime=<%=creditInfo.jsTime.getTime()-System.currentTimeMillis()%>;
	function levtime(){
		var leftsecond = parseInt(ltime / 1000);
		if (leftsecond <= 0) {
			clearInterval(clearTime);
			location.reload(true);
		}
		var day = Math.floor(leftsecond/ (60 * 60 * 24)) < 0 ? 0 : Math.floor(leftsecond / (60 * 60 * 24));
		var hour = Math.floor((leftsecond - day * 24 * 60 * 60) / 3600) < 0 ? 0: Math.floor((leftsecond - day * 24 * 60 * 60) / 3600);
		var minute = Math.floor((leftsecond - day* 24 * 60 * 60 - hour * 3600) / 60) < 0 ? 0: Math.floor((leftsecond - day* 24 * 60 * 60 - hour * 3600) / 60);
		var second = Math.floor(leftsecond - day* 24 * 60 * 60 - hour * 3600- minute * 60) < 0 ? 0 : Math.floor(leftsecond - day * 24 * 60* 60 - hour * 3600 - minute* 60);
		if(hour<10)
		{
			hour="0"+hour;	
		}
		if(minute<10)
		{
			minute="0"+minute;	
		}
		if(second<10)
		{
			second="0"+second;	
		}
		$("#levitime").html('<em class="f24 gray33" >'+day+'</em>&nbsp;天<em class="f24 gray33">'+hour+'</em>&nbsp;时<em class="f24 gray33">'+minute+'</em>&nbsp;分<em class="f24 gray33">'+second+'</em>&nbsp;秒');
		
	}
	
	
	//最低可投100赋值 
	chmodint();
	
	function chmodint(){
		var bcInt = <%=creditInfo.F06%>;
		var inday=<%=t6231.F22%>;
		var inmon=<%=creditInfo.F09%>;
		var monuts = $("#amount").val();
		var cmonint;
		var mints;
		<% if(T6231_F21.S == t6231.F21) {%>
		 
		   mints=bcInt*inday/360;
		<%}else{%>
		    mints=bcInt*inmon/12;
		<%}%>
		 cmonint = monuts*mints;
		$("#scinvest").html(parseFloat(cmonint).toFixed(2));
	}
	
	function subgo(){
		var invmons = <%= creditInfo.F07%>;
		var usemons = $("#kyMoney").val();
		if(usemons >invmons){
			$("#amount").val(parseInt(invmons));
		}else{
		   $("#amount").val(parseInt(usemons));
		}
		chmodint();
	}
	
	
			<%if(creditInfo.F20 == T6230_F20.YFB){%>
		clearTime = setInterval(function() {
		endTime = endTime - 1000;
		time();
		}, 1000);
		<%}else if(creditInfo.F20 == T6230_F20.TBZ && sytime>0){%>
		    clearTime = setInterval(function() {
			  ltime = ltime - 1000;
			  levtime();
		   }, 1000);
		<% }else{%>
		clearInterval(clearTime);
			<%}%>
	</script>
		<div class="popup_bg"  style="display: none;"></div>
		<div class="dialog d_error w510" style="margin:-150px 0 0 -255px; display: none;" >
		<div class="dialog_close fr"><a></a></div>
		<div class="con clearfix">
		<div class="d_succeed fl"></div>
		<div class="info fr" id="div_confirm">
		<p class="f20 gray33">投标购买确认</p>
		您此次购买金额为<i class="red"><span id="zxMoney"><%=zxMoney%></span></i>元
		</div>
		<div class="clear" ></div>
		<div class="dialog_btn"><a href="javascript:void(0);" id="ok" class="btn btn01">确 定</a><a href="javascript:void(0)" id="cancel" class="btn btn05">取 消</a></div>
		</div>
		</div>


