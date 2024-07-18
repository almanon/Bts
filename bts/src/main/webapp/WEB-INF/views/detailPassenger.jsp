<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js"> <!--<![endif]-->
	<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title>BTS &mdash; Best Tour Seoul!</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="description" content="Free HTML5 Template by FREEHTML5.CO" />
	<meta name="keywords" content="free html5, free template, free bootstrap, html5, css3, mobile first, responsive" />
	<meta name="author" content="FREEHTML5.CO" />

  <!-- 
	//////////////////////////////////////////////////////

	FREE HTML5 TEMPLATE 
	DESIGNED & DEVELOPED by FREEHTML5.CO
		
	Website: 		http://freehtml5.co/
	Email: 			info@freehtml5.co
	Twitter: 		http://twitter.com/fh5co
	Facebook: 		https://www.facebook.com/fh5co

	//////////////////////////////////////////////////////
	 -->

  	<!-- Facebook and Twitter integration -->
	<meta property="og:title" content=""/>
	<meta property="og:image" content=""/>
	<meta property="og:url" content=""/>
	<meta property="og:site_name" content=""/>
	<meta property="og:description" content=""/>
	<meta name="twitter:title" content="" />
	<meta name="twitter:image" content="" />
	<meta name="twitter:url" content="" />
	<meta name="twitter:card" content="" />

	<!-- Place favicon.ico and apple-touch-icon.png in the root directory -->
	<link rel="shortcut icon" href="favicon.ico">

	<link href='https://fonts.googleapis.com/css?family=Open+Sans:400,700,300' rel='stylesheet' type='text/css'>
	
	<!-- Animate.css -->
	<link rel="stylesheet" href="css/animate.css">
	<!-- Icomoon Icon Fonts-->
	<link rel="stylesheet" href="css/icomoon.css">
	<!-- Bootstrap  -->
	<link rel="stylesheet" href="css/bootstrap.css">
	<!-- Superfish -->
	<link rel="stylesheet" href="css/superfish.css">
	<!-- Magnific Popup -->
	<link rel="stylesheet" href="css/magnific-popup.css">
	<!-- Date Picker -->
	<link rel="stylesheet" href="css/bootstrap-datepicker.min.css">
	
	<link rel="stylesheet" type="text/css" href="css/font-awesome-4.7.0/css/font-awesome.css">
	
	<!-- CS Select -->
	<link rel="stylesheet" href="css/cs-select.css">
	<link rel="stylesheet" href="css/cs-skin-border.css">
	
	<link rel="stylesheet" href="css/style.css">

	<link rel="stylesheet" type="text/css" href="css/w3.css">
	<link rel="stylesheet" type="text/css" href="css/user.css">
	

	<script type="text/javascript" src="js/jquery-3.7.1.min.js"></script>
	<style type="text/css">
    html, body {
        height: 100%;
        margin: 0;
    }
    .fh5co-cover {
        background-image: url(/bts/images/img17.jpg);
        background-attachment: fixed;
        background-size: cover; /* Ensure the background covers the entire area */
        background-repeat: no-repeat;
        min-height: 100vh; /* Set minimum height to 100% of the viewport height */
    }
    .content-wrapper {
        display: flex;
        max-width: 1100px;
        margin: 0 auto;
    }
    .main-container {
        padding: 8px;
        width: 100%;
        margin-top: 40px;
        margin-bottom: 10px;
    }
    .inner-container {
        display: flex;
        background-color: #ffdddd; /* w3-pale-red 색상 */
        padding: 0px;
        border-radius: 10px; /* 둥근 모서리 */
        overflow: hidden; /* 둥근 모서리 내부 컨텐츠 잘리게 */
        box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2); /* 그림자 추가 */
    }
    .left-container {
        width: 400px;
        display: flex;
        flex-direction: column;
        padding: 16px; /* 내용물 패딩 */
    }
    .text-container {
        font-size: 1.2em; /* 글자 크기 */
        flex-grow: 1;
    }
    .form-container {
        margin-top: 20px;
        text-align: center;
        width: 100%;
    }
    .form-container input{
        padding: 5px;
    }
    .image-container {
        width: 700px;
        display: flex;
        flex-direction: column;
        padding: 16px; /* 내용물 패딩 */
    }
    .image-container img {
        max-width: 100%;
        height: 400px;
        border-radius: 10px; /* 이미지 모서리 둥글게 */
    }
    .image-container div {
        width: 100%;
        text-align: center;
        font-size: 1.2em; /* 제목 크기 */
        margin-bottom: 8px;
    }
	</style>
	
	<!-- Modernizr JS -->
	<script src="js/modernizr-2.6.2.min.js"></script>
	<!-- FOR IE9 below -->
	<!--[if lt IE 9]>
	<script src="js/respond.min.js"></script>
	<![endif]-->
	<script type="text/javascript">
    $(document).ready(function() {
    	$('#locBtn').click(function(){
    		$('#frm').submit();
    	});
		$('#logout').click(function(){
			$(location).attr('href', '/bts/logout.bts');
		});
    });
	

	</script>
	
	</head>
	<body>

		<div id="fh5co-wrapper">
		<div id="fh5co-page">
		<header id="fh5co-header-section" class="sticky-banner">
			<div class="container">
				<div class="nav-header">
					<a href="#" class="js-fh5co-nav-toggle fh5co-nav-toggle dark"><i></i></a>
					<h1 id="fh5co-logo"><a href="/bts/main.bts"><i class="fa fa-bus"></i>BTS</a></h1>
