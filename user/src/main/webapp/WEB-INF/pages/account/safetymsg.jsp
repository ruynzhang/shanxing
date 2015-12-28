<%@page import="com.dimeng.p2p.S61.enums.T6118_F04"%>
<%@page import="com.dimeng.p2p.S61.enums.T6141_F04"%>
<%@page import="com.dimeng.p2p.account.user.service.entity.Safety"%>
<%@page import="com.dimeng.p2p.account.user.service.SafetyManage"%>
<%@page import="com.dimeng.p2p.user.servlets.account.*"%>
<%@include file="/WEB-INF/include/authenticatedSession.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title><%=configureProvider.getProperty(SystemVariable.SITE_NAME)%></title>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<%
	
		CURRENT_CATEGORY = "ZHGL";
		CURRENT_SUB_CATEGORY = "AQXX";
		SafetyManage userManage = serviceSession.getService(SafetyManage.class);
		Safety data = userManage.get();
		String a = data.phoneNumber;
		int userId=serviceSession.getSession().getAccountId();
		String phonenumber =StringHelper.isEmpty(a) || a.length() != 11 ? "" : a.substring(0,3)+"*****"+a.substring(7,a.length());
	%>
	<div class="contain clearfix">
		<div class="user_top"></div>
		<div class="about">
			<%@include file="/WEB-INF/include/menu.jsp"%>
			<div class="container fr bor1">
				<div class="p15">
					<p class="title1"><b>个人信息</b></p>
					<%--
					<ul class="xx_li" id="kjd">
						<li style="text-align: center;color: red;">
						实名认证包括身份证、邮箱和提现密码认证，认证完自动跳转到肾6抽奖页面
						</li>
					</ul>
					 --%>
					<%String ermsg = controller.getPrompt(request, response,PromptLevel.ERROR);if(!StringHelper.isEmpty(ermsg)){ %>
					<ul class="xx_li" id="kjd">
						<li style="text-align: center;color: red;">
						<%StringHelper.filterHTML(out, ermsg);%>
						</li>
					</ul>
					<%}%>
					<ul class="xx_li">
						<li><span class="xx_ico1 mr40"></span>
							<div class="til">昵称</div>
							<div class="info"><%StringHelper.filterHTML(out, data.username);%></div>
							<div class="tir"></div>
							<div class="clear"></div>
						</li>
						<li>
						
						<%
						if(!StringHelper.isEmpty(data.isIdCard) && data.isIdCard.equals(T6141_F04.TG.name())){ %>
							<span class="xx_ico3 mr40"></span>
							<div class="til">实名认证</div>
							<div class="info"><%StringHelper.filterHTML(out, data.idCard);   %></div>
							<div class="tir">
								<a href="javascript:void(-1);" class="gray"><%=data.name.substring(0,1)+"**" %></a>
							</div>

							<script type="text/javascript">
							var _orderno="<%=userId%>";  //替换此处!;
							var b=location.href,c=d.referrer,f,s,g=d.cookie,h=g.match(/(^|;)\s*ipycookie=([^;]*)/),i=g.match(/(^|;)\s*ipysession=([^;]*)/);if (w.parent!=w){f=b;b=c;c=f;};u='//stats.ipinyou.com/cvt?a='+e('Vc.vB.pBiedqM2ajjdiPBaU78Ve0')+'&c='+e(h?h[2]:'')+'&s='+e(i?i[2].match(/jump\%3D(\d+)/)[1]:'')+'&u='+e(b)+'&r='+e(c)+'&rd='+(new Date()).getTime()+'&OrderNo='+e(_orderno)+'&e=';
	                        function _(){if(!d.body){setTimeout(_(),100);}else{s= d.createElement('script');s.src = u;d.body.insertBefore(s,d.body.firstChild);}}_();
							(window,document,encodeURIComponent);
							</script>

						<%}else{%>
						<form action="<%=controller.getURI(request, UpdateName.class)%>" class="form1" method="post">
						<span class="xx_ico2 mr40"></span>
							<div class="til">实名认证</div>
							<div class="info">
								<span class="red">未设置</span>
							</div>
							<div class="tir">
								<a href="javascript:void(0);"
									onclick="openShutManager(this,'box1',false,'取消设置','设置')"
									class="blue">设置</a>
							</div>
							<div class="clear"></div>
							<div id="box1" style="display: none" class="mt15">
									<ul class="tou_li">
										<li>
											<div class="til">
												<span class="red">*</span>真实姓名：
											</div>
											<div class="info">
												<input type="text" name="name" class="text yhgl_ser w200 required" mtest="/^[\u4e00-\u9fa5]{2,}$/" mtestmsg="请输入合法的姓名"/>
												<p tip></p>
												<p errortip class="" style="display: none"></p>
											</div>
											<div class="clear"></div>
										</li>
										<li>
											<div class="til">
												<span class="red">*</span>身份证号：
											</div>
											<div class="info">
												<input type="text" name="idCard" class="text yhgl_ser w200 required idcard" />
												<p tip></p>
												<p errortip class="" style="display: none"></p>
											</div>
											<div class="clear"></div>
										</li>
										<li>
											<div class="til">&nbsp;</div>
											<div class="info">
												<input name="input" type="submit" value="提 交" fromname="form1" class="btn01 sumbitForme" />
											</div>
											<div class="clear"></div>
										</li>
									</ul>
							</div>
							</form>
						<%}%>
						<div class="clear"></div>
						</li>
						<li><span class="xx_ico3 mr40"></span>
							<div class="til">登录密码</div>
							<% String type="设置";
							if(!StringHelper.isEmpty(data.password)){ type="修改";%>
							<div class="info">已设置</div>
							<%}else{ type="设置";%><div class="info red">未设置</div><%} %>
							<div class="tir">
								<a href="javascript:void(0);" onclick="openShutManager(this,'box2',false,'取消<%=type%>','<%=type%>')"
									class="blue"><%=type%></a>
							</div>
							<div class="clear"></div>
							<form action="<%=controller.getURI(request, UpdatePassword.class)%>" class="form2" method="post">
							<div id="box2" style="display: none" class="mt15">
								<ul class="tou_li">
									<li>
										<div class="til">
											<span class="red">*</span> 原密码：
										</div>
										<div class="info">
											<input type="password" name="old" maxlength="20" class="text yhgl_ser w200 required min-length-6" />
											<p tip></p>
											<p errortip class="" style="display: none"></p>
										</div>
										<div class="clear"></div>
									</li>
									<li>
										<div class="til">
											<span class="red">*</span>新密码：
										</div>
										<div class="info">
											<input type="password" name="new" fromname="form2"  class="text yhgl_ser w200 required password-a min-length-6 max-length-20" />
											<p tip></p>
											<p errortip class="" style="display: none"></p>
										</div>
										<div class="clear"></div>
									</li>
									<li>
										<div class="til">
											<span class="red">*</span>确认新密码：
										</div>
										<div class="info">
											<input type="password" name="news" class="text yhgl_ser w200 required password-b min-length-6 max-length-20" />
											<p tip></p>
											<p errortip class="" style="display: none"></p>
										</div>
										<div class="clear"></div>
									</li>
									<li>
										<div class="til">&nbsp;</div>
										<div class="info">
											<input name="submit" type="submit" value="提 交" fromname="form2" class="btn01 sumbitForme" />
										</div>
										<div class="clear"></div>
									</li>
								</ul>
							</div>
							</form>
						</li>
						<li><span class="xx_ico4 mr40"></span>
							<div class="til">绑定邮箱</div>
							<%String emil="";if(!StringHelper.isEmpty(data.isEmil) && data.isEmil.equals(T6118_F04.TG.name())){ type="修改";emil=data.emil.substring(0,1)+"*****"+data.emil.split("@")[1];%>
							<div class="info"><%=emil%></div>
							<%}else{ type="设置";%><div class="info red">未设置</div><%} %>
							<div class="tir">
								<a href="javascript:void(0);"
									onclick="openShutManager(this,'box3',false,'取消<%=type%>','<%=type%>')"
									class="blue"><%=type%></a>
							</div>
							<div class="clear"></div>
							<div id="box3" style="display: none" class="mt15">
								<ul class="tou_li" id="mt1" <%if(type.equals("设置")){ %>style="display: none"<%} %>>
									<li class="tc">您正在修改的绑定邮箱是<span class="red"><%=emil %></span></li>
									<li>
										<div class="xx_w250">
											<div class="w100 fl mr30">
												<a href="javascript:void(0);" class="xx_ico7"></a>
												<p>
													<a href="javascript:void(0);">通过原邮箱修改</a>
												</p>
											</div>
											<div class="w100 fr">
												<a href="javascript:void(0);" class="xx_ico8 ml10"></a>
												<p>
													<a href="javascript:void(0);">通过手机号码修改</a>
												</p>
											</div>
										</div>
										<div class="clear"></div>
									</li>
								</ul>
								
								<ul class="tou_li" id="e1" style="display: none">
									<li style="margin-bottom: 0"><div class="xx_lc01"></div></li>
									<li class="tc"><div class="fl xx_w1 blue">1.验证当前邮箱</div>
										<div class="fl xx_w2">2.验证新邮箱</div>
										<div class="fl xx_w3">3.成功</div>
										<div class="clear"></div></li>
									<li>
										<div class="til">
											<span class="red">*</span> 验证邮箱：
										</div>
										<div class="info"><%=emil%></div>
										<div class="clear"></div>
									</li>
									<li>
										<div class="til">
											<span class="red">*</span>验证码：
										</div>
										<div class="info">
											<input type="text" class="text yhgl_ser w150 fl mr10 code"/>
											<input type="button" onclick="eupdate(this);" value="获取验证码" class="btn03" />
											<p tip></p>
											<p errortip class="" style="display: none"></p>
										</div>
										<div class="clear"></div>
									</li>
									<li>
										<div class="til">&nbsp;</div>
										<div class="info">
											<input name="input" type="button"  value="下一步" checktype="oldone" class="btn01 coden" />
										</div>
										<div class="clear"></div>
									</li>
									<li class="tc">为保障您的账户信息安全，在变更重要信息时需要进行验证。</li>
								</ul>
								
								<ul class="tou_li" id="e2" style="display: none">
									<li style="margin-bottom: 0"><div class="xx_lc02"></div></li>
									<li class="tc"><div class="fl xx_w1 blue">1.验证当前邮箱</div>
										<div class="fl xx_w2 blue">2.验证新邮箱</div>
										<div class="fl xx_w3">3.成功</div>
										<div class="clear"></div>
									<li>
										<div class="til">验证邮箱：</div>
										<div class="info">
											<input type="text" class="text yhgl_ser w150 fl mr10 sendemil" maxlength="26"/>
											<p tip></p>
											<p errortip class="" style="display: none"></p>
										</div>
										<div class="clear"></div>
									</li>
									<li>
										<div class="til">
											<span class="red">*</span>验证码：
										</div>
										<div class="info">
											<input type="text" class="text yhgl_ser w150 fl mr10 code" />
											<input name="input" type="button" value="获取验证码" class="btn03 emilsend" />
											<p tip></p>
											<p errortip class="" style="display: none"></p>
										</div>
										<div class="clear"></div>
									</li>
									<li>
										<div class="til">&nbsp;</div>
										<div class="info">
											<input name="input" type="button" value="下一步" checktype="newtwo" class="btn01 coden" />
										</div>
										<div class="clear"></div>
									</li>
									<li class="tc">为保障您的账户信息安全，在变更重要信息时需要进行验证。</li>
								</ul>
								
								<ul class="tou_li " id="e3" style="display: none">
									<li style="margin-bottom: 0"><div class="xx_lc03"></div></li>
									<li class="tc"><div class="fl xx_w1 blue">1.验证当前邮箱</div>
										<div class="fl xx_w2 blue">2.验证新邮箱</div>
										<div class="fl xx_w3 blue">3.成功</div>
										<div class="clear"></div>
									<li class="tc ln30 orange f16">恭喜您，已经成功绑定您的新邮箱！<br>
									<p></p>
									</li>
								</ul>
								
								<ul class="tou_li" id="ep1"  style="display: none">
									<li style="margin-bottom: 0"><div class="xx_lc01"></div></li>
									<li class="tc"><div class="fl xx_w1 blue">1.验证原手机号码</div>
										<div class="fl xx_w2">2.验证新邮箱</div>
										<div class="fl xx_w3">3.成功</div>
										<div class="clear"></div></li>
									<li>
										<div class="til">原手机号码：</div>
										<div class="info"><%=phonenumber%></div>
										<div class="clear"></div>
									</li>
									<li>
										<div class="til">
											<span class="red">*</span>手机验证码：
										</div>
										<div class="info">
											<input type="text" class="text yhgl_ser w150 fl mr10 code" />
											<input name="input" type="button" value="获取验证码" onclick="epupdate(this);"  class="btn03" />
											<p tip></p>
											<p errortip class="" style="display: none"></p>
										</div>
										<div class="clear"></div>
									</li>
									<li>
										<div class="til">&nbsp;</div>
										<div class="info">
											<input name="input" type="button" value="下一步" checktype="epoldone" class="btn01 coden" />
										</div>
										<div class="clear"></div>
									</li>
								</ul>
								
								<ul class="tou_li" id="ep2"  style="display: none">
									<li style="margin-bottom: 0"><div class="xx_lc02"></div></li>
									<li class="tc">
										<div class="fl xx_w1 blue">1.验证原手机号码</div>
										<div class="fl xx_w2 blue">2.验证新邮箱</div>
										<div class="fl xx_w3">3.成功</div>
										<div class="clear"></div>
									<li>
										<div class="til">验证新邮箱：</div>
										<div class="info">
											<input type="text" class="text yhgl_ser w150 fl mr10 sendemil" maxlength="26"/>
											<p tip></p>
											<p errortip class="" style="display: none"></p>
										</div>
										<div class="clear"></div>
									</li>
									<li>
										<div class="til">
											<span class="red">*</span>验证码：
										</div>
										<div class="info">
											<input type="text" class="text yhgl_ser w150 fl mr10 code" />
											<input name="input" type="button" value="获取验证码" class="btn03 emilsend" />
											<p tip></p>
											<p errortip class="" style="display: none"></p>
										</div>
										<div class="clear"></div>
									</li>
									<li>
										<div class="til">&nbsp;</div>
										<div class="info">
											<input name="input" type="button" value="下一步" checktype="epnewtwo" class="btn01 coden" />
										</div>
										<div class="clear"></div>
									</li>
								</ul>
								
								<ul class="tou_li" id="ep3"  style="display: none">
									<li style="margin-bottom: 0"><div class="xx_lc03"></div></li>
									<li class="tc"><div class="fl xx_w1 blue">1.验证原手机号码</div>
										<div class="fl xx_w2 blue">2.验证新邮箱</div>
										<div class="fl xx_w3 blue">3.成功</div>
										<div class="clear"></div>
									<li class="tc ln30 orange f16">恭喜您，已经成功绑定您的新邮箱！<br><p></p>
									</li>
								</ul>
								<form action="<%=controller.getURI(request, BindEmil.class)%>" method="post" class="form3">
							 	<ul class="tou_li" <%if(type.equals("修改")){ %>style="display: none"<%} %>>
									<li>
				                        <div class="til">邮箱： </div>
                        				<div class="info">
                        				<input name="bemil" type="text" class="text yhgl_ser w150 fl mr10 required e-mail" maxlength="26"/>
                        				<p tip></p>
										<p errortip class="" style="display: none"></p>
                        				</div>
                       					 <div class="clear"></div> 
				                    </li>
				                    <li>
				                        <div class="til"><span class="red">*</span>验证码：</div>
				                        <div class="info">
				                        <input name="bemilCode" type="text" class="text yhgl_ser w150 fl mr10 required" />
				                        <input name="input" type="button" onclick="bandEmil(this)" value="获取验证码" class="btn03"/>
				                        <p tip></p>
										<p errortip class="" style="display: none"></p>
				                        </div>
				                        <div class="clear"></div> 
				                   </li>
				                   <li>
				                        <div class="til">&nbsp;</div>
				                        <div class="info"><input name="input" type="submit" fromname="form3"  value="提交" class="btn01 sumbitForme"/></div>
				                        <div class="clear"></div> 
				                   </li>
			                    </ul>
			                    </form>
								
								
							</div>
						</li>
						<li><span class="xx_ico5 mr40"></span>
							<div class="til">绑定手机</div>
							<%String phone="";if(!StringHelper.isEmpty(data.phoneNumber)){ type="修改";phone=phonenumber;%>
							<div class="info"><%=phone%></div>
							<%}else{ type="设置";%><div class="info red">未设置</div><%} %>
							<div class="tir">
								<a href="javascript:void(0);"
									onclick="openShutManager(this,'box4',false,'取消<%=type%>','<%=type%>')"
									class="blue"><%=type%></a>
							</div>
							<div class="clear"></div>
							<div id="box4" style="display: none" class="mt15">
								<div class="xx_txmm" id="pr1" style="display: none">
									<p class="mb20">
										<span class="xx_ts"></span><span class="f20">请先设置提现密码。</span>
									</p>
									<div class="clear"></div>
									<input name="input" type="button" onclick="localch('pr1');" value="返 回" class="btn01"
										style="margin: auto" />
								</div>
								<div class="xx_txmm" id="pr2" style="display: none">
									<p class="mb20">
										<span class="xx_ts"></span><span class="f20">请先设置实名认证。</span>
									</p>
									<div class="clear"></div>
									<input name="input" type="button" value="返 回" onclick="localch('pr2');" class="btn01"
										style="margin: auto" />
								</div>
								
								 <ul class="tou_li" id="mt2" <%if(type.equals("设置")){ %>style="display: none"<%} %>>
				                   <li class="tc">您正在修改的绑定手机号是<span class="red"><%=phone%></span></li>
				                   <li>
				                   		<div class="xx_w250">
				                        <div class="w100 fl"><a href="javascript:void(0);" class="xx_ico9"></a><p><a href="javascript:void(0);">通过原手机短信修改</a></p></div>
				                  		<div class="w100 fr"><a href="javascript:void(0);" class="xx_ico10"></a><p><a href="javascript:void(0);">通过身份证修改</a></p></div>
				                        </div>
				                        <div class="clear"></div> 
				                   </li>
			                     </ul>
								
								<ul class="tou_li" id="p1" style="display: none">
									<li style="margin-bottom: 0"><div class="xx_lc01"></div></li>
									<li class="tc">
										<div class="fl xx_w1 blue">1.验证原手机号码</div>
										<div class="fl xx_w2">2.验证新手机号码</div>
										<div class="fl xx_w3">3.成功</div>
										<div class="clear"></div>
									</li>
									<li>
										<div class="til">原手机号码：</div>
										<div class="info"><%=phone%></div>
										<div class="clear"></div>
									</li>
									<li>
										<div class="til">
											<span class="red">*</span>手机号验证码：
										</div>
										<div class="info">
											<input type="text" class="text yhgl_ser w150 fl mr10 code" />
											<input name="input" type="button" value="获取验证码" onclick="pupdate(this);" class="btn03" />
											<p tip></p>
											<p errortip class="" style="display: none"></p>
										</div>
										<div class="clear"></div>
									</li>
									<li>
										<div class="til">&nbsp;</div>
										<div class="info">
											<input name="input" type="button" value="下一步" checktype="poldone" class="btn01 coden" />
										</div>
										<div class="clear"></div>
									</li>
									<li class="tc">为保障您的账户信息安全，在变更重要信息时需要进行验证。</li>
								</ul>
								<ul class="tou_li" id="p2" style="display: none">
									<li style="margin-bottom:0"><div class="xx_lc02"></div></li>
									<li class="tc">
										<div class="fl xx_w1 blue">1.验证原手机号码</div>
										<div class="fl xx_w2 blue">2.验证新手机号码</div>
										<div class="fl xx_w3">3.成功</div>
										<div class="clear"></div>
									<li class="tc">身份证号码验证已通过，请填写您的新手机号码。</li>
									<li>
										<div class="til">
											<span class="red">*</span>新手机号码 ：
										</div>
										<div class="info">
											<input type="text" class="text yhgl_ser w150 fl mr10 sendphone" />
											<p tip></p>
											<p errortip class="" style="display: none"></p>
										</div>
										<div class="clear"></div>
									</li>
									<li>
										<div class="til">
											<span class="red">*</span>手机验证码：
										</div>
										<div class="info">
											<input type="text" class="text yhgl_ser w150 fl mr10 code" />
											<input name="input" type="button" value="获取验证码" class="btn03 phonesend" />
											<p tip></p>
											<p errortip class="" style="display: none"></p>
										</div>
										<div class="clear"></div>
									</li>
									<li>
										<div class="til">&nbsp;</div>
										<div class="info">
											<input name="input" type="button" value="下一步" checktype="pnewtwo" class="btn01 coden" />
										</div>
										<div class="clear"></div>
									</li>
									<li class="tc">为保障您的账户信息安全，在变更重要信息时需要进行验证。</li>
								</ul>
								<ul class="tou_li" id="p3" style="display: none">
									<li style="margin-bottom: 0"><div class="xx_lc03"></div></li>
									<li class="tc">
										<div class="fl xx_w1 blue">1.验证原手机号码</div>
										<div class="fl xx_w2 blue">2.验证新手机号码</div>
										<div class="fl xx_w3 blue">3.成功</div>
										<div class="clear"></div>
									<li class="tc ln30 orange f16">恭喜您，已经成功绑定您的新手机号码！<br><p></p>
									</li>
								</ul>
								
								<ul class="tou_li" id="ip1" style="display: none">
									<li style="margin-bottom: 0"><div class="xx_lc01"></div></li>
									<li class="tc">
										<div class="fl xx_w1 blue">1.填写身份证号码</div>
										<div class="fl xx_w2">2.验证新手机号码</div>
										<div class="fl xx_w3">3.成功</div>
										<div class="clear"></div>
									</li>
									<li>
										<div class="til">账号昵称：</div>
										<div class="info"><%=data.username%></div>
										<div class="clear"></div>
									</li>
									<li>
										<div class="til">
											<span class="red">*</span>身份证号码：
										</div>
										<div class="info">
											<input type="text" class="text yhgl_ser w150 fl mr10" />
											<p tip></p>
											<p errortip class="" style="display: none"></p>
										</div>
										<div class="clear"></div>
									</li>
									<li>
										<div class="til">
											<span class="red">*</span>提现密码：
										</div>
										<div class="info">
											<input type="password" class="text yhgl_ser w150 fl mr10" />
											<p tip></p>
											<p errortip class="" style="display: none"></p>
										</div>
										<div class="clear"></div>
									</li>
									<li>
										<div class="til">&nbsp;</div>
										<div class="info">
											<input name="input" type="button" value="下一步" checktype="ipoldone" class="btn01 coden" />
										</div>
										<div class="clear"></div>
									</li>
									<li class="tc">为保障您的账户信息安全，在变更重要信息时需要进行验证。</li>
								</ul>
								<ul class="tou_li" id="ip2" style="display: none">
									<li style="margin-bottom: 0"><div class="xx_lc02"></div></li>
									<li class="tc">
										<div class="fl xx_w1 blue">1.填写身份证号码</div>
										<div class="fl xx_w2 blue">2.验证新手机号码</div>
										<div class="fl xx_w3">3.成功</div>
										<div class="clear"></div>
									<li class="tc">身份证号码验证已通过，请填写您的新手机号码。</li>
									<li>
										<div class="til">
											<span class="red">*</span>新手机号码 ：
										</div>
										<div class="info">
											<input type="text" class="text yhgl_ser w150 fl mr10 sendphone" />
											<p tip></p>
											<p errortip class="" style="display: none"></p>
										</div>
										<div class="clear"></div>
									</li>
									<li>
										<div class="til">
											<span class="red">*</span>手机验证码：
										</div>
										<div class="info">
											<input type="text" class="text yhgl_ser w150 fl mr10 code" />
											<input name="input" type="button" value="获取验证码"  class="btn03 phonesend" />
											<p tip></p>
											<p errortip class="" style="display: none"></p>
										</div>
										<div class="clear"></div>
									</li>
									<li>
										<div class="til">&nbsp;</div>
										<div class="info">
											<input name="input" type="button" value="下一步" checktype="ipnewtwo" class="btn01 coden" />
										</div>
										<div class="clear"></div>
									</li>
									<li class="tc">为保障您的账户信息安全，在变更重要信息时需要进行验证。</li>
								</ul>
								<ul class="tou_li" id="ip3" style="display: none">
									<li style="margin-bottom: 0"><div class="xx_lc03"></div></li>
									<li class="tc">
										<div class="fl xx_w1 blue">1.填写身份证号码</div>
										<div class="fl xx_w2 blue">2.验证新手机号码</div>
										<div class="fl xx_w3 blue">3.成功</div>
										<div class="clear"></div>
									<li class="tc ln30 orange f16">恭喜您，已经成功绑定您的新手机号码！<br><p></p>
									</li>
								</ul>
								
								<form action="<%=controller.getURI(request, BindPhone.class)%>" method="post" class="form12">
							 	<ul class="tou_li"  <%if(type.equals("修改")){ %>style="display: none"<%} %>>
									<li>
				                        <div class="til">手机号： </div>
                        				<div class="info">
                        				<input name="binphpne" type="text" class="text yhgl_ser w150 fl mr10 required phonenumber " />
                        				<p tip></p>
										<p errortip class="" style="display: none"></p>
                        				</div>
                       					 <div class="clear"></div> 
				                    </li>
				                    <li>
				                        <div class="til"><span class="red">*</span>验证码：</div>
				                        <div class="info">
				                        <input name="bphoneCode" type="text" class="text yhgl_ser w150 fl mr10 required" />
				                        <input name="input" type="button" onclick="bandPhone(this)" value="获取验证码" class="btn03"/>
				                        <p tip></p>
										<p errortip class="" style="display: none"></p>
				                        </div>
				                        <div class="clear"></div> 
				                   </li>
				                   <li>
				                        <div class="til">&nbsp;</div>
				                        <div class="info"><input name="input" type="submit" fromname="form12"  value="提交" class="btn01 sumbitForme"/></div>
				                        <div class="clear"></div> 
				                   </li>
			                    </ul>
			                    </form>
							</div>
							
							
							
							</li>
						<li><span class="xx_ico6 mr40"></span>
							<div class="til">提现密码</div>
							<%if(!StringHelper.isEmpty(data.txpassword)){%>
							<div class="info">已设置</div>
							<div class="tir">
								<a href="javascript:void(0);"onclick="openShutManager(this,'box6',false,'取消修改','修改')"
									class="blue">修改 &nbsp;|&nbsp;</a>
								<a href="javascript:void(0);"onclick="openShutManager(this,'box7',false,'取消找回','找回')"
									class="blue">找回</a>
							</div>
							<%}else{%>
							<div class="info red">未设置</div>
							<div class="tir">
							<a href="javascript:void(0);"onclick="openShutManager(this,'box5',false,'取消设置','设置')"
									class="blue">设置</a>
									</div>
							<%}%>
							<div class="clear"></div>
							<div id="box5" style="display: none" class="mt15">
								<%--设定密码--%>
								<form action="<%=controller.getURI(request, SettxPassword.class)%>" class="form4" method="post">
								<ul class="tou_li">
									<li style="margin-bottom: 0"></li>
									<li class="tc">为了您的账户安全，请定期更换提现密码，并确保提现密码设置与登录密码不同</li>
									<li>
										<div class="til">
											<span class="red">*</span>提现密码：<br />
										</div>
										<div class="info">
											<input type="password" maxlength="16" name="new" class="text yhgl_ser w150 fl mr10 required password-a"/>
											<p tip></p>
											<p errortip class="" style="display: none"></p>
											<div class="clear"></div>
										</div>
										<div class="clear"></div>
									</li>
									<li>
										<div class="til">
											<span class="red">*</span>重复密码：
										</div>
										<div class="info">
											<input type="password" maxlength="16" name="cnew" class="text yhgl_ser w150 fl mr10 required password-b" />
											<p tip></p>
											<p errortip class="" style="display: none"></p>
										</div>
										<div class="clear"></div>
									</li>
									<li>
										<div class="til">&nbsp;</div>
										<div class="info">
											<input name="input" type="submit" value="提 交" fromname="form4"  class="btn01 sumbitForme" />
										</div>
										<div class="clear"></div>
									</li>
								</ul>
								</form>
								
							</div>
							<div id="box6" style="display: none" class="mt15">
							
								<%--修改密码--%>
								<form action="<%=controller.getURI(request, UpdatetxPassword.class)%>" class="form5" method="post">
								<ul class="tou_li">
									<li style="margin-bottom: 0"></li>
									<li class="tc">为了您的账户安全，请定期更换提现密码，并确保提现密码设置与登录密码不同</li>
									<li>
										<div class="til">
											<span class="red">*</span>原提现密码：<br />
										</div>
										<div class="info">
											<input type="password" maxlength="20" name="old" class="text yhgl_ser w150 fl mr10 required " />
											<p tip></p>
											<p errortip class="" style="display: none"></p>
										</div>
										<div class="clear"></div>
									</li>
									<li>
										<div class="til">
											<span class="red">*</span>新提现密码：
										</div>
										<div class="info">
											<input type="password" maxlength="20" name="new" class="text yhgl_ser w150 fl mr10 required password-a" />
											<p tip></p>
											<p errortip class="" style="display: none"></p>
										</div>
										<div class="clear"></div>
									</li>
									<li>
										<div class="til">
											<span class="red">*</span>确认提现密码：
										</div>
										<div class="info">
											<input type="password" maxlength="20" name="cnew" class="text yhgl_ser w150 fl mr10 required password-b"  />
											<p tip></p>
											<p errortip class="" style="display: none"></p>
										</div>
										<div class="clear"></div>
									</li>
									<li>
										<div class="til">&nbsp;</div>
										<div class="info">
											<input name="input2" type="submit" fromname="form5"  value="提 交" class="btn01 sumbitForme" />
										</div>
										<div class="clear"></div>
									</li>
									<li class="tc">如果您在操作过程中出现问题，请点击页面顶侧在线客服，或拨打<%=configureProvider.getProperty(SystemVariable.SITE_NAME) %>客服电话：<%=configureProvider.getProperty(SystemVariable.SITE_CUSTOMERSERVICE_TEL)  %></li>
								</ul>
								</form>
							
							</div>
							
							
							<div id="box7" style="display: none" class="mt15">
							<%--找回密码--%>
								<ul class="tou_li" id="ps1">
									<%if(!StringHelper.isEmpty(phonenumber)){ %>
									<li style="margin-bottom: 0"><div class="xx_lc01"></div></li>
									<li class="tc">
										<div class="fl xx_w1 blue">1.验证手机号码</div>
										<div class="fl xx_w2">2.重设提现密码</div>
										<div class="fl xx_w3">3.成功</div>
										<div class="clear"></div>
									<li>
										<div class="til">原手机号码 ：</div>
										<div class="info"><%=phonenumber%></div>
										<div class="clear"></div>
									</li>
									<li>
										<div class="til">
											<span class="red">*</span>手机验证码：
										</div>
										<div class="info">
											<input type="text" class="text yhgl_ser w150 fl mr10 code" />
											<input name="input" type="button" value="获取验证码" onclick="getoldcode(this);" class="btn03" />
											<p tip></p>
											<p errortip class="" style="display: none"></p>
										</div>
										<div class="clear"></div>
									</li>
									<li>
										<div class="til">&nbsp;</div>
										<div class="info">
											<input name="input" type="button" value="下一步"  checktype="pswone" class="btn01 coden" />
										</div>
										<div class="clear"></div>
									</li>
									<%}else{ %>
										<li style="margin-left: 200px;color: red;">请先绑定手机，才能找回提现密码!</li>
									<%} %>
								</ul>
								<ul class="tou_li" id="ps2" style="display: none">
									<li style="margin-bottom: 0"><div class="xx_lc02"></div></li>
									<li class="tc">
										<div class="fl xx_w1 blue">1.验证手机号码</div>
										<div class="fl xx_w2 blue">2.重设提现密码</div>
										<div class="fl xx_w3">3.成功</div>
										<div class="clear"></div>
									<li>
										<div class="til">
											<span class="red">*</span>输入新提现密码：
										</div>
										<div class="info">
											<input type="password" maxlength="20" class="text yhgl_ser w150 fl mr10" />
											<p tip></p>
											<p errortip class="" style="display: none"></p>
										</div>
										<div class="clear"></div>
									</li>
									<li>
										<div class="til">
											<span class="red">*</span>再次输入新提现密码：
										</div>
										<div class="info">
											<input type="password" maxlength="20" class="text yhgl_ser w150 fl mr10" />
											<p tip></p>
											<p errortip class="" style="display: none"></p>
										</div>
										<div class="clear"></div>
									</li>
									<li>
										<div class="til">&nbsp;</div>
										<div class="info">
											<input name="input" type="button" value="下一步" checktype="pswtwo" class="btn01 coden" />
										</div>
										<div class="clear"></div>
									</li>
								</ul>
								<ul class="tou_li" id="ps3" style="display: none">
									<li style="margin-bottom: 0"><div class="xx_lc03"></div></li>
									<li class="tc">
										<div class="fl xx_w1 blue">1.验证手机号码</div>
										<div class="fl xx_w2 blue">2.重设提现密码</div>
										<div class="fl xx_w3 blue">3.成功</div>
										<div class="clear"></div>
									</li>
									<li class="tc ln30 orange f16">恭喜您，已经成功修改您的提现密码！</li>
								</ul>
							</div>
							</li>
							<li><span class="xx_ico3 mr40"></span>
								<div class="til">联系地址</div>
								<%if(!StringHelper.isEmpty(data.address)){%>
								<div class="info">已设置</div>
								<div class="tir">
									<a href="javascript:void(0);"onclick="openShutManager(this,'box8',false,'取消修改','修改')" class="blue">修改 </a>
								</div>
								<%}else{%>
								<div class="info red">未设置</div>
								<div class="tir">
								<a href="javascript:void(0);"onclick="openShutManager(this,'box8',false,'取消设置','设置')" class="blue">设置</a>
								</div>
								<%}%>
								<div class="clear"></div>
								<form action="<%=controller.getURI(request, UpdateAddress.class)%>" class="form6" method="post">
								<div id="box8" style="display: none" class="mt15">
									<ul class="tou_li">
										<li style="margin-bottom: 0"></li>
										<li class="tc">联系地址仅用于邮寄资料和礼品</li>
										<li>
											<div class="til">
												<span class="red">*</span> 联系地址：
											</div>
											<div class="info">
												<input type="text" name="address" maxlength="100" class="text yhgl_ser w200 required max-length-100">
												<p tip=""></p>
												<p errortip="" class="" style="display: none"></p>
											</div>
											<div class="clear"></div>
										</li>
										<li>
											<div class="til">
												<span class="red">*</span>邮编：
											</div>
											<div class="info">
												<input type="text" name="postcode" maxlength="6" class="text yhgl_ser w200 required postcode">
												<p tip=""></p>
												<p errortip="" class="" style="display: none"></p>
											</div>
											<div class="clear"></div>
										</li>
										<li>
											<div class="til">&nbsp;</div>
											<div class="info">
												<input name="submit" type="submit" value="提 交" fromname="form6" class="btn01 sumbitForme">
											</div>
											<div class="clear"></div>
										</li>
									</ul>
								</div>
								</form>
							</li>
					</ul>
				</div>
			</div>
			<div class="clear"></div>
		</div>
	</div>
	<script type="text/javascript">
		
	</script>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
	<script type="text/javascript"
		src="<%=controller.getStaticPath(request)%>/js/zhankai.js"></script>
	<script type="text/javascript"
		src="<%=controller.getStaticPath(request)%>/js/validation.js"></script>
	<script type="text/javascript">
	<%--绑定邮箱时--%>
	var wait = 180;
	<%--新邮箱时--%>
	var wait1 = 180;
	<%--手机修改邮箱时--%>
	var wait2 = 180;
	<%--绑定手机时--%>
	var wait3 = 180;
	<%--新手机时--%>
	var wait4 = 180;
	<%--找回提现密码时--%>
	var wait5 = 180;
	<%--修改邮箱时--%>
	var wait6 = 180;
	<%--修改手机时--%>
	var wait7 = 180;
		function bandEmil(evn){
			var bemil = $("input[name='bemil']");
			if(bemil.val().length<=0){
				$error = bemil.nextAll("p[errortip]");
				$tip = bemil.nextAll("p[tip]");
				$error.addClass("error_tip");
				$error.html("邮箱地址不正确！");
				$tip.hide();
				$error.show();
				return false;
			}
			var myreg = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,4}$/;
			if(!myreg.test(bemil.val()))
			{
				$error = bemil.nextAll("p[errortip]");
				$tip = bemil.nextAll("p[tip]");
				$error.addClass("error_tip");
				$error.html("邮箱地址不正确！");
				$tip.hide();
				$error.show();
				return false;
			}
			var data1={"evencheck":"emil","value":bemil.val()};
			$.ajax({
				type:"post",
				dataType:"html",
				url:"<%=controller.getURI(request, Check.class)%>",
				data:data1,
				success:function(data){
					if(data == "04"){
						$error = bemil.nextAll("p[errortip]");
						$tip = bemil.nextAll("p[tip]");
						$error.addClass("error_tip");
						$error.html("邮箱已存在！");
						$tip.hide();
						$error.show();
						return false;
					}else{
						var data3={"type":"band","emil":bemil.val(),"phone":""};
						$.ajax({
							type:"post",
							dataType:"html",
							url:"<%=controller.getURI(request, Send.class)%>",
							data:data3,
							success:function(data){
								if(data){
									var ct = eval('('+data+')');
									if(ct.length>0 && ct[0].num == 0){
										$error = bemil.nextAll("p[errortip]");
										$tip = bemil.nextAll("p[tip]");
										$error.addClass("error_tip");
										$error.html(ct[0].msg);
										$tip.hide();
										$error.show();
										return false;
									}
									if(ct.length>0 && ct[0].num == 1){
										sendclick(evn);
									}
								}
							}
						});
					}
				}
			});
		}
		function bandPhone(evn){
			var bemil = $("input[name='binphpne']");
			if(bemil.val().length<=0){
				$error = bemil.nextAll("p[errortip]");
				$tip = bemil.nextAll("p[tip]");
				$error.addClass("error_tip");
				$error.html("手机号码不正确！");
				$tip.hide();
				$error.show();
				return false;
				return false;
			}
			var myreg = /^(13|15|18|14|17)[0-9]{9}$/;
			if(!myreg.test(bemil.val()))
			{
				$error = bemil.nextAll("p[errortip]");
				$tip = bemil.nextAll("p[tip]");
				$error.addClass("error_tip");
				$error.html("手机号码不正确！");
				$tip.hide();
				$error.show();
				return false;
				return false;
			}
			
			var data1={"evencheck":"phone","value":bemil.val()};
			$.ajax({
				type:"post",
				dataType:"html",
				url:"<%=controller.getURI(request, Check.class)%>",
				data:data1,
				success:function(data){
					if(data == "04"){
						$error = bemil.nextAll("p[errortip]");
						$tip = bemil.nextAll("p[tip]");
						$error.addClass("error_tip");
						$error.html("手机已存在！");
						$tip.hide();
						$error.show();
						return false;
					}else{
						var data3={"type":"band","emil":"","phone":bemil.val()};
						$.ajax({
							type:"post",
							dataType:"html",
							url:"<%=controller.getURI(request, Send.class)%>",
							data:data3,
							success:function(data){
								var ct = eval('('+data+')');
								if(ct.length>0 && ct[0].num == 0){
									$error = bemil.nextAll("p[errortip]");
									$tip = bemil.nextAll("p[tip]");
									$error.addClass("error_tip");
									$error.html(ct[0].msg);
									$tip.hide();
									$error.show();
									return false;
								}
								if(ct.length>0 && ct[0].num == 1){
									sendclick3(evn);
								}
							}
						});
					}
				}
			});
		}
		function eupdate(evn){
			var bemil = "<%StringHelper.filterHTML(out, data.emil);%>";
			var data={"type":"update","emil":bemil,"phone":""};
			$.ajax({
				type:"post",
				dataType:"html",
				url:"<%=controller.getURI(request, Send.class)%>",
				data:data,
				success:function(data){
					if(data){
						var ct = eval('('+data+')');
						if(ct.length>0 && ct[0].num == 0){
							$error = $(evn).nextAll("p[errortip]");
							$tip = $(evn).nextAll("p[tip]");
							$error.addClass("error_tip");
							$error.html(ct[0].msg);
							$tip.hide();
							$error.show();
							return false;
						}
						if(ct.length>0 && ct[0].num == 1){
							sendclick6(evn);
						}
					}
				}
			});
		}
		
		function pupdate(evn){
			var phone = "<%StringHelper.filterHTML(out, data.phoneNumber);%>";
			var data={"type":"update","emil":"","phone":phone};
			$.ajax({
				type:"post",
				dataType:"html",
				url:"<%=controller.getURI(request, Send.class)%>",
				data:data,
				success:function(data){
					if(data){
						var ct = eval('('+data+')');
						if(ct.length>0 && ct[0].num == 0){
							$error = $(evn).nextAll("p[errortip]");
							$tip = $(evn).nextAll("p[tip]");
							$error.addClass("error_tip");
							$error.html(ct[0].msg);
							$tip.hide();
							$error.show();
							return false;
						}
						if(ct.length>0 && ct[0].num == 1){
							sendclick7(evn);
						}
					}
				}
			});
		}
		function getoldcode(evn){
			var phone = "<%StringHelper.filterHTML(out, data.phoneNumber);%>";
			var data={"type":"getoldpas","emil":"","phone":phone};
			$.ajax({
				type:"post",
				dataType:"html",
				url:"<%=controller.getURI(request, Send.class)%>",
				data:data,
				success:function(data){
					if(data){
						var ct = eval('('+data+')');
						if(ct.length>0 && ct[0].num == 0){
							$error = $(evn).nextAll("p[errortip]");
							$tip = $(evn).nextAll("p[tip]");
							$error.addClass("error_tip");
							$error.html(ct[0].msg);
							$tip.hide();
							$error.show();
							return false;
						}
						if(ct.length>0 && ct[0].num == 1){
							sendclick5(evn);
						}
					}
				}
			});
		}
		
		function epupdate(evn){
			var phone = "<%StringHelper.filterHTML(out, data.phoneNumber);%>";
			var data={"type":"phoneemil","emil":"","phone":phone};
			$.ajax({
				type:"post",
				dataType:"html",
				url:"<%=controller.getURI(request, Send.class)%>",
				data:data,
				success:function(data){
					if(data){
						var ct = eval('('+data+')');
						if(ct.length>0 && ct[0].num == 0){
							$error = $(evn).nextAll("p[errortip]");
							$tip = $(evn).nextAll("p[tip]");
							$error.addClass("error_tip");
							$error.html(ct[0].msg);
							$tip.hide();
							$error.show();
							return false;
						}
						if(ct.length>0 && ct[0].num == 1){
							sendclick2(evn);
						}
					}
				}
			});
		}
		
		$(".w100").click( function () {
			var ind = $(this).index(".w100");
			<%--通过邮箱修改邮箱--%>
			if(ind==0){
				$("#mt1").hide();
				$("#e1").show();
			}
			<%--通过手机号修改邮箱--%>
			if(ind==1){
				$("#mt1").hide();
				$("#ep1").show();
			}
			<%--通过手机号修改绑定手机--%>
			if(ind==2){
				$("#mt2").hide();
				$("#p1").show();
			}
			<%--通过身份证修改绑定手机--%>
			if(ind==3){
				$("#mt2").hide();
				$("#ip1").show();
			}
		});
		
		$(function(){
			$(".coden").click(function(){
				$intext =$('input[type="text"]');
				$inpassword =$('input[type="password"]');
				var type = $(this).attr("checktype");
				flgs = true;
				if(type=="oldone"){
					<%--通过旧邮箱修改邮箱 1--%>
					var $cli = $(this).parent().parent().prev();
					var code = $cli.children("div").eq(1).children("input").eq(0);
					if(code.val().length<=0){
						$error = code.nextAll("p[errortip]");
						$tip = code.nextAll("p[tip]");
						$error.addClass("error_tip");
						$error.html("请输入验证码！");
						$tip.hide();
						$error.show();
						return false;
					}
					var data={"evencheck":"emil","ctp":"eupdate","code":code.val()};
					$.ajax({
						type:"post",
						dataType:"html",
						url:"<%=controller.getURI(request, CheckCode.class)%>",
						data:data,
						success:function(data){
							if(data == "01"){
								$error = code.nextAll("p[errortip]");
								$tip = code.nextAll("p[tip]");
								$error.addClass("error_tip");
								$error.html("输入邮箱有误！");
								$tip.hide();
								$error.show();
								return false;
							}else if(data == "02"){
								$error = code.nextAll("p[errortip]");
								$tip = code.nextAll("p[tip]");
								$error.addClass("error_tip");
								$error.html("输入验证码有误！");
								$tip.hide();
								$error.show();
								return false;
							}else if(data == "03"){
								$error = code.nextAll("p[errortip]");
								$tip = code.nextAll("p[tip]");
								$error.addClass("error_tip");
								$error.html("验证码不正确！");
								$tip.hide();
								$error.show();
								return false;
							}else{
								$("#e1").hide();
								$("#e2").show();
							}
						}
					});
				}
				if(type=="newtwo"){
					<%--通过旧邮箱修改邮箱 2--%>
					var $cli = $(this).parent().parent().prev();
					var $eli = $(this).parent().parent().prev().prev();
					var emil = $eli.children("div").eq(1).children("input").eq(0);
					var code = $cli.children("div").eq(1).children("input").eq(0);
					
					var myreg = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,4}$/;
					if(!myreg.test(emil.val()))
					{
						$error = code.nextAll("p[errortip]");
						$tip = code.nextAll("p[tip]");
						$error.addClass("error_tip");
						$error.html("邮箱地址不正确！");
						$tip.hide();
						$error.show();
						return false;
					}
					if(code.val().length<=0){
						$error = code.nextAll("p[errortip]");
						$tip = code.nextAll("p[tip]");
						$error.addClass("error_tip");
						$error.html("请输入验证码！");
						$tip.hide();
						$error.show();
						return false;
					}
					
					var data={"evencheck":"emil","utp":"eupdate","ctp":"enew","value":emil.val(),"code":code.val()};
					$.ajax({
						type:"post",
						dataType:"html",
						url:"<%=controller.getURI(request, CheckNewCode.class)%>",
						data:data,
						success:function(data){
							if(data == "00"){
								$("#e1").show();
								$("#e2").hide();
								return false;
							}
							if(data == "01"){
								$error = code.nextAll("p[errortip]");
								$tip = code.nextAll("p[tip]");
								$error.addClass("error_tip");
								$error.html("输入邮箱有误！");
								$tip.hide();
								$error.show();
								return false;
							}else if(data == "02"){
								$error = code.nextAll("p[errortip]");
								$tip = code.nextAll("p[tip]");
								$error.addClass("error_tip");
								$error.html("输入验证码有误！");
								$tip.hide();
								$error.show();
								return false;
							}else if(data == "03"){
								$error = code.nextAll("p[errortip]");
								$tip = code.nextAll("p[tip]");
								$error.addClass("error_tip");
								$error.html("验证码不正确！");
								$tip.hide();
								$error.show();
								return false;
							}else if(data == "04"){
								$error = code.nextAll("p[errortip]");
								$tip = code.nextAll("p[tip]");
								$error.addClass("error_tip");
								$error.html("邮箱已存在！");
								$tip.hide();
								$error.show();
								return false;
							}else{
								$("#e2").hide();
								$("#e3").show();
								$("#e3").find("p").html(emil.val().substring(0,1)+"*****"+emil.val().split("@")[1]);
							}
						}
					});
				}if(type=="epoldone"){
					<%--通过手机修改邮箱 1--%>
					var $cli = $(this).parent().parent().prev();
					var code = $cli.children("div").eq(1).children("input").eq(0);
					if(code.val().length<=0){
						$error = code.nextAll("p[errortip]");
						$tip = code.nextAll("p[tip]");
						$error.addClass("error_tip");
						$error.html("请输入验证码！");
						$tip.hide();
						$error.show();
						return false;
					}
					var data={"evencheck":"phone","ctp":"pphoneemil","code":code.val()};
					$.ajax({
						type:"post",
						dataType:"html",
						url:"<%=controller.getURI(request, CheckCode.class)%>",
						data:data,
						success:function(data){
							if(data == "01"){
								$error = code.nextAll("p[errortip]");
								$tip = code.nextAll("p[tip]");
								$error.addClass("error_tip");
								$error.html("输入手机号！");
								$tip.hide();
								$error.show();
								return false;
							}else if(data == "02"){
								$error = code.nextAll("p[errortip]");
								$tip = code.nextAll("p[tip]");
								$error.addClass("error_tip");
								$error.html("输入验证码有误！");
								$tip.hide();
								$error.show();
								return false;
							}else if(data == "03"){
								$error = code.nextAll("p[errortip]");
								$tip = code.nextAll("p[tip]");
								$error.addClass("error_tip");
								$error.html("验证码不正确！");
								$tip.hide();
								$error.show();
								return false;
							}else{
								$("#ep1").hide();
								$("#ep2").show();
							}
						}
					});
				}
				if(type=="epnewtwo"){
					<%--通过手机修改邮箱 2--%>
					var $cli = $(this).parent().parent().prev();
					var $eli = $(this).parent().parent().prev().prev();
					var emil = $eli.children("div").eq(1).children("input").eq(0);
					var code = $cli.children("div").eq(1).children("input").eq(0);
					
					var myreg = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,4}$/;
					if(!myreg.test(emil.val()))
					{
						$error = code.nextAll("p[errortip]");
						$tip = code.nextAll("p[tip]");
						$error.addClass("error_tip");
						$error.html("邮箱地址不正确！");
						$tip.hide();
						$error.show();
						return false;
					}
					if(code.val().length<=0){
						$error = code.nextAll("p[errortip]");
						$tip = code.nextAll("p[tip]");
						$error.addClass("error_tip");
						$error.html("请输入验证码！");
						$tip.hide();
						$error.show();
						return false;
					}
					var data={"evencheck":"emil","utp":"pphoneemil","ctp":"enew","value":emil.val(),"code":code.val()};
					$.ajax({
						type:"post",
						dataType:"html",
						url:"<%=controller.getURI(request, CheckNewCode.class)%>",
						data:data,
						success:function(data){
							if(data == "00"){
								$("#ep1").show();
								$("#ep2").hide();
								return false;
							}
							if(data == "01"){
								$error = code.nextAll("p[errortip]");
								$tip = code.nextAll("p[tip]");
								$error.addClass("error_tip");
								$error.html("输入邮箱有误！");
								$tip.hide();
								$error.show();
								return false;
							}else if(data == "02"){
								$error = code.nextAll("p[errortip]");
								$tip = code.nextAll("p[tip]");
								$error.addClass("error_tip");
								$error.html("输入验证码有误！");
								$tip.hide();
								$error.show();
								return false;
							}else if(data == "03"){
								$error = code.nextAll("p[errortip]");
								$tip = code.nextAll("p[tip]");
								$error.addClass("error_tip");
								$error.html("验证码不正确！");
								$tip.hide();
								$error.show();
								return false;
							}else if(data == "04"){
								$error = code.nextAll("p[errortip]");
								$tip = code.nextAll("p[tip]");
								$error.addClass("error_tip");
								$error.html("邮箱已存在！");
								$tip.hide();
								$error.show();
								return false;
							}else{
								$("#ep2").hide();
								$("#ep3").show();
								$("#ep3").find("p").html(emil.val().substring(0,1)+"*****"+emil.val().split("@")[1]);
							}
						}
					});
					
				}if(type=="poldone"){
					<%--通过短信修改手机号 1--%>
					var $cli = $(this).parent().parent().prev();
					var code = $cli.children("div").eq(1).children("input").eq(0);
					if(code.val().length<=0){
						$error = code.nextAll("p[errortip]");
						$tip = code.nextAll("p[tip]");
						$error.addClass("error_tip");
						$error.html("请输入验证码！");
						$tip.hide();
						$error.show();
						return false;
					}
					
					var data={"evencheck":"phone","ctp":"pupdate","code":code.val()};
					$.ajax({
						type:"post",
						dataType:"html",
						url:"<%=controller.getURI(request, CheckCode.class)%>",
						data:data,
						success:function(data){
							if(data == "01"){
								$error = code.nextAll("p[errortip]");
								$tip = code.nextAll("p[tip]");
								$error.addClass("error_tip");
								$error.html("输入手机号！");
								$tip.hide();
								$error.show();
								return false;
							}else if(data == "02"){
								$error = code.nextAll("p[errortip]");
								$tip = code.nextAll("p[tip]");
								$error.addClass("error_tip");
								$error.html("输入验证码有误！");
								$tip.hide();
								$error.show();
								return false;
							}else if(data == "03"){
								$error = code.nextAll("p[errortip]");
								$tip = code.nextAll("p[tip]");
								$error.addClass("error_tip");
								$error.html("验证码不正确！");
								$tip.hide();
								$error.show();
								return false;
							}else{
								$("#p1").hide();
								$("#p2").show();
							}
						}
					});
					
				}
				if(type=="pnewtwo"){
					<%--通过短信修改手机号 2--%>
					var $cli = $(this).parent().parent().prev();
					var $eli = $(this).parent().parent().prev().prev();
					var emil = $eli.children("div").eq(1).children("input").eq(0);
					var code = $cli.children("div").eq(1).children("input").eq(0);
					
					var myreg = /^(13|15|18|14|17)[0-9]{9}$/;
					if(!myreg.test(emil.val()))
					{
						$error = code.nextAll("p[errortip]");
						$tip = code.nextAll("p[tip]");
						$error.addClass("error_tip");
						$error.html("手机号码不正确!");
						$tip.hide();
						$error.show();
						return false;
					}
					if(code.val().length<=0){
						$error = code.nextAll("p[errortip]");
						$tip = code.nextAll("p[tip]");
						$error.addClass("error_tip");
						$error.html("请输入验证码！");
						$tip.hide();
						$error.show();
						return false;
					}
					
					var data={"evencheck":"phone","utp":"pupdate","ctp":"pnew","value":emil.val(),"code":code.val()};
					$.ajax({
						type:"post",
						dataType:"html",
						url:"<%=controller.getURI(request, CheckNewCode.class)%>",
						data:data,
						success:function(data){
							if(data == "00"){
								$("#p1").show();
								$("#p2").hide();
								return false;
							}
							if(data == "01"){
								$error = code.nextAll("p[errortip]");
								$tip = code.nextAll("p[tip]");
								$error.addClass("error_tip");
								$error.html("输入手机号有误！");
								$tip.hide();
								$error.show();
								return false;
							}else if(data == "02"){
								$error = code.nextAll("p[errortip]");
								$tip = code.nextAll("p[tip]");
								$error.addClass("error_tip");
								$error.html("输入验证码有误！");
								$tip.hide();
								$error.show();
								return false;
							}else if(data == "03"){
								$error = code.nextAll("p[errortip]");
								$tip = code.nextAll("p[tip]");
								$error.addClass("error_tip");
								$error.html("验证码不正确！");
								$tip.hide();
								$error.show();
								return false;
							}else if(data == "04"){
								$error = code.nextAll("p[errortip]");
								$tip = code.nextAll("p[tip]");
								$error.addClass("error_tip");
								$error.html("手机号码已存在！");
								$tip.hide();
								$error.show();
								return false;
							}else{
								$("#p2").hide();
								$("#p3").show();
								$("#p3").find("p").html(emil.val().substring(0,3)+"*****"+emil.val().substring(7,11));
							}
						}
					});
				}if(type=="ipoldone"){
					<%--通过身份证修改手机号 1 --%>
					
					if("BTG" == "<%=data.isIdCard%>"){
						$("#ip1").hide();
						$("#pr2").show();
						return false;
					}
					
					var t = true;
					<%if(StringHelper.isEmpty(data.txpassword)){%>
					t = false;
					<%}%>
					if(!t){
						$("#ip1").hide();
						$("#pr1").show();
						return false;
					}
					
					var $tli = $(this).parent().parent().prev();
					var $ili = $(this).parent().parent().prev().prev();
					var idcard = $ili.children("div").eq(1).children("input").eq(0).val();
					var txpassword = $tli.children("div").eq(1).children("input").eq(0);
					if(!isIdCardNo(idcard)){
						return false;
					}
					if(txpassword.val().length<=0){
						$error = txpassword.nextAll("p[errortip]");
						$tip = txpassword.nextAll("p[tip]");
						$error.addClass("error_tip");
						$error.html("请输入提现密码！");
						$tip.hide();
						$error.show();
						return false;
					}
					if(idcard != "<%=StringHelper.decode(data.sfzh)%>"){
						$error = txpassword.nextAll("p[errortip]");
						$tip = txpassword.nextAll("p[tip]");
						$error.addClass("error_tip");
						$error.html("不是本人身份证！");
						$tip.hide();
						$error.show();
						return false;
					}
					var data={"value":txpassword.val()};
					$.ajax({
						type:"post",
						dataType:"html",
						url:"<%=controller.getURI(request, Checkpassword.class)%>",
						data:data,
						success:function(data){
							if(data == "01"){
								$error = txpassword.nextAll("p[errortip]");
								$tip = txpassword.nextAll("p[tip]");
								$error.addClass("error_tip");
								$error.html("提现密码输入错误！");
								$tip.hide();
								$error.show();
								return false;
							}else{
								$("#ip1").hide();
								$("#ip2").show();
							}
						}
					});
					
				}
				if(type=="ipnewtwo"){
					<%--通过身份证修改手机号 2 --%>
					var $cli = $(this).parent().parent().prev();
					var $eli = $(this).parent().parent().prev().prev();
					var emil = $eli.children("div").eq(1).children("input").eq(0);
					var code = $cli.children("div").eq(1).children("input").eq(0);
					
					var myreg = /^(13|15|18|14|17)[0-9]{9}$/;
					
					if(!myreg.test(emil.val()))
					{
						alert("手机号码不正确!");
						return false;
					}
					if(code.val().length<=0){
						$error = code.nextAll("p[errortip]");
						$tip = code.nextAll("p[tip]");
						$error.addClass("error_tip");
						$error.html("请输入验证码！");
						$tip.hide();
						$error.show();
						return false;
					}
					var data={"evencheck":"phone","utp":"pnew","ctp":"pnew","value":emil.val(),"code":code.val()};
					$.ajax({
						type:"post",
						dataType:"html",
						url:"<%=controller.getURI(request, CheckNewCode.class)%>",
						data:data,
						success:function(data){
							if(data == "00"){
								$("#p1").show();
								$("#p2").hide();
								return false;
							}
							if(data == "01"){
								$error = code.nextAll("p[errortip]");
								$tip = code.nextAll("p[tip]");
								$error.addClass("error_tip");
								$error.html("输入手机号有误！");
								$tip.hide();
								$error.show();
								return false;
							}else if(data == "02"){
								$error = code.nextAll("p[errortip]");
								$tip = code.nextAll("p[tip]");
								$error.addClass("error_tip");
								$error.html("输入验证码有误！");
								$tip.hide();
								$error.show();
								return false;
							}else if(data == "03"){
								$error = code.nextAll("p[errortip]");
								$tip = code.nextAll("p[tip]");
								$error.addClass("error_tip");
								$error.html("验证码不正确！");
								$tip.hide();
								$error.show();
								return false;
							}else if(data == "04"){
								$error = code.nextAll("p[errortip]");
								$tip = code.nextAll("p[tip]");
								$error.addClass("error_tip");
								$error.html("手机号码已存在！");
								$tip.hide();
								$error.show();
								return false;
							}else{
								$("#ip2").hide();
								$("#ip3").show();
								$("#ip3").find("p").html(emil.val().substring(0,3)+"*****"+emil.val().substring(7,11));
							}
						}
					});
				}if(type=="pswone"){
					<%--找回提现密码 1--%>
					var $cli = $(this).parent().parent().prev();
					var code = $cli.children("div").eq(1).children("input").eq(0);
					if(code.val().length<=0){
						$error = code.nextAll("p[errortip]");
						$tip = code.nextAll("p[tip]");
						$error.addClass("error_tip");
						$error.html("请输入验证码！");
						$tip.hide();
						$error.show();
						return false;
					}
					
					var data={"evencheck":"phone","ctp":"pgetoldpas","code":code.val()};
					$.ajax({
						type:"post",
						dataType:"html",
						url:"<%=controller.getURI(request, CheckCode.class)%>",
						data:data,
						success:function(data){
							if(data == "01"){
								$error = code.nextAll("p[errortip]");
								$tip = code.nextAll("p[tip]");
								$error.addClass("error_tip");
								$error.html("输入手机号！");
								$tip.hide();
								$error.show();
								return false;
							}else if(data == "02"){
								$error = code.nextAll("p[errortip]");
								$tip = code.nextAll("p[tip]");
								$error.addClass("error_tip");
								$error.html("输入验证码有误！");
								$tip.hide();
								$error.show();
								return false;
							}else if(data == "03"){
								$error = code.nextAll("p[errortip]");
								$tip = code.nextAll("p[tip]");
								$error.addClass("error_tip");
								$error.html("验证码不正确！");
								$tip.hide();
								$error.show();
								return false;
							}else{
								$("#ps1").hide();
								$("#ps2").show();
							}
						}
					});
				}
				if(type=="pswtwo"){
					<%--找回提现密码 2--%>
					var $cli = $(this).parent().parent().prev();
					var $eli = $(this).parent().parent().prev().prev();
					var code = $cli.children("div").eq(1).children("input").eq(0);
					var emil = $eli.children("div").eq(1).children("input").eq(0);
					
					var myreg = /^[a-zA-Z0-9]{6,20}$/;
					
					if(emil.val().length<=0){
						$error = emil.nextAll("p[errortip]");
						$tip = emil.nextAll("p[tip]");
						$error.addClass("error_tip");
						$error.html("不能为空！");
						$tip.hide();
						$error.show();
						return false;
					}else if(!myreg.test(emil.val()))
					{
						$error = emil.nextAll("p[errortip]");
						$tip = emil.nextAll("p[tip]");
						$error.addClass("error_tip");
						$error.html("6-20个字符，区分大小写");
						$tip.hide();
						$error.show();
						return false;
					}
					if(code.val() != emil.val()){
						$error = code.nextAll("p[errortip]");
						$tip = code.nextAll("p[tip]");
						$error.addClass("error_tip");
						$error.html("两次输入密码不一致！");
						$tip.hide();
						$error.show();
						return false;
					}
					var data={"evencheck":"phone","utp":"pgetoldpas","number":"<%StringHelper.filterHTML(out, data.phoneNumber);%>","new":emil.val()};
					$.ajax({
						type:"post",
						dataType:"html",
						url:"<%=controller.getURI(request, pdatetxPasswordajx.class)%>",
						data:data,
						success:function(data){
							if(data == "09"){
								$("#ps1").show();
								$("#ps2").hide();
								return false;
							}else if(data == "00"){
								$error = code.nextAll("p[errortip]");
								$tip = code.nextAll("p[tip]");
								$error.addClass("error_tip");
								$error.html("输入正确密码！");
								$tip.hide();
								$error.show();
								return false;
							}
							else if(data == "01"){
								$error = code.nextAll("p[errortip]");
								$tip = code.nextAll("p[tip]");
								$error.addClass("error_tip");
								$error.html("不能和登录密码相同！");
								$tip.hide();
								$error.show();
								return false;
							}else if(data == "03"){
								$("#ps2").hide();
								$("#ps3").show();
							}
							else{
								$error = code.nextAll("p[errortip]");
								$tip = code.nextAll("p[tip]");
								$error.addClass("error_tip");
								$error.html(data);
								$tip.hide();
								$error.show();
								return false;
							}
						}
					});
				}
			});
		});
		
		$(function(){
			$(".emilsend").click(function(){
				var $eli = $(this).parent().parent().prev();
				var bemil = $eli.children("div").eq(1).children("input").eq(0);
				var myreg = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,4}$/;
				if(bemil.val().length<=0 || !myreg.test(bemil.val()))
				{
					$error = bemil.nextAll("p[errortip]");
					$tip = bemil.nextAll("p[tip]");
					$error.addClass("error_tip");
					$error.html("邮箱地址不正确!");
					$tip.hide();
					$error.show();
					return false;
				}
				var evn = this;
				var data={"type":"new","emil":bemil.val(),"phone":""};
				$.ajax({
					type:"post",
					dataType:"html",
					url:"<%=controller.getURI(request, Send.class)%>",
					data:data,
					success:function(data){
						if(data){
							var ct = eval('('+data+')');
							if(ct.length>0 && ct[0].num == 0){
								$error = bemil.nextAll("p[errortip]");
								$tip = bemil.nextAll("p[tip]");
								$error.addClass("error_tip");
								$error.html(ct[0].msg);
								$tip.hide();
								$error.show();
								return false;
							}
							if(ct.length>0 && ct[0].num == 1){
								sendclick1(evn);
							}
						}
					}
				});
			});
		});
		
		$(function(){
			$(".phonesend").click(function(){
				var $eli = $(this).parent().parent().prev();
				var bemil = $eli.children("div").eq(1).children("input").eq(0);
				var myreg = /^(13|15|18|14|17)[0-9]{9}$/;
				if(bemil.val().length<=0 || !myreg.test(bemil.val()))
				{
					$error = bemil.nextAll("p[errortip]");
					$tip = bemil.nextAll("p[tip]");
					$error.addClass("error_tip");
					$error.html("手机号码不正确!");
					$tip.hide();
					$error.show();
					return false;
				}
				var evn = this;
				var data={"type":"new","emil":"","phone":bemil.val()};
				$.ajax({
					type:"post",
					dataType:"html",
					url:"<%=controller.getURI(request, Send.class)%>",
					data:data,
					success:function(data){
						if(data){
							var ct = eval('('+data+')');
							if(ct.length>0 && ct[0].num == 0){
								$error = bemil.nextAll("p[errortip]");
								$tip = bemil.nextAll("p[tip]");
								$error.addClass("error_tip");
								$error.html(ct[0].msg);
								$tip.hide();
								$error.show();
								return false;
							}
							if(ct.length>0 && ct[0].num == 1){
								sendclick4(evn);
							}
						}
					}
				});
			});
		});
		
		
		function isIdCardNo(num) {           
		    num = num.toUpperCase();           //身份证号码为15位或者18位，15位时全为数字，18位前17位为数字，最后一位是校验位，可能为数字或字符X。        
		    if (!(/(^\d{15}$)|(^\d{17}([0-9]|X)$)/.test(num))) {     
		        alert('输入的身份证号长度不对，或者号码不符合规定！\n15位号码应全为数字，18位号码末位可以为数字或X。');              
		        return false;         
		    } //校验位按照ISO 7064:1983.MOD 11-2的规定生成，X可以认为是数字10。 
		    //下面分别分析出生日期和校验位 
		    var len, re; len = num.length; if (len == 15) { 
		        re = new RegExp(/^(\d{6})(\d{2})(\d{2})(\d{2})(\d{3})$/); 
		        var arrSplit = num.match(re);  //检查生日日期是否正确
		        var dtmBirth = new Date('19' + arrSplit[2] + '/' + arrSplit[3] + '/' + arrSplit[4]); 
		        var bGoodDay; bGoodDay = (dtmBirth.getYear() == Number(arrSplit[2])) && ((dtmBirth.getMonth() + 1) == Number(arrSplit[3])) && (dtmBirth.getDate() == Number(arrSplit[4]));
		        if (!bGoodDay) {         
		            alert('输入的身份证号里出生日期不对！');            
		            return false;
		        } else { //将15位身份证转成18位 //校验位按照ISO 7064:1983.MOD 11-2的规定生成，X可以认为是数字10。        
		            var arrInt = new Array(7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2);         
		            var arrCh = new Array('1', '0', 'X', '9', '8', '7', '6', '5', '4', '3', '2');      
		            var nTemp = 0, i;            
		            num = num.substr(0, 6) + '19' + num.substr(6, num.length - 6);           
		            for(i = 0; i < 17; i ++) {                 
		                nTemp += num.substr(i, 1) * arrInt[i];        
		            }
		            num += arrCh[nTemp % 11]; 
		            return true;
		        }
		    }
		    if (len == 18) {
		        re = new RegExp(/^(\d{6})(\d{4})(\d{2})(\d{2})(\d{3})([0-9]|X)$/); 
		        var arrSplit = num.match(re);  //检查生日日期是否正确 
		        var dtmBirth = new Date(arrSplit[2] + "/" + arrSplit[3] + "/" + arrSplit[4]); 
		        var bGoodDay; bGoodDay = (dtmBirth.getFullYear() == Number(arrSplit[2])) && ((dtmBirth.getMonth() + 1) == Number(arrSplit[3])) && (dtmBirth.getDate() == Number(arrSplit[4])); 
		        if (!bGoodDay) { 
		            alert(dtmBirth.getYear()); 
		            alert(arrSplit[2]); 
		            alert('输入的身份证号里出生日期不对！'); 
		            return false; 
		        }
		        else { //检验18位身份证的校验码是否正确。 //校验位按照ISO 7064:1983.MOD 11-2的规定生成，X可以认为是数字10。 
		            var valnum; 
		            var arrInt = new Array(7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2); 
		            var arrCh = new Array('1', '0', 'X', '9', '8', '7', '6', '5', '4', '3', '2'); 
		            var nTemp = 0, i; 
		            for(i = 0; i < 17; i ++) { 
		                nTemp += num.substr(i, 1) * arrInt[i];
		            } 
		            valnum = arrCh[nTemp % 11]; 
		            if (valnum != num.substr(17, 1)) { 
		                alert('18位身份证的校验码不正确!'); 
		                return false; 
		            } 
		            return true; 
		        } 
		    } return false;
		}
		
		function localch(id){
			$("#"+id).hide();
			$("#ip1").show();
		}
		
		
		<%--绑定邮箱时计时器 --%>
		function sendclick(evn){
			if (wait == 0) {
				evn.removeAttribute("disabled");
				$(evn).removeClass("btn08");
				$(evn).addClass("btn03");
				evn.value="获取验证码";
				wait = 180;
			} else {
				if(!$(evn).hasClass("btn08")){
					$(evn).addClass("btn08");
					$(evn).removeClass("btn03");
				}
				evn.setAttribute("disabled", true);
				evn.value="(" + wait + ")秒重新获取";
				wait--;
				setTimeout(function() {
					sendclick(evn);
				},
				1000);
			}
		}
		<%--修改邮箱时计时器 --%>
		function sendclick6(evn){
			if (wait6 == 0) {
				evn.removeAttribute("disabled");
				$(evn).removeClass("btn08");
				$(evn).addClass("btn03");
				evn.value="获取验证码";
				wait6 = 180;
			} else {
				if(!$(evn).hasClass("btn08")){
					$(evn).addClass("btn08");
					$(evn).removeClass("btn03");
				}
				evn.setAttribute("disabled", true);
				evn.value="(" + wait6 + ")秒重新获取";
				wait6--;
				setTimeout(function() {
					sendclick6(evn);
				},
				1000);
			}
		}
		<%--新邮箱时计时器 --%>
		function sendclick1(evn){
			if (wait1 == 0) {
				evn.removeAttribute("disabled");
				$(evn).removeClass("btn08");
				$(evn).addClass("btn03");
				evn.value="获取验证码";
				wait1 = 180;
			} else {
				if(!$(evn).hasClass("btn08")){
					$(evn).addClass("btn08");
					$(evn).removeClass("btn03");
				}
				evn.setAttribute("disabled", true);
				evn.value="(" + wait1 + ")秒重新获取";
				wait1--;
				setTimeout(function() {
					sendclick1(evn);
				},
				1000);
			}
		}
		
		<%--手机修改邮箱时 --%>
		function sendclick2(evn){
			if (wait2 == 0) {
				evn.removeAttribute("disabled");
				$(evn).removeClass("btn08");
				$(evn).addClass("btn03");
				evn.value="获取验证码";
				wait2 = 180;
			} else {
				if(!$(evn).hasClass("btn08")){
					$(evn).addClass("btn08");
					$(evn).removeClass("btn03");
				}
				evn.setAttribute("disabled", true);
				evn.value="(" + wait2 + ")秒重新获取";
				wait2--;
				setTimeout(function() {
					sendclick2(evn);
				},
				1000);
			}
		}
		
		<%--绑定手机时计时器 --%>
		function sendclick3(evn){
			if (wait3 == 0) {
				evn.removeAttribute("disabled");
				$(evn).removeClass("btn08");
				$(evn).addClass("btn03");
				evn.value="获取验证码";
				wait3 = 180;
			} else {
				if(!$(evn).hasClass("btn08")){
					$(evn).addClass("btn08");
					$(evn).removeClass("btn03");
				}
				evn.setAttribute("disabled", true);
				evn.value="(" + wait3 + ")秒重新获取";
				wait3--;
				setTimeout(function() {
					sendclick3(evn);
				},
				1000);
			}
		}
		<%--修改手机时计时器 --%>
		function sendclick7(evn){
			if (wait7 == 0) {
				evn.removeAttribute("disabled");
				$(evn).removeClass("btn08");
				$(evn).addClass("btn03");
				evn.value="获取验证码";
				wait7 = 180;
			} else {
				if(!$(evn).hasClass("btn08")){
					$(evn).addClass("btn08");
					$(evn).removeClass("btn03");
				}
				evn.setAttribute("disabled", true);
				evn.value="(" + wait7 + ")秒重新获取";
				wait7--;
				setTimeout(function() {
					sendclick7(evn);
				},
				1000);
			}
		}
		<%--新手机时计时器 --%>
		function sendclick4(evn){
			if (wait4 == 0) {
				evn.removeAttribute("disabled");
				$(evn).removeClass("btn08");
				$(evn).addClass("btn03");
				evn.value="获取验证码";
				wait4 = 180;
			} else {
				if(!$(evn).hasClass("btn08")){
					$(evn).addClass("btn08");
					$(evn).removeClass("btn03");
				}
				evn.setAttribute("disabled", true);
				evn.value="(" + wait4 + ")秒重新获取";
				wait4--;
				setTimeout(function() {
					sendclick4(evn);
				},
				1000);
			}
		}
		<%--提现密码时计时器 --%>
		function sendclick5(evn){
			if (wait5 == 0) {
				evn.removeAttribute("disabled");
				$(evn).removeClass("btn08");
				$(evn).addClass("btn03");
				evn.value="获取验证码";
				wait5 = 180;
			} else {
				if(!$(evn).hasClass("btn08")){
					$(evn).addClass("btn08");
					$(evn).removeClass("btn03");
				}
				evn.setAttribute("disabled", true);
				evn.value="(" + wait5 + ")秒重新获取";
				wait5--;
				setTimeout(function() {
					sendclick5(evn);
				},
				1000);
			}
		}
	</script>
	
</body>
</html>