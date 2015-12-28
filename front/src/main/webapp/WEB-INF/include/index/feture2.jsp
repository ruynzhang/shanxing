<%{%>
<div class="gird">
	<ul>
		<li>
			<span class="navpic invest"></span>
			<span class="investitle"><a href="<%configureProvider.format(out,URLVariable.FINANCING_SBTZ);%>">投资理财</a></span>
			<span class="content"><%configureProvider.format(out, SystemVariable.FETURE_TZLC);%></span>
		</li>
		<li>
			<span class="navpic invest01"></span>
			<span class="investitle"><a href="<%configureProvider.format(out,URLVariable.CREDIT_CENTER);%>">快捷借款</a></span>
			<span class="content"><%configureProvider.format(out, SystemVariable.FETURE_KJDK);%></span>
		</li>
		<li>
			<span class="navpic invest02"></span>
			<span class="investitle"><a href="<%configureProvider.format(out, URLVariable.GYWM_AQBZ);%>">本息保障</a></span>
			<span class="content"><%configureProvider.format(out, SystemVariable.FETURE_BZBZ);%></span>
		</li>
	</ul>
</div>
<%}%>