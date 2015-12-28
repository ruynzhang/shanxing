<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.front.servlets.financing.yxlc.Yxlb"%>
<%@page import="com.dimeng.p2p.modules.financial.front.service.entity.YxlcCount"%>
<%@page import="com.dimeng.p2p.S61.entities.T6101"%>
<%@page import="com.dimeng.p2p.account.front.service.UserInfoManage"%>
<%@page import="java.util.Calendar"%>
<%@page import="com.dimeng.p2p.S64.enums.T6410_F07"%>
<%@page import="com.dimeng.p2p.common.enums.TermType"%>
<%@page import="com.dimeng.p2p.front.servlets.Term"%>
<%@page import="com.dimeng.p2p.front.servlets.financing.yxlc.Jhjs"%>
<%@page import="com.dimeng.p2p.modules.financial.front.service.entity.YxxqEntity"%>
<%@page import="com.dimeng.p2p.modules.financial.front.service.FinancialManage"%>
<html>
<head>
<title>优选理财计划<%=configureProvider.getProperty(SystemVariable.SITE_TITLE)%></title>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<%
		FinancialManage service = serviceSession.getService(FinancialManage.class);
			YxxqEntity caInfo= service.getNewPlan();
			if(caInfo==null){
		controller.sendRedirect(request, response,controller.getViewURI(request, Jhjs.class));
		return;
			}
			BigDecimal gmMoney= new BigDecimal(0);
			BigDecimal jrfMoney= new BigDecimal(0);
	%>
	<div class="contain clearfix">
		<div class="w1002 top_title">
			<span class="fl"><a href="<%=controller.getViewURI(request, com.dimeng.p2p.front.servlets.financing.Index.class)%>">我要理财</a> &gt;   优选理财计划</span>
      <span class="fr">
      </span>
		</div>
		<div class="contain_main clearfix">
			<div class="pub_title clearfix">
				<span class="fl">
				<%
					StringHelper.filterHTML(out, caInfo.F02);
				%>
				<a href="<%=controller.getPagingItemURI(request, com.dimeng.p2p.front.servlets.financing.yxlc.Yxxq.class,caInfo.F01)%>" class="gray3 ml15"><em class="ml5 blue f14 ">查看详情</em></a></span> 
				<span class="fr f14"><a target="_blank" href="<%=controller.getPagingItemURI(request, Term.class, TermType.YXLCXY.name())%>" class="blue">NO.56 优选理财服务计划协议范本</a></span>
			</div>
			<div class="plan_given clearfix">
				<ul class="tender w620 fl clearfix">
					<li>
						<div class="list01">计划金额</div>
						<div class="list02">
							<em class="f20"><%=Formater.formatAmount(caInfo.F03)%></em>元
						</div>
						<div class="list01">预期收益</div>
						<div class="list02">
							<em class="f20"><%=caInfo.F05 == null? "0%":Formater.formatRate(caInfo.F05.doubleValue())%></em>每年
						</div>
					</li>
					<li>
						<div class="list01">投标范围</div>
						<div class="list02">
						<em class="xin mt15 mr10">保</em>
							 
						</div>
						<div class="list01">保障方式</div>
						<div class="list02">
							参见<a target="_blank" href="<%=controller.getPagingItemURI(request, Term.class, TermType.BXBZ.name())%>" class="ml5 blue">本息保障计划</a>
						</div>
					</li>
					<li>
						<div class="list01">计划状态</div>
						<div class="list02">
							<%if(caInfo.F07 == T6410_F07.YFB && caInfo.F09.after(caInfo.currentTime)){%>
								预售中
							<%}else if(caInfo.F07 == T6410_F07.YFB && !caInfo.F09.after(caInfo.currentTime)){%>
								申请中
							<%}else if(caInfo.F07 == T6410_F07.YSX){%>
								已满额
							<%}else if(caInfo.F07 == T6410_F07.YJZ){%>
								已截止
							<%}%>
						</div>
						
						
						<%if(caInfo.F07 == T6410_F07.YFB && caInfo.F09.after(caInfo.currentTime)){
												long hm=1000*3600*24;
												long time =	 caInfo.F09.getTime() - System.currentTimeMillis();
												long day=time/hm;
												long hour=(time-day*hm)/(1000*3600);
												long min=(time-day*hm-hour*1000*3600)/(1000*60);
						%>
						<div class="list01">距离发售</div>
						<div class="list02"><%=day%>天<%=hour%>小时<%=min%>分</div>
						<%
						}else if(caInfo.F07 == T6410_F07.YSX || caInfo.F07 == T6410_F07.YJZ){	
												long hm=3600*24;
												long time =	caInfo.F08;
												long day=time/hm;
												long hour=(time-day*hm)/3600;
												long min=(time-day*hm-hour*3600)/60;
												long ss=time-day*hm-hour*3600-min*60;
						%>
					<div class="list01">满额用时</div>
					<div class="list02"><%=day%>天<%=hour%>时<%=min%>分<%=ss%>秒</div>
						<%
						}else if(caInfo.F07 == T6410_F07.YFB && !(caInfo.F09.after(caInfo.currentTime))){
												long hm=1000*3600*24;
												long time =	caInfo.F10.getTime()-System.currentTimeMillis();
												long day=time/hm;
												long hour=(time-day*hm)/(1000*3600);
												long min=(time-day*hm-hour*1000*3600)/(1000*60);
						%>
						<div class="list01">距离截止</div>
						<div class="list02"><%=day<0?0:day%>天<%=hour<0?0:hour%>小时<%=min<0?0:min%>分</div>
						<%
							}
						%>
						
						
						
					</li>
					<li>
						<div class="list01">锁定期限</div>
						<div class="list02">
							<em class="f20"><%=caInfo.F11%></em>个月
						</div>
						<%
								Calendar calendar = Calendar.getInstance();
								calendar.setTimeInMillis(caInfo.F13.getTime());
								int year=calendar.get(Calendar.YEAR); 
								int month=calendar.get(Calendar.MONTH)+1; 
								int date=calendar.get(Calendar.DATE);
						%>
							<div class="list01">锁定结束</div>
						<div class="list02"><%=year%>年<%=month%>月<%=date%>日</div>
					</li>
					<li>
						<div class="list01">收益处理</div>
						<div class="list02"><%StringHelper.filterHTML(out, caInfo.F14.getChineseName());  %></div>
						<div class="list01">费率说明</div>
						<div class="list02">本期计划费用如下</div>
					</li>
					<li style="border-bottom: none">
						<ul class="plan_charge clearfix fl">
							<li>
								<div class="list04">
									<span class="fl">加入费率 <%=Formater.formatRate(caInfo.F15)%></span>
									<div class="tips_content">
										<span class="ui_plan_bj ui_i_tips ml5" style="margin-top: 7px;" onmouseover="mouseOver(3)" onmouseout="mouseOut(3)"></span>
										<div class="ui-pop-con" style="display: none;" id="txfy3">
											<div class="fl ui-pop-pic"></div>
											<div class="ui-pop-info">
											初期额外收取加入计划金额的<%=Formater.formatRate(caInfo.F15)%>作为加入费用，归<%=configureProvider.getProperty(SystemVariable.SITE_NAME)%>所有。
											</div>
										</div>
									</div>
								</div>
							</li>
							<li>
								<div class="list04">
									<span class="fl">服务费率 <%=Formater.formatRate(caInfo.F16)%></span>
									<div class="tips_content">
										<span class="ui_plan_bj ui_i_tips ml5" style="margin-top: 7px;" onmouseover="mouseOver(2)" onmouseout="mouseOut(2)"></span>
										<div class="ui-pop-con" style="display: none;" id="txfy2">
											<div class="fl ui-pop-pic"></div>
											<div class="ui-pop-info">
											计划中收取投标所得利息收益的<%=Formater.formatRate(caInfo.F16)%>作为服务费，归<%=configureProvider.getProperty(SystemVariable.SITE_NAME)%>所有。</div>
										</div>
									</div>
								</div>
							</li>
							<li>
								<div class="list04">
									<span class="fl">退出费率 <%=Formater.formatRate(caInfo.F17)%></span>
									<div class="tips_content">
										<span class="ui_plan_bj ui_i_tips ml5" style="margin-top: 7px;" onmouseover="mouseOver(0)" onmouseout="mouseOut(0)"></span>
										<div class="ui-pop-con" style="display: none;" id="txfy0">
											<div class="fl ui-pop-pic"></div>
											<div class="ui-pop-info">
												退出计划时收取退出计划金额的<%=Formater.formatRate(caInfo.F17)%>作为退出费，归<%=configureProvider.getProperty(SystemVariable.SITE_NAME)%>所有。</div>
										</div>
									</div>
								</div>
							</li>
						</ul>
					</li>
				</ul>
				<div></div>
				<div class="fr m_invest w240 mt15">
					<form method="post" action="<%configureProvider.format(out,URLVariable.TB_YXLC);%>">
					<input type="hidden" id="yxId" name="yxId" value="<%=caInfo.F01%>">
					<input type="hidden" id="syMoney" name="syMoney" value="<%=caInfo.F04 == null ?0 : caInfo.F04%>">
					<input type="hidden" id="maxMoney" name="maxMoney" value="<%=caInfo.F23 == null ?0 : caInfo.F23%>">
					<input type="hidden" id="minMoney" name="minMoney" value="<%=caInfo.F22 == null ?0 : caInfo.F22%>">
					<input type="hidden" id="yxlcSucc" name="yxlcSucc" value="<%configureProvider.format(out, URLVariable.USER_YXLC);%>">
					<input type="hidden" id="yxlcSqz" name="yxlcSqz" value="<%configureProvider.format(out, URLVariable.USER_YXLC_SQZ);%>">
					
						<div class="text">
							剩余金额<br /> <em class="f20"> <%=Formater.formatAmount(caInfo.F04)%></em>元
						</div>
						<div class="text mb20 clearfix">
							<span class="f12 fl mr15"><em>每人可加入金额上限</em><br /> <em class="f16"><%=Formater.formatAmount(caInfo.F23)%></em>元</span> 
							
							<%
								if(!(dimengSession==null || !dimengSession.isAuthenticated())){
									UserInfoManage userInfoManage = serviceSession.getService(UserInfoManage.class);
									T6101 userInfo= userInfoManage.search();
							%>								
							
							<span class="f12 fl"><em>可用金额（<a href="<%configureProvider.format(out,URLVariable.USER_CHARGE);%>" class="blue">充值</a>）
							</em><br />
							<em class="f16"><%=Formater.formatAmount(userInfo.F06)%></em>元
							<input type="hidden" id="kyMoney" name="kyMoney" value="<%=userInfo.F06%>">
							</span>
							<%}else{%>
							<span class="f12 fl"><em>可用金额</em><br />
								<em><a href="<%configureProvider.format(out, URLVariable.LOGIN);%>" class="blue">登录</a>后可见</em>
							</span>
							<%}%>
						</div>
						<div class="text">
							<div class="yuan">元</div>
							<input name="gmMoney" maxlength="10" type="text" class="input_border w240" id="gmMoney" value="" onKeyUp="value=(parseInt((value=value.replace(/\D/g,''))==''?'0':value,10))"/>
							<p>不低于<%=Formater.formatAmount(caInfo.F22)%>元</p>
							
							
							
					<%if(caInfo.F07 == T6410_F07.YFB && caInfo.F09.after(caInfo.currentTime)){%>
							<p class="mt15">
								<i class="btn02">敬请期待</i>
							</p>
				<%}else if(caInfo.F07 == T6410_F07.YFB && !(caInfo.F09.after(caInfo.currentTime))){
						if(!(dimengSession==null || !dimengSession.isAuthenticated())){
							UserInfoManage userInfoManage = serviceSession.getService(UserInfoManage.class);
								String isYuqi =  userInfoManage.isYuqi();		
								BigDecimal tzMoney =  service.tzMoney(caInfo.F01);	
					%>
						<input type="hidden" id="isYuqi" name="isYuqi" value="<%=isYuqi%>">
						<input type="hidden" id="tzMoney" name="tzMoney" value="<%=tzMoney%>">
						<input type="hidden" id="jrfl" name="jrfl" value="<%=caInfo.F15%>">
						<input type="hidden" id="charge" name="charge" value="<%configureProvider.format(out,URLVariable.USER_CHARGE);%>">
							<p class="mt15">
								<button type="button" id="tbButton"  style="cursor: pointer;" class="btn01">申 请</button>
							</p>
					<%
						}else {
					%>
							<p class="mt15">
								<a href="<%configureProvider.format(out, URLVariable.LOGIN);%>" class="btn01">申 请 </a>
							</p>
					<%
						}
					}else if(caInfo.F07 == T6410_F07.YJZ ){
				%>
					<p class="mt15">
						<i class="btn02">已截止</i>
					</p>
				<%
					}else if(caInfo.F07 == T6410_F07.YSX){
				%>
						<p class="mt15">
							<i class="btn02">已满额</i>
						</p>
				<%
					}
				%>
							
							
						</div>
					</form>
				</div>
			</div>
		</div>
		<%
		YxlcCount fpCount=service.getStatistics();
		%>
		<div class="contain_main clearfix">
	       <div class="pub_title clearfix">
	          <span class="fl">投资效果</span>
	          <span class="fr f14"><a href="<%=controller.getViewURI(request, Yxlb.class) %>" class="blue">查看往期优选理财计划 &gt;&gt;</a></span>
	       </div>
        <div class="targeting">
        	<%if(fpCount != null ){ %>
				<ul>
					<li>
						<p>
							<i class="icons_bj iterm_ico01"></i>累计总金额
						</p>
						<p>
						<%if(fpCount.totleMoney.doubleValue()>=100000000){%>
			        	   <em class="f20"><%=Formater.formatAmount(fpCount.totleMoney.doubleValue()/100000000)%></em>亿元
			        	<%}else if(fpCount.totleMoney.doubleValue()>=10000 && fpCount.totleMoney.doubleValue() <100000000){%>
			        		<em class="f20"><%=Formater.formatAmount(fpCount.totleMoney.doubleValue()/10000)%></em>万元
			        	<%}else{%>
			        		<em class="f20"><%=Formater.formatAmount(fpCount.totleMoney)%></em>元
			        	<%}%>
						</p>
					</li>
					<li>
						<p>
							<i class="icons_bj iterm_ico02"></i>加入总人次
						</p>
						<p>
							<em class="f20"><%=fpCount.joinCount%></em>次
						</p>
					</li>
					<li>
						<p>
							<i class="icons_bj iterm_ico03"></i>资金利用率
						</p>
						<p>
							<em class="f20"><%=Formater.formatRate(fpCount.moneyUse)%></em>
						</p>
					</li>
					<li>
						<p>
							<i class="icons_bj iterm_ico05"></i>为用户累计赚取
						</p>
						<p>
							<%if(fpCount.userEarnMoney.doubleValue()>=100000000){%>
				        	   <em class="f20"><%=Formater.formatAmount(fpCount.userEarnMoney.doubleValue()/100000000)%></em>亿元
				        	<%}else if(fpCount.userEarnMoney.doubleValue()>=10000 && fpCount.userEarnMoney.doubleValue() <100000000){%>
				        		<em class="f20"><%=Formater.formatAmount(fpCount.userEarnMoney.doubleValue()/10000)%></em>万元
				        	<%}else{%>
				        		<em class="f20"><%=Formater.formatAmount(fpCount.userEarnMoney)%></em>元
				        	<%}%>
						</p>
					</li>
				</ul>
				<%}else{ %>
				<ul>
					<li>
						<p>
							<i class="icons_bj iterm_ico01"></i>累计总金额
						</p>
						<p><em class="f20">0</em>元
						</p>
					</li>
					<li>
						<p>
							<i class="icons_bj iterm_ico02"></i>加入总人次
						</p>
						<p>
							<em class="f20">0</em>次
						</p>
					</li>
					<li>
						<p>
							<i class="icons_bj iterm_ico03"></i>资金利用率
						</p>
						<p>
							<em class="f20">0%</em>
						</p>
					</li>
					<li>
						<p>
							<i class="icons_bj iterm_ico05"></i>为用户累计赚取
						</p>
						<p>
							<em class="f20">
							<em class="f20">0</em>元
							</em>
						</p>
					</li>
				</ul>
				<%}%>
			</div>
   </div>
		
		
		<div class="contain_main clearfix plan_intr">
			<div class="w620 fl">
				<div class="pub_title">计划介绍</div>
				<div class="pt10"><%StringHelper.filterHTML(out, caInfo.F18); %></div>
				<div class="pt20">
					<a target="_blank" href="<%=controller.getPagingItemURI(request, Term.class, TermType.YXLCXY.name())%>" class="blue">点此查看计划说明书 &gt;&gt;</a>
				</div>
			</div>
		</div>
	</div>
