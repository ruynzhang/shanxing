package com.dimeng.p2p.console.servlets.info.kfzx;

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
import com.dimeng.p2p.common.enums.CustomerServiceType;
import com.dimeng.p2p.modules.base.console.service.CustomerServiceManage;
import com.dimeng.p2p.modules.base.console.service.entity.CustomerService;
import com.dimeng.util.parser.EnumParser;
import com.dimeng.util.parser.IntegerParser;

@MultipartConfig
@Right(id = "P2P_C_INFO_KFZX_ADD", name = "增加客户中心")
public class AddKfzx extends AbstractKfzxServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void processPost(final HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		try {
			CustomerServiceManage manage = serviceSession
					.getService(CustomerServiceManage.class);

			CustomerService service = new CustomerService() {

				@Override
				public CustomerServiceType getType() {
					return EnumParser.parse(CustomerServiceType.class,
							request.getParameter("type"));
				}

				@Override
				public int getSortIndex() {
					return IntegerParser.parse(request
							.getParameter("sortIndex"));
				}

				@Override
				public String getNumber() {
					return request.getParameter("number");
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
			};

			manage.add(service);
			sendRedirect(request, response,
					getController().getURI(request, SearchKfzx.class));
		} catch (ParameterException | LogicalException e) {
			prompt(request, response, PromptLevel.ERROR, e.getMessage());
			processGet(request, response, serviceSession);
		}

	}

}
