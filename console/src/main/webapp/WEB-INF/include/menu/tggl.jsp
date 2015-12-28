<%@page import="com.dimeng.p2p.console.servlets.spread.ywygl.Statistics"%>
<%@page import="com.dimeng.p2p.console.servlets.spread.ywygl.SalesmanList"%>
<%@page import="com.dimeng.p2p.console.servlets.spread.hdgl.SearchHdgl"%>
<%@page import="com.dimeng.p2p.console.servlets.spread.tgxq.SearchTgxq"%>
<%@page import="com.dimeng.p2p.console.servlets.spread.tgjl.SearchTgjl"%>
<%@page import="com.dimeng.p2p.console.servlets.spread.tgtj.SearchTgtj"%>
<%if("TGGL".equals(CURRENT_CATEGORY)){%>
<div class="l_main">
	<div class="sidenav admin_lf">
		<h2 class="home_yhgl">推广管理<span class="ico"></span></h2>     
		<div>
	      <p><a href="javascript:void(0)" style="cursor: default;">推广奖励</a></p>
	      <div>
	        <ul class="admin_li">
	        	<%if(dimengSession.isAccessableResource(SearchTgtj.class)){ %>
	         	<li><a <%if("TGTJ".equals(CURRENT_SUB_CATEGORY)){%>class="curr"<%}%> href="<%=controller.getURI(request, SearchTgtj.class) %>">推广奖励概要列表</a></li>
	        	<%}else{ %>
          		<li><a href="javascript:viod(0)" class="disabled">推广奖励概要列表</a></li>
          		<%} %>
	        	
	        	<%if(dimengSession.isAccessableResource(SearchTgjl.class)){ %>
	        	<li><a <%if("TGJL".equals(CURRENT_SUB_CATEGORY)){%>class="curr"<%}%> href="<%=controller.getURI(request, SearchTgjl.class) %>">推广持续奖励详情列表</a></li>
	        	<%}else{ %>
          		<li><a href="javascript:viod(0)" class="disabled">推广持续奖励详情列表</a></li>
          		<%} %>
          		
	        	<%if(dimengSession.isAccessableResource(SearchTgxq.class)){ %>
	        	<li><a <%if("TGXQ".equals(CURRENT_SUB_CATEGORY)){%>class="curr"<%}%> href="<%=controller.getURI(request, SearchTgxq.class) %>">推广详情列表</a></li>
	       		<%}else{ %>
          		<li><a href="javascript:viod(0)" class="disabled">推广详情列表</a></li>
          		<%} %>
	        </ul>
	      </div>
	    </div>  
	    <%-- <div>
	      <p><a href="javascript:void(0)" style="cursor: default;">活动管理</a></p>
	      <div>
	        <ul class="admin_li">
	        	<%if(dimengSession.isAccessableResource(SearchHdgl.class)){ %>
	         	<li><a <%if("HDGL".equals(CURRENT_SUB_CATEGORY)){%>class="curr"<%}%> href="<%=controller.getURI(request, SearchHdgl.class) %>">活动管理</a></li>
	        	<%}else{ %>
          		<li><a href="javascript:viod(0)" class="disabled">活动管理</a></li>
          		<%} %>
	        </ul>
	      </div>
	    </div> 
	      <div>
	      <p><a href="javascript:void(0)" style="cursor: default;">业务员管理</a></p>
	      <div>
	        <ul class="admin_li">
	        	<%if(dimengSession.isAccessableResource(SalesmanList.class)){ %>
	         	<li><a <%if("YWYGL".equals(CURRENT_SUB_CATEGORY)){%>class="curr"<%}%> href="<%=controller.getURI(request, SalesmanList.class) %>">业务员信息</a></li>
	        	<%}else{ %>
          		<li><a href="javascript:viod(0)" class="disabled">业务员信息</a></li>
          		<%} %>
          		
          		<%if(dimengSession.isAccessableResource(Statistics.class)){ %>
	         	<li><a <%if("TJTJ".equals(CURRENT_SUB_CATEGORY)){%>class="curr"<%}%> href="<%=controller.getURI(request, Statistics.class) %>">推荐统计</a></li>
	        	<%}else{ %>
          		<li><a href="javascript:viod(0)" class="disabled">推荐统计</a></li>
          		<%} %>
	        </ul>
	      </div>
	    </div> 
	    --%>   
	</div>   
	<div></div>
</div>
<%}%>
 