<div class="popup_bg"  style="display: none;"></div>
<div class="dialog d_error w510" id="gmDialog" style="margin:-150px 0 0 -255px; display: none;" >
	<div class="dialog_close fr"><a></a></div>
    <div class="con clearfix">
      <div class="d_succeed fl"></div>
      <div class="info fr">
          <p class="f20 gray33">购买确认</p>
          	您此次购买金额为<i class="red"><span id="zxMoney"></span></i>元，加入费为<i class="red"><span id="jrfMoney"></span></i>元，总需为<i class="red"><span id="zgxMoney"></span></i>确认购买？
      </div>  
      <div class="clear" ></div>    
      <div class="dialog_btn"><a href="javascript:void(0)" id="ok" class="btn btn01">确 定</a><a href="javascript:void(0)" id="cancel" class="btn btn05">取 消</a></div> 
    </div>
</div>


<div id="info"></div>
<%@include file="/WEB-INF/include/footer.jsp"%>
<%@include file="/WEB-INF/include/script.jsp"%>
	
	<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/financing/yxlc.js"></script>
	<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/dialog.js"></script>

	<%
		String message = controller.getPrompt(request, response , PromptLevel.INFO);
			if (!StringHelper.isEmpty(message)) {
				if(caInfo.F07 == T6410_F07.YSX){
	%>
	<script type="text/javascript">
		$("#info").html(showSuccInfo("<%=message%>","succeed",$("#yxlcSucc").val()));	
		$("div.popup_bg").show();
	</script>
	<%}else{%>
	<script type="text/javascript">
		alert($("#yxlcSqz").val())
		$("#info").html(showSuccInfo("<%=message%>","succeed",$("#yxlcSqz").val()));	
		$("div.popup_bg").show();
	</script>
	<%}}%>
	
	<%
		String errorMessage = controller.getPrompt(request, response , PromptLevel.ERROR);
			if (!StringHelper.isEmpty(errorMessage)) {
				
	%>
	<script type="text/javascript">
		$("#info").html(showDialogInfo("<%=errorMessage%>","error"));	
		$("div.popup_bg").show();
	</script>
	<%
		}
	%>
	
	<%
		String warnMessage = controller.getPrompt(request, response , PromptLevel.WARRING);
			if (!StringHelper.isEmpty(warnMessage)) {
	%>
	<script type="text/javascript">
		$("#info").html(showDialogInfo("<%=warnMessage%>","perfect"));	
		$("div.popup_bg").show();
	</script>
	<%
		}
	%>

</body>



</html>


