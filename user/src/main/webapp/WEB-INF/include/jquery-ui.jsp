<%@include file="/WEB-INF/include/jquery.jsp" %>
<%if(JQUERY_UI_NOT_INCLUDED){%>
<link type="text/css" rel="stylesheet" href="<%=controller.getStaticPath(request)%>/js/jquery-ui-1.10.4/css/smoothness/jquery-ui-1.10.4.custom.min.css" media="screen" />
<script type="text/javascript" src="<%=controller.getStaticPath(request)%>/js/jquery-ui-1.10.4/js/jquery-ui-1.10.4.custom.min.js" charset="UTF-8"></script>
<script src="<%=controller.getStaticPath(request) %>/js/jquery-ui-1.10.4/js/jquery-ui-i18n.js"></script>
<%JQUERY_UI_NOT_INCLUDED=false;}%>