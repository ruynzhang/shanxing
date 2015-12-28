<%@page import="com.dimeng.p2p.S50.entities.T5014"%>
<%@page import="com.dimeng.p2p.modules.base.front.service.FriendlyLinkManage"%>
<%{
	T5014[] friendlyLinks=serviceSession.getService(FriendlyLinkManage.class).getAll();
	if(friendlyLinks!=null&&friendlyLinks.length>0){
%>
 <div class="Parag">
      <div class="cement news_ct" style="width: 100%">
        <div class="noun">
          <h2>友情链接</h2>
          <div style="float: left;margin-left: 10px;">
           <%for(T5014 friendlyLink:friendlyLinks){if(friendlyLink==null){continue;}%>
		    <a style="color: black;margin-right: 10px;float: left;" <%="T".equals(friendlyLink.nofollow)?"rel=\"nofollow\"":""%> href="http://<%StringHelper.filterHTML(out, friendlyLink.F05.replaceAll("http://", ""));%>" target="_blank" title="<%StringHelper.filterHTML(out, friendlyLink.F04);%>"><%StringHelper.filterHTML(out, friendlyLink.F04);%></a>
		  <%}%> 
		  </div>
         </div>
       </div>
       <div class="clear"></div>
</div>
<%}}%>
