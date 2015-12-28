package com.dimeng.p2p.front.servlets;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.service.ServiceSession;
import com.dimeng.p2p.S50.entities.T5019;
import com.dimeng.p2p.modules.base.front.service.DistrictManage;

public class Region extends AbstractFrontServlet {

	private static final long serialVersionUID = 1L;

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
		DistrictManage districtManage = serviceSession
				.getService(DistrictManage.class);
		response.setContentType("text/javascript");
		response.setCharacterEncoding("UTF-8");
		T5019[] shengs = districtManage.getSheng();
		if (shengs == null || shengs.length <= 0) {
			return;
		}
		PrintWriter writer = response.getWriter();
		int i = 0;
		writer.write("var region =[");
		for (T5019 sheng : shengs) {
			writer.write("{");
			writer.write("id:");
			writer.write(Integer.toString(sheng.F01));
			writer.write(",");
			writer.write("name:");
			writer.write("\"");
			writer.write(sheng.F05);
			writer.write("\"");
			writer.write(",");
			T5019[] shis = districtManage.getShi(sheng.F01);
			if (shis == null || shis.length <= 0) {
				writer.write("children:\"\"");
			} else {
				writer.write("children:[");
				int j = 0;
				for (T5019 shi : shis) {
					writer.write("{");
					writer.write("id:");
					writer.write(Integer.toString(shi.F01));
					writer.write(",");
					writer.write("name:");
					writer.write("\"");
					writer.write(shi.F05);
					writer.write("\"");
					writer.write(",");
					T5019[] xians = districtManage.getXian(shi.F01);
					if (xians.length <= 0 || xians == null) {
						writer.write("children:\"\"");
					} else {
						writer.write("children:[");
						int k = 0;
						for (T5019 xian : xians) {
							writer.write("{");
							writer.write("id:");
							writer.write(Integer.toString(xian.F01));
							writer.write(",");
							writer.write("name:");
							writer.write("\"");
							writer.write(xian.F05);
							writer.write("\"");
							writer.write(",");
							writer.write("children:\"\"");
							writer.write("}");
							k++;
							if (k < xians.length) {
								writer.write(",");
							}
						}
						writer.write("]");
					}
					writer.write("}");
					j++;
					if (j < shis.length) {
						writer.write(",");
					}
				}
				writer.write("]");
			}
			writer.write("}");
			i++;
			if (i < shengs.length) {
				writer.write(",");
			}
		}
		writer.write("];");
		writer.write("function getRegion(regionid) {");
		writer.write("if (regionid == null || \"\" == regionid || \"undefind\" == regionid) {");
		writer.write("return;");
		writer.write("}");
		writer.write("regionid = \"\" + regionid;");
		writer.write("var pro = regionid.substr(0, 2);");
		writer.write("var city = regionid.substr(2, 2);");
		writer.write("var pro_obj = null;");
		writer.write("var city_obj = null;");
		writer.write("var area_obj = null;");
		writer.write("var str = \"\";");
		writer.write("for (var i = 0; i < region.length; i++) {");
		writer.write("if ((\"\" + region[i].id).substr(0, 2) == pro) {");
		writer.write("pro_obj = region[i];");
		writer.write("str += pro_obj.name;");
		writer.write("break;");
		writer.write("}");
		writer.write("}");
		writer.write("if (pro_obj) {");
		writer.write("for (var j = 0; j < pro_obj.children.length; j++) {");
		writer.write("if ((\"\" + pro_obj.children[j].id).substr(0, 4) == (pro + city)) {");
		writer.write("city_obj = pro_obj.children[j];");
		writer.write("str += \"-\";");
		writer.write("str += city_obj.name;");
		writer.write("break;");
		writer.write("}");
		writer.write("}");
		writer.write("}");
		writer.write("if (city_obj) {");
		writer.write("for (var k = 0; k < city_obj.children.length; k++) {");
		writer.write("if ((\"\" + city_obj.children[k].id) == regionid) {");
		writer.write("area_obj = city_obj.children[k];");
		writer.write("str += \"-\";");
		writer.write("str += area_obj.name;");
		writer.write("break;");
		writer.write("}");
		writer.write("}");
		writer.write("}");
		writer.write("return str;");
		writer.write("};");
		writer.write("$(function() {");

