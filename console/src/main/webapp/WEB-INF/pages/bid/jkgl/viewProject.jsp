<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.S62.enums.T6231_F21"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F10"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F17"%>
<%@page import="com.dimeng.p2p.modules.bid.console.service.entity.BidCheck"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.jkgl.DetailAuthentication"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.jkgl.ViewAuthentication"%>
<%@page import="com.dimeng.p2p.S62.entities.T6238"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.jkgl.ViewHkRecord"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F20"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.jkgl.ViewRecord"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F15"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F16"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F14"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F13"%>
<%@page import="com.dimeng.p2p.S62.enums.T6230_F11"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.jkgl.LoanList"%>
<%@page import="com.dimeng.p2p.S62.entities.T6211"%>
<%@page import="com.dimeng.p2p.S61.enums.T6110_F06"%>
<%@page import="com.dimeng.p2p.S62.entities.T6231"%>
<%@page import="com.dimeng.p2p.S62.entities.T6230"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.jkgl.DetailAnnexWz"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.jkgl.DetailAnnexMsk"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.jkgl.ViewGuarantee"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.jkgl.ViewEnterprise"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.jkgl.ViewDyw"%>
<%@page import="com.dimeng.p2p.console.servlets.bid.jkgl.ViewUserInfo"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<%@page import="com.dimeng.p2p.common.enums.LoanType"%>
<%@page import="com.dimeng.p2p.S60.enums.T6010_1_F02"%>
<%@page import="com.dimeng.p2p.console.servlets.AbstractConsoleServlet"%>
<html>
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%
		CURRENT_CATEGORY="YWGL";
			CURRENT_SUB_CATEGORY="BDGL";
			T6230 loan = ObjectHelper.convert(request.getAttribute("loan"), T6230.class);
			T6231 t6231=ObjectHelper.convert(request.getAttribute("t6231"), T6231.class);
			T6230 t6230=ObjectHelper.convert(request.getAttribute("t6230"), T6230.class);
			T6110_F06 userType=EnumParser.parse(T6110_F06.class, request.getAttribute("userType").toString());
			T6211[] t6211s=ObjectHelper.convertArray(request.getAttribute("t6211s"), T6211.class);
			T6238 t6238=ObjectHelper.convert(request.getAttribute("t6238"), T6238.class);
			BidCheck[] bidChecks = ObjectHelper.convertArray(request.getAttribute("bidChecks"), BidCheck.class);
			String userName=ObjectHelper.convert(request.getAttribute("userName"), String.class);
			if(loan==null)
			{
		response.sendError(HttpServletResponse.SC_NOT_FOUND);
			}
			int loanId=IntegerParser.parse(request.getParameter("loanId"));
			int userId=loan.F02;
	%>
