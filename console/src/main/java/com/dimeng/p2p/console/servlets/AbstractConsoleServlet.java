package com.dimeng.p2p.console.servlets;

import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.security.SecureRandom;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;

import com.dimeng.framework.config.Envionment;
import com.dimeng.framework.http.servlet.AbstractServlet;
import com.dimeng.framework.http.servlet.Controller;
import com.dimeng.framework.http.session.authentication.AuthenticationException;
import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.query.PagingResult;
import com.dimeng.p2p.S62.entities.T6251;
import com.google.code.kaptcha.Producer;
import com.google.code.kaptcha.util.Config;

import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;

public abstract class AbstractConsoleServlet extends AbstractServlet {

	private static final long serialVersionUID = 1L;
	public static final Producer COMMON_KAPTCHA_PRODUCER;
	protected static final SecureRandom RANDOM = new SecureRandom();
	public static final String PAGING_CURRENT = "paging.current";

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
			e.printStackTrace();
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

	public static void rendPagingResult(JspWriter out, PagingResult<?> result)
			throws IOException {
		if (out == null || result == null) {
			return;
		}
		String id = '_' + Long.toHexString(RANDOM.nextLong());
		String func = '_' + Long.toHexString(RANDOM.nextLong());
		int currentPage = result.getCurrentPage();
		out.println("<input type='hidden' name='" + PAGING_CURRENT + "' id='"
				+ id + "' value='" + currentPage + "'/>");
		out.println("<script type='text/javascript'>");
		out.println("<!--");
		out.print("function ");
		out.print(func);
		out.print("(p){var _cur=document.getElementById('");
		out.print(id);
		out.println("');if(_cur){if(p){_cur.value=p;}_cur.form.submit();}}");
		out.println("//-->");
		out.println("</script>");
		out.print("<div class='page'>");
		out.print("<span class='fl pr15 ml150'>第");
		out.print(currentPage);
		out.print("页/共");
		out.print(result.getPageCount());
		out.print("页");
		out.print("（共" + result.getItemCount() + "条记录）");
		out.print("</span>");
		if (currentPage == 1 && result.getPageCount() > 1) {
			out.print("<a href=\"javascript:void(0)\"><span class='page-link prev'><</span></a>");
		}
		if (currentPage > 1) {
			out.print("<a href='javascript:");
			out.print(func);
			out.print("(");
			out.print(1);
			out.print(")' class='page-link prev'>首页</a>");
			
			out.print("<a href='javascript:");
			out.print(func);
			out.print("(");
			out.print(currentPage - 1);
			out.print(")' class='page-link prev'><</a>");
		}
		if (result.getPageCount() > 1) {
			int total = 1;
			final int max = 5;
			int index = result.getPageCount() - currentPage;
			if (index > 2) {
				index = 2;
			} else {
				index = index <= 0 ? (max - 1) : (max - index - 1);
			}
			int i;
			for (i = (currentPage - index); i <= result.getPageCount()
					&& total <= max; i++) {
				if (i <= 0) {
					continue;
				}
				if (currentPage == i) {
					out.print("<a href='javascript:void(0)' class='page-link on'>");
					out.print(i);
					out.print("</a>");
				} else {
					out.print("<a href='javascript:");
					out.print(func);
					out.print("(");
					out.print(i);
					out.print(")' class='page-link'>");
					out.print(i);
					out.print("</a>");
				}
				total++;
			}
			if (i < result.getPageCount()) {
				out.print("<span>...</span>");
				int idx = result.getPageCount() - 2;
				if (i <= idx) {
					out.print("<a href='javascript:");
					out.print(func);
					out.print("(");
					out.print(idx);
					out.print(")' class='page-link'>");
					out.print(idx);
					out.print("</a>");
				}
				idx++;
				if (i <= idx) {
					out.print("<a href='javascript:");
					out.print(func);
					out.print("(");
					out.print(idx);
					out.print(")' class='page-link'>");
					out.print(idx);
					out.print("</a>");
				}
			}
		}
		if (currentPage < result.getPageCount()) {
			out.print("<a href='javascript:");
			out.print(func);
			out.print("(");
			out.print(currentPage + 1);
			out.print(")' class='page-link next'>></a>");
			
			out.print("<a href='javascript:");
			out.print(func);
			out.print("(");
			out.print(result.getPageCount());
			out.print(")' class='page-link next'>尾页</a>");
		}
		if (currentPage == result.getPageCount() && result.getPageCount() > 1) {
			out.print("<a href=\"javascript:void(0)\"><span class='page-link next'>></span></a>");
		}
		out.print("</div>");
	}

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		forwardView(request, response, getClass());
	}

	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		forwardView(request, response, getClass());
	}

	@Override
	protected void onThrowable(HttpServletRequest request,
			HttpServletResponse response, Throwable throwable)
			throws ServletException, IOException {
		getResourceProvider().log(throwable);
		prompt(request, response, PromptLevel.ERROR, throwable.getMessage());
		if (throwable instanceof AuthenticationException) {
			Controller controller = getController();
			controller.redirectLogin(request, response,
					controller.getURI(request, Login.class));
		} else {
			forwardView(request, response, getClass());
		}
	}

	protected void demo(final Envionment envionment) throws IOException {
		Configuration cfg = new Configuration();
		Map<String, Object> valueMap = new HashMap<String, Object>() {

			private static final long serialVersionUID = 1L;

			@Override
			public Object get(Object key) {
				Object object = super.get(key);
				if (object == null) {
					return envionment == null ? null : envionment.get(key
							.toString());
				}
				return object;
			}
		};

		valueMap.put("abc", "123");
		valueMap.put("investers", new T6251[0]);
		Template template = new Template("模版名称", "协议模版内容${SYSTEM.ASADF}", cfg);
		try {
			template.process(valueMap, new OutputStreamWriter(System.out,
					"utf-8"));
		} catch (TemplateException e) {
			throw new IOException(e);
		}

	}
}
