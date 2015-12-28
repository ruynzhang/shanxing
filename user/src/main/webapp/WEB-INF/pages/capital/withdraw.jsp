<%@page import="com.dimeng.p2p.S61.entities.T6101"%>
<%@page import="com.dimeng.p2p.account.user.service.entity.BankCard"%>
<%@page import="com.dimeng.p2p.account.user.service.UserInfoManage"%>
<%@page import="com.dimeng.p2p.account.user.service.TxManage"%>
<%@page import="com.dimeng.p2p.user.servlets.account.Safetymsg"%>
<%@page import="com.dimeng.p2p.user.servlets.account.Addbankcard"%>
<%@page import="com.dimeng.p2p.user.servlets.account.Bankcardlist"%>
<%@page import="java.util.Date"%>
<%@page import="com.dimeng.p2p.user.servlets.capital.Withdraw"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<%@include file="/WEB-INF/include/authenticatedSession.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>我的<%configureProvider.format(out,SystemVariable.SITE_NAME); %>_提现管理
</title>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<%
		TxManage manage = serviceSession.getService(TxManage.class);
		UserInfoManage userInfoManage = serviceSession.getService(UserInfoManage.class);
		T6101 t6101 = userInfoManage.search();
		BankCard[] cards = manage.bankCards();
		int cardId = IntegerParser.parse(request.getAttribute("cardId"));
		boolean realName = manage.getnewVerifyStatus();
		String funds = controller.getPrompt(request, response, PromptLevel.WARRING);
		UserManage userManage = serviceSession.getService(UserManage.class);
		String usrCustId = userManage.getUsrCustId();
		boolean tg = BooleanParser.parse(configureProvider.getProperty(SystemVariable.SFZJTG));
		tg=false;
		String action = null;
		if(tg){
			action = configureProvider.format(URLVariable.ESCROW_URL_WITHDRAW);
		}else{
			action = controller.getURI(request, Withdraw.class);
		}
		CURRENT_CATEGORY = "WDWDW";
		CURRENT_SUB_CATEGORY = "WDWDW";
	%>
	<div class="contain clearfix">
		<div class="user_top"></div>
		<div class="about">
			<%@include file="/WEB-INF/include/menu.jsp"%>
			<form action="<%=controller.getURI(request, Withdraw.class) %>" autocomplete="off" method="post" onsubmit="return onSubmit();">
				<%if(cardId>0){ %>
				<input type="hidden" name="cardId" value="<%=cardId %>" />
				<%}else{ %>
				<input type="hidden" name="cardId" value="<%=(cards!=null&&cards.length>0)?cards[0].id:"" %>" />
				<%} %>
				<div class="container fr bor1">
					<div class="p15">
						<%if(tg && StringHelper.isEmpty(usrCustId)){ %>
							<div class="f16 mt30 pt50 pb50 tc ml30 mr30" style="background:#f3f3f3;">
				            	 您需要在第三方托管平台上进行注册，才可申请充值提现！请<a target="_blank" href="<%=configureProvider.format(URLVariable.ESCROW_URL_USERREGISTER) %>" class="red">立即注册</a>！
				        	</div>
						<%} else { %>
						<div>
							<span class="tx_an3 fr"><a href="<%=controller.getViewURI(request, Bankcardlist.class) %>">管理银行卡</a></span>
							<%if(cards==null || cards.length<IntegerParser.parse(configureProvider.getProperty(SystemVariable.MAX_BANKCARD_COUNT))){ %>
								<%if(tg){ %>
									<span class="tx_an2 fr mr10"><a target="_blank" href="<%=configureProvider.format(URLVariable.ESCROW_URL_BINDCARD) %>">添加银行卡</a></span>
								<%}else{ %>
								<span class="tx_an2 fr mr10"><a href="javascript:void(0);" onclick="addCard();">添加银行卡</a></span>
								<%} %>
							<%} %>
                            <p class="title1"><b>选择提现银行</b></p>
						</div>
						<ul class="tx_li tc mb30">
							<%
							if(cards!=null&&cards.length>0){
								int i=0;
								for(BankCard card : cards){
									if(card==null){
										continue;
									}
							%>
							<li class="cards"><a href="javascript:void(0);" onclick="checkCard(this, <%=card.id %>)" <%if(cardId>0){if(cardId==card.id){ %> class="curr"<%}}else{if(i==0){ %>class="curr"<%}} %>>
									<p><%StringHelper.filterQuoter(out, card.Bankname); %></p>
									<%if(!StringHelper.isEmpty(card.BankNumber) && card.BankNumber.length()>4){
									StringHelper.filterHTML(out, card.BankNumber);} %>
									</a>
							</li>
							<%i++;}}else{ %>
								<li class="cards">
									<%if(tg){ %>
									<a class="blue" href="<%=configureProvider.format(URLVariable.ESCROW_URL_BINDCARD) %>"><p>添加银行卡</p></a>
									<%}else{ %>
									<a class="blue" href="javascript:void(0);" onclick="addCard();"><p>添加银行卡</p></a>
									<%} %>
								</li>
							<%} %>
							<div class="clear"></div>
						</ul>
						<div class="user_lsjt mb15">填写提现金额</div>
						<div class="bom mb20" style="border:none;">
							<ul class="noborder" style="width:800px;">
								<li>
									<div class="til">可用金额：</div>
									<div class="info">
										<span class="f24" id="aFunds"><%=Formater.formatAmount(t6101.F06) %></span>元
									</div>
									<div class="clear"></div>
								</li>
								<li>
									<div class="til">提现金额：</div>
									<div class="info">
										<input type="password" name="showPwd" class="text yhgl_ser" style="display: none;"/> 
										<input type="text" name="amount" onKeyUp="value=(value=value.replace(/[^\d\.]/g,''))==''?'':value" autocomplete="off" maxlength="9" class="text yhgl_ser" /> 元
									</div>
									<div class="clear"></div>
								</li>
								<li>
									<div class="til">提现手续费：</div>
									<div class="info">
										<span class="f24 fl" id="poundage">0.00</span><span class="fl">元</span>
										<a class="ml20 tx_an1" href="javascript:void(0)"></a>
										<div class="info"></div>
									</div>
									<div class="pop-con" style="margin-left:540px; margin-top:-30px;display: none;">
			                           <div class="fl pop-pic"></div>
			                           <div class="pop-info">
		                                    <p>第三方收取提现手续费</p>
		                                     <%--
		                                     <table width="100%" border="0" cellspacing="0" class="table-f">
		                                        <tr>
		                                          <td>5000以下</td>
		                                          <td>5000以上（含5000）</td>
		                                        </tr>
		                                        <tr>
		                                          <td><%=configureProvider.getProperty(SystemVariable.WITHDRAW_POUNDAGE_1_5) %>元/笔</td>
		                                          <td><%=configureProvider.getProperty(SystemVariable.WITHDRAW_POUNDAGE_5_20) %>元/笔</td>
		                                        </tr>
		                                      </table>
		                                      --%>
		                                      <table width="100%" border="0" cellspacing="0" class="table-f">
		                                        <tr>
		                                          <td>提现手续费比例：<%=Formater.formatRate(new BigDecimal(configureProvider.getProperty(SystemVariable.WITHDRAW_POUNDAGE_PROPORTION)))%>，最低<%=configureProvider.getProperty(SystemVariable.WITHDRAW_POUNDAGE_MIN)%>元每笔</td>
		                                        </tr>
		                                      </table>
		                                   <p><span class="orange">温馨提示：</span>单日提现金额超过500万元请提前三个工作日通知<%=configureProvider.getProperty(SystemVariable.SITE_NAME) %>，以便我们尽快处理您的提现</p>
		                              </div>
			                        </div>
			                        <div class="clear"></div>
								</li>
								<li>
									<div class="til">&nbsp;</div>
									<div class="info">
										提现费用将从您的<%=configureProvider.getProperty(SystemVariable.SITE_NAME) %>账户余额中扣除，余额不足则从提现资金中扣除
									</div>
									<div class="clear"></div>
								</li>
								<li>
									<div class="til">实际支付金额：</div>
									<div class="info">
										<span class="f24 red" id="paySum">0.00</span>元
									</div>
									<div class="clear"></div>
								</li>
								<li>
									<div class="til">预计到账时间：</div>
									<div class="info">
										<span class="fl"><%=DateParser.format(new Date(System.currentTimeMillis()+2*24*60*60*1000)) %></span>
										<div class="sx_tip_box"><a class="ml20 tx_an1" href="javascript:void(0)"></a><div class="sx_tip_info" style="top:-28px; right:-152px; width:300px;">1-2个工作日（双休日和法定节假日除外）之内到账<span></span></div></div>
									</div>
									<div class="pop-con" style="margin-left:360px;display: none;">
			                           <div class="fl pop-pic"></div>
			                           <div class="pop-info">1-2个工作日（双休日和法定节假日除外）之内到账</div>
			                        </div>
			                        <div class="clear"></div>
								</li>
								<li>
									<div class="til">提现密码：</div>
									<div class="info">
										<input type="password" name="showWithdrawPsd" class="text yhgl_ser" style="display: none;"/> 
										<input type="password" name="withdrawPsd" class="text yhgl_ser" /> 
										<a href="<%=controller.getViewURI(request, Safetymsg.class) %>" class="xhx">找回密码？</a>
									</div>
									<div class="clear"></div>
								</li>
								<li>
									<div class="til">&nbsp;</div>
									<div class="info">
										<input type="submit" style="cursor: pointer;" value="提现"
											class="btn01 mb15 mt15" />
									</div>
									<div class="clear"></div>
								</li>
							</ul>
						</div>
						<%} %>
                        <div class="clear"></div>
						<div class="ln30 pl20 mb40">
							<p class="blue_ls">温馨提示：</p>
							1.请确保您输入的提现金额，以及银行账号信息准确无误。<br />
							2.在双休日和法定节假日期间，用户可以申请提现，<%=configureProvider.getProperty(SystemVariable.SITE_NAME) %>会在下一个工作日进行处理。由此造成的不便，<br /> 请多多谅解！<br />
							3.平台禁止洗钱、信用卡套现、虚假交易等行为，一经发现并确认，将终止该账户的使用。<br>
						</div>
					</div>
				</div>
			</form>
			<div class="clear"></div>
		</div>
	</div>
	<%
		String infoMsg = controller.getPrompt(request, response, PromptLevel.INFO);
	%>
	<div id="dialog" style="<%=StringHelper.isEmpty(infoMsg)?"display: none;":"" %>">
		<div class="popup_bg"></div>
		<div class="dialog w510 thickpos" style="margin:-80px 0 0 -255px;">
		  <div class="dialog_close fr"><a href="javascript:void(0);"></a></div>
		  <div class="con clearfix">
		    <div class="d_perfect fl"></div>
		    <div class="info fr">
		      <p class="f20 gray33" id="con_error"><%=StringHelper.isEmpty(infoMsg)?"":infoMsg %></p>
		    </div>
		  </div>
		</div>
	</div>
	<script type="text/javascript">
	var balance = <%=t6101.F06%>;
	<%--
		var p1 = <%=configureProvider.getProperty(SystemVariable.WITHDRAW_POUNDAGE_1_5) %>; 
		var p2 = <%=configureProvider.getProperty(SystemVariable.WITHDRAW_POUNDAGE_5_20) %>; 
	--%>
		var proRate = <%=configureProvider.getProperty(SystemVariable.WITHDRAW_POUNDAGE_PROPORTION) %>; 
		var proMin = <%=configureProvider.getProperty(SystemVariable.WITHDRAW_POUNDAGE_MIN) %>;
		var min = <%=configureProvider.getProperty(SystemVariable.WITHDRAW_MIN_FUNDS) %>; 
		var max = <%=configureProvider.getProperty(SystemVariable.WITHDRAW_MAX_FUNDS) %>; 
		var rn = 0;
		<%if(realName){%>
			rn = 1;
		<%}%>
	</script>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
	<%@include file="/WEB-INF/include/dialog.jsp"%>
	<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/withdraw.js"></script>
	<script type="text/javascript">
	function addCard(){
	 	if(rn == 0){
			$("#con_error").html("添加银行卡必须先<span class='red'>实名认证、设置提现密码</span>请到<a class='blue' href='<%=controller.getViewURI(request, Safetymsg.class) %>'>安全信息</a>设置");
			$("#dialog").show();
			return ;
		}  
		global_art = art.dialog.open(
					"<%=controller.getViewURI(request, Addbankcard.class)%>", {
						id : 'addCard',
						title : '添加银行卡',
						opacity : 0.1,
						width : 783,
						height : 500,
						lock : true,
						close : function() {
							window.location.reload();
						}
					}, false);
		}
		var len = <%=cards==null?0:cards.length %>;
	</script>
</body>
</html>