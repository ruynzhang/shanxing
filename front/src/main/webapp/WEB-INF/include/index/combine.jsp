<%@page import="com.dimeng.p2p.S50.entities.T5011"%>
<%@page import="com.dimeng.p2p.S50.entities.T5014"%>
<%@page import="com.dimeng.p2p.modules.base.front.service.ArticleManage"%>
<%@page import="com.dimeng.p2p.modules.base.front.service.FriendlyLinkManage"%>
<%@page import="com.dimeng.p2p.S50.enums.T5011_F02"%>
<%@page import="com.dimeng.p2p.front.servlets.AbstractFrontServlet"%>
<%@page import="com.dimeng.p2p.front.servlets.zxdt.Mtbd"%>
<%@page import="com.dimeng.p2p.front.servlets.zxdt.Hlwjryj"%>
<%@page import="com.dimeng.p2p.front.servlets.zxdt.Wdhyzx"%>
<%@page import="com.dimeng.p2p.common.enums.ArticleType"%>
<%@page import="com.dimeng.p2p.account.front.service.UserManage"%>
<%@page import="com.dimeng.p2p.common.BidemInt"%>
<%@page import="java.util.List"%>


<div class="sx_normal_box sx_baozai">
       <div class="sx_box_title">本息保障金</div>
       <div class="sx_box_ct" >
         <span class="sx_bluefont f32" style="float:left;">￥</span><p  style="float:left; cursor:pointer;" class="timer count-title sx_bluefont f32 count-number" data-to="10000000" data-speed="1500" onclick="location.href='<%=controller.getStaticPath(request)%>/safe/keep.html#baozhan'"></p>
       </div>
   </div>
   <%--
  <% 
   if(tyjbid!=null){
   %>
   <div class="sx_normal_box2 mt22" style="position:relative;">
     <a href="/active/rank.html" target="_blank"><img src="images/m_ad1.jpg" alt="" /></a>
     <!-- <a href="<%configureProvider.format(out,URLVariable.USER_NCIIC);%>" class="ti_picbt ti_picbt1" >实名认证送800体验金</a>
     <a href="<%configureProvider.format(out,URLVariable.REGISTER);%>" class="ti_picbt ti_picbt2" >注册送200体验金</a>
     
     <a href="/user/account/safetymsg.html" class="ti_picbt ti_picbt1">实名认证送1000体验金</a>
     <a href="/register.html" class="ti_picbt ti_picbt2">注册送500体验金</a>
      -->
   </div>
   <%} %> --%>
   <div class="sx_normal_box mt22">
       <div class="sx_box_title">成功投标</div>
       <div class="sx_box_ct maquee">
          <ul class="sx_invester_new">
             <%
                UserManage usermage = serviceSession.getService(UserManage.class);
                List<BidemInt> list = usermage.getBidemintlist();
                if (list != null){
                   for(BidemInt bigemint:list){
             %>
             <li>
                <p class="invester_award">获得收益￥<%=bigemint.F04%></p>
                <p class="invester_name"><%StringHelper.filterHTML(out, bigemint.F02.substring(0,4)+"***");%>投资￥<%=bigemint.F03%></p>
             </li>
             <%} }%>
             
          </ul>
       </div>
       <p class="sx_invester_more"></p>
   </div>
   <div class="sx_normal_box mt22 sx_boxgroup">
       <div class="sx_3box">
			<ul class="tab_menu">
				<li class="current">新手指引</li>
				<li>理财透明</li>
				<li>风控流程</li>
			</ul>
			<div class="tab_box">
				<div>
                    <div class="invest_ctbox">
					<img src="images/newguide.jpg" alt="" />
                    <p>我要投资，我是新手怎么办？<br /><a href="<%=controller.getStaticPath(request)%>/guide/" class="sx_pinkLink">新手指引&gt;&gt;</a></p>
                    </div>
				</div>
				<div class="hide">
					<ul>
						<li><span class="sx_angle"></span><a href="<%=controller.getStaticPath(request)%>/zxdt/mtbd/86.html" target="_blank">中国互联网金融行业AAA级信用企业</a></li>
                        <li><span class="sx_angle"></span><a href="<%=controller.getStaticPath(request)%>/zxdt/mtbd/126.html" target="_blank">荣获中国互联网信用评价征信证书</a></li>
                        <li><span class="sx_angle"></span><a href="<%=controller.getStaticPath(request)%>/zxdt/wzgg/23.html" target="_blank">充值投资手续费全免</a></li>
                        <li><span class="sx_angle"></span><a href="<%=controller.getStaticPath(request)%>/xszy/help.htm?id=2&pid=10&cid=93" target="_blank">提现最快当天到账</a></li>
					</ul>
				</div>
				<div class="hide">
                   <div class="sx_show_3box_pic">
					<img src="images/sx_process.jpg" alt="" />
                    
                   </div>
				</div>
			</div>
		</div>
   </div>
   


