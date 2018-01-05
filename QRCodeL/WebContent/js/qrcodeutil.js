function selectedTableData(div_con, tab_con,imgw,imgh) {
	document.getElementById(div_con).innerHTML = "";
	var tbodyObj = document.getElementById(tab_con);
	var selectedData = [];
	$("table :checkbox").each(function(key, value) {
		if ($(value).prop('checked')) {
			var gs = tbodyObj.rows[key + 1].cells[1].innerHTML;
			var bm = tbodyObj.rows[key + 1].cells[2].innerHTML;
			var ry = tbodyObj.rows[key + 1].cells[3].innerHTML;
			var bh = tbodyObj.rows[key + 1].cells[4].innerHTML;
			selectedData.push({
				"GS" : gs,
				"BM" : bm,
				"RY" : ry,
				"BH" : bh
			});
		}
	});
	//alert(JSON.stringify(selectedData));
	var znum=selectedData.length;
	$.each(selectedData, function(n, value) {
		var gs = value.GS;
		var bm = value.BM;
		var ry = value.RY;
		var bh = value.BH;
		getBJImg(gs, bm, ry, bh,imgw,imgh,znum,n);
	});
}

function getBJImg(gs, bm, ry, bh,imgw,imgh,znum,n) {
	
	var starImg = new Image();//背景
	starImg.src ='';// $('#photo').attr('src');
	
	var starImg1 = new Image();//人头
	starImg1.src = $('#pol').attr('src');
	
	var c = document.createElement("canvas");
	c.id = "CursorLayer";
	var ctx = c.getContext("2d");
	c.width = 250;
	c.height = 300;

	ctx.drawImage(starImg, 0, 0, 250, 300);//背景
	
	ctx.drawImage(starImg1, 75, 65, 100, 105);//人头

	ctx.drawImage(imgrq, 180, 210, 50, 50);//二维码

	ctx.font = 'Bold 2px Arial';
	ctx.fillStyle = '#333';
	ctx.fillText(gs, 90, 205);
	ctx.fillStyle = '#333';
	ctx.fillText(bm, 90, 225);
	ctx.fillStyle = '#333';
	ctx.fillText(ry, 90, 243);
	ctx.fillStyle = '#333';
	ctx.fillText(bh, 90, 263);
	ctx.save();
	ctx.restore();

	var as = "qrDivimg";
	var imi = c.toDataURL()
	addElementImg(as, imi,imgw,imgh,znum,n);
}

function addElementImg(obj, imgs,imgw,imgh,znum,n) {
	var ul = document.getElementById(obj);
	var sjnum=znum-1;//总数减一与集合比较
	/*var lr = document.createElement("tr");*/
	
	
	/*var li = document.createElement("td");*/
	var li = document.createElement("div");
	li.setAttribute("id", "divImg");
	if(n!=sjnum){
     	li.setAttribute("style", "page-break-after:always");
    }
	var img = document.createElement("img");
	img.setAttribute("id", "newImg");
	img.setAttribute("width", imgw);
	img.setAttribute("height", imgh);
	//img.setAttribute("style", "page-break-after:always");
	img.src = imgs;
	
	/*li.appendChild(img);
	lr.appendChild(li);*/
	li.appendChild(img);
	ul.appendChild(li);
}



function qrcode(div_qrcImg_con,t,w,h,b,f) {
	$(div_qrcImg_con).qrcode({
		text : t,
		width :w, //二维码的宽度
		height : h, //二维码的高度
		background : b, //二维码的后景色
		foreground :f //二维码的前景色
	});
	//获取网页中的canvas对象
	var mycanvas1 = document.getElementsByTagName('canvas')[0];
	//将转换后的img标签插入到html中
	var img = convertCanvasToImage(mycanvas1);
	return img;
}
//从canvas中提取图片image
function convertCanvasToImage(canvas) {
	//新Image对象，可以理解为DOM
	var image = new Image();
	// canvas.toDataURL 返回的是一串Base64编码的URL，当然,浏览器自己肯定支持
	// 指定格式PNG
	image.src = canvas.toDataURL("image/png");
	return image;
}