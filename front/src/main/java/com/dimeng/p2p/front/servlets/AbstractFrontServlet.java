package com.dimeng.p2p.front.servlets;

import java.awt.image.BufferedImage;
import java.io.IOException;
import java.security.SecureRandom;
import java.util.Properties;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;

import com.dimeng.framework.config.ConfigureProvider;
import com.dimeng.framework.http.servlet.AbstractServlet;
import com.dimeng.framework.http.servlet.Controller;
import com.dimeng.framework.http.session.authentication.AuthenticationException;
import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.resource.ResourceProvider;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.query.Paging;
import com.dimeng.framework.service.query.PagingResult;
import com.dimeng.p2p.variables.defines.URLVariable;
import com.dimeng.util.StringHelper;
import com.google.code.kaptcha.Producer;
import com.google.code.kaptcha.util.Config;

/**
 * 前台系统抽象Servlet
 * 
 */
public abstract class AbstractFrontServlet extends AbstractServlet {

	private static final long serialVersionUID = 1L;

	public static final Paging INDEX_PAGING = new Paging() {
		public int getCurrentPage() {
			return 1;
		}

		public int getSize() {
			return 6;
		}
	};
	public static final Producer COMMON_KAPTCHA_PRODUCER;

	protected static final SecureRandom RANDOM = new SecureRandom();

	static {
		ImageIO.setUseCache(false);
		final Properties props = new Properties();
		props.setProperty("kaptcha.image.height", "70");
		props.put("kaptcha.border", "no");
		props.put("kaptcha.textproducer.font.color", "black");
		props.put("kaptcha.textproducer.char.space", "5");
		COMMON_KAPTCHA_PRODUCER = new Config(props).getProducerImpl();
	}

	public static void showKaptcha(Producer producer, String verifyCode,
			HttpServletResponse response) {
		response.setContentType("image/jpeg");
		response.setDateHeader("Expires", 0);
		response.setHeader("Cache-Control",
				"no-store, no-cache, must-revalidate");
		response.addHeader("Cache-Control", "post-check=0, pre-check=0");
		response.setHeader("Pragma", "no-cache");
		try {
			final BufferedImage bi = producer.createImage(verifyCode);
			ImageIO.write(bi, "jpeg", response.getOutputStream());
		} catch (IOException e) {
		}
	}

	public static void showKaptcha(Producer producer, String verifyCode,
			PageContext pageContext) {
		HttpServletResponse response = (HttpServletResponse) pageContext
				.getResponse();
		response.setContentType("image/jpeg");
		response.setDateHeader("Expires", 0);
		response.setHeader("Cache-Control",
				"no-store, no-cache, must-revalidate");
		response.addHeader("Cache-Control", "post-check=0, pre-check=0");
		response.setHeader("Pragma", "no-cache");
		try {
			final BufferedImage bi = producer.createImage(verifyCode);
			ImageIO.write(bi, "jpeg", response.getOutputStream());
			JspWriter out = pageContext.getOut();
			out.clear();
			out = pageContext.pushBody();
		} catch (IOException e) {
		}
	}

	@Override
	protected boolean mustAuthenticated() {
		return false;
	}

	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		sendRedirect(request, response,
				getController().getViewURI(request, getClass()));
	}

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		sendRedirect(request, response,
				getController().getViewURI(request, getClass()));
	}

	/**
	 * 
	 * @param out
	 * @param paging
	 * @param pagingPath
	 *            分页路径 {@code /}结尾
	 * @param parameters
	 *            包含{@code ?}字符
	 * @throws IOException
	 */
	public static void rendPaging(JspWriter out, PagingResult<?> paging,
			String pagingPath, String parameters) throws IOException {
		if (out == null) {
			return;
		}
		boolean notEmpty = !StringHelper.isEmpty(parameters);
		int currentPage = paging.getCurrentPage();
		out.print("<div class='page'>");
		out.print("<span class='fl pr15 ml150'>第");
		out.print(currentPage);
		out.print("页/共");
		out.print(paging.getPageCount());
		out.print("页");
		out.print("（共" + paging.getItemCount() + "条记录）");
		out.print("</span>");
		if (currentPage == 1 && paging.getPageCount() > 1) {
			out.print("<a href=\"#\"><span class='page-link prev'></span></a>");
		}
		if (currentPage > 1) {
			out.print("<a href='");
			out.print(pagingPath);
			out.print(1);
			if (notEmpty) {
				out.print(parameters);
			}
			out.print("' class='page-link'>首页</a>");

			out.print("<a href='");
			out.print(pagingPath);
			out.print(currentPage - 1);
			if (notEmpty) {
				out.print(parameters);
			}
			out.print("' class='page-link prev'></a>");
		}
		if (paging.getPageCount() > 1) {
			int total = 1;
			final int max = 5;
			int index = paging.getPageCount() - currentPage;
			if (index > 2) {
				index = 2;
			} else {
				index = index <= 0 ? (max - 1) : (max - index - 1);
			}
			int i;
			for (i = (currentPage - index); i <= paging.getPageCount()
					&& total <= max; i++) {
				if (i <= 0) {
					continue;
				}
				if (currentPage == i) {
					out.print("<a href='#' class='page-link on'>");
					out.print(i);
					out.print("</a>");
				} else {
					out.print("<a href='");
					out.print(pagingPath);
					out.print(i);
					if (notEmpty) {
						out.print(parameters);
					}
					out.print("' class='page-link'>");
					out.print(i);
					out.print("</a>");
				}
				total++;
			}
			if (i < paging.getPageCount()) {
				out.print("<span>...</span>");
				int idx = paging.getPageCount() - 2;
				if (i <= idx) {
					out.print("<a href='");
					out.print(pagingPath);
					out.print(idx);
					if (notEmpty) {
						out.print(parameters);
					}
					out.print("' class='page-link'>");
					out.print(idx);
					out.print("</a>");
				}
				idx++;
				if (i <= idx) {
					out.print("<a href='");
					out.print(pagingPath);
					out.print(idx);
					if (notEmpty) {
						out.print(parameters);
					}
					out.print("' class='page-link'>");
					out.print(idx);
					out.print("</a>");
				}
			}
		}
		if (currentPage < paging.getPageCount()) {
			out.print("<a href='");
			out.print(pagingPath);
			out.print(currentPage + 1);
			if (notEmpty) {
				out.print(parameters);
			}
			out.print("' class='page-link next'></a>");

			out.print("<a href='");
			out.print(pagingPath);
			out.print(paging.getPageCount());
			if (notEmpty) {
				out.print(parameters);
			}
			out.print("' class='page-link'>尾页</a>");
		}
		if (currentPage == paging.getPageCount() && paging.getPageCount() > 1) {
			out.print("<a href=\"#\"><span class='page-link next'></span></a>");
		}
		out.print("</div>");
	}

	public static void rendPaging(JspWriter out, PagingResult<?> paging,
			String pagingPath) throws IOException {
		rendPaging(out, paging, pagingPath, null);
	}

	@Override
	protected void onThrowable(HttpServletRequest request,
			HttpServletResponse response, Throwable throwable)
			throws ServletException, IOException {
		ResourceProvider resourceProvider = getResourceProvider();
		getController().prompt(request, response, PromptLevel.ERROR,
				throwable.getMessage());
		if (throwable instanceof AuthenticationException) {
			Controller controller = getController();
			controller.redirectLogin(request, response,
					resourceProvider.getResource(ConfigureProvider.class)
							.format(URLVariable.LOGIN));
		} else {
			resourceProvider.log(throwable);
			forwardView(request, response, getClass());
		}
	}
}
