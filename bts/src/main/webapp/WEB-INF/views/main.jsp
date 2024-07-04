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
					<h1 id="fh5co-logo"><a href="index.html"><i class="icon-aircraft-take-off"></i>BTS</a></h1>
					
<!-- START #fh5co-menu-wrap -->
					<nav id="fh5co-menu-wrap" role="navigation">
						<ul class="sf-menu" id="fh5co-primary-menu">
							<li class="active"><a href="index.html">Home</a></li>						
							<li><a href="flight.html">혼잡도</a></li>
							<li><a href="hotel.html">서울지도</a></li>
							<li><a href="car.html">길찾기</a></li>
							<li><a href="blog.html">테마지도</a></li>
						</ul>
					</nav>
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
													<label for="id">아이디:</label>
													<input type="text" class="form-control" name="id" id="id" placeholder="아이디를 입력하세요"/>
												</div> 
											</div>
											
										<div class="col-xxs-12 col-xs-12 mt">
												<div class="input-field">
													<label for="pw">비밀번호:</label>
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
									<h2>쾌적한 서울여행!</h2>
									<h2>B est</h2>
									<h2>T our</h2>
									<h2>S eoul</h2>
								</div>
							</div>
							
</c:if>
<c:if test="${not empty SID}">
<div class="w3-display-middle w3-center w3-marigin-top">
    <h3 class="w3-animate-top" style="color:white;">BTS와 함께 서울을 즐겨보세요!</h3>
    <hr class="w3-border-white" style="margin:auto;width:40%">
    <p class="w3-large w3-center"></p>
    <div class="col-xs-12"style="margin-bottom:15px;">
											</div>
											<div class="col-xs-12" style="margin-bottom:50px;">
												<input type="button" class="btn btn-primary btn-block" value="길찾기">
											</div>
											<div class="col-xs-6" style="margin-bottom:15px;">
												<input type="button" class="btn btn-primary btn-block w3-small" value="정보수정">
											</div>
											<div class="col-xs-6" style="margin-bottom:15px;">
												<input name="logout" id="logout" type="button" class="btn btn-primary btn-block w3-small" value="로그아웃">
											</div>
  </div>
</c:if>
							</div>
						</div>
					</div>
				</div>
			</div>
		
		
		<div id="fh5co-tours" class="fh5co-section-gray">
			<div class="container">
				<div class="row">
					<div class="col-md-8 col-md-offset-2 text-center heading-section animate-box">
						<h3>BTS</h3>
						<p>BTS는 여러분이 쾌적한 환경에서 서울시 대중교통을 이용할 수 있도록 종합적인 정보를 제공합니다. 
						출발지부터 도착지까지 최적의 경로를 제시하며, 교통 혼잡도를 실시간으로 알려줍니다. 쾌적한 서울여행을 위해 BTS을 이용해 보세요</p>
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
								<p>BTS는 정확한 서울지도를 제공함으로써 서울여행에 도움을 줍니다.</p>
							</div>
						</div>

					</div>

					<div class="col-md-4 animate-box">
						<div class="feature-left">
							<span class="icon">
								<i class="icon-search2"></i>
							</span>
							<div class="feature-copy">
								<h3>여행 계획</h3>
								<p>BTS만의 테마지도를 이용해 보다 즐거운 여행계획을 작성해보세요</p>
							</div>
						</div>
					</div>
					<div class="col-md-4 animate-box">
						<div class="feature-left">
							<span class="icon">
								<i class="icon-megaphone"></i>
							</span>
							<div class="feature-copy">
								<h3>실시간 안내</h3>
								<p>실시간 제공되는 대중교통 시간표를 통해 여행시간을 절약해보세요</p>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-md-4 animate-box">

						<div class="feature-left">
							<span class="icon">
								<i class="icon-wine"></i>
							</span>
							<div class="feature-copy">
								<h3>편안한 여정</h3>
								<p>실시간으로 BTS만의 혼잡도 데이터를 통해 쾌적한 서울 대중교통을 이용하세</p>
							</div>
						</div>

					</div>

					<div class="col-md-4 animate-box">
						<div class="feature-left">
							<span class="icon">
								<i class="icon-expand"></i>
							</span>
							<div class="feature-copy">
								<h3>스마트한 서울 문화생활</h3>
								<p>BTS의 테마지도는 최신화된 서울시의 문화컨텐츠를 제공합니다.</p>
							</div>
						</div>

					</div>
					<div class="col-md-4 animate-box">
						<div class="feature-left">
							<span class="icon">
								<i class="icon-upload2"></i>
							</span>
							<div class="feature-copy">
								<h3>주기적인 업데이트</h3>
								<p>정확한 정보제공을 위해 서울의 주요행사일정을 주기적으로 업데이트하여 제공합니다.</p>
							</div>
						</div>
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