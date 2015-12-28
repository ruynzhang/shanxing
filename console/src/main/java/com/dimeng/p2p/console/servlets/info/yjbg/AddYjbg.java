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
import com.dimeng.util.parser.EnumParser;

@MultipartConfig
@Right(id = "P2P_C_INFO_YJBG_ADD", name = "增加业绩报告")
public class AddYjbg extends AbstractYjbgServlet {
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
			manage.add(report);
			sendRedirect(request, response,
					getController().getURI(request, SearchYjbg.class));
		} catch (ParameterException | LogicalException e) {
			prompt(request, response, PromptLevel.ERROR, e.getMessage());
			processGet(request, response, serviceSession);
		}
	}

}
