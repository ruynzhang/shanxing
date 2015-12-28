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
<%@page import="com.dimeng.p2p.FeeCode"%>
<%@page import="com.dimeng.p2p.modules.bid.front.service.BidManage"%>
<%@page import="com.dimeng.p2p.common.Expemonyinfo"%>
<%@page import="com.dimeng.p2p.common.Expemoneyrecord"%>
<%@page import="com.dimeng.p2p.common.enums.Tyjbdinfo_status"%>
<%@page import="java.util.List"%>
<div class="w1002 top_title">
	<a href="<%configureProvider.format(out,URLVariable.INDEX);%>">首页</a>&nbsp;&gt;&nbsp;<a href="<%configureProvider.format(out,URLVariable.FINANCING_SBTZ);%>">我要投资</a>&nbsp;&gt;&nbsp;体验标的详情
</div>
<%
	BidManage investManage = serviceSession.getService(BidManage.class);
	int id = IntegerParser.parse(request.getParameter("id"));
	//购买金额
	BigDecimal zxMoney = new BigDecimal(0);
	//体验标的详情
	Expemonyinfo tyjbid=investManage.getTyj(id);
	//com.dimeng.p2p.modules.bid.front.service.entity.Bdxq creditInfo = investManage.get(id);
	if(tyjbid==null){
		response.sendError(HttpServletResponse.SC_NOT_FOUND );
		return;
	}
	UserInfoManage userInfoManage = serviceSession.getService(UserInfoManage.class);
	// T6110 t6110 = userInfoManage.getUserInfo(creditInfo.F02);
