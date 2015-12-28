<%@page import="com.dimeng.p2p.account.front.service.UserManage"%>
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
<%@page import="com.dimeng.p2p.common.Phpinfo"%>
<%@page import="java.util.List"%>

<div class="sx_normal_box sx_user_voice">
      <div class="sx_box_title"><a  href="<%configureProvider.format(out, URLVariable.GYWM_BBS);%>" target="_blank" class="sx_info_more">更多&gt;&gt;</a>用户心声</div>
      <div class="maquee2">
      <ul>
          <%
          UserManage usmanage = serviceSession.getService(UserManage.class);
          List<Phpinfo> list2 = usmanage.getpnpinfolist();
         
          if (list2 != null){
             for (Phpinfo phpinfo: list2){
             %>
        <li>
        <div class="sx_froum_box">
        <div class="sx_user_icon"><img src="<%configureProvider.format(out, URLVariable.GYWM_BBS);%>/uc_server/avatar.php?uid=<%=phpinfo.authorid%>&size=middle" alt="" /></div>
        <div class="sx_user_desc">
           <p class="sx_user_name"><%StringHelper.filterHTML(out, phpinfo.author.substring(0,4)+"***");%></p>
           <p class="sc_user_word"><a href="<%configureProvider.format(out, URLVariable.GYWM_BBS);%>/forum.php?mod=viewthread&tid=<%=phpinfo.tid%>"  target="_blank"><%StringHelper.filterHTML(out, phpinfo.subject);%></a></p>
        </div>
         <div class="sx_user_date"><%=DateTimeParser.format(phpinfo.dateline,"yyyy-MM-dd") %></div>
        <div class="clear"></div>
        </div>
        </li>
        <% } } %>
      </ul>
      </div>
      <div class="clear"></div>
</div>