<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@include file="/WEB-INF/include/meta.jsp"%>
<%@include file="/WEB-INF/include/style.jsp"%>
</head>
<body>
<%CURRENT_CATEGORY="YWGL";%>
<%@include file="/WEB-INF/include/header.jsp" %>
<div class="w_main">
  <div class="main clearfix">
    <div class="wrap">
      <div class="r_main">
        <div class="home_main">
          <div class="box box1 mb15">
            <div class="con">
              <ul class="yw_li">
                <li><p class="f18">理财管理</p>
                <span class="dian"></span>理财管理对包括债权、债权转让等理财项目的数据进行统计，便于平台管理。</li>
                <li><p class="f18">借款管理</p>
                <span class="dian"></span>借款管理对各种状态的借款进行统计管理，方便业务人员查看相应借款信息。</li>
               <!--  <li><p class="f18">线下债权转让管理</p>
                <span class="dian"></span>线下债权转让管理可查看线下债权转让状态，以及对线下债权转让进行查看、修改、审核、发布等操作。</li> -->
                <li><p class="f18">催收管理</p>
                <span class="dian"></span>催收管理记录催款的全过程，让催收变得更合理，更有效。</li>
              </ul>
              <div class="clear"></div>
            </div>
          </div>
          <div class="box2 clearfix"></div>
        </div>
      </div>
    </div>
   	<%@include file="/WEB-INF/include/left.jsp" %>
	</div>
</div>
<%@include file="/WEB-INF/include/footer.jsp" %>
<%@include file="/WEB-INF/include/script.jsp" %>
</body>
</html>