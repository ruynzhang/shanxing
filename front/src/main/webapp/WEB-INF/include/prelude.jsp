<%@page import="com.dimeng.framework.http.session.authentication.PasswordAuthentication"%>
<%@page import="com.dimeng.framework.http.upload.FileStore"%>
<%@page import="com.dimeng.util.Formater"%>
<%@page import="com.dimeng.util.StringHelper"%>
<%@page import="com.dimeng.util.ObjectHelper"%>
<%@page import="com.dimeng.util.parser.*"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="com.dimeng.framework.config.*"%>
<%@page import="com.dimeng.framework.resource.*"%>
<%@page import="com.dimeng.framework.http.servlet.*"%>
<%@page import="com.dimeng.framework.http.session.*"%>
<%@page import="com.dimeng.framework.service.*"%>
<%@page import="com.dimeng.framework.service.query.*"%>
<%@page import="com.dimeng.p2p.variables.*"%>
<%@page import="com.dimeng.p2p.variables.defines.*"%>
<%@page session="false"%>
<%
	boolean JQUERY_NOT_INCLUDED = true;
	boolean JQUERY_UI_NOT_INCLUDED = true;
	boolean DIALOG_NOT_INCLUDED = true;
	String CURRENT_CATEGORY = "";
	String CURRENT_SUB_CATEGORY = "";
	ResourceProvider resourceProvider = ResourceRegister.getResourceProvider(application);
	SessionManager sessionManager = resourceProvider.getResource(SessionManager.class);
	Session dimengSession = sessionManager.getSession(request, response,true);
	SystemDefine systemDefine = resourceProvider.getSystemDefine();
	try (ServiceSession serviceSession = resourceProvider.getResource(
			ServiceProvider.class).createServiceSession(dimengSession)) {
		FileStore fileStore  = resourceProvider.getResource(FileStore.class);
		Rewriter rewriter = resourceProvider.getSystemDefine().getRewriter();
		Controller controller = resourceProvider.getResource(Controller.class);
		ConfigureProvider configureProvider = resourceProvider.getResource(ConfigureProvider.class);
%>