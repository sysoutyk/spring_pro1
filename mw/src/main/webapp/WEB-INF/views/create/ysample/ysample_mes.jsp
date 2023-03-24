<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<!--
	Resto by GetTemplates.co
	URL: https://gettemplates.co
-->
<html lang="ko">

<head>
<%@include file="../../include/temp_y/ytemp_css.jsp" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/css/swiper.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/js/swiper.min.js"></script>
<script>
$(document).ready(function(){
	new Swiper('.swiper-container', {

		slidesPerView : 3, 
		spaceBetween : 30, 
		slidesPerGroup : 3,
		
		loopFillGroupWithBlank : true,

		loop : true,

		navigation : { 
			nextEl : '.swiper-button-next', 
			prevEl : '.swiper-button-prev',
		},
	});

});
</script>
</head>

<body>

<div class="boxed-page">
<%@ include file="../../include/ysample_header.jsp"%>	
<!-- 오시는길 Section -->

<!-- 쪽지 디스플레이 Section -->
		<section id="gtco-team" class="bg-grey section-padding">
			<div class="container">
				<div class="section-content">
					<div class="heading-section text-center">
						<span class="subheading">
							지은탁+도깨비
						</span>
						<h2>사랑의 대나무숲</h2>
					</div>
					<div class="row">
						<div class="swiper-container">
							<div class="swiper-wrapper">
									<div class="swiper-slide">
										<div class="col-md-4">
											<div class="team-card mb-5">
												<img src="/create_tempY/img/euntakSolo.jpg" alt=""
													width="300" height="435">
												<div class="team-desc">
													<p class="mb-1">오라버니가 말 안들으면 나한테 꼭 톡해^^ 진심으로 결혼축하해!</p>
													<p class="mb-1"><b>by 치킨 사장님</b></p>
													<p class="mb-1">-2023/01/25-</p>
												</div>
											</div>
											</div>
										</div>
										<div class="swiper-slide">
											<div class="col-md-4">
												<div class="team-card mb-5">
													<img src="/create_tempY/img/rommie.jpg" alt=""
														width="300" height="435">
													<div class="team-desc">
														<p class="mb-1">우리 평생 지금처럼 사이좋게 하우스메이트로 잘 살자!</p>
														<p class="mb-1"><b>by 저승사자</b></p>
														<p class="mb-1">-2023/01/24-</p>
												</div>
											</div>
											</div>
										</div>
										<div class="swiper-slide">
											<div class="col-md-4">
												<div class="team-card mb-5">
													<img src="/create_tempY/img/manager.jpg" alt=""
														width="300" height="435">
													<div class="team-desc">
														<p class="mb-1">결혼 진심으로 축하드립니다.</p>
														<p class="mb-1"><b>by 비서</b></p>
														<p class="mb-1">-2023/01/24-</p>
													</div>
												</div>
											</div>
										</div>
									</div>
									<div class="swiper-button-next"></div>
									<div class="swiper-button-prev"></div>
								</div>
							</div>
							
						</div>
					<!-- class="row -->			
			</div>
		</section>
<!-- End of 쪽지 디스플레이 -->	
<footer class="mastfoot pb-5 bg-white section-padding pb-0">
<section id="gtco-testimonial"
			class="overlay bg-fixed section-padding"
			style="background-image: url(/create_tempY/img/footer.jpg);">
    <div class="container">
		<div class="section-content">
			<div class="heading-section text-center">
				<span class="subheading">
					지은탁 + 도꺠비 </span>
				<h2>잘 살겠습니다</h2>
			</div>
		</div>	
    </div>
 </section>
</footer>	
    
 	<!-- footer -->
	<footer class="mastfoot pb-5 bg-white section-padding pb-0">
	    <div class="inner container">
	         <div class="row">
	         	<div class="col-md-12 d-flex align-items-center">
	         		<p class="mx-auto text-center mb-0">
	         			Copyright 2023. All Right Reserved. Design by 울산kh정보교육원 자바클래스
	         		</p>
	         	</div>
	            
	        </div>
	    </div>
	</footer>	
    <!-- end of footer -->
</div>

	<!-- External JS -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.22.2/moment.min.js"></script>
	<script src="vendor/bootstrap/popper.min.js"></script>
	<script src="vendor/bootstrap/bootstrap.min.js"></script>
	<script src="vendor/select2/select2.min.js "></script>
	<script src="vendor/owlcarousel/owl.carousel.min.js"></script>
	<script src="https://cdn.rawgit.com/noelboss/featherlight/1.7.13/release/featherlight.min.js"></script>
	<script src="vendor/stellar/jquery.stellar.js" type="text/javascript" charset="utf-8"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/tempusdominus-bootstrap-4/5.0.1/js/tempusdominus-bootstrap-4.min.js"></script>

	<!-- Main JS -->
	<script src="js/app.min.js "></script>
</body>
</html>
