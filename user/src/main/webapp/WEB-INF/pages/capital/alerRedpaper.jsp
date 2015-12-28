<%@page import="com.dimeng.p2p.account.user.service.UserInfoManage"%>
<%@page import="com.dimeng.p2p.user.servlets.capital.AlerRedpaper"%>
<%@page import="com.dimeng.p2p.user.servlets.capital.Redpaperend"%>
<%@page import="com.dimeng.p2p.user.servlets.capital.Redpaper"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>我的<%configureProvider.format(out,SystemVariable.SITE_NAME);%>_红包
</title>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
	<%@include file="/WEB-INF/include/header.jsp"%>
	<%
		//CURRENT_CATEGORY = "WDHB";
	CURRENT_SUB_CATEGORY = "WDHB";
		//CURRENT_SUB_CATEGORY = "DDCX";
	%>
	<div class="w994 pb5">
		<span class="f16">
		<a href="<%=controller.getViewURI(request, com.dimeng.p2p.user.servlets.Index.class)%>">我的<%
			configureProvider.format(out,SystemVariable.SITE_NAME);
		%></a>
		</span> &gt; <a href="javascript:void(0)">资金管理</a>&gt; 我的红包
	</div>
	<div class="contain clearfix">
		<div class="user_top"></div>
		<div class="about">
			<%@include file="/WEB-INF/include/menu.jsp"%>
			<div class="container fr">
				<div class="p15">
					<div class="ln30 Men_bt">
						<div class="Menubox">                   
		                     <ul>
		                        <li><a href="<%=controller.getViewURI(request, Redpaper.class)%>">未使用</a></li>
		                        <li class="hover">已使用</li>
		                        <li style="border-right:1px #d7dfe3 solid;"><a href="<%=controller.getViewURI(request, Redpaperend.class)%>">已过期</a></li> 
		                     </ul>
	                    </div>
                        <div class="clear"></div>
					</div>
                    <form action="" method="post">
               		<div class="bs_bg pt10">
		                  <div class="no_table user_bolr bot">
		                    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="user_table tc">
		                      <tr class="user_lsbg">
		                        <td>红包</td>
		                        <td>个数</td>
		                        <td>使用日期</td>
		                      </tr>
		                      <tr>
		                        <td colspan="3">你暂时没有已使用的红包</td>
		                      </tr>
		                    </table>
		            	  </div>
		                    <div class="page">
								<% // AbstractFinancingServlet.rendPagingResult(out, raList); %>
							</div>
                  </div>         
                  </form>
                    <div class="ln30 pl20 mb40">
						<p class="blue f16">红包使用规则：</p>
						 具体红包使用规则在上线时再作公布<br>
					    *本规则最终的解析权归善行创投所有
					<!--  
						2、红包只能使用一次，使用时最多抵扣服务费的20%，如服务费100元，即可使用20元红包，服务费200元，即可使用40元红包，红包剩余金额即将失效<br>
                        3、红包不能提现，平台上线之日起60个自然日内有效（平台即将上线）<br>
						4、红包将于2014年12月15日10点后可在平台的“我的账户”中点击“我的红包”查看红包数量，12月15日前功能“我的红包”暂未开通（统计中奖红包数量中）<br>
						5、所抽红包只能在每笔服务费中使用3个红包<br>
						6、对于恶意刷奖的用户，善行创投有权取消其活动资格，所得奖励不予承兑<br>
                           &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*本规则最终的解析权归善行创投所有 -->
					</div>
				</div>
			</div>
			<div class="clear"></div>
		</div>
	</div>
	<%@include file="/WEB-INF/include/footer.jsp"%>
	<%@include file="/WEB-INF/include/script.jsp"%>
	<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/charge.js"></script>
</body>
</html>