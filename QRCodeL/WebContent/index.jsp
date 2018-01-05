<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>  
<%  
String path = request.getContextPath();  
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";  
%> 
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">  
<html lang="en">
<head>
<meta content="text/html; charset=utf-8">
<title>jquery实现微信长按识别二维码功能</title>
<script type="text/javascript" src="js/jquery-1.11.1.js"></script>
<script type="text/javascript" src="js/jquery.qrcode.min.js"></script>
<script type="text/javascript" src="js/utf.js"></script>
<style type="text/css">

</style>
</head>
<body>
	<img src="${pageContext.request.contextPath}/image/2222.png" alt="" id="photo" width="200" height="200" style="display: none;">
	<img src="${pageContext.request.contextPath}/image/333.png" alt="" id="pol" width="200" height="200" style="display: none;">
	<!--canvas中的二维码-->
	<div id="qrDiv" style="display: none;"></div>
	<input type="button" value="提交" onclick="getBJImg()"></input>
	<input type="button" value="获取画布中的图片" onclick="getCanvas()"></input>
	<input type="button" value="打印" onclick="print1()"></input>
	<input type="button" value="获取checkbox值" onclick="sub1()"></input>
	<table id="poptable" border='1' >
	  <tr>
	     <td>选择</td>
	     <td>公司</td>
	     <td>部门</td>
	     <td>人员</td>
	     <td>人员编号</td>
	  </tr>
	  <tr>
	     <td><input type='checkbox' name='checkbox' value='checkbox1' onclick="test(this);"></td>
	     <td>中国移动</td>
	     <td>采购部</td>
	     <td>张三</td>
	     <td>201703928</td>
	  </tr>
	  <tr>
	     <td><input type='checkbox' name='checkbox' value='checkbox2' onclick="test(this);"></td>
	     <td>中国移动</td>
	     <td>采购部</td>
	     <td>李四</td>
	     <td>204343438</td>
	  </tr>
	  <tr>
	     <td><input type='checkbox' name='checkbox' value='checkbox3' onclick="test(this);"></td>
	     <td>中国移动</td>
	     <td>采购部</td>
	     <td>小兰</td>
	     <td>204324338</td>
	  </tr>
	  <tr>
	     <td><input type='checkbox' name='checkbox' value='checkbox4' onclick="test(this);"></td>
	     <td>中国移动</td>
	     <td>采购部</td>
	     <td>小红</td>
	     <td>204332338</td>
	  </tr>
	</table>
	<div id="printpage4"  style="display: none;">
	<table id="qrDivimg" >
	  
	</table>
	</div>
   
    
	<!--width="250" height="300"-->
	<script>
	 function test(o) { 
		   if (!o.checked) { 
		    return; 
		   } 
		   var tr = o.parentNode.parentNode; 
		   var tds = tr.cells; 
		   var str =""; 
		   for(var i = 0;i < tds.length;i++){ 
		    if (i < 3) { 
		     str = tds[i].innerHTML; 
		    } 
		   } 
		   //alert(str); 
		  }  
	 var cont=0;
	 function  sub1(){

		/* $.each($('input:checkbox'),function(){
			    if(this.checked){
			         window.alert("你选了："+$('input[type=checkbox]:checked').length+"个，其中有："+$(this).val()); 
			       alert($(this).val()); 
			       alert($(this).attr("id"));
			    }
			}); */
			document.getElementById('qrDivimg').innerHTML = "";
			var tbodyObj = document.getElementById('poptable');
			var selectedData = [];
			$("table :checkbox").each(function(key, value) {
				if ($(value).prop('checked')) {
					cont++;
					var gs = tbodyObj.rows[key + 1].cells[1].innerHTML;
					var bm = tbodyObj.rows[key + 1].cells[2].innerHTML;
					var ry = tbodyObj.rows[key + 1].cells[3].innerHTML;
					var bh = tbodyObj.rows[key + 1].cells[4].innerHTML;
					//alert(tbodyObj.rows[key+1].cells[1].innerHTML);
					selectedData.push({
						"GS" : gs,
						"BM" : bm,
						"RY" : ry,
						"BH" : bh
					});
					/*  print(tbodyObj.rows[key+1].cells[4].innerHTML);  */

				}
			});
			alert(JSON.stringify(selectedData));
			$.each(selectedData, function(n, value) {
				// alert(value.GS);
				var gs = value.GS;
				var bm = value.BM;
				var ry = value.RY;
				var bh = value.BH;
				getBJImg(gs, bm, ry, bh);
			});
		}
		function qrcode() {
			$('#qrDiv').qrcode({
				text : "http://www.baidu.com",
				width : "100", //二维码的宽度
				height : "100", //二维码的高度
				background : "#ffffff", //二维码的后景色
				foreground : "#000000" //二维码的前景色
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
			//alert(image.src);
			return image;
		}
		var imgrq = qrcode();

		function getBJImg(gs, bm, ry, bh) {
			//console.log(imgrq);
			var starImg = new Image();
			starImg.src = $('#photo').attr('src');

			var c = document.createElement("canvas");
			c.id = "CursorLayer";
			//var p=document.getElementById("photo");
			//var pl=document.getElementById("pol");
			var ctx = c.getContext("2d");
			c.width = 250;
			c.height = 300;

			//alert(c.width+" "+c.height);
			ctx.drawImage(starImg, 0, 0, 250, 300);
			var starImg1 = new Image();
			starImg1.src = $('#pol').attr('src');
			console.log(starImg1)
			ctx.drawImage(starImg1, 75, 65, 100, 105);

			ctx.drawImage(imgrq, 180, 210, 50, 50);

			ctx.font = 'bold 3px Arial';
			ctx.fillStyle = '#333';
			ctx.fillText(gs, 90, 205);
			ctx.fillStyle = '#f5c158';
			ctx.fillText(bm, 90, 225);
			ctx.fillStyle = '#333';
			ctx.fillText(ry, 90, 243);
			ctx.fillStyle = '#333';
			ctx.fillText(bh, 90, 263);
			ctx.save();
			ctx.restore();

			//$('#img').append(c.toDataURL());
			var as = "qrDivimg";
			var imi = c.toDataURL()
			
			addElementImg(as, imi);
			// JSON.stringify
			//console.log(c.toDataURL());
		}

		function getCanvas() {
			 var image = new Image();
			var canvas = document.getElementById("newImg");
			var image = canvas.toDataURL("image/png").replace("image/png","image/octet-stream");
			/*  document.write('<img src="'+img+'"/>'); */
			//           alert(img);
			alert(image); 

		}
		function print1() {
			var headhtml = "<html><head><title></title></head><body>";
			var foothtml = "</body>";
			var newhtml = document.getElementById("printpage4").innerHTML;
			var oldhtml = document.body.innerHTML;
			//console.log(newhtml);
			document.body.innerHTML = headhtml + newhtml + foothtml;
			window.print();
			document.body.innerHTML = oldhtml;
			//alert(headhtml + newhtml + foothtml);
		}
		function addElementImg(obj, imgs) {
			
			var ul = document.getElementById(obj);
			//添加 li
			var lr = document.createElement("tr");
			lr.setAttribute("style", "page-break-after:always");
			var li = document.createElement("td");
			//添加 img
			var img = document.createElement("img");
			//设置 img 属性，如 id
			img.setAttribute("id", "newImg");
		    
			//设置 img 图片地址
			img.src = imgs;

			li.appendChild(img);
			lr.appendChild(li);
			ul.appendChild(lr);
			
			//alert(img);
		}
	</script>
</body>
</html>