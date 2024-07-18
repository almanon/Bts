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
	<link rel="stylesheet" type="text/css" href="css/font-awesome-4.7.0/css/font-awesome.css">
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
		    html, body {
		        height: 100%;
		        margin: 0;
		    }
			.fh5co-cover {
			    background-image: url(/bts/images/img17.jpg);
			    background-attachment: fixed;
			    background-size: cover; /* Ensure the background covers the entire area */
			    background-repeat: no-repeat;
			    min-height: 110vh; /* Set minimum height to 100% of the viewport height */
			}
		    .w3-hover-pink:hover {
		        background-color: #ffc0cb !important;
		        cursor: pointer; /* 포인터 커서 추가 */
		    }
	</style>
	
	<!-- Modernizr JS -->
	<script src="js/modernizr-2.6.2.min.js"></script>
	<!-- FOR IE9 below -->
	<!--[if lt IE 9]>
	<script src="js/respond.min.js"></script>
	<![endif]-->
	<script type="text/javascript">
	$(document).ready(function(){
		$('.pageBtn').click(function(){
			// 할일
			// 어떤 버튼일 클릭되었는지 알아내서 페이지 번호를 꺼내온다.
			var spage = $(this).attr('id');
			// 태그의 value 속성에 데이터 채우고
			$('#nowPage').val(spage);
			
			// 폼태그 전송하고
			$('#pageFrm').submit();
		});
		
		$('.gameInfo').click(function(){
			
            var formId = $(this).data("form-id");
            $("#" + formId).submit();
		});
		$('#logout').click(function(){
			$(location).attr('href', '/bts/logout.bts');
		});
	});
	</script>
	
	</head>
	<body>
		<form method="post" action="/bts/gamelist.bts" id="pageFrm">
			<input type="hidden" name="nowPage" id="nowPage" value="${PAGE.nowPage}">
		</form>
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

<div style="display: flex; justify-content: center; max-width: 1000px; margin: 0 auto; ">
<div class="w3-container center-container" style="padding-top: 8px; padding-bottom: 8px; width: 100%; margin-top: 40px; margin-bottom: 10px;">
    <div class="w3-card-4 w3-white mgt6">
        <table class="w3-table w3-centered w3-bordered w3-striped">
            <thead class="w3-orange">
                <tr>
                    <th class="w3-border-right" style="height:35px; line-height:35px">날짜</th>
                    <th class="w3-border-right" style="height:35px; line-height:35px">요일</th>
                    <th class="w3-border-right" style="height:35px; line-height:35px">경기시간</th>
                    <th class="w3-border-right" style="height:35px; line-height:35px">경기</th>
                    <th class="w3-border-right" style="height:35px; line-height:35px">구장</th>
                </tr>
            </thead>
            <tbody>
                <c:if test="${not empty GMLIST}">
                    <c:forEach var="GMLIST" items="${GMLIST}" varStatus="status">
                        <tr id="${GMLIST.game_day}" class="w3-hover-pink gameInfo" data-form-id="form${status.index}">
                        	<form method="POST" action="/bts/detail.bts" id="form${status.index}">
	                        	<input type="hidden" name="game_day" value="${GMLIST.game_day}" />
	                        	<input type="hidden" name="weekday" value="${GMLIST.weekday}" />
	                        	<input type="hidden" name="game_time" value="${GMLIST.game_time}" />
	                        	<input type="hidden" name="home" value="${GMLIST.home}" />
	                        	<input type="hidden" name="away" value="${GMLIST.away}" />
	                        	<input type="hidden" name="stadium" value="${GMLIST.stadium}" />
	                        	<input type="hidden" name="crowd" value="${GMLIST.crowd}" />
	                            <td class="w3-border-right w3-text-bord" style="height:30px; line-height:30px">${GMLIST.game_day}</td>
	                            <td class="w3-border-right" style="height:30px; line-height:30px">${GMLIST.weekday}</td>
	                            <td class="w3-border-right" style="height:30px; line-height:30px">${GMLIST.game_time}</td>
	                            <td class="w3-border-right" style="height:30px; line-height:30px">${GMLIST.home} vs ${GMLIST.away}</td>
	                            <td class="w3-border-right" style="height:30px; line-height:30px">${GMLIST.stadium}</td>
                            </form>
                        </tr>
                    </c:forEach>
                </c:if>
                <c:if test="${empty GMLIST}">
                    <tr>
                        <td colspan="5" class="w3-center w3-text-gray" style="height:45px; line-height:45px;">* 현재 일정이 없습니다. *</td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>
</div>
</div>
<c:if test="${not empty GMLIST}">
    <div class="w3-col w3-center mgb20" style="position: relative; z-index: 1; margin-top: 20px;">
        <div class="w3-bar w3-border w3-border-blue w3-round" style="background: rgba(255, 255, 255, 0.8);">
<c:if test="${PAGE.startPage eq 1}">
				<span class="w3-bar-item w3-pale-blue">&laquo;</span>
</c:if>
<c:if test="${PAGE.startPage ne 1}">
				<span class="w3-bar-item w3-btn w3-hover-blue pageBtn" 
													id="${PAGE.startPage - 1}">&laquo;</span>
</c:if>
<c:forEach var="pno" begin="${PAGE.startPage}" end="${PAGE.endPage}">
	<c:if test="${PAGE.nowPage eq pno}"><!-- 현재 보고있는 페이지인 경우 -->
				<span class="w3-bar-item w3-btn w3-pink w3-hover-blue pageBtn" 
																id="${pno}">${pno}</span>
	</c:if>
	<c:if test="${PAGE.nowPage ne pno}">
				<span class="w3-bar-item w3-btn w3-hover-blue pageBtn" 
																id="${pno}">${pno}</span>
	</c:if>
</c:forEach>
<c:if test="${PAGE.endPage ne PAGE.totalPage}">
				<span class="w3-bar-item w3-btn w3-hover-blue pageBtn" 
													id="${PAGE.endPage + 1}">&raquo;</span>
</c:if>
<c:if test="${PAGE.endPage eq PAGE.totalPage}">
				<span class="w3-bar-item w3-pale-blue">&raquo;</span>
</c:if>
			</div>
		</div>
</c:if>

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