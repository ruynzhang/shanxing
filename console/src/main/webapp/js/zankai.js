  function show(obj){
  
      var obj=document.getElementById(obj);  //获得id为b的容器
	  //如果下面的内容显示的话就隐藏
	  if(obj.style.display=="block"){
	     obj.style.display="none";
	  }else 
	  obj.style.display="block";

}
//tab切换
function setTab(name,cursel,n){
for(i=1;i<=n;i++){
var menu=document.getElementById(name+i);
var con=document.getElementById("con_"+name+"_"+i);
menu.className=i==cursel?"hover":"";
con.style.display=i==cursel?"block":"none";
}
}