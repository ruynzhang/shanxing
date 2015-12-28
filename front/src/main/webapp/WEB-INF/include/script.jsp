<%--@include file="/WEB-INF/include/jquery.jsp" --%>
<script type="text/javascript">

<%--{var a = window.opener||window.parent;while(a.parent!=a){a = a.parent;}if(a.location.host!='<%=configureProvider.format(systemDefine.getSiteDomainKey())%>'){a.location.href='<%=configureProvider.format(systemDefine.getSiteIndexKey())%>';}}--%>
$(function(){$("#nav").click(function(e){var src = e?e.target:event.srcElement;if(src.tagName == "H3"){var next = src.nextElementSibling || src.nextSibling;next.style.display = (next.style.display =="block")?"none":"block";}});});
function setTab(name,cursel,n){for(var i=1;i<=n;i++){var menu=document.getElementById(name+i);var con=document.getElementById("con_"+name+"_"+i);menu.className=i==cursel?"hover":"";con.style.display=i==cursel?"block":"none";}}
//-->
</script> 
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/public.min.js"></script>