<c:if test="${not empty SID}">				
<!-- START #fh5co-menu-wrap -->
					<nav id="fh5co-menu-wrap" role="navigation">
						<ul class="sf-menu" id="fh5co-primary-menu">
							<li class="active" ><a href="/bts/logout.bts">logout</a></li>
						</ul>
					</nav>
</c:if>
<c:if test="${empty SID}">	
<!-- START #fh5co-menu-wrap -->
			
					<nav id="fh5co-menu-wrap" role="navigation">
						<ul class="sf-menu" id="fh5co-primary-menu">
							<li class="active" ><a href="#fh5co-section-gray">about</a></li>
						</ul>
					</nav>
</c:if>
				</div>
			</div>
		</header>
<!-- end:header-top -->
	
			<div class="fh5co-cover">
				<div class="content-wrapper">
				    <div class="main-container">
                    <div class="inner-container">
                        <div class="left-container">
                            <div class="text-container">
                                <div class="info-container w3-half w3-center w3-text-grey" style="font-weight:bold;">
	                                <div class="info-title mgt30">홈</div>
                                    <div class="mgt20">${DATA.home}</div>
                                    <div class="mgt30" style="text-align: right;margin-right:60px">경기 시간 : </div>
                                    <div class="mgt20" style="text-align: right;margin-right:60px">예측 관중수 : </div>
                                </div>
                                <div class="info-container w3-half w3-center w3-text-grey" style="font-weight:bold;">
                                    <div class="info-title mgt30">방문</div>
                                    <div class="mgt20">${DATA.away}</div>
                                    <div class="mgt30">${DATA.game_time}</div>
                                    <div class="mgt20">${DATA.crowd} 명</div>
                                </div>
                            </div>
                            <div class="form-container">
                            	<div class="w3-text-grey w3-large" style="margin-bottom: 10px;font-weight:bold;">대중교통 경로찾기</div>
                            	<form action="/bts/loadjs.bts" method="POST" id="frm" >
                                	<input type="text" id="startLoc" name="startLoc" placeholder="출발지를 입력하세요">
 		                             <div id="locBtn"class="w3-button w3-blue w3-round w3-right" style="height:37px">경로 찾기</div>
                            	</form>
                            </div>
                        </div>
                        <div class="image-container">
                            <h3 style="text-align: center;">종합운동장역 승하차</h3>
                            <img src="http://58.72.151.124:6617/graph/${DATA.game_day}/" alt="Graph Image"/>
                        </div>
                    </div>
                </div>
				    </div>
				</div>
			</div>
		</div>
		
		

	<!-- END fh5co-wrapper -->

	<!-- jQuery -->


	<script src="js/jquery.min.js"></script>
	<!-- jQuery Easing -->
	<script src="js/jquery.easing.1.3.js"></script>
	<!-- Bootstrap -->
	<script src="js/bootstrap.min.js"></script>
	<!-- Waypoints -->
	<script src="js/jquery.waypoints.min.js"></script>
	<script src="js/sticky.js"></script>

	<!-- Stellar -->
	<script src="js/jquery.stellar.min.js"></script>
	<!-- Superfish -->
	<script src="js/hoverIntent.js"></script>
	<script src="js/superfish.js"></script>
	<!-- Magnific Popup -->
	<script src="js/jquery.magnific-popup.min.js"></script>
	<script src="js/magnific-popup-options.js"></script>
	<!-- Date Picker -->
	<script src="js/bootstrap-datepicker.min.js"></script>
	<!-- CS Select -->
	<script src="js/classie.js"></script>
	<script src="js/selectFx.js"></script>
	
	<!-- Main JS -->
	<script src="js/main.js"></script>

	</body>
</html>