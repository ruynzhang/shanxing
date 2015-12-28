package com.dimeng.p2p.console.servlets.info.gywm.hzhb;

import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.http.upload.FileStore;
import com.dimeng.framework.http.upload.PartFile;
import com.dimeng.framework.http.upload.UploadFile;
import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.exception.LogicalException;
import com.dimeng.framework.service.exception.ParameterException;
import com.dimeng.p2p.console.servlets.info.AbstractInformationServlet;
import com.dimeng.p2p.modules.base.console.service.PartnerManage;
import com.dimeng.p2p.modules.base.console.service.entity.Partner;
import com.dimeng.p2p.modules.base.console.service.entity.PartnerRecord;
import com.dimeng.util.parser.IntegerParser;

@MultipartConfig
@Right(id = "P2P_C_INFO_HZHB_UPDATE", name = "修改合作伙伴")
public class UpdateHzhb extends AbstractInformationServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		try {
			Partner partner = new Partner() {

				@Override
				public String getURL() {
					return request.getParameter("url");
				}

				@Override
				public int getSortIndex() {
					return IntegerParser.parse(request
							.getParameter("sortIndex"));
				}

				@Override
				public String getName() {
					return request.getParameter("name");
				}

				@Override
				public UploadFile getImage() throws Throwable {
					Part part = request.getPart("image");
					if (part == null || part.getContentType() == null
							|| part.getSize() == 0) {
						return null;
					}
					return new PartFile(part);
				}

				@Override
				public String getDescription() {
					return getResourceProvider().getResource(FileStore.class)
							.encode(request.getParameter("content"));
				}

				@Override
				public String getAddress() {
					return request.getParameter("address");
				}
			};
			PartnerManage manage = serviceSession
					.getService(PartnerManage.class);
			manage.update(IntegerParser.parse(request.getParameter("id")),
					partner);
			sendRedirect(request, response,
					getController().getURI(request, SearchHzhb.class));
		} catch (ParameterException | LogicalException e) {
			prompt(request, response, PromptLevel.ERROR, e.getMessage());
			processGet(request, response, serviceSession);
		}
	}

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		PartnerManage manage = serviceSession.getService(PartnerManage.class);
		PartnerRecord record = manage.get(IntegerParser.parse(request
				.getParameter("id")));
		if (record == null) {
			response.sendError(HttpServletResponse.SC_NOT_FOUND);
			return;
		}
		request.setAttribute("record", record);
		forwardView(request, response, getClass());
	}

}