%>
  <div class="contain_main clearfix">
    <div class="pub_title clearfix"> <span style="display:inline-block;" title="<%StringHelper.filterHTML(out, tyjbid.title);%>"><%
 	StringHelper.filterHTML(out, StringHelper.truncation(tyjbid.title, 20));
 %> </span> 
    </div>
    <div class="plan_given clearfix">
    <div class="details_image mt10 fl mr30"><img src="<%=controller.getStaticPath(request)%>/images/details_image.jpg"/></div>
    <ul class="tender w395 mt10 fl clearfix yxlc_li">
      <li>
        <div class="mr20 tc br">
          <p class="orange f18 mb5 tc"><%=Formater.formatAmount(tyjbid.borrint)%>%</p><p><span class="f12 grey1">年化收益</span></p></div>
        <div class="mr20 ml10 tc br">
          <p class="f18 mb5"><%
          	out.print(tyjbid.borrterm + "天");
          %></p><p><span class="f12 grey1">投资期限</span></p></div>
        <div class="ml10 tc">
          <p class="f18 mb5"><%=Formater.formatAmount(tyjbid.borrmoney)%>元</p><p><span class="f12 grey1">项目规模</span></p></div>
      
      </li>
      <li>发布日期<span class="item"><%=TimestampParser.format(tyjbid.releasetime,"yyyy-MM-dd")%></span>
      <%
      	//筹款结束时间
      	      Calendar calendar = Calendar.getInstance();
      	      calendar.setTime(tyjbid.releasetime);
      	      calendar.add(Calendar.DAY_OF_MONTH, tyjbid.fundraterm);
      %>
      <%
          Calendar calendar7 = Calendar.getInstance();
	      calendar7.setTime(tyjbid.releasetime);
	      calendar7.add(Calendar.DAY_OF_MONTH, tyjbid.borrterm);
        
      %>
      完结日期<span class="item"><%=DateParser.format(calendar7.getTime(),"yyyy-MM-dd")%></span></li>
      <li><span >还款方式</span><span class="item">利息到期一次付清</span>
          <span >费率说明</span><span class="item">本活动不收取任何费用</span>
        </li>
        	<%
        		long sytime = calendar.getTimeInMillis()-System.currentTimeMillis();
        			if (tyjbid.estatus == Tyjbdinfo_status.TBZ && sytime > 0) {
        	%>
			<li>
				剩余时间<span class="item">
					
					<%
											if(calendar.getTime() != null){
														long hm=1000*3600*24;
														long day=sytime/hm;
														long hour=(sytime-day*hm)/(1000*3600);
														long min=(sytime-day*hm-hour*1000*3600)/(1000*60);
										%>
					<em class="f16 gray33"><%=day<0?0:day%></em>&nbsp;天<em class="f16 gray33"><%=hour<0?0:hour%></em>&nbsp;时<em class="f16 gray33"><%=min<0?0:min%></em>&nbsp;分
					<%
						}
					%>
					</span>
			</li>
			<%
				}else{
			%>
		 <li>投标载止日期:<span class="item" style="width:120px;"><%=TimestampParser.format(tyjbid.deloantime,"yyyy-MM-dd")%></span>
		    <% if (tyjbid.estatus == Tyjbdinfo_status.HKZ || tyjbid.estatus == Tyjbdinfo_status.YJQ){ %>
                                还息日期:<span class="item"><%=TimestampParser.format(tyjbid.repaymenttime,"yyyy-MM-dd")%></span>
             <% } %>
        </li>
			     
			<%} %>
    </ul>
    <!--左侧-->
    		<form method="post" class="form1" action="<%configureProvider.format(out,URLVariable.PAY_BIDTYJ_URL);%>">
				<input type="hidden" id="sbSucc" name="sbSucc" value="<%=controller.getViewURI(request, com.dimeng.p2p.front.servlets.financing.sbtz.Tyblb.class)%>">
		<%
			if (tyjbid.estatus == Tyjbdinfo_status.TBZ  && sytime>0) {
		%>
		<div class="fr submission mt15">
			<%
				if(dimengSession!=null && dimengSession.isAuthenticated()){
					T6101 userInfo= userInfoManage.search();
					T6110 t6110_1 = userInfoManage.getUserInfo(serviceSession.getSession().getAccountId());
					UserManage userManage = serviceSession.getService(UserManage.class);
					String usrCustId = userManage.getUsrCustId();
			%>
			    <%if(StringHelper.isEmpty(usrCustId)){ %>
					<div class="mt30 mb30 f16">
						您需要在第三方托管平台上进行注册，才可申请投标！
						<a target="_blank" href="<%=configureProvider.format(URLVariable.ESCROW_URL_USERREGISTER) %>" class="red">立即注册</a>
					</div>
				<%}else{ %>
				<div class="text">
					<h4>剩余金额</h4>
					<span class="f30 orange">￥<%=Formater.formatAmount(tyjbid.cancasemoney)%></span><br/>
				</div>
				<input type="hidden" id="charge" name="charge" value="<%configureProvider.format(out,URLVariable.USER_CHARGE);%>">
				<input type="hidden" name="loanId" id="loanId" value="<%=id%>">
				<input type="hidden" name="minBid" id="minBid" value="<%configureProvider.format(out, SystemVariable.MIN_BIDING_AMOUNT);%>">
			    <input type="hidden" name="inmony" id="inmony" value="<%=Formater.formatAmount(tyjbid.borrterm *tyjbid.borrint.doubleValue())%>">
				<div class="text">
					<%
						BigDecimal kytyj = userInfoManage.getUserketyj2();
					%>
	                <h5 class="mb5" style="height:18px;display:block;">你可用的体验金有:<%=Formater.formatAmount(kytyj)%> 元</h5>
	                <h5 class="mb5" style="height:18px;display:block;">预期收益:<span class="chmoney"><%=Formater.formatAmount(kytyj.doubleValue()*tyjbid.borrterm *tyjbid.borrint.doubleValue()/36000)%></span>元</h5>
					<p>					   
						<input name="amount" maxlength="10" type="text" class="input_border w202" id="amount" onKeyUp="value=(parseInt((value=value.replace(/\D/g,''))==''?'0':value,10))" oninput="chmodint()" onpropertychange="chmodint()"  value="<%=kytyj%>" /> 
					</p>
                    <div class="clear"></div>
					<p class="mt15">
						<%
							if(t6110_1.F06 == T6110_F06.ZRR) {
						%>
						<button type="button" id="tbButton"  style="cursor: pointer;" fromname="form1" class="btn sumbitForme">立即体验</button>
						<%
							}
						%>
					</p>
				</div>
				   <%} %>
				
			 <%
							 	}else{
							 %>
			 <div class="text">
				<h4>剩余金额</h4>
				<span class="f30">￥<%=Formater.formatAmount(tyjbid.cancasemoney)%></span>
			</div>
			<div class="mt30 mb30 ml50 f16">请<a href="<%configureProvider.format(out,URLVariable.LOGIN);%>?_z=/financing/sbtz/bdxqTyj/<%=id%>.html" class="blue mr5 ml5">立即投标</a>或<a href="<%configureProvider.format(out,URLVariable.REGISTER);%>" class="blue mr5 ml5">注册</a></div>
			 <%
			 	}
			 %>
		</div>
		</form>
		<%
			} else if (tyjbid.estatus == Tyjbdinfo_status.HKZ) {
				  BigDecimal dhtyjlx = userInfoManage.getTyjdhlx(tyjbid.id);
				
		%>
	
		<div class="fr w280 payfrom ui_full ui_plan_bj ui_pay_bj">
			<ul class="paylist">
				<li><span class="mr10">待还利息（元）</span> <span class="f20">￥<%=Formater.formatAmount(dhtyjlx)%></span></li>
			</ul>
		</div>
		<div class="plan_given_btn" >
			<i class="ui_pay ui_plan_bj"></i>
		</div>
		<%
			} else if (tyjbid.estatus == Tyjbdinfo_status.TBZ && sytime <=0) {
		%>
		<div class="fr w280 floodmark ui_full">
			<ul class="fulist">
			<%
				//标的发布时间
					      Calendar calendar2 = Calendar.getInstance();
					      calendar2.setTime(tyjbid.releasetime);
					      
					long hm=1000*3600*24;
					long time =	calendar.getTimeInMillis()-calendar2.getTimeInMillis();
					long day=time/hm;
					long hour=(time-day*hm)/(1000*3600);
					long min=(time-day*hm-hour*1000*3600)/(1000*60);
					long ss=(time-day*hm-hour*1000*3600-min*1000*60)/(1000);
					//Expemoneyrecord Erlists = investManage.getTyjrecordlist(id);
					Expemoneyrecord Erlists = investManage.getTyjlistSumint(id);
			%>
				<li><span class="mr10">结束用时</span> <span class="f14"><%=day%>天<%=hour%>时<%=min%>分<%=ss%>秒</span></li>
				<li><span class="mr10">加入人次</span> <span class="f14"><%=Erlists == null ?0 :Erlists.id%></span></li>
			</ul>
		</div>
		<div class="plan_given_btn" >
			<i class="ui_full ui_plan_bj"></i>
		</div>
		<%
			} else if (tyjbid.estatus == Tyjbdinfo_status.DFK) {
		%>
		<div class="fr w280 floodmark ui_full">
			<ul class="fulist">
			<%
				//标的发布时间
				  Calendar calendar2 = Calendar.getInstance();
					      calendar2.setTime(tyjbid.releasetime);
					      
					      //待放款时间
					      Calendar calendar3 = Calendar.getInstance();
					      calendar3.setTime(tyjbid.deloantime);
				
					long hm=1000*3600*24;
					//long time =	t6231.F11.getTime()-creditInfo.F22.getTime();
					//待放款时间-发布时间
					long time =  calendar3.getTimeInMillis()-calendar2.getTimeInMillis();
					long day=time/hm;
					long hour=(time-day*hm)/(1000*3600);
					long min=(time-day*hm-hour*1000*3600)/(1000*60);
					long ss=(time-day*hm-hour*1000*3600-min*1000*60)/(1000);
					//T6250[] t6250s= investManage.getRecord(id);
					//List<Expemoneyrecord> list = investManage.getTyjrecordlist(id);
					Expemoneyrecord Erlists = investManage.getTyjlistSumint(id);
			%>
				<li><span class="mr10">满标用时</span> <span class="f14"><%=day %>天<%=hour %>时<%=min %>分<%=ss %>秒</span></li>
				<li><span class="mr10">加入人次</span> <span class="f14"><%=Erlists == null ?0 :Erlists.id %></span></li>
			</ul>
		</div>
		<div class="plan_given_btn">
			<i class="ui_full ui_plan_bj"></i>
		</div>
		<%
			} else if (tyjbid.estatus == Tyjbdinfo_status.YJQ ) {
		%>
		<div class="fr w280 ui_payoff_bj ui_full">
			<p class="payoff_info">
				还清时间<br /><%=DateTimeParser.format(tyjbid.repaymenttime,"yyyy-MM-dd HH:mm")%> <br /> <span class="pt20 f18"></span>
			</p>
		</div>
		<div class="plan_given_btn">
			<i class="ui_paid ui_plan_bj"></i>
		</div>
		<%
			}else if(tyjbid.estatus == Tyjbdinfo_status.YFB){
		%>
      <div class="fr submission w240">
          <div class="text bom pt10">
          	<%if(!(dimengSession!=null && dimengSession.isAuthenticated())){%>
            <p class="mb30 f16">请先<span class="orange"><a href="<%configureProvider.format(out,URLVariable.LOGIN);%>">登录</a></span></p>
            <%} %>
            <p class="mb30">可投金额：<span class="f20 orange"><%=Formater.formatAmount(tyjbid.cancasemoney)%>元</span></p>
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
		var endTime =<%=tyjbid.releasetime.getTime()- System.currentTimeMillis()%>;
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
		<%if(tyjbid.estatus == Tyjbdinfo_status.YFB){%>
			clearTime = setInterval(function() {
			endTime = endTime - 1000;
			time();
		}, 1000);
		<%}else{%>
			clearInterval(clearTime);
		<%}%>

function chmodint(){
	var monuts = $("#amount").val();
	var mints=  $("#inmony").val();
	var cmonint = monuts*mints/36000;
	$(".chmoney").html(parseFloat(cmonint).toFixed(2));
}
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


