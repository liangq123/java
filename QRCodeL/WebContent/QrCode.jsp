<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"
	contentType="text/html; charset=UTF-8"%>
<%  
String path = request.getContextPath();  
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";  
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html lang="en">
<head>
<meta content="text/html; charset=utf-8">
<!--不缓存    -->
<meta HTTP-EQUIV="pragma" CONTENT="no-cache">   
<meta HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate">   
<meta HTTP-EQUIV="expires" CONTENT="0"> 


<title>jquery实现微信长按识别二维码功能</title>
<script type="text/javascript" src="js/jquery-1.11.1.js"></script>
<script type="text/javascript" src="js/jquery.qrcode.min.js"></script>
<!-- <script type="text/javascript" src="js/jquery-ean13.min.js"></script> -->
<script type="text/javascript" src="js/utf.js"></script>
<script type="text/javascript" src="js/qrcodeutil.js"></script>
<link id="stylesheet_demo" rel="stylesheet" type="text/css" href="Styles/webdemo_teal.css" />
<style type="text/css">
</style>

</head>
<body>

	<img src="${pageContext.request.contextPath}/image/2222.png" alt="" id="photo" width="200" height="200" style="display: none;">
	<img src="${pageContext.request.contextPath}/image/333.png" alt="" id="pol" width="200" height="200" style="display: none;">
	<!--canvas中的二维码-->
	<div id="qrDiv" style="display: none;"></div>
	<div id="ean"></div>
	<input type="button" value="提交" onclick="getBJImg()"></input>
	<input type="button" value="先生成图片" onclick="sub1()"></input>
	<input type="button" value="再打印" onclick="print1()"></input>

	<table id="poptable" border='1'>
		<tr>
			<td>选择</td>
			<td>公司</td>
			<td>部门</td>
			<td>人员</td>
			<td>人员编号</td>
		</tr>
		<tr>
			<td><input type='checkbox' name='checkbox' value='checkbox1'></td>
			<td>中国移动</td>
			<td>采购部</td>
			<td>张三</td>
			<td>201703928</td>
		</tr>
		<tr>
			<td><input type='checkbox' name='checkbox' value='checkbox2'></td>
			<td>中国移动</td>
			<td>采购部</td>
			<td>李四</td>
			<td>204343438</td>
		</tr>
		<tr>
			<td><input type='checkbox' name='checkbox' value='checkbox3'></td>
			<td>中国移动</td>
			<td>采购部</td>
			<td>小兰</td>
			<td>204324338</td>
		</tr>
		<tr>
			<td><input type='checkbox' name='checkbox' value='checkbox4'></td>
			<td>中国移动</td>
			<td>采购部</td>
			<td>小红</td>
			<td>204332338</td>
		</tr>
	</table>
	<div id="printpage4" style="display: none;">
	  <div id="qrDivimg"></div>
	</div>
	
	<!--width="250" height="300"-->
	<script>
	 var cont=0;
	 var div_qrcImg_con="#qrDiv";
	 var t="http://www.baidu.com";
	 var w="100";
     var h="100";
     var b="#ffffff";
     var f="#000000";
	 var imgrq = qrcode(div_qrcImg_con,t,w,h,b,f);//提前生成二维码
	 function  sub1(){
		 var div_con="qrDivimg";
		 var tab_con="poptable";
		 var imgw=250;//图片宽度  可调节
		 var imgh=300;//图片高度  可调节
		 selectedTableData(div_con,tab_con,imgw,imgh);//合并图片并嵌入table
		}
	 function print2() {//打印
		   var ifr = document.createElement("iframe");
		    document.body.appendChild(ifr);
		    ifr.style.pixelWidth = 1;
		    ifr.style.pixelHeight = 1;
		    var ifrdoc = ifr.contentWindow.document;
		    ifrdoc.open();
		    ifrdoc.write("<BODY>");
		    var newhtml = document.getElementById("qrDivimg").innerHTML;
		    ifrdoc.write(newhtml);
		    ifrdoc.write("</BODY>");
		    ifrdoc.close();
		  /*document.body.removeChild(ifr);  */
		    
	}
	 /*弹出框*/
	 function tckWindow(newhtml){
		 var wind = window.open("",'newwindow', 'height=300, width=700, top=100, left=100, toolbar=no, menubar=no, scrollbars=no, resizable=no,location=n o, status=no');
		    wind.document.write("<BODY>")
	        wind.document.write(newhtml);
		    wind.document.write("<a href=\"javascript:window.print();\" class=\"noprint\" >打印</a>");
		    wind.document.write("</BODY>");
		    wind.document.close();
	}
		function print1() {//打印
			    
			var headhtml = "<html>";
			    headhtml+= "<head>";
			    headhtml+= "<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">";
			    headhtml+= "<title>" + "\u6253\u5370" + "</title>";
			    headhtml+= "<style type=\"text/css\" media=\"print\">.noprint{ display:none;}</style>";
			    headhtml+= "</head><a href=\"javascript:window.print();\" class=\"noprint\" >打印</a>";
			    headhtml+= "<body>";
			var foothtml = "</body>";
			var newhtml = document.getElementById("qrDivimg").innerHTML;
			
			var oldhtml = document.body.innerHTML;
			/* document.body.innerHTML = headhtml + newhtml + foothtml; */
			var wind = window.open("",'newwindow', 'height=300, width=700, top=100, left=100, toolbar=no, menubar=no, scrollbars=no, resizable=no,location=n o, status=no');
			console.log(wind);
			wind.document.body.innerHTML =  headhtml + newhtml + foothtml;
			/* wind.print(); */
		 /* 	document.body.innerHTML = oldhtml;   */
			
		}
		
	</script>
</body>
</html>