		writer.write("var province = $(\"select[name='sheng']\");");
		writer.write("var city = $(\"select[name='shi']\");");
		writer.write("var area = $(\"select[name='xian']\");");
		writer.write("var shengId = $(\"#shengId\").val();");
		writer.write("var shiId = $(\"#shiId\").val();");
		writer.write("var xianId = $(\"#xianId\").val();");
		writer.write("var city_data = null;");
		writer.write("var area_data = null;");
		writer.write("province.html(getSelectHtml(region, shengId));");
		writer.write("city_data = null;");
		writer.write("area_data = null;");
		writer.write("if (shengId > 0 || shiId > 0 || xianId > 0) {");
		writer.write("city.show();");
		writer.write("area.show();");
		writer.write("for (var i = 0; i < region.length; i++) {");
		writer.write("if (region[i].id == shengId) {");
		writer.write("city_data = region[i].children;");
		writer.write("if (city_data.length > 0) {");
		writer.write("city.html(getSelectHtml(city_data, shiId));");
		writer.write("}");
		writer.write("break;");
		writer.write("}");
		writer.write("}");
		writer.write("for (var i = 0; i < city_data.length; i++) {");
		writer.write("if (city_data[i].id == shiId) {");
		writer.write("area_data = city_data[i].children;");
		writer.write("if (area_data.length > 0) {");
		writer.write("area.html(getSelectHtml(area_data, xianId));");
		writer.write("}");
		writer.write("break;");
		writer.write("}");
		writer.write("}");
		writer.write("}");
		writer.write("province.change(function() {");
		writer.write("var pro_val = $(this).val();");
		writer.write("city.children().remove();");
		writer.write("area.children().remove();");
		writer.write("for (var i = 0; i < region.length; i++) {");
		writer.write("if (region[i].id == pro_val) {");
		writer.write("city_data = region[i].children;");
		writer.write("if (city_data.length > 0) {");
		writer.write("city.html(getSelectHtml(city_data, 0));");
		writer.write("city.show();");
		writer.write("}");
		writer.write("break;");
		writer.write("}");
		writer.write("}");
		writer.write("});");
		writer.write("city.change(function() {");
		writer.write("var city_val = $(this).val();");
		writer.write("area.children().remove();");
		writer.write("for (var i = 0; i < city_data.length; i++) {");
		writer.write("if (city_data[i].id == city_val) {");
		writer.write("area_data = city_data[i].children;");
		writer.write("if (area_data.length > 0) {");
		writer.write("area.html(getSelectHtml(area_data, 0));");
		writer.write("area.show();");
		writer.write("}");
		writer.write("break;");
		writer.write("}");
		writer.write("}");
		writer.write("});");

