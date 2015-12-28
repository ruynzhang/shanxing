Number.prototype.toFixed = function(d)
	  {
	      var s=this+"";if(!d)d=0;
	      if(s.indexOf(".")==-1)s+=".";s+=new Array(d+1).join("0");
	      if (new RegExp("^(-|\\+)?(\\d+(\\.\\d{0,"+ (d+1) +"})?)\\d*$").test(s))
	      {
	          var s="0"+ RegExp.$2, pm=RegExp.$1, a=RegExp.$3.length, b=true;
	          if (a==d+2){a=s.match(/\d/g); if (parseInt(a[a.length-1])>4)
	          {
	              for(var i=a.length-2; i>=0; i--) {a[i] = parseInt(a[i])+1;
	              if(a[i]==10){a[i]=0; b=i!=1;} else break;}
	          }
	          s=a.join("").replace(new RegExp("(\\d+)(\\d{"+d+"})\\d$"),"$1.$2");
	      }if(b)s=s.substr(1);return (pm+s).replace(/\.$/, "");} return this+"";
	};
	function accDiv(arg1,arg2){
		var t1=0,t2=0,r1,r2;
		try{t1=arg1.toString().split(".")[1].length;}catch(e){}
		try{t2=arg2.toString().split(".")[1].length;}catch(e){}
		with(Math){
		r1=Number(arg1.toString().replace(".",""));
		r2=Number(arg2.toString().replace(".",""));
		return (r1/r2)*pow(10,t2-t1);
		}
	}
	function accMul(arg1,arg2)
	{
		var m=0,s1=arg1.toString(),s2=arg2.toString();
		try{m+=s1.split(".")[1].length;}catch(e){}
		try{m+=s2.split(".")[1].length;}catch(e){}
		return Number(s1.replace(".",""))*Number(s2.replace(".",""))/Math.pow(10,m);
	}
	Number.prototype.mul = function (arg){
		return accMul(arg, this);
	};
	
	function accAdd(arg1,arg2){
		var r1,r2,m;
		try{r1=arg1.toString().split(".")[1].length;}catch(e){r1=0;}
		try{r2=arg2.toString().split(".")[1].length;}catch(e){r2=0;}
		m=Math.pow(10,Math.max(r1,r2));
		return (arg1*m+arg2*m)/m;
	}
	
	Number.prototype.add = function (arg){
		return accAdd(arg,this);
	};
	
	
	Number.prototype.div = function (arg){
		return accDiv(this, arg);
	};
	
	function Subtr(arg1,arg2){
		var r1,r2,m,n;
		try{r1=arg1.toString().split(".")[1].length;}catch(e){r1=0;}
		try{r2=arg2.toString().split(".")[1].length;}catch(e){r2=0;}
		m=Math.pow(10,Math.max(r1,r2));
	     //last modify by deeka
		 //动态控制精度长度
		n=(r1>=r2)?r1:r2;
		return ((arg1*m-arg2*m)/m).toFixed(n);
	}
	Number.prototype.substr = function (arg){
		return Subtr(this, arg);
	};
	
		$(".jsqks").click( function() {
				var $envs = $(".jejs");
				//借款金额
				var toal = $envs.eq(0).val();
			  	//借款期限
			  	var month = $envs.eq(2).val();
			  	//借款年利率
			  	var year = $envs.eq(1).val();
			  	//还款方式
			  	var type = $envs.eq(3).val();
			  	//月利率
			  	var yln = parseFloat(year)/12;
				if($.trim(toal) == "" || $.trim(month) == "" || $.trim(year) == "0"){
			  		return false;
			  	}
				
				var myreg = /^[0-9]([0-9])*$/;
				var yeareg=/^\d+(\d|(\.[1-9]{1}))$/;
				if(!myreg.test(toal)){
					return;
				}
				if(!yeareg.test(year)){
					return;
				}
				$("#showjs").show();
				if(type == "DEBX"){
							yln = yln/100;
						   //月还本息
						  //power（1+x,n）*x*y/ (power（1+x,n）-1)
						   var yhbx = ((Math.pow(1+yln, month)*yln*parseInt(toal))/(Math.pow(1+yln, month)-1)).toFixed(2);
						   $("#mthns").html(month);
						   $("#mtoal").html(toal);
						   
						//应收利息
						 var yslxh = 0; 
						 $(".jstr").html("");
					 	 var content='<tr>';
						 content+='<td>期次</td>';
						 content+='<td>偿还本息(元)</td>';
						 content+='<td>偿还利息(元)</td>';
						 content+='<td>偿还本金(元)</td>';
		 				 content+='<td>剩余本金(元)</td>';
						 content+='</tr>';
							 
						//已还本金之和	 
						 var totalYhbj = 0;
						 var dsbj = 0;
						 var yhbj = 0;
						 var  interest_cur = 0;
						 var zhdhbj = toal;
						 for(var i=1;i<=month;i++){
							 //应还利息
							  	interest_cur = parseFloat(Subtr(toal,totalYhbj)*yln).toFixed(2);
							  	//应还本金
							  	yhbj = parseFloat(Subtr(yhbx, interest_cur)).toFixed(2);
							    
							  	 totalYhbj =accAdd(totalYhbj, yhbj);
							  	//待收本金
							    dsbj  = parseFloat(Subtr(toal, totalYhbj)).toFixed(2);
							    
							    if(i == (month-1)){
							    	zhdhbj =  dsbj;
							    }
							    if(i == month){
							    	yhbj = zhdhbj;
							    	 //应还利息
								  	interest_cur = parseFloat(Subtr(yhbx, yhbj)).toFixed(2);
								  	totalYhbj =accAdd(totalYhbj, yhbj);
								  	dsbj  = 0;
							    }
							  	 
							  	content+='<tr>';
							  	content+='<td>'+i+'</td>';
								content+='<td id="ysbx'+i+'">'+yhbx+'</td>';
								content+='<td id="yslx'+i+'">'+interest_cur+'</td>';
								content+='<td id="ysbj'+i+'">'+yhbj+'</td>';
				 			    content+='<td id="dsbj'+i+'">'+dsbj+'</td>';
								content+='</tr>';
								yslxh=accAdd(yslxh, interest_cur);
						 }
						 $("#ghbx").html(yslxh.toFixed(2));
						 $(".jstr").append(content);
				 }else if(type == "DEBJ"){
						//月利息
					   $("#mthns").html(month);
					   $("#mtoal").html(toal);
					   
					   
						 $(".jstr").html("");
						 var content='<tr>';
							 content+='<td>期次</td>';
							 content+='<td>偿还本息(元)</td>';
							 content+='<td>偿还利息(元)</td>';
							 content+='<td>偿还本金(元)</td>';
			 				 content+='<td>剩余本金(元)</td>';
							 content+='</tr>';
							 
						 var new_ysbx = 0;
						 var new_ysbj = 0;
						 var new_yslx = 0;
						 var new_sybj = 0;
						 var yslxTotle = 0;
						 var ysbjTotle = 0;
						 new_ysbj = parseInt(toal).div(month);
						 for(var i=1;i<=month;i++){
							 new_yslx = (toal - ysbjTotle)*(yln/100);
							 ysbjTotle = ysbjTotle + new_ysbj;
							 new_ysbx = new_yslx + new_ysbj;
							 new_sybj = toal - new_ysbj*i;
						  	content+='<tr>';
						  	content+='<td>'+i+'</td>';
							content+='<td id="ysbx'+i+'">'+new_ysbx.toFixed(2)+'</td>';
							content+='<td id="yslx'+i+'">'+new_yslx.toFixed(2)+'</td>';
							content+='<td id="ysbj'+i+'">'+new_ysbj.toFixed(2)+'</td>';
			 			    content+='<td id="dsbj'+i+'">'+new_sybj.toFixed(2)+'</td>';
							content+='</tr>';
							
							yslxTotle = accAdd(yslxTotle,new_yslx);
							
						 }
						 
						 $("#ghbx").html(yslxTotle.toFixed(2));
						 $(".jstr").append(content);
						 
				 }else if(type == "YCFQ"){
					  //还利息
					   var yslx = (yln * parseInt(toal) * month)/100;
					   $("#mthns").html(month);
					   $("#mtoal").html(toal);
					   $("#ghbx").html(yslx.toFixed(2));
					   
					 $(".jstr").html("");
					 var content='<tr>';
						 content+='<td>期次</td>';
						 content+='<td>偿还本息(元)</td>';
						 content+='<td>偿还利息(元)</td>';
						 content+='<td>偿还本金(元)</td>';
		 				 content+='<td>剩余本金(元)</td>';
						 content+='</tr>';
						 
					 for(var i=1;i<=month;i++){
						 var new_ysbx = 0;
						 var new_ysbj = 0;
						 var new_yslx = 0;
						 var new_sybj = parseInt(toal);
						 if(i == month){
							 new_yslx = yslx;
							 new_ysbj = parseInt(toal);
							 new_ysbx = new_yslx + new_ysbj;
							 new_sybj = 0;
						 }
						 
					  	 
					  	content+='<tr>';
					  	content+='<td>'+i+'</td>';
						content+='<td id="ysbx'+i+'">'+new_ysbx.toFixed(2)+'</td>';
						content+='<td id="yslx'+i+'">'+new_yslx.toFixed(2)+'</td>';
						content+='<td id="ysbj'+i+'">'+new_ysbj.toFixed(2)+'</td>';
		 			    content+='<td id="dsbj'+i+'">'+new_sybj.toFixed(2)+'</td>';
						content+='</tr>';
					 }
					 $(".jstr").append(content);
				 }else if(type == "MYFX"){
					//月还本息
					   var yslx = (yln * parseInt(toal))/100;
					   $("#mthns").html(month);
					   $("#mtoal").html(toal);
					   var yslxTotle = 0;
					   
					 $(".jstr").html("");
					 var content='<tr>';
						 content+='<td>期次</td>';
						 content+='<td>偿还本息(元)</td>';
						 content+='<td>偿还利息(元)</td>';
						 content+='<td>偿还本金(元)</td>';
		 				 content+='<td>剩余本金(元)</td>';
						 content+='</tr>';
						 
					 for(var i=1;i<=month;i++){
						 var new_ysbx = 0;
						 var new_ysbj = 0;
						 var new_yslx = 0;
						 var new_sybj = parseInt(toal);
						 new_yslx = yslx;
						 if(i == month){
							 new_ysbj = parseInt(toal);
							 new_sybj = 0;
						 }
						 new_ysbx = new_yslx + new_ysbj;
					  	 
					  	content+='<tr>';
					  	content+='<td>'+i+'</td>';
						content+='<td id="ysbx'+i+'">'+new_ysbx.toFixed(2)+'</td>';
						content+='<td id="yslx'+i+'">'+new_yslx.toFixed(2)+'</td>';
						content+='<td id="ysbj'+i+'">'+new_ysbj.toFixed(2)+'</td>';
		 			    content+='<td id="dsbj'+i+'">'+new_sybj.toFixed(2)+'</td>';
						content+='</tr>';
						
						yslxTotle  = accAdd(yslxTotle,new_yslx.toFixed(2));
						
					 }
					 
					 $("#ghbx").html(yslxTotle.toFixed(2));
					 $(".jstr").append(content);
					 
				 }
		});