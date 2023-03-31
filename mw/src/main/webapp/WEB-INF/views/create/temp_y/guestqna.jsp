<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<!--
	Resto by GetTemplates.co
	URL: https://gettemplates.co
-->
<html lang="ko">
<head>
<%@include file="../../include/temp_y/ytemp_css.jsp"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script> 
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/css/swiper.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/js/swiper.min.js"></script>
<script>
$(document).ready(function(){
	//heartbtn
	$(".heartbtn").click(function(e){
		var that = $(this);
		var url = "";
		var sData;
		var count = parseInt($(this).text());
		var val = $(this).attr("data-value");
		if(val == undefined){
			url = "/like/chkcookie";	
	 		$.get(url, sData, function(rData){			
	 			console.log(rData);
	 			that.attr("data-value", rData);
	 			
	 		});
			//하트 db 전송
 			var url = "/like/sendaskLike";
	 		var userid = "${recipient}";
	 		var qno = $(this).prev().text();
	 		var sData = {
	 			"userid" : userid,
	 			"qno" : qno
	 		};
	 		$.post(url,sData,function(rData){
	 			if(rData == true){
	 				count++;
	 				that.text(count);
	 				that.css("color", "red");
	 			}
	 		});

		}else if(val != undefined){
			$.get(url,sData, function(rData){				
				alert("이미 선택하신 하트입니다");
			});//.$get
		}
	});//$(.heartbtn);
		var formtype = "${map.formtype}";
		
	//pagination 이전버튼
	$("#prev").click(function(e){
		if(formtype == 'preview'){
			e.preventDefault();
			alert("이 기능은 미리보기에서 제공하지 않습니다.");
		}else{
			var url = "${url}";
			var prevpage = parseInt(${pagingDto.page})-1;
			$("#frmPaging").find("input[name=page]").val(prevpage);
			$("#frmPaging").find("input[name=url]").val(url);
			$("#frmPaging").attr("action", "/create/guestqna").submit();
		}
	});
	//pagination 다음버튼 
	$("#next").click(function(e){
		if(formtype == 'preview'){
			e.preventDefault();
			alert("이 기능은 미리보기에서 제공하지 않습니다");
		}else{
			var url = "${url}";
			var nextpage = parseInt(${pagingDto.page})+1;
			$("#frmPaging").find("input[name=page]").val(nextpage);
			$("#frmPaging").find("input[name=url]").val(url);
			$("#frmPaging").attr("action", "/create/guestqna").submit();
		}
	});
});//(document)

</script>
</head>
<body>
<%@include file="../../include/ypagingparam.jsp" %>
	<div class="boxed-page">
	<%@ include file="../../include/temp_y/ytemp_menu.jsp"%>
		<!-- Menu Section -->
		<section id="gtco-menu" class="section-padding">
			<div class="container">
					<div class="row mb-5">
						<div class="col-md-12">
							<div class="heading-section text-center">
								<span class="subheading"> 									
					                   ${fn:substring(map.homeVo.brideNm,0,3) } +
										${fn:substring(map.homeVo.groomNm,0,3) }                
								</span>
								<h2>From 하객</h2>
							</div>
						</div>						
					</div>
				<div style="margin-left:800px;">
				<b>${pagingDto.startRow } - 
				<c:choose>
					<c:when test="${pagingDto.page == pagingDto.totalPage }">
						${pagingDto.count}
					</c:when>
					<c:otherwise>
						${pagingDto.endRow }
					</c:otherwise>
				</c:choose>
				 of ${pagingDto.count }</b>
					<nav>
						<ul class="pagination"  >
							
							<li class="page-item">
								<a  class="page-link" href="#" id="prev"
									<c:if test="${pagingDto.page == 1}">
										 style="pointer-events: none;"
									</c:if>
									> 
									< 
								</a>
							</li>
							<li class="page-item">
								<a class="page-link" href="#" id="next"
									<c:if test="${pagingDto.page == pagingDto.totalPage }">
										style="pointer-events: none;"
									</c:if>
								> > </a>
							</li>
						</ul>
					</nav>
				</div>
				<div class="row justify-content-center align-items-center">				
					<div class="col-lg-8 menu-wrap">							
							<c:forEach var="askVo" items="${map.askVo}" varStatus="status">
								<div class="swiper-slide">
								<div class="menus d-flex align-items-center">														
									<div class="text-wrap">									
										<div class="row align-items-start">										
											<div class="col-8">
												<h4>Q${status.count}. ${askVo.question}</h4>
											</div>
											<div class="col-4">
												<h4 class="text-muted menu-price ">
												<span style="display:none">${askVo.qno}</span>
													<i class="heartbtn fa fa-heart" aria-hidden="true">&nbsp;
														${askVo.likecount }
													</i>																																																												
												</h4>
																								
											</div>
										</div>
										<p>A${status.count}. ${askVo.answer}</p>																																														
									</div>
								</div>
								</div>										
							</c:forEach>
						</div>
				</div>
			</div>
		</section>
		<!-- End of Q + A Section -->
<%@include file="../../include/temp_y/ytemp_photoVo.jsp" %>	
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
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.22.2/moment.min.js"></script>
	<script src="vendor/bootstrap/popper.min.js"></script>
	<script src="vendor/bootstrap/bootstrap.min.js"></script>
	<script src="vendor/select2/select2.min.js "></script>
	<script src="vendor/owlcarousel/owl.carousel.min.js"></script>
	<script
		src="https://cdn.rawgit.com/noelboss/featherlight/1.7.13/release/featherlight.min.js"></script>
	<script src="vendor/stellar/jquery.stellar.js" type="text/javascript"
		charset="utf-8"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/tempusdominus-bootstrap-4/5.0.1/js/tempusdominus-bootstrap-4.min.js"></script>

	<!-- Main JS -->
	<script src="js/app.min.js "></script>
</body>
</html>
