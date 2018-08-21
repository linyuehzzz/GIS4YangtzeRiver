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
        #container{height:100%; width:100%}		  
		#heatmap{position:absolute; right:100px; margin:10px}
		#heatmap select{position:absolute; top:0; right:76px; width:100px; height:100%; border:2px solid #7BA7AB; border-radius:0 5px 5px 0; cursor:pointer; opacity:0.8;}
  		#side_panel{position:absolute; width:300px; height:500px; margin:10px 50px; background:white; opacity:0.8}
   		#querySearch input{position:absolute; width:300px; height:40px; padding-left:10px; border:2px solid #6690BA; border-radius:3px; outline:none; background:white; color:#9E9C9C; opacity:0.9}
   		#querySearch button{position:absolute; top:4px; left:250px; width:32px; height:32px; border:none; border-radius:0 3px 3px 0; cursor:pointer; background:url(img/search.png)no-repeat} 		
  		#queryDisplay{position:absolute; top:30px; left:5px; width:300px}
   		#river{position:relative; top: -10px; font-size:12}
   		#waterQuality{position:relative; font-size:13}
		</style>
	<script src="js/jquery-3.3.1.min.js"></script>
	<script src="js/echarts.js"></script>
	<script src="js/turf.min.js"></script>
    <!-- The line below is only needed for old environments like Internet Explorer and Android 4.x -->
    <script src="js/polyfill.min.js"></script>
    <script src="js/ol.js"></script>
    <%@ include file="SessionCheck.jsp"%>
</head>
<body>
    <!--地图界面 -->
    <div id="container">
        <div id="map" class="map"></div>
    </div>
   
    <!--侧边栏 -->
    <div id='side_panel' style='position:fixed; z-index:999; top:0;'>
		<!--搜索框 -->
	    <div id='querySearch'>
	        <input type="text" id="queryName"/>
	        <button onclick="doQuery()"></button>
	    </div>
		<!--搜索结果 -->		
		<div id='queryDisplay'>
	        <h3 id="station"></h3>
	        <p id="river"></p>
	        <p id="waterQuality"></p>
	        <p id="chartmain" style='width:300px; height:200px;'></p>	        	           
	    </div>
    </div>
    
    <!--热力图 -->
    <div id='heatmap' style='position:fixed; z-index:999; top:0;'>
	    <select id="heatmap_option">
	        <option value="g1" >一类水质</option>
		    <option value="g2" >二类水质</option>
		    <option value="g3" >三类水质</option>
	    </select>
	    <button onclick="doHeatmap();" style='background-color:#6690BA; width:76px; height:36px; color:#FFFFFF; opacity:0.8;'>确定</button>
	</div>
	