		writer.write("var provincejg = $(\"select[name='shengjg']\");");
		writer.write("var cityjg = $(\"select[name='shijg']\");");
		writer.write("var areajg = $(\"select[name='xianjg']\");");
		writer.write("var shengIdjg = $(\"#shengIdjg\").val();");
		writer.write("var shiIdjg = $(\"#shiIdjg\").val();");
		writer.write("var xianIdjg = $(\"#xianIdjg\").val();");
		writer.write("var city_datajg = null;");
		writer.write("var area_datajg = null;");
		writer.write("provincejg.html(getSelectHtml(region, shengIdjg));");
		writer.write("city_datajg = null;");
		writer.write("area_datajg = null;");
		writer.write("if (shengIdjg > 0 || shiIdjg > 0 || xianIdjg > 0) {");
		writer.write("cityjg.show();");
		writer.write("areajg.show();");
		writer.write("for (var i = 0; i < region.length; i++) {");
		writer.write("if (region[i].id == shengIdjg) {");
		writer.write("city_datajg = region[i].children;");
		writer.write("if (city_datajg.length > 0) {");
		writer.write("cityjg.html(getSelectHtml(city_datajg, shiIdjg));");
		writer.write("}");
		writer.write("break;");
		writer.write("}");
		writer.write("}");
		writer.write("for (var i = 0; i < city_datajg.length; i++) {");
		writer.write("if (city_datajg[i].id == shiIdjg) {");
		writer.write("area_datajg = city_datajg[i].children;");
		writer.write("if (area_datajg.length > 0) {");
		writer.write("areajg.html(getSelectHtml(area_datajg, xianIdjg));");
		writer.write("}");
		writer.write("break;");
		writer.write("}");
		writer.write("}");
		writer.write("}");
		writer.write("provincejg.change(function() {");
		writer.write("var pro_val = $(this).val();");
		writer.write("cityjg.children().remove();");
		writer.write("areajg.children().remove();");
		writer.write("for (var i = 0; i < region.length; i++) {");
		writer.write("if (region[i].id == pro_val) {");
		writer.write("city_datajg = region[i].children;");
		writer.write("if (city_datajg.length > 0) {");
		writer.write("cityjg.html(getSelectHtml(city_datajg, 0));");
		writer.write("cityjg.show();");
		writer.write("}");
		writer.write("break;");
		writer.write("}");
		writer.write("}");
		writer.write("});");
		writer.write("cityjg.change(function() {");
		writer.write("var city_val = $(this).val();");
		writer.write("areajg.children().remove();");
		writer.write("for (var i = 0; i < city_datajg.length; i++) {");
		writer.write("if (city_datajg[i].id == city_val) {");
		writer.write("area_datajg = city_datajg[i].children;");
		writer.write("if (area_datajg.length > 0) {");
		writer.write("areajg.html(getSelectHtml(area_datajg, 0));");
		writer.write("areajg.show();");
		writer.write("}");
		writer.write("break;");
		writer.write("}");
		writer.write("}");
		writer.write("});");
		writer.write("});");
		writer.write("function getSelectHtml(obj, regionId) {");
		writer.write("var html = \"<option value=''>请选择</option>\";");
		writer.write("for (var i = 0; i < obj.length; i++) {");
		writer.write("if (obj[i].id == regionId) {");
		writer.write("html = html + \"<option value=\"+ obj[i].id+\" selected='selected'>\" + obj[i].name + \"</option>\";");
		writer.write("} else {");
		writer.write("html = html + \"<option value=\" + obj[i].id +\">\" + obj[i].name+ \"</option>\";");
		writer.write("}");
		writer.write("}");
		writer.write("return html;");
		writer.write("}");
		writer.write("function getctName(xianid) {");
		writer.write("if (xianid == null || \"\" == xianid || \"undefind\" == xianid) {");
		writer.write("return;");
		writer.write("}");
		writer.write("var sheng = xianid.substring(0, 2) + \"0000\";");
		writer.write("var shi = xianid.substring(0, 4) + \"00\";");
		writer.write("var shengname = \"\";");
		writer.write("var shiname = \"\";");
		writer.write("var xianname = \"\";");
		writer.write("for (var i = 0; i < region.length; i++) {");
		writer.write("if (region[i].id == sheng) {");
		writer.write("shengname = region[i].name;");
		writer.write("var shengc = region[i].children;");
		writer.write("for (var j = 0; j < shengc.length; j++) {");
		writer.write("if (shengc[j].id == shi) {");
		writer.write("shiname = shengc[j].name;");
		writer.write("var xianc = shengc[j].children;");
		writer.write("for (var k = 0; k < xianc.length; k++) {");
		writer.write("if (xianc[k].id == xianid) {");
		writer.write("xianname = xianc[k].name;");
		writer.write("break;");
		writer.write("}");
		writer.write("}");
		writer.write("break;");
		writer.write("}");
		writer.write("}");
		writer.write("break;");
		writer.write("}");
		writer.write("}");
		writer.write("return shengname + \":\" + shiname + \":\" + xianname;");
		writer.write("}");
	}
}
