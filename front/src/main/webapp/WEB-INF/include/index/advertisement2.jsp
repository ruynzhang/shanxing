<%@page import="com.dimeng.p2p.S50.entities.T5016"%>
<%@page import="com.dimeng.p2p.modules.base.front.service.AdvertisementManage"%>
<%{
	AdvertisementManage advertisementManage = serviceSession.getService(AdvertisementManage.class);
	T5016[] advertisements = advertisementManage.getAll();
	if (advertisements != null && advertisements.length > 0) {
%>
<div class="fullSlide clearfix">
	<div class="bd">
		<ul>
			<%for(T5016 advertisement : advertisements){if (advertisement == null) {continue;}%>
			<li style="background: url(<%=fileStore.getURL(advertisement.F05)%>) no-repeat center center; margin-left: -2px;" title="<%StringHelper.filterHTML(out, advertisement.F03);%>">
				<%if(!StringHelper.isEmpty(advertisement.F04)){%>
				<a target="_blank" href="<%StringHelper.filterHTML(out, advertisement.F04);%>" style="height:300px; display:block;"></a>
				<%}%>
			</li>
			<%}%>
		</ul>
	</div>
	<div class="hd"><ul></ul></div>
</div>
<%}}%>