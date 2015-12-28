package com.dimeng.p2p.console.servlets.bid.sxbaogl;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dimeng.framework.http.servlet.annotation.Right;
import com.dimeng.framework.resource.PromptLevel;
import com.dimeng.framework.service.ServiceSession;
import com.dimeng.framework.service.exception.LogicalException;
import com.dimeng.framework.service.exception.ParameterException;
import com.dimeng.p2p.S61.entities.T6161;
import com.dimeng.p2p.S61.enums.T6110_F06;
import com.dimeng.p2p.S61.enums.T6110_F10;
import com.dimeng.p2p.S62.entities.SxbaoConfig;
import com.dimeng.p2p.S62.entities.SxbaoType;
import com.dimeng.p2p.console.servlets.bid.AbstractBidServlet;
import com.dimeng.p2p.modules.account.console.service.EnterpriseManage;
import com.dimeng.p2p.modules.account.console.service.GrManage;
import com.dimeng.p2p.modules.account.console.service.UserManage;
import com.dimeng.p2p.modules.account.console.service.entity.Grxx;
import com.dimeng.p2p.service.SxbaoManage;
import com.dimeng.util.StringHelper;

@Right(id = "P2P_C_FINANCE_UPDATESXBAO", name = "更新善行宝")
public class UpdateSxbao extends AbstractBidServlet{

	private static final long serialVersionUID = 1L;
	
	@Override
	protected void processGet(HttpServletRequest request, HttpServletResponse response, ServiceSession serviceSession) throws Throwable {
		String id = request.getParameter("id");
		if(id != null){
			Long cid = Long.valueOf(id);
			SxbaoManage sxbaoManage = serviceSession.getService(SxbaoManage.class);
			SxbaoConfig sxbaoConfig = sxbaoManage.findConfigById(cid);
			request.setAttribute("sxbaoConfig", sxbaoConfig);
			forwardView(request, response, AddSxbao.class);
		}else{
			forwardView(request, response, SxbaoList.class);
		}
	}
	
	@Override
	protected void processPost(HttpServletRequest request, HttpServletResponse response, ServiceSession serviceSession) throws Throwable {
		serviceSession.openTransactions();
		SxbaoConfig sxbaoConfig = new SxbaoConfig();
		sxbaoConfig.parse(request);
		if(sxbaoConfig.id == null){
			return;
		}
		int loanerId = -1;
		GrManage personalManage = serviceSession.getService(GrManage.class);
		EnterpriseManage enterpriseManage = serviceSession
				.getService(EnterpriseManage.class);
		UserManage userManage = serviceSession.getService(UserManage.class);
		SxbaoManage sxbaoManage = serviceSession.getService(SxbaoManage.class);
		SxbaoConfig dbConfig = sxbaoManage.findConfigById(sxbaoConfig.id);
		try {
			String typeIdstr = request.getParameter("typeId");
			SxbaoType type = null;
			if(typeIdstr == null || Long.valueOf(typeIdstr).compareTo(Long.valueOf(0l)) <= 0
					|| (type = sxbaoManage.findTypeById(Long.valueOf(typeIdstr))) == null){
				throw new ParameterException("请选择善行宝类型");
			}
			sxbaoConfig.type = type;
			//判断标题是否存在
			if(!dbConfig.title.equals(sxbaoConfig.title) && sxbaoManage.isExistTitle(sxbaoConfig.title)){
				throw new ParameterException(sxbaoConfig.title + ":已存在的标题");
			}
			if (loanerId <= 0) {
				loanerId = userManage.getIdByName(sxbaoConfig.loanerName);
				sxbaoConfig.loaner = Long.valueOf(loanerId);
			}
			if (loanerId <= 0) {
				throw new ParameterException(sxbaoConfig.loanerName + ":该用户名不存在或者被锁定，请重新输入");
			}
			if (!userManage.isTg(loanerId)) {
				throw new ParameterException(sxbaoConfig.loanerName + ":该用户没用注册第三方托管账号");
			}
			T6110_F06 userType = userManage.getUserType(loanerId);
			T6110_F10 t6110_F10 = userManage.getDb(loanerId);
			if (userType == T6110_F06.ZRR) {
				Grxx user = personalManage.getUser(loanerId);
				if (user == null
						|| StringHelper.isEmpty(user.name)
						|| StringHelper.isEmpty(user.userName)
						|| (StringHelper.isEmpty(user.phone) && StringHelper
								.isEmpty(user.email))
						|| StringHelper.isEmpty(user.sfzh)) {
					throw new LogicalException(sxbaoConfig.loanerName + ":该用户的个人资料未填写完整,不能进行发标操作");
				}
			} else if (userType == T6110_F06.FZRR) {
				T6161 t6161 = enterpriseManage.getEnterprise(loanerId);
				if (t6161 == null || StringHelper.isEmpty(t6161.F02)
						|| StringHelper.isEmpty(t6161.F03)
						|| StringHelper.isEmpty(t6161.F04)
						|| StringHelper.isEmpty(t6161.F05)
						|| StringHelper.isEmpty(t6161.F05)) {
					throw new LogicalException(sxbaoConfig.loanerName + ":该企业的必要基础信息未填写完整,不能进行发标操作");
				}
				if (t6110_F10 == T6110_F10.S) {
					throw new LogicalException(sxbaoConfig.loanerName + ":机构不允许借款");
				}
			}
			if (sxbaoConfig.loanPeriod < 1 || sxbaoConfig.loanPeriod > 36) {
				throw new LogicalException("借款期限超出有效月数[1-36]");
			}
			sxbaoManage.updateConfig(sxbaoConfig);
			getController().prompt(request, response, PromptLevel.WARRING,
					"保存成功");
			processGet(request, response, serviceSession);
		} catch (Throwable throwable) {
			if (throwable instanceof ParameterException
					|| throwable instanceof LogicalException) {
				getController().prompt(request, response, PromptLevel.WARRING,
						throwable.getMessage());
				processGet(request, response, serviceSession);
			} else {
				super.onThrowable(request, response, throwable);
			}
		}
	}
}
