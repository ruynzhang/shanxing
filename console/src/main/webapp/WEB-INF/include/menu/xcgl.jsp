<%@page import="com.dimeng.p2p.console.servlets.info.helpCenter.HcList"%>
<%@page import="com.dimeng.p2p.console.servlets.info.zcydl.UpdateZcydl"%>
<%@page import="com.dimeng.p2p.console.servlets.info.zhyaq.UpdateZhyaq"%>
<%@page import="com.dimeng.p2p.console.servlets.info.tzyhk.UpdateTzyhk"%>
<%@page import="com.dimeng.p2p.console.servlets.info.czytx.UpdateCzytx"%>
<%@page import="com.dimeng.p2p.console.servlets.info.aqbz.gctm.UpdateGctm"%>
<%@page import="com.dimeng.p2p.console.servlets.info.aqbz.flhg.UpdateFlhg"%>
<%@page import="com.dimeng.p2p.console.servlets.info.aqbz.zjaq.UpdateZjaq"%>
<%@page import="com.dimeng.p2p.console.servlets.info.aqbz.xmfk.UpdateXmfk"%>
<%@page import="com.dimeng.p2p.console.servlets.info.aqbz.bxdb.UpdateBxdb"%>
<%@page import="com.dimeng.p2p.console.servlets.info.gywm.hzjg.UpdateHzjg"%>
<%@page import="com.dimeng.p2p.console.servlets.info.tzgl.ptzh.UpdatePtzh"%>
<%@page import="com.dimeng.p2p.console.servlets.info.tzgl.wyjk.UpdateWyjk"%>
<%@page import="com.dimeng.p2p.console.servlets.info.tzgl.wylc.UpdateWylc"%>
<%@page import="com.dimeng.p2p.console.servlets.info.tzgl.lxhfy.UpdateLxhfy"%>
<%@page import="com.dimeng.p2p.console.servlets.info.tzgl.ptjs.UpdatePtjs"%>
<%@page import="com.dimeng.p2p.console.servlets.info.tzgl.mcjs.UpdateMcjs"%>
<%@page import="com.dimeng.p2p.console.servlets.info.tzgl.xszy.SearchXszy"%>
<%@page import="com.dimeng.p2p.console.servlets.info.kfzx.SearchKfzx"%>
<%@page import="com.dimeng.p2p.console.servlets.info.bzwd.SearchBzwd"%>
<%@page import="com.dimeng.p2p.console.servlets.info.yqlj.SearchYqlj"%>
<%@page import="com.dimeng.p2p.console.servlets.info.wzgg.SearchWzgg"%>
<%@page import="com.dimeng.p2p.console.servlets.info.yjbg.SearchYjbg"%>
<%@page import="com.dimeng.p2p.console.servlets.info.xytk.SearchXytk"%>
<%@page import="com.dimeng.p2p.console.servlets.info.gggl.SearchGggl"%>
<%@page import="com.dimeng.p2p.console.servlets.info.gywm.aqbz.UpdateAqbz"%>
<%@page import="com.dimeng.p2p.console.servlets.info.gywm.lxwm.UpdateLxwm"%>
<%@page import="com.dimeng.p2p.console.servlets.info.gywm.zxns.UpdateZxns"%>
<%@page import="com.dimeng.p2p.console.servlets.info.gywm.hzhb.SearchHzhb"%>
<%@page import="com.dimeng.p2p.console.servlets.info.gywm.zjgw.SearchZjgw"%>
<%@page import="com.dimeng.p2p.console.servlets.info.gywm.gltd.SearchGltd"%>
<%@page import="com.dimeng.p2p.console.servlets.info.gywm.gsjj.UpdateGsjj"%>
<%@page import="com.dimeng.p2p.console.servlets.info.zxdt.shzr.SearchShzr"%>
<%@page import="com.dimeng.p2p.console.servlets.info.zxdt.mtbd.SearchMtbd"%>
<%@page import="com.dimeng.p2p.console.servlets.info.zxdt.hlwjryj.SearchHlwjryj"%>
<%@page import="com.dimeng.p2p.console.servlets.info.zxdt.wdhyzx.SearchWdhyzx"%>
<%
	if("XCGL".equals(CURRENT_CATEGORY)){
%>
<div class="l_main">
  <div class="sidenav admin_lf">
    <h2 class="home_yhgl">宣传管理<span class="ico"></span></h2>
  	<div>
      <p><a href="javascript:void(0)" style="cursor: default;">安全保障</a></p>
      <div>
        <ul class="admin_li">
        	<%
        		if(dimengSession.isAccessableResource(UpdateBxdb.class)){
        	%>
	        <li><a <%if("BXDB".equals(CURRENT_SUB_CATEGORY)){%>class="curr"<%}%> href="<%=controller.getURI(request, UpdateBxdb.class)%>">本息担保</a></li>
	        <%
	        	}else{
	        %>
          	<li><a href="javascript:viod(0)" class="disabled">本息担保</a></li>
          	<%
          		}
          	%>
          	
          	<%
          		if(dimengSession.isAccessableResource(UpdateXmfk.class)){
          	%>
	        <li><a <%if("XMFK".equals(CURRENT_SUB_CATEGORY)){%>class="curr"<%}%> href="<%=controller.getURI(request, UpdateXmfk.class)%>">项目风控</a></li>
	        <%
	        	}else{
	        %>
          	<li><a href="javascript:viod(0)" class="disabled">项目风控</a></li>
          	<%
          		}
          	%>
          	
          	<%
          		if(dimengSession.isAccessableResource(UpdateZjaq.class)){
          	%>
	        <li><a <%if("ZJAQ".equals(CURRENT_SUB_CATEGORY)){%>class="curr"<%}%> href="<%=controller.getURI(request, UpdateZjaq.class)%>">资金安全</a></li>
	        <%
	        	}else{
	        %>
          	<li><a href="javascript:viod(0)" class="disabled">资金安全</a></li>
          	<%
          		}
          	%>
		  
		  	<%
		  		if(dimengSession.isAccessableResource(UpdateFlhg.class)){
		  	%>
	        <li><a <%if("FLHG".equals(CURRENT_SUB_CATEGORY)){%>class="curr"<%}%> href="<%=controller.getURI(request, UpdateFlhg.class)%>">法律合规</a></li>
	        <%
	        	}else{
	        %>
          	<li><a href="javascript:viod(0)" class="disabled">法律法规</a></li>
          	<%
          		}
          	%>
          	
		  	<%
          		if(dimengSession.isAccessableResource(UpdateGctm.class)){
          	%>
	        <li><a <%if("GCTM".equals(CURRENT_SUB_CATEGORY)){%>class="curr"<%}%> href="<%=controller.getURI(request, UpdateGctm.class)%>">过程透明</a></li>
	        <%
	        	}else{
	        %>
          	<li><a href="javascript:viod(0)" class="disabled">过程透明</a></li>
          	<%
          		}
          	%>
		  	
		  	<%
		  		if(dimengSession.isAccessableResource(UpdateHzjg.class)){
		  	%>
	        <li><a <%if("HZJG".equals(CURRENT_SUB_CATEGORY)){%>class="curr"<%}%> href="<%=controller.getURI(request, UpdateHzjg.class)%>">合作机构</a></li>
	        <%
	        	}else{
	        %>
          	<li><a href="javascript:viod(0)" class="disabled">合作机构</a></li>
          	<%
          		}
          	%>
        </ul>
      </div>
    </div>
 
    <div>
      <p><a href="javascript:void(0)" style="cursor: default;">最新动态</a></p>
      <div>
        <ul class="admin_li">
        	<%if(dimengSession.isAccessableResource(SearchWdhyzx.class)){ %>
          <li><a <%if("WDHYZX".equals(CURRENT_SUB_CATEGORY)){%>class="curr"<%}%> href="<%=controller.getURI(request, SearchWdhyzx.class)%>">网贷行业资讯</a></li>
          <%}else{ %>
          	<li><a href="javascript:viod(0)" class="disabled">网贷行业资讯</a></li>
          <%} %>
          
          <%if(dimengSession.isAccessableResource(SearchHlwjryj.class)){ %>
          <li><a <%if("HLWJRYJ".equals(CURRENT_SUB_CATEGORY)){%>class="curr"<%}%> href="<%=controller.getURI(request, SearchHlwjryj.class)%>">互联网金融研究</a></li>
          <%}else{ %>
          	<li><a href="javascript:viod(0)" class="disabled">互联网金融研究</a></li>
          <%} %>
          
           <%if(dimengSession.isAccessableResource(SearchMtbd.class)){ %>
          <li><a <%if("MTBD".equals(CURRENT_SUB_CATEGORY)){%>class="curr"<%}%> href="<%=controller.getURI(request, SearchMtbd.class)%>">媒体报道</a></li>
         <%}else{ %>
          	<li><a href="javascript:viod(0)" class="disabled">媒体报道</a></li>
          <%} %>
         
          <%if(dimengSession.isAccessableResource(SearchShzr.class)){ %>
          <li><a <%if("SHZR".equals(CURRENT_SUB_CATEGORY)){%>class="curr"<%}%> href="<%=controller.getURI(request, SearchShzr.class)%>">社会责任</a></li>
         <%}else{ %>
          	<li><a href="javascript:viod(0)" class="disabled">社会责任</a></li>
          <%} %>
        </ul>
      </div>
    </div>
    <div>
      <p><a href="javascript:void(0)" style="cursor: default;">关于我们</a></p>
      <div>
        <ul class="admin_li">
        	<%if(dimengSession.isAccessableResource(UpdateGsjj.class)){ %>
	        <li><a <%if("GSJJ".equals(CURRENT_SUB_CATEGORY)){%>class="curr"<%}%> href="<%=controller.getURI(request, UpdateGsjj.class)%>">公司简介</a></li>
	         <%}else{ %>
          	<li><a href="javascript:viod(0)" class="disabled">公司简介</a></li>
          	<%} %>
          
          	<%if(dimengSession.isAccessableResource(SearchGltd.class)){ %>
	        <li><a <%if("GLTD".equals(CURRENT_SUB_CATEGORY)){%>class="curr"<%}%> href="<%=controller.getURI(request, SearchGltd.class)%>">管理团队</a></li>
	         <%}else{ %>
          	<li><a href="javascript:viod(0)" class="disabled">管理团队</a></li>
          	<%} %>
	        
	        <%if(dimengSession.isAccessableResource(SearchZjgw.class)){ %>
	        <li><a <%if("ZJGW".equals(CURRENT_SUB_CATEGORY)){%>class="curr"<%}%> href="<%=controller.getURI(request, SearchZjgw.class)%>">专家顾问</a></li>
	         <%}else{ %>
          	<li><a href="javascript:viod(0)" class="disabled">专家顾问</a></li>
          	<%} %>
	        
	        <%if(dimengSession.isAccessableResource(SearchHzhb.class)){ %>
	        <li><a <%if("HZHB".equals(CURRENT_SUB_CATEGORY)){%>class="curr"<%}%> href="<%=controller.getURI(request, SearchHzhb.class)%>">合作伙伴</a></li>
	         <%}else{ %>
          	<li><a href="javascript:viod(0)" class="disabled">合作伙伴</a></li>
          	<%} %>
          	
          	<%--<%if(dimengSession.isAccessableResource(UpdateHzjg.class)){ 
	        <li><a <%if("HZJG".equals(CURRENT_SUB_CATEGORY)){%>class="curr"<%}%> href="<%=controller.getURI(request, UpdateHzjg.class)%>">合作机构</a></li>
	         <%}else{ %>
          	<li><a href="javascript:viod(0)" class="disabled">合作机构</a></li>
          	<%} %>--%>
	        
	         <%if(dimengSession.isAccessableResource(UpdateZxns.class)){ %>
	        <li><a <%if("ZXNS".equals(CURRENT_SUB_CATEGORY)){%>class="curr"<%}%> href="<%=controller.getURI(request, UpdateZxns.class)%>">招贤纳士</a></li>
	         <%}else{ %>
          	<li><a href="javascript:viod(0)" class="disabled">招贤纳士</a></li>
          	<%} %>
	        
	        <%if(dimengSession.isAccessableResource(UpdateLxwm.class)){ %>
	        <li><a <%if("LXWM".equals(CURRENT_SUB_CATEGORY)){%>class="curr"<%}%> href="<%=controller.getURI(request, UpdateLxwm.class)%>">联系我们</a></li>
	        <%}else{ %>
          	<li><a href="javascript:viod(0)" class="disabled">联系我们</a></li>
          	<%} %>
	        
	        <%if(dimengSession.isAccessableResource(UpdateAqbz.class)){ %>
	        <li><a <%if("AQBZ".equals(CURRENT_SUB_CATEGORY)){%>class="curr"<%}%> href="<%=controller.getURI(request, UpdateAqbz.class)%>">安全保障(大事记)</a></li>
	        <%}else{ %>
          	<li><a href="javascript:viod(0)" class="disabled">安全保障(大事记)</a></li>
          	<%} %>
        </ul>
      </div>
    </div>
  

   
    <div>
      <p><a href="javascript:void(0)" style="cursor: default;">运营管理</a></p>
      <div>
        <ul class="admin_li">
        	<%if(dimengSession.isAccessableResource(SearchGggl.class)){ %>
        	<li><a <%if("GGGL".equals(CURRENT_SUB_CATEGORY)){%>class="curr"<%}%> href="<%=controller.getURI(request, SearchGggl.class)%>">广告管理</a></li>
        	 <%}else{ %>
          	<li><a href="javascript:viod(0)" class="disabled">广告管理</a></li>
          	<%} %>
          	
          	<%if(dimengSession.isAccessableResource(SearchXytk.class)){ %>
        	<li><a <%if("XYTK".equals(CURRENT_SUB_CATEGORY)){%>class="curr"<%}%> href="<%=controller.getURI(request, SearchXytk.class)%>">协议条款</a></li>
        	 <%}else{ %>
          	<li><a href="javascript:viod(0)" class="disabled">协议条款</a></li>
          	<%} %>
        	
        	<%if(dimengSession.isAccessableResource(SearchYjbg.class)){ %>
	        <li><a <%if("YJBG".equals(CURRENT_SUB_CATEGORY)){%>class="curr"<%}%> href="<%=controller.getURI(request, SearchYjbg.class)%>">业绩报告</a></li>
	        <%}else{ %>
          	<li><a href="javascript:viod(0)" class="disabled">业绩报告</a></li>
          	<%} %>
	        
	        <%if(dimengSession.isAccessableResource(SearchWzgg.class)){ %>
		    <li><a <%if("WZGG".equals(CURRENT_SUB_CATEGORY)){%>class="curr"<%}%> href="<%=controller.getURI(request, SearchWzgg.class)%>">网站公告</a></li>
		    <%}else{ %>
          	<li><a href="javascript:viod(0)" class="disabled">网站公告</a></li>
          	<%} %>
		    
		    <%if(dimengSession.isAccessableResource(SearchYqlj.class)){ %>
		    <li><a <%if("YQLJ".equals(CURRENT_SUB_CATEGORY)){%>class="curr"<%}%> href="<%=controller.getURI(request, SearchYqlj.class)%>">友情链接</a></li>
		     <%}else{ %>
          	<li><a href="javascript:viod(0)" class="disabled">友情链接</a></li>
          	<%} %>
          	
          	<%if(dimengSession.isAccessableResource(SearchKfzx.class)){ %>
		    <li><a <%if("KFZX".equals(CURRENT_SUB_CATEGORY)){%>class="curr"<%}%> href="<%=controller.getURI(request, SearchKfzx.class)%>">客服中心</a></li>
		     <%}else{ %>
          	<li><a href="javascript:viod(0)" class="disabled">客服中心</a></li>
          	<%} %>
        </ul>
       </div>
    </div>
    <div>
      <p><a href="javascript:void(0)" style="cursor: default;">帮助中心</a></p>
      <div>
        <ul class="admin_li">
       		<%
        		if(dimengSession.isAccessableResource(HcList.class)){
        	%>
          	<li><a <%if("HCLIST".equals(CURRENT_SUB_CATEGORY)){%>class="curr"<%}%> href="<%=controller.getURI(request, HcList.class)%>">帮助中心</a></li>
         	<%
         		}else{
         	%>
          	<li><a href="javascript:viod(0)" class="disabled">帮助中心</a></li>
          	<%
          		}
          	%>
        </ul>
      </div>
    </div>
    
    <div></div>
  </div>
</div>
<%}%>
 