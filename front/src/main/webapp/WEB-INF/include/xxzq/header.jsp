<%@page import="java.util.Calendar"%>
<%@page import="com.dimeng.p2p.S62.entities.T6240"%>
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
	<span class="fl">
	<a href="<%=controller.getURI(request, com.dimeng.p2p.front.servlets.financing.Index.class)%>">我要理财</a>&gt;
	<a href="<%=controller.getURI(request, com.dimeng.p2p.front.servlets.financing.sbtz.Index.class)%>">理财投资列表</a>&gt;线下债权转让详情
	</span>
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
	
	T6240 t6240 = investManage.getXXZQ(id);
	String zqName = "";
	if(t6240 != null) {
		zqName = userInfoManage.getUserName(t6240.F02);
	}
%>
<div class="clearfix">
  <div class="contain_main clearfix">
    <div class="pub_title clearfix"> <span class="fl" title="<%StringHelper.filterHTML(out, t6240.F05);%>"><%StringHelper.filterHTML(out, StringHelper.truncation(t6240.F05, 20)); %> </span> 
    </div>
    <div class="plan_given clearfix">
    <div class="details_image mt30 fl mr30"><img src="<%if(StringHelper.isEmpty(creditInfo.F21)){%><%=controller.getStaticPath(request)%>/images/details_image.jpg<%}else{%><%=fileStore.getURL(creditInfo.F21) %><%}%>"  /></div>
    <ul class="tender w395 mt15 fl clearfix yxlc_li">
      <li>
        <div class="mr30">年化收益<br />
          <span class="red f24 mt10 mb10"><%=Formater.formatRate(creditInfo.F06)%></span></div>
        <div class="mr30 ml30">投资期限<br />
          <span class="f24 mt10 mb10"><%=creditInfo.F09%>个月</span></div>
        <div class="ml30">项目规模<br />
          <span class="f24 mt10 mb10"><%if(creditInfo.F05.doubleValue()>10000){%><%=Formater.formatAmount(creditInfo.F05.doubleValue()/10000)%>万<%}else{ %><%=creditInfo.F05%>元<%} %></span></div>
      </li>
      <li><span>发布日期：<%=TimestampParser.format(creditInfo.F22,"yyyy-MM-dd") %></span>
      <%if(t6231.F06 != null){ %>
      <span class="ml40">还款日期：<%=TimestampParser.format(t6231.F06,"yyyy-MM-dd") %></span>
      <%} %>
      </li>
     
     <%if(creditInfo.F11 == T6230_F11.S){ %>
      	<li><span>担保机构：<%=investManage.getDB(id) == null?"":investManage.getDB(id).F06%></span></li>
      	<li><span>保障方式：<%=creditInfo.F12.getChineseName() %></span></li>
      <%} %>
      <li><span>还款方式：</span><span><%=creditInfo.F10.getChineseName()%></span>
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
   		<li>
    		<span>债权人：</span><span><%=zqName %></span>
   		</li>
   		<%
       		long sytime = 0;
			if (creditInfo.F20 == T6230_F20.TBZ) {
		%>
    	<li>
				<span>剩余时间：
					
					<%
					if(creditInfo.jsTime != null){
						long hm=1000*3600*24;
						sytime = creditInfo.jsTime.getTime()-System.currentTimeMillis();
						long day=sytime/hm;
						long hour=(sytime-day*hm)/(1000*3600);
						long min=(sytime-day*hm-hour*1000*3600)/(1000*60);
					%>
					<em class="f18 gray33"><%=day<0?0:day %></em>天<em class="f18 gray33"><%=hour<0?0:hour %></em>时<em class="f18 gray33"><%=min<0?0:min %></em>分
					<%} %>
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
			if (creditInfo.F20 == T6230_F20.TBZ) {

		%>
		<div class="fr submission w240 mt15">
			<%if(dimengSession!=null && dimengSession.isAuthenticated()){
				T6101 userInfo= userInfoManage.search();
				String isYuqi =  userInfoManage.isYuqi();		
			%>
			
				<input type="hidden" id="isYuqi" name="isYuqi" value="<%=isYuqi%>">
				<input type="hidden" id="charge" name="charge" value="<%configureProvider.format(out,URLVariable.USER_CHARGE);%>">
				<input type="hidden" name="kyMoney" id="kyMoney" value="<%=userInfo.F06%>">
				<input type="hidden" name="loanId" id="loanId" value="<%=id%>">
				<input type="hidden" name="syje" id="syje" value="<%=creditInfo.F07%>">
				<input type="hidden" name="minBid" id="minBid" value="<%configureProvider.format(out, SystemVariable.MIN_BIDING_AMOUNT);%>">
				<div class="text">
					<h4>剩余金额</h4>
					<span class="f30">￥<%=Formater.formatAmount(creditInfo.F07)%></span><br/>
				</div>
				<div class="text">
					<h4 class="mb5" style="height:18px;display:block;">
						<span class="fl">余额:<%=Formater.formatAmount(userInfo.F06) %></span><a href="<%configureProvider.format(out,URLVariable.USER_CHARGE);%>" class="blue fr">充值</a>
					</h4>
	                <div class="fen">元</div>
					<p>					   
						<input name="amount" maxlength="10" type="text" class="input_border w240" id="amount" onKeyUp="value=(parseInt((value=value.replace(/\D/g,''))==''?'0':value,10))"  value="" /> 
					</p>
					<p>
						你可以购买： <em class="orange">
						<%if(userInfo.F06.compareTo(creditInfo.F07)>0){%>
							<%=creditInfo.F07%>
							<%}else{%>
							<%=userInfo.F06%>
						<%}%>
							</em> 元
					</p>
					<p class="mt15">
						<button type="button" id="tbButton"  style="cursor: pointer;" fromname="form1" class="btn sumbitForme">投 标</button>
					</p>
				</div>
			
			 <%}else{ %>
			 <div class="text">
				<h4>剩余金额</h4>
				<span class="f30">￥<%=creditInfo.F07%></span>
			</div>
			<div class="mt30 mb30 ml50 f16">请<a href="<%configureProvider.format(out,URLVariable.LOGIN);%>" class="blue mr5 ml5">登录</a>或<a href="<%configureProvider.format(out,URLVariable.REGISTER);%>" class="blue mr5 ml5">注册</a></div>
			 <%}%>
		</div>
		</form>
		<%} else if (creditInfo.F20 == T6230_F20.HKZ) {%>
		<div class="fr w280 payfrom ui_full ui_plan_bj ui_pay_bj">
			<ul class="paylist">
				<% Mbxx mbxx=investManage.getMbxx(id); %>
				<li><span class="mr10">待还本息（元）</span> <span class="f20">￥<%=Formater.formatAmount(mbxx.dhje)%></span></li>
				<li><span class="mr10">剩余期数（月）</span> <span class="f20"><%=t6231.F03%></span></li>
<%-- 				<li><span class="mr10">下一合约还款日</span> <span class="f20"><%=Formater.formatDate(mbxx.F08)%></span></li>
 --%>			</ul>
		</div>
		<div class="plan_given_btn">
			<i class="ui_pay ui_plan_bj"></i>
		</div>
		<%
			} else if (creditInfo.F20 == T6230_F20.TBZ && sytime <=0) {
		%>
		<div class="fr w280 floodmark ui_full ui_plan_bj ui_full_bj">
			<ul class="fulist">
			<%
				Calendar calendar = Calendar.getInstance();
		       calendar.setTime(creditInfo.F22);
		       calendar.add(Calendar.MONTH, creditInfo.F09);
				long hm=1000*3600*24;
				long time =	calendar.getTimeInMillis();
				long day=time/hm;
				long hour=(time-day*hm)/(1000*3600);
				long min=(time-day*hm-hour*1000*3600)/(1000*60);
				long ss=(time-day*hm-hour*1000*3600-min*1000*60)/(1000);
				T6250[] t6250s= investManage.getRecord(id);
			%>
				<li><span class="mr10">满标用时</span> <span class="f24"><%=hour %>时<%=min %>分<%=ss %>秒</span></li>
				<li><span class="mr10">加入人次</span> <span class="f24"><%=t6250s == null ?0 :t6250s.length %></span></li>
			</ul>
		</div>
		<div class="plan_given_btn">
			<i class="ui_full ui_plan_bj"></i>
		</div>
		<%
			} else if (creditInfo.F20 == T6230_F20.DFK) {
		%>
		<div class="fr w280 floodmark ui_full ui_plan_bj ui_full_bj">
			<ul class="fulist">
			<%
				long hm=1000*3600*24;
				long time =	t6231.F11.getTime()-t6231.F10.getTime();
				long day=time/hm;
				long hour=(time-day*hm)/(1000*3600);
				long min=(time-day*hm-hour*1000*3600)/(1000*60);
				long ss=(time-day*hm-hour*1000*3600-min*1000*60)/(1000);
				T6250[] t6250s= investManage.getRecord(id);
			%>
				<li><span class="mr10">满标用时</span> <span class="f24"><%=hour %>时<%=min %>分<%=ss %>秒</span></li>
				<li><span class="mr10">加入人次</span> <span class="f24"><%=t6250s == null ?0 :t6250s.length %></span></li>
			</ul>
		</div>
		<div class="plan_given_btn">
			<i class="ui_full ui_plan_bj"></i>
		</div>
		<%
			} else if (creditInfo.F20 == T6230_F20.YJQ || creditInfo.F20 == T6230_F20.YDF) {
		%>
		<div class="fr w280 ui_payoff_bj ui_full ui_plan_bj ui_pay_bj payoff">
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
		<div class="fr w280 floodmark ui_full ui_plan_bj ui_lose_bj"></div>
		<%
			}else if(creditInfo.F20 == T6230_F20.YFB){
		%>
      <div class="fr submission w260">
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
   
</div>

<script type="text/javascript">
		var endTime =<%=creditInfo.F22.getTime()- System.currentTimeMillis()%>;
		var clearTime = null;
		function time() {
			var leftsecond = parseInt(endTime / 1000);
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
			if (leftsecond <= 0) {
				clearInterval(clearTime);
				location.reload();
			}
		}
		<%if(creditInfo.F20 == T6230_F20.YFB){%>
			clearTime = setInterval(function() {
			endTime = endTime - 1000;
			time();
		}, 1000);
		<%}else{%>
			clearInterval(clearTime);
		<%}%>
</script>
<div class="popup_bg"  style="display: none;"></div>
<div class="dialog d_error w510" style="margin:-150px 0 0 -255px; display: none;" >
	<div class="dialog_close fr"><a></a></div>
    <div class="con clearfix">
      <div class="d_succeed fl"></div>
      <div class="info fr">
          <p class="f20 gray33">投标购买确认</p>
          	您此次购买金额为<i class="red"><span id="zxMoney"><%=zxMoney%></span></i>元
      </div>  
      <div class="clear" ></div>    
      <div class="dialog_btn"><a href="javascript:void(0)" id="ok" class="btn btn01">确 定</a><a href="javascript:void(0)" id="cancel" class="btn btn05">取 消</a></div> 
    </div>
</div>


