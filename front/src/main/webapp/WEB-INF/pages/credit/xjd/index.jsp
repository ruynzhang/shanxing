<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.dimeng.p2p.front.servlets.credit.sl.Sjsl"%>
<%@page import="com.dimeng.p2p.front.servlets.credit.sl.Sfzsl"%>
<%@page import="com.dimeng.p2p.front.servlets.credit.sl.Xybgsl"%>
<html>
<head>
<title><%=configureProvider.getProperty(SystemVariable.SITE_TITLE)%></title>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<%
	String erd = request.getParameter("erd");
%>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<div class="contain clearfix">
		<div class="want_loan">
			<span>薪金贷</span>
		</div>
		<div class="contain_main want">
			<div class="con_info clearfix">
				<div class="one clearfix">
					<div class="pub_title pt10">申请条件</div>
					<div class="fl pt10">
						<em class="s_blue mr5">•</em>22-55周岁的中国公民<br /> <em
							class="s_blue mr5">•</em>在现单位工作满3个月<br /> <em class="s_blue mr5">•</em>月收入2000以上<br />
					</div>
					<div class="fr pt20 f18 tc">
						<a href="<%=controller.getViewURI(request,com.dimeng.p2p.front.servlets.credit.xjd.Xjd.class)%>" class="big_btn01 big_btn">立即申请</a>
					</div>
				</div>
				<div class="one clearfix">
					<div class="pub_title pt10">借款方式</div>
					<div class="fl pt10">
						借款额度：3,000-500,000元<br /> 借款年利率：10%-24%<span><a target="_blank" href="<%=controller.getViewURI(request, com.dimeng.p2p.front.servlets.credit.Jkjsq.class)%>"
							class="f14 counter ml10">借款计算器</a></span><br /> 借款期限：1-36个月<br />
						审核时间：1-3个工作日<br /> 还款方式：等额本息，每月还款
					</div>
				</div>
				<%--
				<div class="one clearfix">
					<div class="pub_title pt10">费用说明</div>
					<div class="fl pt10">
						<p>
							<em class="f16 gray33">成交服务费</em><br />
							用户成功借款后按照评定的信用等级会一次性的从所得借款中扣除一定的比例（0%-5%）作为成交服务费，该服务费将进入<%=configureProvider.getProperty(SystemVariable.SITE_NAME) %>
							平台的风险备用金账户，专项用于<%=configureProvider.getProperty(SystemVariable.SITE_NAME) %>的本金保障计划。
						</p>
						<table width="75%" border="0" cellspacing="0" class="level_table">
							<thead>
								<tr class="tit">
									<th>信用等级</th>
									<th><i class="ui-creditlevel ui-creditlevel-s AA snow">AA</i></th>
									<th><i class="ui-creditlevel ui-creditlevel-s A snow">A</i></th>
									<th><i class="ui-creditlevel ui-creditlevel-s B snow">B</i></th>
									<th><i class="ui-creditlevel ui-creditlevel-s C snow">C</i></th>
									<th><i class="ui-creditlevel ui-creditlevel-s D snow">D</i></th>
									<th><i class="ui-creditlevel ui-creditlevel-s E snow">E</i></th>
									<th><i class="ui-creditlevel ui-creditlevel-s HR snow">HR</i></th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>费率</td>
									<td><%=Formater.formatRate(Float.parseFloat(configureProvider.getProperty(SystemVariable.SUCCESS_BMONEY_RATE_AA)))%></td>
									<td><%=Formater.formatRate(Float.parseFloat(configureProvider.getProperty(SystemVariable.SUCCESS_BMONEY_RATE_A)))%></td>
									<td><%=Formater.formatRate(Float.parseFloat(configureProvider.getProperty(SystemVariable.SUCCESS_BMONEY_RATE_B)))%></td>
									<td><%=Formater.formatRate(Float.parseFloat(configureProvider.getProperty(SystemVariable.SUCCESS_BMONEY_RATE_C)))%></td>
									<td><%=Formater.formatRate(Float.parseFloat(configureProvider.getProperty(SystemVariable.SUCCESS_BMONEY_RATE_D)))%></td>
									<td><%=Formater.formatRate(Float.parseFloat(configureProvider.getProperty(SystemVariable.SUCCESS_BMONEY_RATE_E)))%></td>
									<td><%=Formater.formatRate(Float.parseFloat(configureProvider.getProperty(SystemVariable.SUCCESS_BMONEY_RATE_HR)))%></td>
								</tr>
							</tbody>
						</table>
						<p class="pt10">
							<em class="gray33 f16">账户管理费</em><br /><%=configureProvider.getProperty(SystemVariable.SITE_NAME) %>将按照借款人的借款期限，每月向借款人收取其借款本金的0.3%作为借款管理费
						</p>

					</div>
				</div>
				 --%>
				<div class="one clearfix">
					<div class="pub_title pt10">必要申请材料</div>
					<div class="fl pt10">
						<p>
							<em class="s_blue">•</em> 身份证<a href="<%=controller.getViewURI(request, Sfzsl.class) %>" target="_blank" class="blue ml30">查看示例</a>
						</p>
						<p>
							<em class="s_blue">•</em> 个人征信报告（可去当地人民银行打印）<a href="<%=controller.getViewURI(request, Xybgsl.class) %>" target="_blank"
								class="blue ml30">查看示例</a>
						</p>
						<p>
							<em class="s_blue">•</em> 近3个月工资卡银行流水<a href="<%=controller.getViewURI(request, Sjsl.class) %>" target="_blank"
								class="blue ml30">查看示例</a>
						</p>

					</div>
				</div>
				<div class="ml380 clearfix">
					<a href="<%=controller.getViewURI(request,com.dimeng.p2p.front.servlets.credit.xjd.Xjd.class)%>"  class="big_btn big_btn01 tc">立即申请</a>
				</div>
			</div>
		</div>

		<div id="smrz" <%if(StringHelper.isEmpty(erd) || !"2".equals(erd)){%>
			style="display: none;" <%}%>>
			<div class="popup_bg"></div>
			<div class="dialog w510" style="margin:-150px 0 0 -255px;">
				<div class="dialog_close fr" onclick="hidebg('smrz');"><a href="javascript:void(-1);"></a></div>
			    <div class="con clearfix">
			      <div class="d_error fl"></div>
			      	<div class="info">尚未完成<span class="red">实名认证设置</span>，请前往<a href="<%=configureProvider.format(URLVariable.USER_NCIIC)%>" class="blue">安全信息</a>进行认证。</div>
			    </div>
			</div>
		</div>
		<div id="txmm" <%if(StringHelper.isEmpty(erd) || !"3".equals(erd)){%>
			style="display: none;" <%}%>>
			<div class="popup_bg"></div>
			<div class="dialog w510" style="margin:-150px 0 0 -255px;">
				<div class="dialog_close fr" onclick="hidebg('txmm');"><a href="javascript:void(-1);"></a></div>
			    <div class="con clearfix">
			      <div class="d_error fl"></div>
			      <div class="info">尚未完成<span class="red">实名认证设置</span>，请前往<a href="<%=configureProvider.format(URLVariable.USER_NCIIC)%>" class="blue">安全信息</a>进行认证。</div>
			    </div>
			</div>
		</div>
		
		<div id="yqts" <%if(StringHelper.isEmpty(erd) || !"4".equals(erd)){%>
			style="display: none;" <%}%>>
			<div class="popup_bg"></div>
			<div class="dialog w510" style="margin:-150px 0 0 -255px;">
				<div class="dialog_close fr" onclick="hidebg('yqts');"><a href="javascript:void(-1);"></a></div>
			    <div class="con clearfix">
			      <div class="d_error fl"></div>
			      <div class="info">您存在借款逾期，请先进行还款！</div>
			    </div>
			</div>
		</div>

		<div id="yycp" <%if(StringHelper.isEmpty(erd) || !"1".equals(erd)){%>
			style="display: none;" <%}%>>
			<div class="popup_bg"></div>
			<div class="dialog d_error w510" style="margin: -150px 0 0 -255px;">
				<div class="dialog_close fr" onclick="hidebg('yycp');">
					<a href="javascript:hidebg('yycp');"></a>
				</div>
				<div class="con clearfix">
					<div class="borrowing clearfix"></div>
					<div class="borrowing clearfix">
						<p>您已申请过其他产品，不能再申请此产品！</p>
					</div>
					<div class="clear"></div>
					<div class="dialog_btn">
						<a href="javascript:hidebg('yycp');" class="btn btn05">关闭</a>
					</div>
				</div>
			</div>
		</div>

	</div>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
	<script type="text/javascript">
	function hrefs(type){
		
		}

		function hidebg(id) {
			$("#" + id).hide();
		}
	</script>
</body>
</html>
