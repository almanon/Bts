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
	<title>BTS &mdash; Best Traffic Seoul!</title>
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


	<!-- Place favicon.ico and apple-touch-icon.png in the root directory -->
	<link rel="shortcut icon" href="favicon.ico">

	<link href='https://fonts.googleapis.com/css?family=Open+Sans:400,700,300' rel='stylesheet' type='text/css'>
	
	<!-- Animate.css -->
	<link rel="stylesheet" href="css/animate.css">
	<!-- Icomoon Icon Fonts-->
	<link rel="stylesheet" href="css/icomoon.css">
	<!-- font-awesome icon fonts -->
	<link rel="stylesheet" type="text/css" href="css/font-awesome-4.7.0/css/font-awesome.css">
	<!-- Bootstrap  -->
	<link rel="stylesheet" href="css/bootstrap.css">
	<!-- Superfish -->
	<link rel="stylesheet" href="css/superfish.css">
	<!-- Magnific Popup -->
	<link rel="stylesheet" href="css/magnific-popup.css">
	<!-- Date Picker -->
	<link rel="stylesheet" href="css/bootstrap-datepicker.min.css">
	<!-- CS Select -->
	<link rel="stylesheet" href="css/cs-select.css">
	<link rel="stylesheet" href="css/cs-skin-border.css">
	
	<link rel="stylesheet" href="css/style.css">
	<link rel="stylesheet" type="text/css" href="css/w3.css">
	<link rel="stylesheet" type="text/css" href="css/user.css">

	<script type="text/javascript" src="js/jquery-3.7.1.min.js"></script>
	<style type="text/css">
	</style>
	
	<!-- Modernizr JS -->
	<script src="js/modernizr-2.6.2.min.js"></script>
	<!-- FOR IE9 below -->
	<!--[if lt IE 9]>
	<script src="js/respond.min.js"></script>
	<![endif]-->
	<script type="text/javascript">
		$(document).ready(function(){
			$('#join').click(function(){
				$(location).attr('href', '/bts/join.bts');
			});
			
			
			$('#login').click(function(){
				
				var sid = $('#id').val();
				if(!sid) {
					$('#id').focus();
					return;
				}
				var spw = $('#pw').val();
				if(!spw){
					$('#pw').focus();
					return;
				}
				
				$('#frm').submit();
			});
			
			$('#logout').click(function(){
				$(location).attr('href', '/bts/logout.bts');
			});
			
			$('#findBtn').click(function(){
				$(location).attr('href', '/bts/load.bts');
			});

			$('#jsBtn').click(function(){
				$(location).attr('href', '/bts/gamelist.bts');
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
							<li class="active" ><a href="#fh5co-section-gray"></a></li>
						</ul>
					</nav>
</c:if>
				</div>
			</div>
		</header>
<!-- end:header-top -->
	
			<div class="fh5co-cover" style="background-image: url(/bts/images/img17.jpg);">
				<div class="desc" >
					<div class="container">
<c:if test="${empty SID}">
							<div class="col-sm-5 col-md-5">
								<div class="animate-box">
								  
								   <!-- Tab panes -->
									<form method="GET" action="/bts/loginProc.bts" name="frm" id="frm">
									<div>
									 <div>
										<div class="col-xxs-12 col-xs-12 mt" >
										<br>
										<br>
									
												<div class="input-field">
													<label for="id">ID</label>
													<input type="text" class="form-control" name="id" id="id" placeholder="아이디를 입력하세요"/>
												</div> 
											</div>
											
										<div class="col-xxs-12 col-xs-12 mt">
												<div class="input-field">
													<label for="pw">Password</label>
													<input type="text" class="form-control" name="pw" id="pw" placeholder="비밀번호를 입력하세요"/>
												</div>
											</div>
										
											<div  class="col-xs-12"style="margin-bottom:15px;">
												<input type="button" class="btn btn-primary btn-block" value="로그인" id="login">
											</div>
										
											<div  class="col-xs-12" style="margin-bottom:15px;">
												<input type="button" class="btn btn-primary btn-block" value="회원가입" id="join">
											</div>
										</div>
									 </div>
									 </form>
									</div>
								</div>
							<div class="desc2 animate-box">
								<div class="col-sm-7 col-sm-push-1 col-sm-7 col-sm-push-1 w3-right">
									<h2 style="color:#F28444"><b>야구.. 좋아하세요?</b></h2>
									<h2 style="color:white"><b style="color:#F28444">B</b> est</h2>
									<h2 style="color:white"><b style="color:#F28444">T</b> raffic</h2>
									<h2 style="color:white"><b style="color:#F28444">S</b> eoul</h2>
								</div>
							</div>
							
</c:if>
<c:if test="${not empty SID}">
<div class="w3-display-middle w3-center" style="margin-top:100px;">
    <h3 class="w3-animate-top" style="color:white;"><b>BTS와 함께 국민 스포츠를 즐겨보세요!</b></h3>
    <hr class="w3-border-white" style="margin:auto;width:40%">
    <p class="w3-large w3-center"></p>
    <div class="col-xs-12"style="margin-bottom:15px;">
											</div>
											<div class="col-xs-12" style="margin-bottom:15px;">
												<input type="button" class="btn btn-primary btn-block" id="findBtn" value="길찾기">
											</div>
											<div class="col-xs-12" style="margin-bottom:50px;">
												<input type="button" class="btn btn-primary btn-block" id="jsBtn" value="잠실종합운동장 일정 보러가기">
											</div>
											
  </div>
</c:if>
							</div>
						</div>
					</div>
				</div>
			</div>
		
		
		<div id="fh5co-tours" class="fh5co-section-gray">
					<div class="col-md-8 col-md-offset-2 text-center heading-section animate-box">
						<h3>BTS</h3><br><br>
						<p>국민 스포츠 경기장 정보에 특화된 BTS와 함께 쾌적하고 편리한 스포츠 관람을 즐겨보세요!<br><br>
						
						   BTS는 여러분이 쾌적한 환경에서 서울시 대중교통을 이용할 수 있도록 종합적인 정보를 제공합니다.
						   출발지부터 도착지까지 최적의 경로를 제시하며, 주요지점 교통 혼잡도를 실시간으로 알려줍니다.
						</p>
					</div>
				</div>
		</div>

		<div id="fh5co-features">
			<div class="container">
				<div class="row">
					<div class="col-md-4 animate-box">

						<div class="feature-left">
							<span class="icon">
								<i class="icon-map"></i>
							</span>
							<div class="feature-copy">
								<h3>지도 제공</h3>
								<p>BTS만의 서울지도를 통해 서울 대중교통 이용에 도움을 줍니다.</p>
							</div>
						</div>

					</div>

					<div class="col-md-4 animate-box">
						<div class="feature-left">
							<span class="icon">
								<i class="icon-search2"></i>
							</span>
							<div class="feature-copy">
								<h3>주요지점 혼잡도</h3>
								<p>스포츠 행사 일정에 따른 주요 경기장의 대중교통 혼잡도를 제공합니다. </p>
							</div>
						</div>
					</div>
					<div class="col-md-4 animate-box">
						<div class="feature-left">
							<span class="icon">
								<i class="icon-megaphone"></i>
							</span>
							<div class="feature-copy">
								<h3>최신정보 포함</h3>
								<p>실시간 교통정보 업데이트를 통해 시간을 절약해보세요</p>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-md-4 animate-box">

					
						</div>
					</div>
				</div>
			</div>
		</div>

	<!-- END fh5co-page -->

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