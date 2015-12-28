<%@page import="com.dimeng.p2p.S50.entities.T5013"%>
<%@page import="com.dimeng.p2p.modules.base.front.service.PartnerManage"%>
<%@page import="com.dimeng.framework.http.upload.FileStore"%>
<%{T5013[] partners=serviceSession.getService(PartnerManage.class).getAll();if(partners!=null&&partners.length>0){%>
<div class="clear"></div>
<div class="picMarquee-left clearfix">
	<div class="pub_tit">
		<span class="fl">合作伙伴</span>
	</div>
	<div class="bd">
		<ul class="picList">
			<%for(T5013 parter:partners){if(parter==null){continue;}%>
			<li><a href="http://<%StringHelper.filterHTML(out, parter.F05.replaceAll("http://", ""));%>" target="_blank" title="<%StringHelper.filterHTML(out, parter.F04);%>"><img src="<%=fileStore.getURL(parter.F06)%>" alt="<%StringHelper.filterHTML(out, parter.F04);%>" height="45px" width="131px"/></a></li>
			<%}%>
		</ul>
	</div>
</div>
<%}}%>


