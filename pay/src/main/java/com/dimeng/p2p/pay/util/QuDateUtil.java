package com.dimeng.p2p.pay.util;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * 任务调度工具类
 * 
 * @author ice
 * 
 */
public class QuDateUtil {
	public static final String charset = "UTF-8";

	/** 特殊时间 ********************************************************/
	public static final String timeEnd = "23:59:59";// 一天的结束时间
	public static final String timeStart = "00:00:00";// 一天的开始时间

	// 字符检查:是否字符串为空
	public static Boolean isBlank(String str) {
		int strLen;
		if ((str == null) || ((strLen = str.length()) == 0)) {
			return true;
		}

		// 若为null字符串也表示为空
		if (str.trim().equalsIgnoreCase("null")) {
			return true;
		}

		for (int i = 0; i < strLen; i++) {
			if (!Character.isWhitespace(str.charAt(i))) {
				return false;
			}
		}
		return true;
	}

	// 获取安全字符并安全剪断两边
	public static String getSafeAndTrim(Object obj) {
		if (obj == null) {
			return "";
		} else {
			return obj.toString().trim();
		}
	}

	// 获取今天午夜日期字符串
	public static String getCurrentDateStringByDayEnd() {
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		return sdf.format(date) + " " + timeEnd;
	}

	// 字符串转化为日期:(yyyy-MM-dd HH:mm:ss)
	public static Date getDate(String str) {
		Date date = null;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		try {
			date = sdf.parse(str);
		} catch (Exception e) {
			throw new RuntimeException("字符串转化为日期:(yyyy-MM-dd HH:mm:ss)异常", e);
		}
		return date;
	}

	// 日期转化为字符串:(yyyy-MM-dd HH:mm:ss)
	public static String getDateStr(Date date) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return sdf.format(date);
	}

	// 获取当前时间(yyyy-MM-dd HH:mm:ss)
	public static String getTime() {
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return sdf.format(date);
	}
}