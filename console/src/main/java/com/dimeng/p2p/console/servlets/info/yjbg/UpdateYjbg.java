package com.dimeng.p2p.console.servlets.info.yjbg;

import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.http.upload.PartFile;
import com.dimeng.framework.http.upload.UploadFile;
import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.exception.LogicalException;
import com.dimeng.framework.service.exception.ParameterException;
import com.dimeng.p2p.common.enums.PerformanceReportPublishStatus;
import com.dimeng.p2p.modules.base.console.service.PerformanceReportManage;
import com.dimeng.p2p.modules.base.console.service.entity.PerformanceReport;
import com.dimeng.p2p.modules.base.console.service.entity.PerformanceReportRecord;
import com.dimeng.util.parser.EnumParser;
import com.dimeng.util.parser.IntegerParser;

@MultipartConfig
@Right(id = "P2P_C_INFO_YJBG_UPDATE", name = "修改业绩报告")
public class UpdateYjbg extends AbstractYjbgServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		try {
			PerformanceReport report = new PerformanceReport() {

				@Override
				public String getTitle() {
					return request.getParameter("title");
				}

				@Override
				public PerformanceReportPublishStatus getPublishStatus() {
					return EnumParser.parse(
							PerformanceReportPublishStatus.class,
							request.getParameter("status"));
				}

				@Override
				public UploadFile getAttachment() throws Throwable {
					Part part = request.getPart("file");
					if (part == null || part.getContentType() == null
							|| part.getSize() == 0) {
						return null;
					}
					return new PartFile(part);
				}
			};
			PerformanceReportManage manage = serviceSession
					.getService(PerformanceReportManage.class);
			manage.update(IntegerParser.parse(request.getParameter("id")),
					report);
			sendRedirect(request, response,
					getController().getURI(request, SearchYjbg.class));
		} catch (ParameterException | LogicalException e) {
			prompt(request, response, PromptLevel.ERROR, e.getMessage());
			processGet(request, response, serviceSession);
		}

	}

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		PerformanceReportManage manage = serviceSession
				.getService(PerformanceReportManage.class);
		PerformanceReportRecord record = manage.get(IntegerParser.parse(request
				.getParameter("id")));
		if (record == null) {
			response.sendError(HttpServletResponse.SC_NOT_FOUND);
			return;
		}
		request.setAttribute("record", record);
		forwardView(request, response, getClass());
	}
}
