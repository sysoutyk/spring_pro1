<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!--
	Resto by GetTemplates.co
	URL: https://gettemplates.co
-->
<html lang="ko">
<head>
<!-- include css ref -->
<%@include file="../../include/temp_y/ytemp_css.jsp"%>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/css/swiper.min.css">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/js/swiper.min.js"></script>
</head>
<body>
	<div class="boxed-page">
		<!--include topMenu -->
		<%@ include file="../../include/ysample_header.jsp"%>
		<!-- end of topMenu -->

		<div class="hero">
			<div class="container">
				<div class="row d-flex align-items-center">
					<div class="col-lg-6 hero-left" style="margin-top: 100px">
						<span class="display-4 mb-5">지은탁</span> &nbsp;<span
							class="display-4 mb-5">♥</span> &nbsp;<span
							class="display-4 mb-5">도깨비</span>
						<div class="mb-2" style="margin-top: 120px">
							<a class="btn btn-primary btn-shadow btn-lg lnr lnr-rocket"
								id="announce" href="#" role="button"> 축의금 보내기 </a> <a
								class="btn btn-icon btn-lg"
								href="https://player.vimeo.com/video/33110953"
								data-featherlight="iframe"
								data-featherlight-iframe-allowfullscreen="true"> <span
								class="lnr lnr-film-play"></span> Play Video
							</a>
						</div>
						<br> <br> <br>
						<div class="hero-info list-unstyled d-flex text-center mb-0">
							<h5 id="wedDate">2023년 9월 23일 (토) &nbsp;&nbsp;&nbsp; 오후 2시</h5>
						</div>
						<div class="list-unstyled d-flex text-center mb-0t">
							<!-- 		    		<span class="lnr lnr-leaf"></span> -->
							<h5 id="wedPlace">잇다카페 - 경북 경주시 강동면 공정길 33-36</h5>
						</div>
						<div class="hero-info list-unstyled d-flex text-center mb-0">
							결혼이란 여행 출발점에 여러분을 초대합니다. <br>
							오셔서 축복해주시면 감사하겠습니다.</div>
					</div>
					<div class="col-lg-6 hero-right">
						<div
							class="owl-carousel owl-theme hero-carousel owl-loaded owl-drag">
							<div class="owl-stage-outer">
								<div class="owl-stage"
									style="transform: transform: translate3d(-2200px, 0px, 0px); transition: all 0.25s ease 0s; width: 3850px;">
									<div class="owl-item"
										style="width: 540px; margin-right: 10 px;">
										<div class="item">
											<img class="img-fluid" src="/create_tempY/img/wedding2.jpg" alt="">
										</div>
									</div>
								</div>
							</div>
							<div class="owl-dots disabled"></div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- Special Dishes Section -->

		<!-- Testimonial Section-->
	<footer class="mastfoot pb-5 bg-white section-padding pb-0">
		<section id="gtco-testimonial"
			class="overlay bg-fixed section-padding"
			style="background-image: url(/create_tempY/img/footer.jpg);">
			<div class="container">
				<div class="section-content">
					<div class="heading-section text-center">
						<span class="subheading">
							지은탁+도깨비
						</span>
						<h2>잘 살겠습니다!</h2>
					</div>
		
				</div>
			</div>
		</section>
	</footer>
		<!-- End of Testimonial Section-->
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
	<!-- </div> -->
	<!-- External JS -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.22.2/moment.min.js"></script>
	<script src="/create_tempY/vendor/bootstrap/popper.min.js"></script>
	<script src="/create_tempY/vendor/bootstrap/bootstrap.min.js"></script>
	<script src="/create_tempY/vendor/select2/select2.min.js "></script>
	<script src="/create_tempY/vendor/owlcarousel/owl.carousel.min.js"></script>
	<script
		src="https://cdn.rawgit.com/noelboss/featherlight/1.7.13/release/featherlight.min.js"></script>
	<script src="/create_tempY/vendor/stellar/jquery.stellar.js"
		type="text/javascript" charset="utf-8"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/tempusdominus-bootstrap-4/5.0.1/js/tempusdominus-bootstrap-4.min.js"></script>

	<!-- Main JS -->
	<script src="js/app.min.js "></script>

</body>
</html>
