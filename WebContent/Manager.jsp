<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import= "com.utils.*"%>
<!DOCTYPE>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>长江流域重点断面水质情况分布</title>
    <link rel="stylesheet" href="css/ol.css" type="text/css"></link>
    <style type="text/css">	    
    	html{height:100%}
        body{height:100%; margin:0px; padding:0px}
        .container{height:100%; width:100%}
        
        .side_panel{position:absolute; width:350px; height:500px; margin:10px 50px; background:white; opacity:0.8}
        .tab-menu ul{position:absolute; top:-18px; left:-40px; list-style:none}
        .tab-menu li{display:block; width:112.5px; height:40px; float:left; border:2px solid #6690BA; text-align:center; line-height:40px; font-weight:bold} 
        .tab-box div{position:absolute; top: 40px; width:346px; height:460px; border:2px solid #6690BA; display:none; overflow-x:scroll; overflow-y:scroll; font-size:12}        
        fieldset{background-color:#f1f1f1; border:none; border-radius:2px; margin-bottom:12px; overflow: hidden;}
        label{cursor:pointer; display:inline-block; padding:3px 6px; text-align:right; width:90px;vertical-align:top;}
        input{font-size:inherit;}
        
        /* 让第一个框显示出来 */
        .tab-box div:first-Child{display:block;}
        /* 改变选项卡选中时候的样式 */
        .change{background:red;}       
		</style>
	<script src="js/jquery-3.3.1.min.js"></script>
    <!-- The line below is only needed for old environments like Internet Explorer and Android 4.x -->
    <script src="js/polyfill.min.js"></script>
    <script src="js/ol.js"></script>
    <%@ include file="SessionCheck.jsp"%>
</head>
<body>
    <!--地图界面 -->
    <div class="container">
        <div id="map" class="map"></div>        
    </div>

    <!--工具条 -->
    <div class='side_panel' style='position:fixed; z-index:999; top:0;'>
        <div class="tab-menu">
            <ul>
                <li>添加站点</li>
                <li>编辑站点</li>
                <li>删除站点</li>
            </ul>
        </div>
        <div class="tab-box">
            <div class="add">
            <fieldset>
            <p><label>点位坐标: </label>
            	<input type="text" id="Coordinate_1" /></p>
            <p><label>点位名称: </label>
            	<input type="text" id="StationName_1" /></p>
            <p><label>河流名称: </label>
            	<input type="text" id="RiverName_1" /></p>
            <p><label>断面情况: </label>
            	<input type="text" id="Section_1" /></p>
            <p><label>PH: </label>
            	<input type="text" id="PH_1" /></p>
            <p><label>DO: </label>
            	<input type="text" id="DO_1" /></p>  
            <p><label>CODMn: </label>
            	<input type="text" id="CODMn_1" /></p>           
            <p><label>NH3-N: </label>
            	<input type="text" id="NH3_N_1" /></p>            
            <p><label>本周水质: </label>
            	<input type="text" id="WQThisWeek_1" /></p>
            <p><label>上周水质: </label>
            	<input type="text" id="WQLastWeek_1" /></p>
            <p><label>主要污染指标: </label>
            	<input type="text" id="MainPollutant_1" /></p>
            <p><label>创建表人员: </label>
            	<input type="text" id="CreateUser_1" /></p>
            <p><label>更新表人员: </label>
            	<input type="text" id="UpdateUser_1" /></p>
			</fieldset>
            <center><button onclick="doAdd()">确定</button></center>
            </div>
            <div class="edit">
            <fieldset>
            <p><label>点位名称: </label>
            	<input type="text" id="StationName_2" /></p>
            <p><label>更新字段: </label></p>
                <p><select id="FieldName">
            	<option value="geom" >点位坐标</option>
			    <option value="点位名称" >点位名称</option>
			    <option value="河流名称" >河流名称</option>
			    <option value="断面情况" >断面情况</option>
			    <option value="ph" >PH</option>
			    <option value="do_mg_l_" >DO</option>
			    <option value="codmn_mg_l" >CODMn</option>
			    <option value="nh3_n_mg_l" >NH3-N</option>
			    <option value="本周水质" >本周水质</option>
			    <option value="上周水质" >上周水质</option>
			    <option value="主要污染指标" >主要污染指标</option>
		    </select>
		    <input type="text" id="FieldValue" /></p>
            <p><label>更新表人员: </label>
            	<input type="text" id="UpdateUser_2" /></p>
		    </fieldset>
		    <center><button onclick="doEdit()">确定</button></center>
		    </div>
            <div class="delete">
            <fieldset>
            <p><label>点位名称: </label>
            	<input type="text" id="StationName_3" /></p>
			</fieldset>
            <center><button onclick="doDel()">确定</button></center>
            </div>
        </div>
    </div>
    
    <script>
    <!--初始化地图容器-->
    var map = new ol.Map({
        layers: [
          new ol.layer.Tile({
            source: new ol.source.OSM()
          })],
        target: 'map',
        view: new ol.View({
          projection: 'EPSG:4326',
          center:[99.52, 29.72],
          zoom: 5
        }),
        controls: ol.control.defaults().extend([
            new ol.control.FullScreen(), //全屏控件
            new ol.control.ScaleLine(), //比例尺
        ])
      });

    <!--设置地图样式-->
    var image = new ol.style.Circle({
        radius: 3,
        fill: new ol.style.Fill({
            color: 'rgba(255,0,0,0.5)'
        }),
        stroke: new ol.style.Stroke({color: 'red', width: 0.5})
      });
    var styles = {
        'Point': new ol.style.Style({
          image: image
        })
      };
    var styleFunction = function(feature) {
        return styles[feature.getGeometry().getType()];
      };
      
    <!--添加WMS图层-->
    var yangtze_river = new ol.layer.Tile({ 
    	title: "yangtze_river", 
    	source: new ol.source.TileWMS({ 
    		url: 'http://localhost:8080/geoserver/yangtze_river/wms', 
    		params:{'LAYERS': 'yangtze_river:yangtze_river'}
          })
    	});
    map.addLayer(yangtze_river);
    
    <!--添加GeoJson图层--> 
    <% StationDao sd = new StationDao();%>
    var geojsonObject = <%= StationDao.getStationGeom()%>;
    var stations = new ol.layer.Vector({
    	title: "stations", 
    	source: new ol.source.Vector({
    		features: (new ol.format.GeoJSON()).readFeatures(geojsonObject)
    		}),
    		style: styleFunction
    		});
    map.addLayer(stations);
    
    <!--站点增删改窗口变化--> 
    $().ready(function(){
        $(".tab-menu li").click(function(){
        //通过 .index()方法获取元素下标，从0开始，赋值给某个变量
            var _index = $(this).index();
        //让内容框的第 _index 个显示出来，其他的被隐藏
            $(".tab-box>div").eq(_index).show().siblings().hide();
        //改变选中时候的选项框的样式，移除其他几个选项的样式
        $(this).addClass("change").siblings().removeClass("change");  
        });
    }); 
    
    <!--添加站点--> 
    //点击输入并显示空间信息
    var pos;
    map.addEventListener('click', function(evt) {
    	var lonlat = evt.coordinate;
    	pos = lonlat.toString();
     	alert("当前坐标:" + pos);
    	});
    
    //执行添加操作
    function doAdd(){
        //输入：属性信息
        var Coordinate = $('#Coordinate_1').val();
    	var StationName = $('#StationName_1').val();
    	var RiverName = $('#RiverName_1').val();
    	var Section = $('#Section_1').val();
    	var PH = $('#PH_1').val();
    	var DO = $('#DO_1').val();
    	var CODMn = $('#CODMn_1').val();
    	var NH3_N = $('#NH3_N_1').val();
    	var WQThisWeek = $('#WQThisWeek_1').val();
    	var WQLastWeek = $('#WQLastWeek_1').val();
    	var MainPollutant = $('#MainPollutant_1').val();
        var CreateUser = $('#CreateUser_1').val();
    	var UpdateUser = $('#UpdateUser_1').val();
        $.ajax({
            type: "post",
            url: "AddServlet",
            dataType: "text",
            data:{
            	StationName : StationName,
            	RiverName : RiverName,
            	Section : Section,
            	PH : PH,
            	DO : DO,
            	CODMn : CODMn,
            	NH3_N : NH3_N,
            	WQThisWeek : WQThisWeek,
            	WQLastWeek : WQLastWeek,
            	MainPollutant : MainPollutant,
				CreateUser : CreateUser,
            	UpdateUser : UpdateUser,
            	Coordinate : Coordinate
            	},       
            success: function (data) {
            	console.log(data);
            	if(data == 1)
            		alert("数据上传成功！"); 
            	else
            		alert("数据上传失败！");
            },
            error: function(xhr, status, errMsg) {
            	alert("数据上传失败！");
            }
        }); 
    };
    
    //执行编辑操作
    function doEdit(){
        //输入：属性信息
        var StationName = $('#StationName_2').val();
        var FieldName = $('#FieldName').val();
    	var FieldValue = $('#FieldValue').val();
    	var UpdateUser = $('#UpdateUser_2').val();
        $.ajax({
            type: "post",
            url: "EditServlet",
            dataType: "text",
            data:{
            	StationName : StationName,
            	FieldName : FieldName,
            	FieldValue : FieldValue,
            	UpdateUser : UpdateUser
            	},       
            success: function (data) {
            	console.log(data);
            	if(data == 1)
            		alert("数据更新成功！"); 
            	else
            		alert("数据更新失败！");
            },
            error: function(xhr, status, errMsg) {
            	alert("数据更新失败！");
            }
        }); 
    };

    //执行删除操作
    function doDel(){
        //输入：属性信息
    	var StationName = $('#StationName_3').val();
        $.ajax({
            type: "post",
            url: "DelServlet",
            dataType: "text",
            data:{
            	StationName : StationName
            	},       
            success: function (data) {
            	console.log(data);
            	if(data == 1)
            		alert("数据删除成功！"); 
            	else
            		alert("数据删除失败！");
            },
            error: function(xhr, status, errMsg) {
            	alert("数据删除失败！");
            }
        }); 
    } 
    </script>   
</body>
</html>