<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="w_main">
		<div class="main clearfix">
			<div class="wrap">
				<div class="r_main">
					<div class="home_main">
						<div class="box box1 mb15">
							<div class="atil">
								<h3>查看借款信息</h3>
							</div>
						</div>
						<div class="newsbox">
							<div class="til clearfix">
								<a href="<%=controller.getURI(request, LoanList.class)%>"
									class="btn4 tc" style="float: right" >返回</a>
								<div class="Menubox">
									<ul>
										<li class="hover">项目信息</li>
										<%
											if(userType==T6110_F06.ZRR)
																			{
										%>
										<li><a href="<%=controller.getURI(request, ViewUserInfo.class)%>?loanId=<%=loanId%>&userId=<%=userId%>">个人信息</a></li>
										<li><a href="<%=controller.getURI(request, DetailAuthentication.class)%>?loanId=<%=loanId%>&userId=<%=userId%>">个人认证信息</a></li>
										<%
											}
										%>
										<%
											if(userType==T6110_F06.FZRR)
																			{
										%>
										<li><a href="<%=controller.getURI(request, ViewEnterprise.class)%>?loanId=<%=loanId%>&userId=<%=userId%>">企业信息</a></li>
										<%
											}
										%>
										<%
											if(T6230_F13.S==t6230.F13){
										%>
										<li><a href="<%=controller.getURI(request, ViewDyw.class)%>?loanId=<%=loanId%>&userId=<%=userId%>">抵押物信息</a></li>
										<%} %>
										<%
											if(T6230_F11.S==t6230.F11)
											{
										%>
										<li><a href="<%=controller.getURI(request, ViewGuarantee.class)%>?loanId=<%=loanId%>&userId=<%=userId%>">担保信息</a></li>
										<%} %>
										<li><a href="<%=controller.getURI(request, DetailAnnexMsk.class)%>?loanId=<%=loanId%>&userId=<%=userId%>">附件(马赛克)</a></li>
										<li><a href="<%=controller.getURI(request, DetailAnnexWz.class)%>?loanId=<%=loanId%>&userId=<%=userId%>">附件(完整版)</a></li>
										<%
										if(t6230.F20!=T6230_F20.SQZ&&t6230.F20!=T6230_F20.DSH&&t6230.F20!=T6230_F20.DFB&&t6230.F20!=T6230_F20.YFB)
											{
										%>
										<li><a href="<%=controller.getURI(request, ViewRecord.class)%>?loanId=<%=loanId%>&userId=<%=userId%>">投资记录</a></li>
										<li><a href="<%=controller.getURI(request, ViewHkRecord.class)%>?loanId=<%=loanId%>&userId=<%=userId%>">还款计划</a></li>
										<%} %>
									</ul>
								</div>
							</div>
							<div class="border p30 Men_bt no_table yw_dl" id="con_one_1">
									<div class="mb20">
										<div class="yw_jcxx">
											<ul class="cell noborder">
												<li>
													<div class="til">
														<span class="red"></span>预约用户名：
													</div>
													<div class="info">
														<%StringHelper.filterHTML(out, loan.investName); %>
													</div>
													<div class="clear"></div>
												</li>
												<li>
													<div class="til">
														<span class="red">*</span>借款账户：
													</div>
													<div class="info"></div>
													<div class="info">
														<%StringHelper.filterHTML(out, userName); %>
													</div>
													<div class="clear"></div>
												</li>
												<li>
													<div class="til">
														<span class="red">*</span>标的类型：
													</div>
													<div class="info">
														<%
														if(t6211s!=null){
																for(T6211 t6211:t6211s)
																{
																	if(t6211==null)
																	{
																		continue;
																	}
																	if(loan.F04==t6211.F01)
																	{
																		StringHelper.filterHTML(out, t6211.F02);
																		break;
																	}
																}
														}
														%>
													</div>
													<div class="clear"></div>
												</li>
												<li>
													<div class="til">
														<span class="red">*</span>项目所在区域：
													</div>
													<div class="info"></div>
													<div class="info">
														<%StringHelper.filterHTML(out, ObjectHelper.convert(request.getAttribute("region"), String.class)); %>
													</div>
													<div class="clear"></div>
												</li>
												<li>
													<div class="til">
														<span class="red">*</span>借款标题：
													</div>
													<div class="info">
														<%StringHelper.filterHTML(out, loan.F03); %>
													</div>
													<div class="clear"></div>
												</li>
												<li>
													<div class="til">
														<span class="red">*</span>借款金额： <br />
													</div>
													<div class="info">
														<%=Formater.formatAmount(loan.F05) %>元
													</div>
													<div class="clear"></div>
												</li>
												<li>
													<div class="til">
														<span class="red"></span><br />
													</div>
													<div class="info">
														<input type="checkbox" disabled="disabled" name="F11" value="S" <%if(loan.F11==T6230_F11.S){ %> checked="checked" <%} %>/>有担保
														<input type="checkbox" disabled="disabled" name="F13" value="S" <%if(loan.F13==T6230_F13.S){ %> checked="checked" <%} %>/>有抵押
														<input type="checkbox" disabled="disabled" name="F14" value="S" <%if(loan.F14==T6230_F14.S){ %> checked="checked" <%} %>/>有实地认证
													</div>
													<div class="clear"></div>
												</li>
												<%
													if(loan.F11==T6230_F11.S)
													{
												%>
												<li>
													<div class="til">
														<span class="red">*</span>担保方案：
													</div>
													<div class="info">
														<%=loan.F12.getChineseName() %>
													</div>
													<div class="clear"></div>
												</li>
												<%} %>
												<li>
													<div class="til">
														<span class="red">*</span>借款用途：
													</div>
													<div class="info">
														<%StringHelper.filterHTML(out, t6231.F08); %>
													</div>
													<div class="clear"></div>
												</li>
												<li>
													<div class="til">
														<span class="red">*</span>借款期限：
													</div>
													<div class="info">
														<%if(T6231_F21.S == t6231.F21){out.print(t6231.F22); %>天
														<%} else {out.print(loan.F09); %>个月<%} %>
													</div>
													<div class="clear"></div>
												</li>
												<li>
													<div class="til">
														<span class="red">*</span>年利率：
													</div>
													<div class="info">
														<%=Formater.formatRate(loan.F06) %>
													</div>
													<div class="clear"></div>
												</li>
												<!-- 鼓励奖 -->
												 <div class="tjsinline">
												 <%for(int pi=0;pi<2;pi++){ %>
										<li id="inrward"><div class="til"><select style="width:120px;" class="text yhgl_ser" name="bijxward" readonly="readonly">
            		                         <option value="stj">首投奖</option>
            		                         <option value="xrj"<%if(pi==0){ %> selected="selected" <%}%>>新人奖</option>
            		                         <option value="thj" <%if(pi==1){ %> selected="selected"}<%} %>>土豪奖</option>
            		                         <option value="mxj">秒杀奖</option>
                                             <option value="hgj">收官奖</option>
		                              </select></div>
		                              <div class="info">
		                              &nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="jlacward" class="text yhgl_ser required max-size-99.999" mtest="/^\d*(\d|(\.[0-9]{1}|\.[0-9]{2}))$/" readonly="readonly"  value="输入额外奖励奖的百分比"/>
		                              </div><div class="clear"></div></li>      
												 <% }%>
												 </div>
												<!-- end -->
												<li>
													<div class="til">
														<span class="red">*</span>额外奖励：
													</div>
													<div class="info">
														<%=loan.bonus%>
													</div>
													<div class="clear"></div>
												</li>
												<li>
													<div class="til">
														<span class="red">*</span>成交服务费率：
													</div>
													<div class="info">
														<%=t6238.F02.doubleValue()%>
													</div>
													<div class="clear"></div>
												</li>
												<li>
													<div class="til">
														<span class="red">*</span>投资管理费率：
													</div>
													<div class="info">
														<%=t6238.F03.doubleValue()%>
													</div>
													<div class="clear"></div>
												</li>
												<li>
													<div class="til">
														<span class="red">*</span>逾期罚息利率：
													</div>
													<div class="info">
														<%=t6238.F04.doubleValue()%>
													</div>
													<div class="clear"></div>
												</li>
												<li>
													<div class="til">
														<span class="red">*</span>还款方式：
													</div>
													<div class="info">
														<%=loan.F10.getChineseName() %>
													</div>
													<div class="clear"></div>
												</li>
												<li>
													<div class="til">
														<span class="red">*</span>还款来源： <br />
													</div>
													<div class="info">
														<%StringHelper.filterHTML(out, t6231.F16);%>
													</div>
													<div class="clear"></div>
												</li>
												<li>
													<div class="til">
														<span class="red">*</span>付息方式：
													</div>
													<div class="info">
														<%=loan.F17.getChineseName() %>
													</div>
													<div class="clear"></div>
												</li>
												<%
													if(loan.F17==T6230_F17.GDR)
													{
												%>
												<li>
													<div class="til">
														<span class="red">*</span>付息日：
													</div>
													<div class="info">
														<%=loan.F18 %>号
													</div>
													<div class="clear"></div>
												</li>
												<%} %>
												<li>
													<div class="til">
														<span class="red">*</span>起息日：
													</div>
													<div class="info">
														<%
															if(loan.F19==0)
															{
																StringHelper.filterHTML(out, "当日计息");
															}else if(loan.F19==1)
															{
																StringHelper.filterHTML(out, "次日计息");
															}
														%>
													</div>
													<div class="clear"></div>
												</li>
												<li>
													<div class="til">
														<span class="red">*</span>筹款期限：
													</div>
													<div class="info">
														<%=loan.F08 %>天
													</div>
													<div class="clear"></div>
												</li>
												<li>
													<div class="til">
														<span class="red">*</span>借款描述：
													</div>
													<div class="info">
														<%= t6231.F09 %>
													</div>
													<div class="clear"></div>
												</li>
											</ul>
										</div>
										<div class="clear"></div>
									</div>
									<div class="clear"></div>
								</div>
								<div class="border p30 Men_bt no_table yw_dl">
									<div class="yw_jcxx">
										<table width="100%" border="0" cellspacing="0" cellpadding="3" class="yhgl_table tc">
											<tr class="hsbg">
												<td>序号</td>
												<td>审核人</td>
												<td>反馈时间</td>
												<td>状态</td>
												<td>审核意见</td>
											</tr>
											<%
												if(bidChecks!=null)
												{int i=1;
												for(BidCheck bidCheck:bidChecks)
												{	if(bidCheck==null){continue;}
											%>
											<tr>
												<td><%=i++%></td>
												<td><%=bidCheck.name%></td>
												<td>
													<%=DateTimeParser.format(bidCheck.F04)
													%>
												</td>
												<td><%=bidCheck.F05.getChineseName() %></td>
												<td><%StringHelper.filterHTML(out, bidCheck.F06); %>
												</td>
											</tr>
											<%}}else{ %>
											<tr><td colspan="5">没有记录</td></tr>
											<%} %>
										</table>
									</div>
								</div>
						</div>
					</div>
					<div class="clear"></div>
				</div>
			</div>
			<%@include file="/WEB-INF/include/left.jsp"%>
		</div>
	</div>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
</body>
</html>