<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>길찾기</title>
<link rel="stylesheet" type="text/css" href="/bts/css/w3.css">
<link rel="stylesheet" type="text/css" href="/bts/css/user.css">
<link rel="stylesheet" href="/bts/css/font-awesome-4.7.0/css/font-awesome.min.css">
<style type="text/css">
	#map {
      width: calc(100%-360px);
      height: 863px;
    }
    .map_wrap, .map_wrap * {margin:0; padding:0;font-family:'Malgun Gothic',dotum,'돋움',sans-serif;font-size:12px;}
	.map_wrap {position:relative;width:100%;height:350px;}
	#category {position:absolute;top:10px;left:10px;border-radius: 5px; border:1px solid #909090;box-shadow: 0 1px 1px rgba(0, 0, 0, 0.4);background: #fff;overflow: hidden;z-index: 2;}
	#category li {float:left;list-style: none;width:50px;px;border-right:1px solid #acacac;padding:6px 0;text-align: center; cursor: pointer;}
	#category li.on {background: #eee;}
	#category li:hover {background: #ffe6e6;border-left:1px solid #acacac;margin-left: -1px;}
	#category li:last-child{margin-right:0;border-right:0;}
	#category li span {display: block;margin:0 auto 3px;width:27px;height: 28px;}
	#category li .category_bg {background:url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_category.png) no-repeat;}
	#category li .bank {background-position: -10px 0;}
	#category li .mart {background-position: -10px -36px;}
	#category li .pharmacy {background-position: -10px -72px;}
	#category li .oil {background-position: -10px -108px;}
	#category li .cafe {background-position: -10px -144px;}
	#category li .store {background-position: -10px -180px;}
	#category li.on .category_bg {background-position-x:-46px;}
	.placeinfo_wrap {position:absolute;bottom:28px;left:-150px;width:300px;}
	.placeinfo {position:relative;width:100%;border-radius:6px;border: 1px solid #ccc;border-bottom:2px solid #ddd;padding-bottom: 10px;background: #fff;}
	.placeinfo:nth-of-type(n) {border:0; box-shadow:0px 1px 2px #888;}
	.placeinfo_wrap .after {content:'';position:relative;margin-left:-12px;left:50%;width:22px;height:12px;background:url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')}
	.placeinfo a, .placeinfo a:hover, .placeinfo a:active{color:#fff;text-decoration: none;}
	.placeinfo a, .placeinfo span {display: block;text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
	.placeinfo span {margin:5px 5px 0 5px;cursor: default;font-size:13px;}
	.placeinfo .title {font-weight: bold; font-size:14px;border-radius: 6px 6px 0 0;margin: -1px -1px 0 -1px;padding:10px; color: #fff;background: #d95050;background: #d95050 url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/arrow_white.png) no-repeat right 14px center;}
	.placeinfo .tel {color:#0f7833;}
	.placeinfo .jibun {color:#999;font-size:11px;margin-top:0;}
	.path{cursor:pointer}
	.path:hover {
	    background-color: grey;
		}
        .custom-button {
            width: 70px;
            height: 42px;
            cursor: pointer;
            border: 2px solid gray;
            display: flex;
            justify-content: center;
            align-items: center;
            text-align: center;
        }
        .w3-super-tiny {
		    font-size: 10px; /* 원하는 크기로 설정 */
		}
</style>
<script type="text/javascript" src="/bts/js/jquery-3.7.1.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=35379a3118419781fdc5be592d7fe272&libraries=services"></script>
<script>
	$(document).ready(function() {
		
	    var sx, sy,ex, ey;
	    var polylines = [];
	    var polylines2 = [];
	    var shadowPolylines = [];
	    var markers2=[];
	    var lineArray = [];
	    var lineArray2 = [];
	    var facilitiesData = [];
	    
	    
	    $('#homeBtn').click(function(){
	    	$(location).attr('href', '/bts/main.bts');
	    });
	    
	    
        $('#resetBtn').on('click', function(event) {
            $('#origin').val("");
            $('#destination').val("");

        });
        
        function getDayType() {
            const today = new Date();
            const day = today.getDay(); 

            let dayType;

            if (day === 0 || day === 6) {
                dayType = "휴일"; 
            } else {
                dayType = "평일"; 
            }

            return dayType;
        }

	    function loadFacilities() {
	        $.ajax({
	            url: "/bts/facility/getAllFacilities.bts",
	            type: "GET",
	            success: function(response) {
	                facilitiesData = response;

	            },
	            error: function(error) {
	                console.error("Error fetching facility data:", error);
	            }
	        });
	    }

	    function getFacilityData(laneType, staNm) {
	        for (var i = 0; i < facilitiesData.length; i++) {
	            if (facilitiesData[i].laneType === laneType && facilitiesData[i].staNm === staNm) {
	                return facilitiesData[i];
	            }
	        }
	        return { evCnt: 0, esCnt: 0, clCnt: 0 }; // default value if no match found
	    }

	    // 초기 로드 시 편의시설 데이터 불러오기
	    loadFacilities();
	    

		var placeOverlay = new kakao.maps.CustomOverlay({zIndex:1}), 
		contentNode = document.createElement('div'), // 커스텀 오버레이의 컨텐츠 엘리먼트 입니다 
		markers = [], // 마커를 담을 배열입니다
		currCategory = ''; // 현재 선택된 카테고리를 가지고 있을 변수입니다
		
	    var mapContainer = document.getElementById('map');
	    var mapOption = {
	        center: new kakao.maps.LatLng(37.5665851,126.9782038),
	        level: 5
	    };
	    var map = new kakao.maps.Map(mapContainer, mapOption);
	    
	    var zoomControl = new kakao.maps.ZoomControl();
	    map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
	    var ps = new kakao.maps.services.Places(map); 
	    var ps2 = new kakao.maps.services.Places();
	    
        $('#searchButton').on('click', function(event) {

            // 출발지와 도착지 입력값 가져오기
            var startLoc = $('#origin').val().trim();
            var endLoc = $('#destination').val().trim();

            // 출발지와 도착지가 비어있는지 확인
            if (!startLoc || !endLoc) {
                alert('출발지와 도착지를 입력해주세요!');
                return;
            }

            removeMarker2();
            removePolyline();

            // 검색 함수 호출
            searchLoadPlaces(startLoc, endLoc);
        });
	    
	    function removePolyline() {
	        if (polylines.length > 0) {
	            for (var i = 0; i < polylines.length; i++) {
		        	polylines[i].setMap(null); // 지도에서 라인 제거
				}
	        }
	        if (polylines2.length > 0) {
	            for (var i = 0; i < polylines2.length; i++) {
		        	polylines2[i].setMap(null); // 지도에서 라인 제거
				}
	        }
	        if (shadowPolylines.length > 0) {
	            for (var i = 0; i < shadowPolylines.length; i++) {
	            	shadowPolylines[i].setMap(null); // 지도에서 라인 제거
				}
	        }
	        polylines = []; // 변수 초기화
	        polylines2 = []; // 변수 초기화
	        shadowPolylines =[];
	    }
	    
	    function removeMarker2() {
	        if (markers2) {
		        for ( var i = 0; i < markers2.length; i++ ) {
		            markers2[i].setMap(null);
		        }
		        markers2 = [];
	        }
	    }

	    
	    
	    function searchLoadPlaces(startLoc, endLoc) {

            if (!startLoc.replace(/^\s+|\s+$/g, '') || !endLoc.replace(/^\s+|\s+$/g, '')) {
                alert('출발지와 도착지를 입력해주세요!');
                return false;
            }

	        ps2.keywordSearch(startLoc, function(data, status) {
	            if (status === kakao.maps.services.Status.OK) {
	                sx = data[0].x;
	                sy = data[0].y;

	                ps2.keywordSearch(endLoc, function(data, status) {
	                    if (status === kakao.maps.services.Status.OK) {
	                        ex = data[0].x;
	                        ey = data[0].y;

	                        searchPubTransPathAJAX(sx,sy,ex,ey); // 검색 결과로 길찾기 API 호출
	                    } else {
	                        alert('도착지 검색 결과가 없습니다.');
	                    }
	                });
	            } else {
	                alert('출발지 검색 결과가 없습니다.');
	            }
	        });
	    }

	 	// 지도에 idle 이벤트를 등록합니다
	    kakao.maps.event.addListener(map, 'idle', searchPlaces);

	    // 커스텀 오버레이의 컨텐츠 노드에 css class를 추가합니다 
	    contentNode.className = 'placeinfo_wrap';

	    // 커스텀 오버레이의 컨텐츠 노드에 mousedown, touchstart 이벤트가 발생했을때
	    // 지도 객체에 이벤트가 전달되지 않도록 이벤트 핸들러로 kakao.maps.event.preventMap 메소드를 등록합니다 
	    addEventHandle(contentNode, 'mousedown', kakao.maps.event.preventMap);
	    addEventHandle(contentNode, 'touchstart', kakao.maps.event.preventMap);

	    // 커스텀 오버레이 컨텐츠를 설정합니다
	    placeOverlay.setContent(contentNode);  

	    // 각 카테고리에 클릭 이벤트를 등록합니다
	    addCategoryClickEvent();

	    // 엘리먼트에 이벤트 핸들러를 등록하는 함수입니다
	    function addEventHandle(target, type, callback) {
	        if (target.addEventListener) {
	            target.addEventListener(type, callback);
	        } else {
	            target.attachEvent('on' + type, callback);
	        }
	    }

	    // 카테고리 검색을 요청하는 함수입니다
	    function searchPlaces() {
	        if (!currCategory) {
	            return;
	        }
	        
	        // 커스텀 오버레이를 숨깁니다 
	        placeOverlay.setMap(null);

	        // 지도에 표시되고 있는 마커를 제거합니다
	        removeMarker();
	        
	        ps.categorySearch(currCategory, placesSearchCB, {useMapBounds:true}); 
	    }

	    // 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
	    function placesSearchCB(data, status, pagination) {
	        if (status === kakao.maps.services.Status.OK) {

	            // 정상적으로 검색이 완료됐으면 지도에 마커를 표출합니다
	            displayPlaces(data);
	        } else if (status === kakao.maps.services.Status.ZERO_RESULT) {
	            // 검색결과가 없는경우 해야할 처리가 있다면 이곳에 작성해 주세요

	        } else if (status === kakao.maps.services.Status.ERROR) {
	            // 에러로 인해 검색결과가 나오지 않은 경우 해야할 처리가 있다면 이곳에 작성해 주세요
	            
	        }
	    }

	    // 지도에 마커를 표출하는 함수입니다
	    function displayPlaces(places) {

	        // 몇번째 카테고리가 선택되어 있는지 얻어옵니다
	        // 이 순서는 스프라이트 이미지에서의 위치를 계산하는데 사용됩니다
	        var order = document.getElementById(currCategory).getAttribute('data-order');

	        for ( var i=0; i<places.length; i++ ) {

	                // 마커를 생성하고 지도에 표시합니다
	                var marker = addMarker(new kakao.maps.LatLng(places[i].y, places[i].x), order);

	                // 마커와 검색결과 항목을 클릭 했을 때
	                // 장소정보를 표출하도록 클릭 이벤트를 등록합니다
	                (function(marker, place) {
	                    kakao.maps.event.addListener(marker, 'click', function() {
	                        displayPlaceInfo(place);
	                    });
	                })(marker, places[i]);
	        }
	    }

	    // 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
	    function addMarker(position, order) {
	        var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_category.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
	            imageSize = new kakao.maps.Size(27, 28),  // 마커 이미지의 크기
	            imgOptions =  {
	                spriteSize : new kakao.maps.Size(72, 208), // 스프라이트 이미지의 크기
	                spriteOrigin : new kakao.maps.Point(46, (order*36)), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
	                offset: new kakao.maps.Point(11, 28) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
	            },
	            markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
	                marker = new kakao.maps.Marker({
	                position: position, // 마커의 위치
	                image: markerImage 
	            });

	        marker.setMap(map); // 지도 위에 마커를 표출합니다
	        markers.push(marker);  // 배열에 생성된 마커를 추가합니다

	        return marker;
	    }

	    // 지도 위에 표시되고 있는 마커를 모두 제거합니다
	    function removeMarker() {
	        for ( var i = 0; i < markers.length; i++ ) {
	            markers[i].setMap(null);
	        }   
	        markers = [];
	    }

	    // 클릭한 마커에 대한 장소 상세정보를 커스텀 오버레이로 표시하는 함수입니다
	    function displayPlaceInfo (place) {
	        var content = '<div class="placeinfo">' +
	                        '   <a class="title" href="' + place.place_url + '" target="_blank" title="' + place.place_name + '">' + place.place_name + '</a>';   

	        if (place.road_address_name) {
	            content += '    <span title="' + place.road_address_name + '">' + place.road_address_name + '</span>' +
	                        '  <span class="jibun" title="' + place.address_name + '">(지번 : ' + place.address_name + ')</span>';
	        }  else {
	            content += '    <span title="' + place.address_name + '">' + place.address_name + '</span>';
	        }                
	       
	        content += '    <span class="tel">' + place.phone + '</span>' + 
	                    '</div>' + 
	                    '<div class="after"></div>';

	        contentNode.innerHTML = content;
	        placeOverlay.setPosition(new kakao.maps.LatLng(place.y, place.x));
	        placeOverlay.setMap(map);  
	    }


	    // 각 카테고리에 클릭 이벤트를 등록합니다
	    function addCategoryClickEvent() {
	        var category = document.getElementById('category'),
	            children = category.children;

	        for (var i=0; i<children.length; i++) {
	            children[i].onclick = onClickCategory;
	        }
	    }

	    // 카테고리를 클릭했을 때 호출되는 함수입니다
	    function onClickCategory() {
	        var id = this.id,
	            className = this.className;

	        placeOverlay.setMap(null);

	        if (className === 'on') {
	            currCategory = '';
	            changeCategoryClass();
	            removeMarker();
	        } else {
	            currCategory = id;
	            changeCategoryClass(this);
	            searchPlaces();
	        }
	    }

	    // 클릭된 카테고리에만 클릭된 스타일을 적용하는 함수입니다
	    function changeCategoryClass(el) {
	        var category = document.getElementById('category'),
	            children = category.children,
	            i;

	        for ( i=0; i<children.length; i++ ) {
	            children[i].className = '';
	        }

	        if (el) {
	            el.className = 'on';
	        } 
	    } 
	    function getCurrentTime(min) {
	        var now = new Date();
	        now.setMinutes(now.getMinutes() + min); // 현재 시간에 min 만큼 더하기
	        var hours = now.getHours();
	        var minutes = now.getMinutes();
	        var ampm = hours >= 12 ? '오후' : '오전';
	        hours = hours % 12;
	        hours = hours ? hours : 12; // 0을 12로 변환
	        var strMinutes = minutes < 10 ? '0' + minutes : minutes;
	        return ampm + ' ' + hours + ':' + strMinutes;
	    }
	    function getNowTime() {
	        var now = new Date();
	        var hours = now.getHours();
	        var minutes = now.getMinutes();
	        var strMinutes = minutes < 10 ? '0' + minutes : minutes;
	        return hours + ':' + strMinutes;
	    }
	    
	
	    function searchPubTransPathAJAX(sx,sy,ex,ey) {
	        $.ajax({
	            url: "https://api.odsay.com/v1/api/searchPubTransPathT",
	            type: "POST",
	            data: {
	                SX: sx,
	                SY: sy,
	                EX: ex,
	                EY: ey,
	                apiKey: "qY8+WJHuyz/xRJc4hOxkn4HDRLV5XSv3e9kR3+5GiE8"
	            },
	            success: function(response) {
	            	
	                var resultJsonData = response;
	                var getData = response.error;
	                var pathList = document.getElementById('pathList');
	                pathList.innerHTML='';
	                var mapObjs = [];
	                var startStNm = [];
	                var sbCode =[];
	                var upDownCode = [];
	                 
	                for (var l = 0; l < resultJsonData.result.path.length; l++) {
						var busID = [];
						var busNm = [];
						var addInfo = [];
						var hBtn = '';
						
					    for (var i = 0; i < resultJsonData.result.path[l].subPath.length; i++) {
						    var lane = resultJsonData.result.path[l].subPath[i].lane;
						    busNm[i] = []; // 각 subPath에 대한 배열 초기화
						    if (lane && lane.length > 0) { // lane이 존재하고 길이가 0보다 큰 경우
						    	for (var j = 0; j < lane.length; j++) {
						        	var busNo = lane[j].busNo;
						        	if (busNo && busNo.trim() !== "") { // busNo가 유효한 경우에만 추가
						          		busNm[i].push(busNo);
						        	}
						        }
						    }
						}
						
	                	if (resultJsonData.result.path[l].subPath[1].trafficType == 1) {
		                		hBtn = '<div class="w3-button w3-super-tiny w3-teal w3-right w3-round-large mgt8 hjdBtn" style="font-weight:bold" data-index="' + l + '">혼잡도 보기</div>'
		                		startStNm[l] = resultJsonData.result.path[l].subPath[1].startName;
		                		if (startStNm[l] == "서울역") {
		                			startStNm[l] == "서울";
								}
		                		sbCode[l] = resultJsonData.result.path[l].subPath[1].lane[0].subwayCode;
		                		upDownCode[l] = resultJsonData.result.path[l].subPath[1].wayCode;
					            var stationID = resultJsonData.result.path[l].subPath[1].startID;
					            var wayCode = resultJsonData.result.path[l].subPath[1].wayCode;
						        /* subwayTime(stationID, wayCode, l); */
						} else if(resultJsonData.result.path[l].subPath[1].trafficType == 2){

							
							for (var i = 0; i < resultJsonData.result.path[l].subPath[1].lane.length;i++) {
								busID[i]=resultJsonData.result.path[l].subPath[1].lane[i].busID + '';

							}					
							var stationID = resultJsonData.result.path[l].subPath[1].startID;
							/* busTime(stationID,busNm,busID,l); */
						}

		                var payment = resultJsonData.result.path[l].info.payment;
		                var totalTime = 0;
		                var icons = [];
		                var transportTypes = [];
		                var sectionTimes = [];
		                var trafficTypes = [];
		                var perSections =[];
		                var laneColors = [];
		                var startNames = [];
		                var endNames = [];
		                
	                    
		                pathList.innerHTML += '<div class="w3-col w3-border path" id="path' + l + '">'+
		                '<div class="pdw15 mgh10">' +
		                    '<span class="w3-xlarge w3-text-pink" id="totalTime' + l +'"></span>' +
		                    '<span class="w3-small" id="arrivalTime' + l + '"></span>' +
		                    '<span class="w3-small" id="payment' + l + '"></span>' +
		                     hBtn +
		                    '<div class="w3-col w3-tiny w3-round-xlarge mgh10" style="background-color:#9c9c9c;" id="prBar' + l + '"></div>' +
		                '</div>' +
		                '<div class="w3-col pdh10 pdw15 w3-border-top" id="transportRoute' + l + '"></div>' +
		            '</div>';
	                	    
    	                var prBar = document.getElementById('prBar' + l);
    	                var transportRoute = document.getElementById('transportRoute' + l);

    	                prBar.style.display = 'flex';
					
		                if (!getData) {
		                	mapObjs[l] = resultJsonData.result.path[l].info.mapObj;
		                	
		           
			                for (var i = 0; i < resultJsonData.result.path[l].subPath.length; i++) {
			                	
				                sectionTimes[i] = resultJsonData.result.path[l].subPath[i].sectionTime;
				                var startName = resultJsonData.result.path[l].subPath[i].startName;
				                var endName = resultJsonData.result.path[l].subPath[i].endName;
				                
				                if (startName) {
									
					                startNames[i] = startName;
					                endNames[i] = endName;
								}
				                
				                trafficTypes[i] = resultJsonData.result.path[l].subPath[i].trafficType;
				                if (sectionTimes[i] == 0) {
				                	sectionTimes[i] = 1;
								}
				                totalTime += sectionTimes[i];
				                addInfo[i] = '';
				                if (trafficTypes[i] == 1) {
				                	
				                    var subwayCode = resultJsonData.result.path[l].subPath[i].lane[0].subwayCode;
						            var stationID = resultJsonData.result.path[l].subPath[1].startID;
						            var wayCode = resultJsonData.result.path[l].subPath[1].wayCode;
				                    var laneColor, transportType;
				                    switch (subwayCode) {
				                        case 1: 
				                            laneColor = '#003499';  // 수도권 1호선
				                            transportType = '1호선';
				                            break;
				                        case 2: 
				                            laneColor = '#37b42d';  // 수도권 2호선
				                            transportType = '2호선';
				                            break;
				                        case 3: 
				                            laneColor = '#ff6f00';  // 수도권 3호선
				                            transportType = '3호선';
				                            break;
				                        case 4: 
				                            laneColor = '#ffcc00';  // 수도권 4호선
				                            transportType = '4호선';
				                            break;
				                        case 5: 
				                            laneColor = '#8e44ad';  // 수도권 5호선
				                            transportType = '5호선';
				                            break;
				                        case 6: 
				                            laneColor = '#3498db';  // 수도권 6호선
				                            transportType = '6호선';
				                            break;
				                        case 7: 
				                            laneColor = '#e74c3c';  // 수도권 7호선
				                            transportType = '7호선';
				                            break;
				                        case 8: 
				                            laneColor = '#2ecc71';  // 수도권 8호선
				                            transportType = '8호선';
				                            break;
				                        case 9: 
				                            laneColor = '#f39c12';  // 수도권 9호선
				                            transportType = '9호선';
				                            break;
				                        case 91: 
				                            laneColor = '#003499';  // GTX-A
				                            transportType = 'GTX-A';
				                            break;
				                        case 101: 
				                            laneColor = '#ff6347';  // 공항철도
				                            transportType = '공항철도';
				                            break;
				                        case 102: 
				                            laneColor = '#ff69b4';  // 자기부상철도
				                            transportType = '자기부상철도';
				                            break;
				                        case 104: 
				                            laneColor = '#f39c12';  // 경의중앙선
				                            transportType = '경의중앙선';
				                            break;
				                        case 107: 
				                            laneColor = '#00ff00';  // 에버라인
				                            transportType = '에버라인';
				                            break;
				                        case 108: 
				                            laneColor = '#3498db';  // 경춘선
				                            transportType = '경춘선';
				                            break;
				                        case 109: 
				                            laneColor = '#d35400';  // 신분당선
				                            transportType = '신분당선';
				                            break;
				                        case 110: 
				                            laneColor = '#7f8c8d';  // 의정부경전철
				                            transportType = '의정부경전철';
				                            break;
				                        case 112: 
				                            laneColor = '#e67e22';  // 경강선
				                            transportType = '경강선';
				                            break;
				                        case 113: 
				                            laneColor = '#006400';  // 우이신설선
				                            transportType = '우이신설선';
				                            break;
				                        case 114: 
				                            laneColor = '#8b4513';  // 서해선
				                            transportType = '서해선';
				                            break;
				                        case 115: 
				                            laneColor = '#dda0dd';  // 김포골드라인
				                            transportType = '김포골드라인';
				                            break;
				                        case 116: 
				                            laneColor = '#00ced1';  // 수인분당선
				                            transportType = '수인분당선';
				                            break;
				                        case 117: 
				                            laneColor = '#4682b4';  // 신림선
				                            transportType = '신림선';
				                            break;
				                    }
				                    var facilityInfo = getFacilityData(transportType, startNames[i]);
				                    
				                	addInfo[i] += '<div class="w3-col m2 w3-small mgt10"><img src="/bts/image/icon/elevator.png" alt="엘리베이터" title="엘리베이터" style="width:20px;height:20px;"></div>' +
		    						'<div class="w3-col m2 w3-small mgt10">' + facilityInfo.evCnt + '</div>' +
		    						'<div class="w3-col m2 w3-small mgt10"><img src="/bts/image/icon/escalator.png" title="에스컬레이터" alt="에스컬레이터" style="width:20px;height:20px;"></div>' +
		    						'<div class="w3-col m2 w3-small mgt10">' + facilityInfo.esCnt + '</div>' +
		    						'<div class="w3-col m2 w3-small mgt10"><img src="/bts/image/icon/wheelchair.png" alt="휠체어리프트" title="휠제어리프트" style="width:20px;height:20px;"></i></div>' +
		    						'<div class="w3-col m2 w3-samll mgt10">' + facilityInfo.clCnt + '</div>';
				                	
			                		if (startNames[i] != '서울역') {
			                			startNames[i] += '역';
									}

				                    icons[i] = 'fa fa-subway';
				                    
				                } else if (trafficTypes[i] == 2) {
				                	
				                	if (busNm[i].length > 0) {
				                	      for (var k = 0; k < busNm[i].length; k++) { // busNm[i]의 길이를 기준으로 반복
				                	        if (busNm[i][k]) { // busNm[i][k]가 유효한 경우에만 추가
				                	          if (k === busNm[i].length - 1) {
				                	            addInfo[i] += busNm[i][k];
				                	          } else {
				                	            addInfo[i] += busNm[i][k] + ' | ';
				                	          }
				                	        }
				                	      }
				                	    }
				                	
				                    var busCode = resultJsonData.result.path[l].subPath[i].lane[0].type;
				                    switch (busCode) {
				                        case 1: 
				                            laneColor = '#2980b9';  // 일반
				                            transportType = '일반';
				                            break;
				                        case 2: 
				                            laneColor = '#8e44ad';  // 좌석
				                            transportType = '좌석';
				                            break;
				                        case 3: 
				                            laneColor = '#f39c12';  // 마을버스
				                            transportType = '마을버스';
				                            break;
				                        case 4: 
				                            laneColor = '#e74c3c';  // 직행좌석
				                            transportType = '직행좌석';
				                            break;
				                        case 5: 
				                            laneColor = '#36c6f4';  // 공항버스
				                            transportType = '공항버스';
				                            break;
				                        case 6: 
				                            laneColor = '#3498db';  // 간선급행
				                            transportType = '간선급행';
				                            break;
				                        case 10: 
				                            laneColor = '#27ae60';  // 외곽
				                            transportType = '외곽';
				                            break;
				                        case 11: 
				                            laneColor = '#003499';  // 간선
				                            transportType = '간선';
				                            break;
				                        case 12: 
				                            laneColor = '#37b42d';  // 지선
				                            transportType = '지선';
				                            break;
				                        case 13: 
				                            laneColor = '#9b59b6';  // 순환
				                            transportType = '순환';
				                            break;
				                        case 14: 
				                            laneColor = '#e67e22';  // 광역
				                            transportType = '광역';
				                            break;
				                        case 15: 
				                            laneColor = '#2c3e50';  // 급행
				                            transportType = '급행';
				                            break;
				                        case 16: 
				                            laneColor = '#d35400';  // 관광버스
				                            transportType = '관광버스';
				                            break;
				                        case 20: 
				                            laneColor = '#16a085';  // 농어촌버스
				                            transportType = '농어촌버스';
				                            break;
				                        case 22: 
				                            laneColor = '#34495e';  // 경기도 시외형버스
				                            transportType = '경기도 시외형버스';
				                            break;
				                        case 26: 
				                            laneColor = '#95a5a6';  // 급행간선
				                            transportType = '급행간선';
				                            break;
	
				                    }
				                    icons[i] = 'fa fa-bus';
				                } else {
				                    laneColor = '#9c9c9c';
				                    transportType = '기타';
				                    icons[i] = '';
				                    addInfo[i] = '';
				                }
				                laneColors[i] = laneColor;
				                transportTypes[i] = transportType;
				                
							}

			                for (var i = 0; i < sectionTimes.length; i++) {
			                	perSections[i] = sectionTimes[i] / totalTime * 100;
			                	var minWidth = 20;
			                	prBar.innerHTML += '<div class="w3-col w3-round-xlarge w3-center" style="color:white; width:' + 
			                	perSections[i] + '%; min-width:' + minWidth + 'px; background-color:' + laneColors[i] + '">' + 
			                	sectionTimes[i] + '분</div>';
							}
			                
			                
			                for (var i = 1; i < sectionTimes.length ; i += 2) {
			                	
			                	if (i == 1) {
			                		

				                	transportRoute.innerHTML +=
				                		'<div class="w3-col pdb10">' +
				    					'<div class="w3-col m3 w3-small" style="color:' + 
				    					laneColors[i] + '"><i class="' + icons[i] + '"></i> ' +
				    					transportTypes[i] + '</div>' +
				    					'<div class="w3-col m8 w3-small"> ' + startNames[i] +
				    						'<div id="facilities' + i + '_' + l + '">' + addInfo[i] + '</div>' +
				    						'<div class="w3-col w3-text-red w3-small mgt10" id="arriveTime' + l + '"></div>' +
				    					'</div>' +
				    	        	'</div>'
								} else {
				                	transportRoute.innerHTML +=
				                		'<div class="w3-col pdb10">' +
				                		'<div class="w3-col m3 w3-small" style="color:' + laneColors[i] + '"><i class="' + icons[i] + '"></i> '
				                		+ transportTypes[i] + '</div>' +
				    					'<div class="w3-col m8 w3-small"> ' + startNames[i] +
			    							'<div id="facilities' + i + '_' + l + '">' + addInfo[i] + '</div>' +
				    					'</div>' +
				    	        	'</div>';
									
								}
			                	
							}

			                
					        
			                transportRoute.innerHTML +=
			                    '<div class="w3-col pdb10">' +
			                    '<div class="w3-col m3 w3-small"><i class="fa fa-circle"></i> 하차</div>' +
			                    '<div class="w3-col m8 w3-small">' + endNames[endNames.length - 1];

			                // 지하철일 때만 addInfo[addInfo.length-2] 추가
			                if (trafficTypes[endNames.length - 1] === 1) {
			                	var facilityInfo = getFacilityData(transportTypes[transportTypes.length-2], endNames[endNames.length - 1]);
		                		
			                	if (endNames[endNames.length - 1] != '서울역') {
									endNames[endNames.length - 1] += '역';
								}
			                	
			                    transportRoute.innerHTML +=
			                        '<div class="w3-col">' +
			                        '<div class="w3-col m3" style="height:1px"></div>' +
			                        '<div class="w3-col m8">' +
			                        '<div class="w3-col m2 w3-small mgt10"><img src="/bts/image/icon/elevator.png" alt="엘리베이터" title="엘리베이터" style="width:20px;height:20px;"></div>' +
			                        '<div class="w3-col m2 w3-small mgt10">' + facilityInfo.evCnt + '</div>' +
			                        '<div class="w3-col m2 w3-small mgt10"><img src="/bts/image/icon/escalator.png" title="에스컬레이터" alt="에스컬레이터" style="width:20px;height:20px;"></div>' +
			                        '<div class="w3-col m2 w3-small mgt10">' + facilityInfo.esCnt + '</div>' +
			                        '<div class="w3-col m2 w3-small mgt10"><img src="/bts/image/icon/wheelchair.png" alt="휠체어리프트" title="휠체어리프트" style="width:20px;height:20px;"></i></div>' +
			                        '<div class="w3-col m2 w3-small mgt10">' + facilityInfo.clCnt + '</div>' +
			                        '</div>' +
			                        '</div>';
			                	}

			                transportRoute.innerHTML += '</div>' + // 닫는 태그 추가
			                    '</div>';
			                
			                var arrivalTime = getCurrentTime(totalTime);

			                $('#totalTime' + l).html(totalTime+ '분');
			                $('#arrivalTime' + l).html(' | ' + arrivalTime + ' 도착');
			                $('#payment' + l).html(' | ' + payment + '원');
			                 
						} else {
							alert(getData.msg)
						}
		                
		            }
	                
	                
	                for (let k = 0; k < mapObjs.length; k++) {
	                    $('#path' + k).on('click', function() {
	                        if (!$(event.target).hasClass('hjdBtn')) {
	                            removeMarker2();
	                            removePolyline();
	                            callMapObjApiAJAX(mapObjs[k]);
	                        }
	                    });
	                    
	                    $('.hjdBtn').on('click', function(event) {
	                        event.stopPropagation(); // 이벤트 전파 중지
	                        event.preventDefault();
	                        var index = $(this).data('index');
	                        var todayDayType = getDayType();
	                        if (index == k) {

	                        	
                       		      $.ajax({
                       		        url: 'http://58.72.151.124:6617/plotly/', // Django 서버의 차트 URL로 변경
                       		        method: 'GET',
                       		        data: {
                       		          line: sbCode[k], // 적절한 파라미터 값을 여기에 넣습니다.
                       		          station: startStNm[k],
                       		          day_type: todayDayType,
                       		          direction: upDownCode[k] // 숫자로 넣든 문자로 넣든 다 됨
                       		        },
                       		        success: function(data) {
                       		          console.log("Success:", data);
                       		          if (data.plotly_data) {
                       		            $('#chartContainer').html(data.plotly_data);
                       		            $('#chartModal').css('display', 'block');
                       		          } else {
                       		            alert('차트를 불러오는데 실패했습니다.');
                       		          }
                       		        },
                       		        error: function(xhr, status, error) {
                       		          console.error("Error:", status, error);
                       		          alert('차트를 불러오는데 실패했습니다.');
                       		        }
                       		      });


                       		    $('#chartClose, #chartConfirm').click(function(){
                       		      $('#chartModal').css('display', 'none');
                       		    });

	                        }
	                    });
	                }
	            },
	            error: function(xhr, status, error) {
	                // 실패 시 처리
	                alert("Error: " + error);
	            }
	        });
	    }
	    
	    var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/red_b.png'; // 마커이미지의 주소입니다    
	    var imageSize = new kakao.maps.Size(50, 45); // 마커이미지의 크기입니다
	    var arriveOption = { 
	        offset: new kakao.maps.Point(15, 43) // 도착 마커이미지에서 마커의 좌표에 일치시킬 좌표를 설정합니다 (기본값은 이미지의 가운데 아래입니다)
	    };

	    var imageSrc2 = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/blue_b.png'; // 마커이미지의 주소입니다    
	    var imageSize2 = new kakao.maps.Size(50, 45); // 마커이미지의 크기입니다
	    var arriveOption2 = { 
	        offset: new kakao.maps.Point(15, 43) // 도착 마커이미지에서 마커의 좌표에 일치시킬 좌표를 설정합니다 (기본값은 이미지의 가운데 아래입니다)
	    };

	    
		// 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
		var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, arriveOption);
		var markerImage2 = new kakao.maps.MarkerImage(imageSrc2, imageSize2, arriveOption2);
	    
	
	    function callMapObjApiAJAX(mapObj) {
	        $.ajax({
	            url: "https://api.odsay.com/v1/api/loadLane",
	            type: "POST",
	            data: {
	                mapObject: "0:0@" + mapObj,
	                apiKey: "qY8+WJHuyz/xRJc4hOxkn4HDRLV5XSv3e9kR3+5GiE8"
	            },
	            success: function(resultJsonData) {
	                drawKakaoMarker(sx, sy, markerImage);
	                drawKakaoMarker(ex, ey, markerImage2);
	                drawKakaoPolyLine(resultJsonData);
	                drawKakaoPolyLine2(resultJsonData);
	                if (resultJsonData.result.boundary) {
	                    var boundary = new kakao.maps.LatLngBounds(
	                        new kakao.maps.LatLng(resultJsonData.result.boundary.top, resultJsonData.result.boundary.left),
	                        new kakao.maps.LatLng(resultJsonData.result.boundary.bottom, resultJsonData.result.boundary.right)
	                    );
	                    map.setBounds(boundary);
	                }
	            }
	        });
	    }
	    
	    
	    function subwayTime(stationID, wayCode, l) {
	        $.ajax({
	            url: "https://api.odsay.com/v1/api/searchSubwaySchedule",
	            type: "POST",
	            data: {
	                stationID: stationID,
	                wayCode: wayCode,
	                apiKey: "qY8+WJHuyz/xRJc4hOxkn4HDRLV5XSv3e9kR3+5GiE8"
	            },
	            success: function(response) {
	                var tSchedule = [];
	                var now = new Date();
	                var daysOfWeek = now.getDay();
	                var hours = now.getHours();
	                var minutes = now.getMinutes();
	                var strHours = hours < 10 ? '0' + hours : hours;
	                var strMinutes = minutes < 10 ? '0' + minutes : minutes;
	                var nowTime = strHours + ':' + strMinutes;

	                if (wayCode == 1) {
	                    if (daysOfWeek == 0) {
	                        for (var i = 0; i < response.result.holidaySchedule.up.length; i++) {
	                            var arrTime = response.result.holidaySchedule.up[i].departureTime;
	                            if (nowTime < arrTime) {
	                                tSchedule.push(arrTime);
	                            }
	                        }
	                    } else if (daysOfWeek == 6) {
	                        for (var i = 0; i < response.result.saturdaySchedule.up.length; i++) {
	                            var arrTime = response.result.saturdaySchedule.up[i].departureTime;
	                            if (nowTime < arrTime) {
	                                tSchedule.push(arrTime);
	                            }
	                        }
	                    } else {
	                        for (var i = 0; i < response.result.weekdaySchedule.up.length; i++) {
	                            var arrTime = response.result.weekdaySchedule.up[i].departureTime;
	                            if (nowTime < arrTime) {
	                                tSchedule.push(arrTime);
	                            }
	                        }
	                    }
	                } else {
	                    if (daysOfWeek == 0) {
	                        for (var i = 0; i < response.result.holidaySchedule.down.length; i++) {
	                            var arrTime = response.result.holidaySchedule.down[i].departureTime;
	                            if (nowTime < arrTime) {
	                                tSchedule.push(arrTime);
	                            }
	                        }
	                    } else if (daysOfWeek == 6) {
	                        for (var i = 0; i < response.result.saturdaySchedule.down.length; i++) {
	                            var arrTime = response.result.saturdaySchedule.down[i].departureTime;
	                            if (nowTime < arrTime) {
	                                tSchedule.push(arrTime);
	                            }
	                        }
	                    } else {
	                        for (var i = 0; i < response.result.weekdaySchedule.down.length; i++) {
	                            var arrTime = response.result.weekdaySchedule.down[i].departureTime;
	                            if (nowTime < arrTime) {
	                                tSchedule.push(arrTime);
	                            }
	                        }
	                    }
	                }
	                

	                var arriveTime = document.getElementById('arriveTime' + l);
	                arriveTime.innerHTML = ''; 

	                tSchedule.slice(0, 2).forEach(function(time) {
	                    var [hours, minutes] = time.split(':').map(Number);
	                    var trainTime = new Date();
	                    trainTime.setHours(hours, minutes, 0);

	                    var diffMinutes = Math.floor((trainTime - now) / 60000);

	                    var displayText = diffMinutes <= 2 ? '곧 도착' : diffMinutes + '분 후 도착';
	                    arriveTime.innerHTML += displayText + '<br>';
	                });
	            }
	        });
	    }
	    
	    function busTime(stationID, busNm, busID, l) {
	        $.ajax({
	            url: "https://api.odsay.com/v1/api/realtimeStation",
	            type: "POST",
	            data: {
	                stationID: stationID,
	                apiKey: "qY8+WJHuyz/xRJc4hOxkn4HDRLV5XSv3e9kR3+5GiE8"
	            },
	            success: function(response) {
	                var real = response.result.real;
	                var arriveTimeElement = document.getElementById('arriveTime' + l);

	                if (!arriveTimeElement) {
	                    console.error("Element not found: " + 'arriveTime' + l);
	                    return;
	                }

	                if (real && real.length > 0) {
	                    // arrival1이 있는 항목만 필터링
	                    real = real.filter(bus => bus.arrival1 && bus.arrival1.arrivalSec !== undefined);

	                    if (real.length === 0) {
	                        return;
	                    }

	                    // 전체 데이터 도착 시간을 기준으로 오름차순 정렬
	                    real.sort((a, b) => a.arrival1.arrivalSec - b.arrival1.arrivalSec);

	                    arriveTimeElement.innerHTML = ''; 

	                    // 정렬된 데이터 표시
	                    real.forEach(bus => {
	                        var routeIdStr = bus.routeId.toString(); // 문자열로 변환하여 비교
	                        var index = busID.indexOf(routeIdStr);
	                        if (index !== -1) {
	                            var arrivalSec = bus.arrival1.arrivalSec;
	                            var arrivalMinutes = Math.floor(arrivalSec / 60);
	                            var displayText = arrivalMinutes <= 1 ? '곧 도착' : arrivalMinutes + '분 ';


                                if (busNm[1][index] !== undefined) {
                                    arriveTimeElement.innerHTML += busNm[1][index] + ' | ' + displayText + '<br>';
                                }
	                            
	                        }
	                    });
	                }
	            },
	            error: function(xhr, status, error) {
	                console.error("Error fetching data:", error);
	            }
	        });
	    }

	
	    function drawKakaoMarker(x, y, image) {
	        marker2 = new kakao.maps.Marker({
	            position: new kakao.maps.LatLng(y, x),
	            image: image,
	            map: map
	        });
	        markers2.push(marker2);
	    }
	    
	    function drawKakaoPolyLine(data) {
	        for (var i = 0; i < data.result.lane.length; i++) {
	            for (var j = 0; j < data.result.lane[i].section.length; j++) {
	                lineArray = [];
	                for (var k = 0; k < data.result.lane[i].section[j].graphPos.length; k++) {
	                    lineArray.push(new kakao.maps.LatLng(data.result.lane[i].section[j].graphPos[k].y, data.result.lane[i].section[j].graphPos[k].x));
	                }
	                var strokeColor = '#000000';
	                var strokeWeight = 6;
	                if (data.result.lane[i].class == 1) {
	                    switch (data.result.lane[i].type) {
		                    case 1: strokeColor = '#2980b9'; break;  // 일반
		                    case 2: strokeColor = '#8e44ad'; break;  // 좌석
		                    case 3: strokeColor = '#f39c12'; break;  // 마을버스
		                    case 4: strokeColor = '#e74c3c'; break;  // 직행좌석
		                    case 5: strokeColor = '#36c6f4'; break;  // 공항버스
		                    case 6: strokeColor = '#3498db'; break;  // 간선급행
		                    case 10: strokeColor = '#27ae60'; break; // 외곽
		                    case 11: strokeColor = '#003499'; break; // 간선
		                    case 12: strokeColor = '#37b42d'; break; // 지선
		                    case 13: strokeColor = '#9b59b6'; break; // 순환
		                    case 14: strokeColor = '#e67e22'; break; // 광역
		                    case 15: strokeColor = '#2c3e50'; break; // 급행
		                    case 16: strokeColor = '#d35400'; break; // 관광버스
		                    case 20: strokeColor = '#16a085'; break; // 농어촌버스
		                    case 22: strokeColor = '#34495e'; break; // 경기도 시외형버스
		                    case 26: strokeColor = '#95a5a6'; break; // 급행간선
		                    
	                    }
	                } else if (data.result.lane[i].class == 2) {
	                    switch (data.result.lane[i].type) {
	                    case 1: strokeColor = '#003499'; break;    // 수도권 1호선
	                    case 2: strokeColor = '#37b42d'; break;    // 수도권 2호선
	                    case 3: strokeColor = '#ff6f00'; break;    // 수도권 3호선
	                    case 4: strokeColor = '#ffcc00'; break;    // 수도권 4호선
	                    case 5: strokeColor = '#8e44ad'; break;    // 수도권 5호선
	                    case 6: strokeColor = '#3498db'; break;    // 수도권 6호선
	                    case 7: strokeColor = '#e74c3c'; break;    // 수도권 7호선
	                    case 8: strokeColor = '#2ecc71'; break;    // 수도권 8호선
	                    case 9: strokeColor = '#f39c12'; break;    // 수도권 9호선
	                    case 91: strokeColor = '#003499'; break;   // GTX-A
	                    case 101: strokeColor = '#ff6347'; break;  // 공항철도
	                    case 102: strokeColor = '#ff69b4'; break;  // 자기부상철도
	                    case 104: strokeColor = '#f39c12'; break;  // 경의중앙선
	                    case 107: strokeColor = '#00ff00'; break;  // 에버라인
	                    case 108: strokeColor = '#3498db'; break;  // 경춘선
	                    case 109: strokeColor = '#d35400'; break;  // 신분당선
	                    case 110: strokeColor = '#7f8c8d'; break;  // 의정부경전철
	                    case 112: strokeColor = '#e67e22'; break;  // 경강선
	                    case 113: strokeColor = '#006400'; break;  // 우이신설선
	                    case 114: strokeColor = '#8b4513'; break;  // 서해선
	                    case 115: strokeColor = '#dda0dd'; break;  // 김포골드라인
	                    case 116: strokeColor = '#00ced1'; break;  // 수인분당선
	                    case 117: strokeColor = '#4682b4'; break;  // 신림선
	                    }
	                } else {
	                	strokeColor = '#9c9c9c';
					}
	    		    var shadowPolyline = new kakao.maps.Polyline({
	    		        map: map,
	    		        path: lineArray,
	    		        strokeWeight: strokeWeight+3, // 더 두꺼운 라인
	    		        strokeColor: '#000000', // 그림자 색상
	    		        strokeOpacity: 0.7, // 그림자 투명도
	    		        strokeStyle: 'solid' // 실선 스타일
	    		    });
	    		    shadowPolylines.push(shadowPolyline);
	                var polyline = new kakao.maps.Polyline({
	                    map: map,
	                    path: lineArray,
	                    strokeWeight: strokeWeight,
	                    strokeColor: strokeColor,
	                    strokeStyle: 'solid',
	                    strokeOpacity: 1.0
	                });
	                polylines.push(polyline);
	            }
	        }
	        
	    }
	
 	    function drawKakaoPolyLine2(data) {
	        lineArray2 = [];
	        var laneArray = data.result.lane;

	
	        for (var i = 0; i < laneArray.length; i++) {
	            var lane = laneArray[i];

	            // 각 section에 대해 반복
	            for (var j = 0; j < lane.section.length; j++) {
	                var section = lane.section[j];
	                var graphPos = section.graphPos;

	                // 각 section의 첫 번째와 마지막 좌표 추출
	                var firstPos = graphPos[0];
	                var lastPos = graphPos[graphPos.length - 1];

	                var startX = firstPos.x;
	                var startY = firstPos.y;
	                var endX = lastPos.x;
	                var endY = lastPos.y;

	                // 첫 번째 좌표부터 시작하여 끝 좌표까지 선 생성
	                lineArray2.push(new kakao.maps.LatLng(startY, startX));
	                lineArray2.push(new kakao.maps.LatLng(endY, endX));
	                
	            }
	        }

	
	        var startCoord = new kakao.maps.LatLng(sy, sx);
	        var endCoord = new kakao.maps.LatLng(ey, ex);
	
	        drawLine(startCoord, lineArray2[0]);
	
	        for (var i = 1; i < lineArray2.length - 1; i += 2) {
	            drawLine(lineArray2[i], lineArray2[i + 1]);
	        }
	
	        drawLine(lineArray2[lineArray2.length - 1], endCoord);
	    }
	
	    function drawLine(start, end) {
            var polyline2 = new kakao.maps.Polyline({
                map: map,
                path: [start, end],
                strokeWeight: 5,
                strokeColor: 'red',
                strokeOpacity: 1.0,
                strokeStyle: 'dashed'
            });
            polylines2.push(polyline2);
	    }
	});
</script>
</head>
<body>

	<div class="w3-sidebar w3-bar-block w3-card w3-light-grey w3-border w3-card-4" style="width:360px;">	
	<div id ="homeBtn" class="w3-center w3-col mgb20 w3-orange w3-button" style="height:40px;">홈으로 돌아가기</div>
		<div class=" w3-container w3-center w3-margin mgb20">
		<form id="searchForm">
		    <input type="text" id="origin" placeholder="출발지를 입력하세요" class="mgb10 w3-col">
		    <input type="text" id="destination" placeholder="도착지를 입력하세요" class="mgb20 w3-col">
		    <div class="w3-col w3-bar-bottom">
		        <div class="w3-btn w3-black w3-left w3-round" id="resetBtn"><i class="fa fa-refresh"></i></div>
		        <div class="w3-button w3-blue w3-round w3-right w3-hover-aqua w3-center custom-button" id="searchButton">길찾기</div>
		    </div>
		</form>
		</div>
        <div class="w3-bar w3-pale-red w3-border" style="display: flex; font-size: 15px; align-items: center;">
            <div class="w3-bar-item w3-center" style="font-weight: bold;" >대중교통 경로 목록</div>
        </div>
        
        <div id="pathList"></div>
		
	</div>
	<div class="map_wrap">
	    <div id="map" style="margin-left:360px;position:relative;overflow:hidden;"></div>
	    <ul id="category" style="margin-left:360px;">
	        <li id="BK9" data-order="0"> 
	            <span class="category_bg bank"></span>
	            은행
	        </li>       
	        <li id="MT1" data-order="1"> 
	            <span class="category_bg mart"></span>
	            마트
	        </li>  
	        <li id="PM9" data-order="2"> 
	            <span class="category_bg pharmacy"></span>
	            약국
	        </li>  
	        <li id="OL7" data-order="3"> 
	            <span class="category_bg oil"></span>
	            주유소
	        </li>  
	        <li id="CE7" data-order="4"> 
	            <span class="category_bg cafe"></span>
	            카페
	        </li>  
	        <li id="CS2" data-order="5"> 
	            <span class="category_bg store"></span>
	            편의점
	        </li>      
	    </ul>
	</div>
	
    	<div id="chartModal" class="w3-modal">
   			<div class="w3-modal-content" style="width : 720px ; height : auto ;">
   				<header class="w3-container w3-blue">
   					<span class="w3-btn w3-display-topright" id="chartClose">&times;</span>
   					<h2 class="w3-center">혼잡도 차트</h2>
   				</header>
   				<div class="w3-container w3-padding">
   					<div id="chartContainer"></div>
   				</div>
   				<footer class="w3-col">
   					<div class="w3-col w3-purple w3-btn" id="chartConfirm">확인</div>
   				</footer>
   			</div>
   		</div>
</body>
</html>