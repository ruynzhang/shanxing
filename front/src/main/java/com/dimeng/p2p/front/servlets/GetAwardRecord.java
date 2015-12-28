package com.dimeng.p2p.front.servlets;

import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.spy.memcached.MemcachedClient;

import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.query.Paging;
import com.dimeng.framework.service.query.PagingResult;
import com.dimeng.p2p.modules.base.front.service.NoticeManage;
import com.dimeng.p2p.utlis.MerCached;
import com.dimeng.util.Formater;
import com.dimeng.util.StringHelper;
import com.dimeng.util.parser.IntegerParser;
import com.fasterxml.jackson.annotation.JsonInclude.Include;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;

public class GetAwardRecord extends AbstractFrontServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected boolean mustAuthenticated() {
		return false;
	}

	@SuppressWarnings("unchecked")
	@Override
	protected void processGet(HttpServletRequest request, HttpServletResponse response, ServiceSession serviceSession) throws Throwable {
		int page = IntegerParser.parse(request.getParameter("page"));
		int size = IntegerParser.parse(request.getParameter("size"));
		if(page == 0 || size == 0){
			return;
		}
		MemcachedClient client = MerCached.client;
		String str = (String) client.get("index_all_award");
		if(str == null){
			NoticeManage noticeManage = serviceSession.getService(NoticeManage.class);
			PagingResult<Object[]> awardPaging = noticeManage.searchAward2(new Paging(){
				public int getCurrentPage(){
					return 1;
				}
				public int getSize() {
					return 10000;
				}
			});
			
			Object[][] awardArr = awardPaging.getItems();
			StringBuilder buff = new StringBuilder("[");
			if (awardArr != null && awardArr.length > 0) {
	        	for(int i = 0, len = awardArr.length; i < len; i++){
	        		buff.append("{\"content\":").append("\"恭喜").append(StringHelper.truncation((String)awardArr[i][1], 2, "**"));
	        		if((Boolean)awardArr[i][5]){
	        			buff.append("投资").append(awardArr[i][2].toString());
	        		}
	        		buff.append("获得").append(awardArr[i][4])
	        		.append("\",\"time\":\"").append(Formater.formatDate((Timestamp)awardArr[i][3])).append("\"},");
	        	}
	        	buff.deleteCharAt(buff.length() - 1);
			}
			buff.append("]");
			str = buff.toString();
			client.set("index_all_award", 60*60*3, str);
		}else{
			ObjectMapper mapper = new ObjectMapper();
			mapper.setSerializationInclusion(Include.ALWAYS);
			mapper.disable(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES);
			List<Map<String,Object>> list = mapper.readValue(str, List.class);
			StringBuilder buff = new StringBuilder("[");
			for (int i = (page - 1) * size, listSize = list.size(), j = 0; j < size && i < listSize; i++, j++) {
				buff.append("{\"content\":\"").append(list.get(i).get("content"))
					.append("\",\"time\":\"").append(list.get(i).get("time")).append("\"},");
			}
			buff.deleteCharAt(buff.length() - 1);
			buff.append("]");
			str = buff.toString();
			
		}
		response.setContentType("text/html;charset="
				+ getResourceProvider().getCharset());
		response.getWriter().print(str);
		response.getWriter().flush();
	}
}