<!-- 	<!--缓冲区--> -->
<!--     <div id='buffer' style='position:fixed; z-index:999; top:0;'> -->
<!-- 	    <button onclick="doBuffer();" style='background-color:#6690BA; width:76px; height:36px; color:#FFFFFF; opacity:0.8;'>生成缓冲区</button> -->
<!-- 	</div> -->
		     
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
    var geojsonObject = <%= StationDao.getStationGeom()%>;
    var stations = new ol.layer.Vector({
    	title: "stations", 
    	source: new ol.source.Vector({
    		features: (new ol.format.GeoJSON()).readFeatures(geojsonObject)
    		}),
    		style: styleFunction
    		});
    map.addLayer(stations);
    
    <!--显示热力图--> 
    function doHeatmap(){
        var value = document.getElementById('heatmap_option').value;
        var heatmapObject;
        if(value == "g1")
        	heatmapObject = <%= StationDao.getHeatmap1()%>;
        else if(value == "g2")
        	heatmapObject = <%= StationDao.getHeatmap2()%>;
        else if(value == "g3")
            	heatmapObject = <%= StationDao.getHeatmap3()%>;
        var heatmap = new ol.layer.Heatmap({
        	source: new ol.source.Vector({
        		features: (new ol.format.GeoJSON()).readFeatures(heatmapObject)
        		})
          });
          map.addLayer(heatmap);
    }
    
    <!--显示缓冲区-->
    function doBuffer(){
/*     	var pt = {
    			  "type": "Feature",
    			  "properties": {},
    			  "geometry": {
    			    "type": "Point",
    			    "coordinates": [-90.548630, 14.616599]
    			  }
    			}; */
    			var unit = 'miles';

    			var buffered = turf.buffer(geojsonObject, 500, unit);
    			var result = turf.featurecollection([buffered, geojsonObject]);
    	        var buffer = new ol.layer.Vector({
    	        	source: new ol.source.Vector({
    	        		features: buffered
    	        		})
    	          });
    	          map.addLayer(buffer);
    }
      
    <!--提交条件查询-->   
    function doQuery () {
    	var queryName = $('#queryName').val();
        $.ajax({
            type: "post",
            url: "QueryServlet",
            dataType: "json",
            data:{queryName : queryName},       
            success: function (data) {
            	console.log(data);
                var item = data.station;
                console.log(item[0]);
            	var s = item[0].id + "&nbsp;&nbsp;&nbsp;" + item[0].StationName;
            	$("#station").html(s);
            	var r = item[0].RiverName + "&nbsp;|&nbsp;" + item[0].Section 
            	        + "<hr style=\"position:relative; left:-5px; filter:alpha(opacity=100, finishopacity=0, style=3)\" color=#6690BA size=2>";
            	$("#river").html(r);
            	var w = "本周水质：" + item[0].QualityThisWeek + "<br>" + "上周水质：" + item[0].QualityLastWeek;
            	$("#waterQuality").html(w);
            	doChart(item[0].PH, item[0].DO, item[0].CODMn, item[0].NH3_N);
            },
            error: function(xhr, status, errMsg) {
            	alert("网络异常，请稍后重试");
            }
        });
    }
    
    <!--点击查询-->
    //注册点击事件
    var coordinate;
    map.addEventListener('click', function(evt) {
    	var lonlat = evt.coordinate;
    	coordinate = lonlat.toString();
    	mapClick(coordinate);
    	});
    //点击事件
    function mapClick(coordinate) {
        $.ajax({ 
            type: "post", 
            url: "ClickServlet", 
            dataType: "json", 
            data:{coordinate : coordinate},
            success: function (data) {
                var item = data.station;
               	var s = item[0].id + "&nbsp;&nbsp;&nbsp;" + item[0].StationName;
               	$("#station").html(s);
               	var r = item[0].RiverName + "&nbsp;|&nbsp;" + item[0].Section 
               	        + "<hr style=\"position:relative; left:-5px; filter:alpha(opacity=100, finishopacity=0, style=3)\" color=#6690BA size=2>";
               	$("#river").html(r);
               	var w = "本周水质：" + item[0].QualityThisWeek + "<br>" + "上周水质：" + item[0].QualityLastWeek;
               	$("#waterQuality").html(w);
               	doChart(item[0].PH, item[0].DO, item[0].CODMn, item[0].NH3_N);
                }, 
            error: function(xhr, status, errMsg) {
                    alert("网络异常，请稍后重试");
            } 
        });
    }
    
    <!--显示统计图表-->    
    function doChart(_ph, _do, _codmn, _nh3n){
        //指定图标的配置和数据
        var option = {
            legend:{
                data:['指标值']
            },
            xAxis:{
                data:["PH","DO","CODMn","NH3-N"]
            },
            yAxis:{
            },
            series:[{
                name:'指标值',
                type:'line',
                data:[_ph, _do, _codmn, _nh3n]
            }]
        };
        //初始化echarts实例
        var myChart = echarts.init(document.getElementById('chartmain'));
        //使用制定的配置项和数据显示图表
        myChart.setOption(option);
    }
    </script>   
</body>
</html>