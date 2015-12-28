function show(obj) {
	var obj = document.getElementById(obj);
	if (obj.style.display == "block") {
		obj.style.display = "none";
	} else
		obj.style.display = "block";

}

function openShutManager(oSourceObj, oTargetObj, shutAble, oOpenTip, oShutTip) {
	var sourceObj = typeof oSourceObj == "string" ? document
			.getElementById(oSourceObj) : oSourceObj;
	var targetObj = typeof oTargetObj == "string" ? document
			.getElementById(oTargetObj) : oTargetObj;
	var openTip = oOpenTip || "";
	var shutTip = oShutTip || "";
	if (targetObj.style.display != "none") {
		if (shutAble)
			return;
		targetObj.style.display = "none";
		if (openTip && shutTip) {
			sourceObj.innerHTML = shutTip;
		}
		history.go(0);
		
	} else {
		targetObj.style.display = "block";
		if (openTip && shutTip) {
			sourceObj.innerHTML = openTip;
		}
	}
}

function setTab(name, cursel, n) {
	for (i = 1; i <= n; i++) {
		var menu = document.getElementById(name + i);
		var con = document.getElementById("con_" + name + "_" + i);
		menu.className = i == cursel ? "hover" : "";
		con.style.display = i == cursel ? "block" : "none";
	}
}


//右侧
$("#attention div").delegate("mouseover mouseout", function (event) {

                var id = $(this).attr("id").replace("m", ""); ;
                if (event.type == 'mouseover') {
                    $("#mn" + id + "").css({ visibility: 'visible' });
                } else {
                    $("#mn" + id + "").css({ visibility: 'hidden' });
                }
            });

