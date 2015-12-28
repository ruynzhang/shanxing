package com.dimeng.p2p.console.servlets.bid.htgl;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.nio.charset.Charset;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletResponseWrapper;

import com.dimeng.framework.config.ConfigureProvider;
import com.dimeng.framework.http.servlet.Controller;
import com.dimeng.framework.http.session.authentication.AuthenticationException;
import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.resource.ResourceProvider;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.console.servlets.AbstractConsoleServlet;
import com.dimeng.p2p.variables.defines.URLVariable;
import com.dimeng.util.StringHelper;
import com.itextpdf.text.Document;
import com.itextpdf.text.Font;
import com.itextpdf.text.FontFactory;
import com.itextpdf.text.Image;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.pdf.PdfWriter;
import com.itextpdf.tool.xml.Pipeline;
import com.itextpdf.tool.xml.XMLWorker;
import com.itextpdf.tool.xml.XMLWorkerFontProvider;
import com.itextpdf.tool.xml.XMLWorkerHelper;
import com.itextpdf.tool.xml.html.CssAppliersImpl;
import com.itextpdf.tool.xml.html.Tags;
import com.itextpdf.tool.xml.net.FileRetrieve;
import com.itextpdf.tool.xml.net.ReadingProcessor;
import com.itextpdf.tool.xml.parser.XMLParser;
import com.itextpdf.tool.xml.pipeline.css.CSSResolver;
import com.itextpdf.tool.xml.pipeline.css.CssResolverPipeline;
import com.itextpdf.tool.xml.pipeline.end.PdfWriterPipeline;
import com.itextpdf.tool.xml.pipeline.html.AbstractImageProvider;
import com.itextpdf.tool.xml.pipeline.html.HtmlPipeline;
import com.itextpdf.tool.xml.pipeline.html.HtmlPipelineContext;
import com.itextpdf.tool.xml.pipeline.html.ImageProvider;
import com.itextpdf.tool.xml.pipeline.html.NoImageProviderException;

public class AbastractHtglServlet extends AbstractConsoleServlet {

	private static final long serialVersionUID = 1L;
	private static final boolean initialized = false;

	@Override
	protected boolean mustAuthenticated() {
		return true;
	}

	@Override
	public void init() throws ServletException {
		super.init();
		initFont(getServletContext());
	}

	@Override
	public void init(ServletConfig config) throws ServletException {
		super.init(config);
		initFont(getServletContext());
	}

	protected synchronized static void initFont(ServletContext servletContext) {
		if (initialized) {
			return;
		}
		FontFactory.registerDirectories();
	}

	@Override
	protected void processGet(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		processPost(request, response, serviceSession);
	}

	@Override
	protected void processPost(HttpServletRequest request,
			HttpServletResponse response, ServiceSession serviceSession)
			throws Throwable {
		final String charsetName = getResourceProvider().getCharset();
		response.setContentType("application/pdf");
		response.addHeader(
				"Content-Disposition",
				"attachment; filename="
						+ String.format("%s.pdf",
								Long.toString(System.currentTimeMillis())));
		XMLWorker worker = null;
		final ServletContext servletContext = getServletContext();
		try (final ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
				final PrintWriter htmlWriter = new PrintWriter(
						new OutputStreamWriter(outputStream, charsetName));) {
			response.setCharacterEncoding(charsetName);
			RequestDispatcher dispatcher = request
					.getRequestDispatcher(getResourceProvider()
							.getSystemDefine().getRewriter()
							.getViewFilePath(getClass()));
			dispatcher.include(request,
					new HttpServletResponseWrapper(response) {
						@Override
						public PrintWriter getWriter() throws IOException {
							return htmlWriter;
						}
					});
			htmlWriter.close();
			Document document = new Document(PageSize.A4, 30, 30, 30, 30);
			document.setMargins(30, 30, 30, 30);
			PdfWriter writer = PdfWriter.getInstance(document,
					response.getOutputStream());
			document.open();
			final String contextPath = getResourceProvider().getContextPath();
			HtmlPipelineContext htmlContext = new HtmlPipelineContext(
					new CssAppliersImpl(new XMLWorkerFontProvider() {
						@Override
						public Font getFont(String fontname, String encoding,
								float size, final int style) {
							if (fontname == null) {
								fontname = "STSongStd-Light";
								encoding = "UniGB-UCS2-H";
							}
							return FontFactory.getFont(fontname, encoding,
									size, style);
						}
					})) {
				@Override
				public HtmlPipelineContext clone()
						throws CloneNotSupportedException {
					HtmlPipelineContext context = super.clone();
					try {
						ImageProvider imageProvider = this.getImageProvider();
						context.setImageProvider(imageProvider);
					} catch (NoImageProviderException e) {
					}
					return context;
				}
			};
			htmlContext.setImageProvider(new AbstractImageProvider() {
				@Override
				public String getImageRootPath() {
					return getServletContext().getRealPath("/");
				}

				@Override
				public Image retrieve(String src) {
					if (StringHelper.isEmpty(src)) {
						return null;
					}
					if (src.startsWith(contextPath)) {
						src = src.substring(contextPath.length());
						try {
							Image image = Image.getInstance(new File(
									getServletContext().getRealPath("/"), src)
									.toURI().toString());
							if (image != null) {
								store(src, image);
								return image;
							}
						} catch (Throwable e) {
						}
					}
					return super.retrieve(src);
				}
			});
			htmlContext.setAcceptUnknown(true).autoBookmark(true)
					.setTagFactory(Tags.getHtmlTagProcessorFactory());
			CSSResolver cssResolver = XMLWorkerHelper.getInstance()
					.getDefaultCssResolver(true);
			cssResolver.setFileRetrieve(new FileRetrieve() {
				@Override
				public void processFromStream(InputStream in,
						ReadingProcessor processor) throws IOException {
					try (InputStreamReader reader = new InputStreamReader(in,
							charsetName)) {
						int i = -1;
						while (-1 != (i = reader.read())) {
							processor.process(i);
						}
					} catch (Throwable e) {
					}
				}

				@Override
				public void processFromHref(String href,
						ReadingProcessor processor) throws IOException {
					if (StringHelper.isEmpty(contextPath)) {
						return;
					}
					if (href.startsWith(contextPath)) {
						href = href.substring(getResourceProvider()
								.getContextPath().length());
						try (InputStreamReader reader = new InputStreamReader(
								servletContext.getResourceAsStream(href),
								charsetName)) {
							int i = -1;
							while (-1 != (i = reader.read())) {
								processor.process(i);
							}
						} catch (Throwable e) {
						}
					}
				}
			});

			HtmlPipeline htmlPipeline = new HtmlPipeline(htmlContext,
					new PdfWriterPipeline(document, writer));
			Pipeline<?> pipeline = new CssResolverPipeline(cssResolver,
					htmlPipeline);
			worker = new XMLWorker(pipeline, true);
			XMLParser parser = new XMLParser(true, worker,
					Charset.forName(charsetName));
			try (InputStream inputStream = new ByteArrayInputStream(
					outputStream.toByteArray())) {
				parser.parse(inputStream, Charset.forName(charsetName));
			}
			document.close();
		} finally {
			if (worker != null) {
				worker.close();
			}

		}
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
			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
		}
	}
}
