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
<script>
$(document).ready(function(){
	var result = "${result}";
	console.log("result: " + result);
	if(result == "insert_success"){
		alert("커플에게 쪽지를 전달하였습니다.");
	}else if(result == "insert_fail"){
		alert("다시 시도해주세요");
	}
	var writetime; 
	var file;
	$("#datetimepicker4").change(function(){
		writetime = $(".datetimepicker-input").val();
		console.log("writetime: " + writetime);
	});
	$("#file").change(function(e) {
//			console.log("click");
		console.log(e);
		file = $(this).val();
		console.log(file);
		var arrFile = file.split("\\");
		var filename = arrFile.pop();
		console.log(filename);
		$(".custom-file-label").text(filename);
		var binary = URL.createObjectURL(e.target.files[0]);//URL.createObjectURL(binary 파일을 읽는 기능) 
		$("#img").attr("src", binary);
	});
	//커플에게 궁금한점 버튼
	$("#rdoQues").click(function(){
		$("#rdoMes").removeAttr("checked");
		$("#rdoQues").attr("checked", "checked");
		$("#mesform").hide(500);
		$("#askform").show(500);
		
	});	
	//축하+감사 메세지 버튼
	$("#rdoMes").click(function(){
		$("#rdoQues").removeAttr("checked");
		$("#rdoMes").attr("checked", "checked");		
		$("#askform").hide(500);
		$("#mesform").show(500);
	});	

	$("#askBtn").click(function(e){
		e.preventDefault();
		console.log("click");
		var recipient = "${userid}";
		var question = $("#question").val();
		var sender = $("#sender").val();
		var url = "/yguest/send";
		var sData = {
				"recipient": recipient,
				"question": question,
				"sender" : sender
		};
		if(question == "null" || sender == "null"){
			alert("빈칸없이 입력해주세요");
		};
		$.post(url, sData, function(rData){
			console.log(rData);
			if(rData){
				console.log("true confirm");
				$("#question").val("");
				$("#sender").val("");
				alert("질문이 커플에게 전달되었습니다.");
			}else{
				console.log(rData);
				alert("다시 한번 시도해주세요");
			}
		});
	});
	$("#file").click(function(){
		var filename = $("#file").val();
		console.log("filename" + filename);
	})
});
</script>
</head>

<body>

<div class="boxed-page">
<%@ include file="../../include/temp_y/ytemp_menu.jsp"%>
<!-- 쪽지 보내기 Section -->
<section id="gtco-reservation" class="bg-fixed bg-white section-padding overlay" style="background-image: url(/create/displayImg?pic=${map.photoVo.mespic});">
    <div class="container">
        <div class="row">
            <div class="col-lg-5">
                <div class="section-content bg-white p-5 shadow">
                    <div class="heading-section text-center">                        
                        <h2>
                            To. ${fn:substring(map.homeVo.brideNm,0,3) } +
								${fn:substring(map.homeVo.groomNm,0,3) }
                        </h2>
                    </div>
                    <div style="margin-bottom:40px">                 	
                       	<input type="radio" id="rdoMes" name="mesType" checked>축하+감사쪽지
                       	<input type="radio" id="rdoQues" name="mesType">커플에게 궁금한점
                  	</div>
                 <!-- 축하+감사 쪽지 -->
                    <form id="mesform" method="post" action="/create/message?url=${url }" enctype="multipart/form-data">
                        <div class="row">                                                                                
                            
                            <div class="col-md-12 form-group">
                                <div class="input-group date" id="datetimepicker4" data-target-input="nearest">
                                    <input type="text" class="form-control datetimepicker-input" data-target="#datetimepicker4" name="writedate" placeholder="추억의 그날" />
                                    <div class="input-group-append" data-target="#datetimepicker4" data-toggle="datetimepicker">
                                        <div class="input-group-text">
                                            <span class="lnr lnr-calendar-full"></span>
                                        </div>
                                    </div>
                                </div>
                            </div>                                                                                                     
                            <div class="col-md-12 form-group">
                                <textarea class="form-control" id="message" name="message" rows="6" placeholder="친구야~ 결혼 진심으로 축하하고 늘 고마웠어!!"></textarea>
                            </div>
                            <div class="col-md-12 form-group">
                           		 <img src="" id="img" width="120px">
                            </div>
                             <div class="col-md-12 form-group">
                             	 
                                <div class="custom-file">                           
								    <input type="file" class="custom-file-input" id="file" name="file" accept="image/*">
								    <label class="custom-file-label" for="customFile">사진 검색</label>
								</div>
                            </div>
                            <div class="col-md-12 form-group">
                                <input type="text" class="form-control" id="writer" name="writer" placeholder="이름">
                            </div>
                            <div class="col-md-12 text-center">
                                <button class="btn btn-primary btn-shadow btn-lg" type="submit" id="mesBtn" >
                                	<i class="fa fa-paper-plane" aria-hidden="true"></i>보내기
                                </button>
                            </div>                     
                        </div>
                    </form>
                    <!-- 질문 쪽지 -->
                   <form id="askform" method="post" action="/yguest/send" enctype="multipart/form-data" style="display:none">
                        <div class="row">                                                                                                                                                                    
                            <div class="col-md-12 form-group">                          
                                <textarea class="form-control" id="question" name="question" rows="6" placeholder="예) 서로의 첫인상은?"></textarea>
                            </div>                          
                            <div class="col-md-12 form-group">
                                <input type="text" class="form-control" id="sender" name="sender" placeholder="이름">
                            </div>
                            <div class="col-md-12 text-center">
                                <button class="btn btn-primary btn-shadow btn-lg" type="submit" id="askBtn" name="submit">
                                	<i class="fa fa-paper-plane" aria-hidden="true"></i>보내기
                                </button>
                            </div>                     
                        </div>
                    </form>
                </div>
            </div>
        </div>
        
    </div>
</section>
<!-- End of 쪽지 보내기-->	
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
