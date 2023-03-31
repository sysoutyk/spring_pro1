<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="../../include/m_header.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<style>
.col-xs-3 {
	margin-left: 12px;
	margin-right: 20px;
}

.col-xs-4 {
	margin-left: 12px;
	margin-right: 20px;
}

.col_reverse {
	margin-left: 12px;
}

.right_float {
	float: right;
}
</style>
<script>
$(document).ready(function() {
	var pjnumVal = $("#pjnum").val();
	//결혼식 시간
	var wedTime = "${map.homeVo.wedTime }";
	$("#dropdownMenuButton").val(wedTime);

	//이미지 미리보기
	$("#pick_coverpic").on("change", function(e) {
		var file = $(this).val();
		var filename = file.split("\\").pop();
		console.log("filename: " + filename);
		$(this).next().text(filename);
		console.log(e.target.files[0]);
		var cover_addr = URL.createObjectURL(e.target.files[0]);
		$("#coverPic").attr("src", cover_addr);
	});
	$("#story_one_pic").on("change", function(e) {
		var file = $(this).val();
		var filename = file.split("\\").pop();
		$(this).next().text(filename);
		var storyone_addr = URL.createObjectURL(e.target.files[0]);
		$("#storyPic1").attr("src", storyone_addr);
	});
	$("#story_two_pic").on("change", function(e) {
		var file = $(this).val();
		var filename = file.split("\\").pop();
		$(this).next().text(filename);
		var storytwo_addr = URL.createObjectURL(e.target.files[0]);
		$("#stroyPic2").attr("src", storytwo_addr);
	});
	$("#pick_mes").on("change", function(e) {
		var file = $(this).val();
		var filename = file.split("\\").pop();
		$(this).next().text(filename);
		var mes_addr = URL.createObjectURL(e.target.files[0]);
		$("#mesPic").attr("src", mes_addr);
	});
	$("#pick_map").on("change", function(e) {
		var file = $(this).val();
		var filename = file.split("\\").pop();
		$(this).next().text(filename);
		var map_addr = URL.createObjectURL(e.target.files[0]);
		$("#mapPic").attr("src", map_addr);
	});
	$("#pick_footer").on("change", function(e) {
		var file = $(this).val();
		var filename = file.split("\\").pop();
		$(this).next().text(filename);
		var footer_addr = URL.createObjectURL(e.target.files[0]);
		$("#footerPic").attr("src", footer_addr);
	});

	//질문+답변 추가
	$("#addQnA").click(function(e) {
				e.preventDefault();
				console.log('click');
				console.log("pjnumVal" + pjnumVal);
				var clonedQnA;
				if(pjnumVal == 0){
					clonedQnA = $("#originQnA").clone();
				}else if(pjnumVal == 1){
					clonedQnA = $("#updateQnA").clone();
				}
				clonedQnA.find("input").val("");
				clonedQnA.find("textarea").val("");
				clonedQnA.find(".delQnA").removeAttr("style");
				$("#attachQnA").append(clonedQnA);
				clonedQnA.show(500);

				//입력본- 질문+답변 삭제
				$(".delQnA").click(function(e) {
					console.log("click");
					e.preventDefault();
					clonedQnA.remove();
				});

			});
	
	//수정본 - 질문+답변 삭제
	$(".delQnA").click(function(e) {
		console.log("click");
		e.preventDefault();
		var that = $(this);
		var qno = $(this).parent().parent().find("input[name=qnos]").val();
		console.log("qnos:" + qno);
		var url = "/create/delqna";
		var userid = "${userVo.userid}";
		var sData = {
			"qno" : qno,
			"userid" : userid
		};
		$.get(url, sData, function(rData) {
			console.log(rData);
			if (rData == true) {
				console.log("true");
				console.log(that);
				that.parent().parent().remove();
			}

		});

	});
	//시간 dropdown
	$(".dropdown-item").click(function(e) {
		e.preventDefault();
		console.log("click");
		console.log(this);
		var timeText = this.val();
		console.log(timeText);
		$("#dropdownMenuButton").text(timeText);
	});

	//템프삭제
	var message = "${message}";
		if (message == "fail_delete") {
			alert("죄송합니다. 고객님이 요청하신 작업 중 오류가 생겼습니다. 고객센터로 문의 해주세요.");
		}
	$("#saveTemp").click(function(e){
		e.preventDefault();
		console.log("saveTemp");
		$("#myform").submit();
	});

});//$(document).ready
</script>
</head>
<!-- blog -->
<div class="blog">
	<div class="container ">
		<form role="form" action="/create/insertInfo" method="post" id="myform"
			enctype="multipart/form-data">
			<input type="hidden" id="pjnum" name="pjnum" value="${userVo.pjnum }">
			<div class="row">
			<div class="col-md-12" style="text-align:center"><b>"저장" 버튼 누르신후, 청첩장을 확인 하실 수 있습니다.</b>
			<a type="button" class="btn btn-dark" id="saveTemp" style="margin-left:950px; margin-bottom:20px; color:white"> <b>저장하기</b></a>
			</div>
				<!-- Home -->
				<div class="col-sm-12">
					<div class="blog_bg margin_bottom30">
						<div class="row d_flex">
							<div class="col-md-12">
								<div class="marriage_text"
									style="margin-left: 20px; padding-bottom: 0px;">
									<h3 style="padding-bottom: 0px">
										<a href="#" class="fold"> <i
											class="fa fa-angle-double-down" aria-hidden="true"
											style="margin-right: 20px"></i></a> <strong>Home</strong>
									</h3>
									<hr>
								</div>
							</div>
							<!--                   <div class="blog_bg margin_bottom30"> -->
				
							<div class="col-md-6 text_align_center befold" data-state="0">
								<div class="blog_img ">
									<figure>
										<img 
										<c:choose>
											<c:when test="${map.homeVo.coverPic == null }">
											 	src="/create_tempY/img/imagedisplay.png"
											</c:when>
											<c:when test="${map.homeVo.coverPic != null }">
												src="/create/displayImg?pic=${map.homeVo.coverPic}" 
											</c:when>
										</c:choose>
										id="coverPic">
									
									</figure>
								</div>
							</div>
							<div class="col-md-6 befold" data-state="0">
								<div class="marriage_text">
									<div class="form-group row">
										<div class="col-xs-3">
											<input type="text" class="form-control" id="brideNm"
												name="brideNm" placeholder="예비신부 이름"
												value="${map.homeVo.brideNm}">
										</div>
										<div class="col-xs-3">
											<input type="text" class="form-control" id="groomNm"
												name="groomNm" placeholder="예비신랑 이름"
												value="${map.homeVo.groomNm}">
										</div>
									</div>
									<div class="form-group row">
										<div class="col-xs-4">
											<input type="text" class="form-control" id="wedDate"
												name="wedDate" placeholder="날짜 - 년.월.일 (요일)"
												value="${map.homeVo.wedDate }">
										</div>
										<div class="dropdown">
											<select class="btn btn-light dropdown-toggle"
												id="dropdownMenuButton" name="wedTime"
												data-toggle="dropdown">
												<option
													<c:choose>
													  <c:when test="${map.homeVo.wedTime == null }">
													  	selected
													  </c:when>
													</c:choose>
												>예식 시간</option>
												<option>오전 11시</option>
												<option>오후 12시</option>
												<option>오후 1시</option>
												<option>오후 2시</option>
												<option>오후 3시</option>
												<option>오후 4시</option>
											</select>
										</div>
									</div>
									<div class="form-group">
										<input type="text" class="form-control" id="wed_addr"
											name="wed_addr" placeholder="결혼식 장소"
											value="${map.homeVo.wed_addr }">
									</div>
									<div class="form-group">
										<textarea class="form-control " id="announce" name="announce"
											rows="4" cols="15" placeholder="To 친애하는 하객분들에게(최대500자)">${map.homeVo.announce }</textarea>
									</div>
									<br>
									<br>
									<div class="form-group">
										<div class="custom-file">
											<input type="file" class="custom-file-input"
												id="pick_coverpic" name="multiFile" accept="image/*">
											<label class="custom-file-label" for="customFile">사진
												검색</label>
										</div>
									</div>
								</div>
							</div>
						
						</div>
						<!-- row-flex -->
					</div>
				</div>
				<!-- end of Home -->
				<div class="col-sm-12">
					<div class="marriage_text"
						style="margin-left: 20px; padding-bottom: 0px;">
						<h3 style="padding-bottom: 0px">
							<a href="#" class="fold"> <i class="fa fa-angle-double-down"
								aria-hidden="true" style="margin-right: 20px"></i></a> <strong>Our
								Story</strong>
						</h3>
						<hr>
					</div>
					<div class="blog_bg">
						<div class="row d_flex">
							<div class="col-md-6 text_align_center befold">
								<div class="blog_img">
									<figure>
										<img 
											<c:choose>
												<c:when test="${map.storyVo.story_one_pic == null }">
													src= "/create_tempY/img/imagedisplay.png"
												</c:when>
												<c:when test="${map.storyVo.story_one_pic != null }">
													src="/create/displayImg?pic=${map.storyVo.story_one_pic }"
												</c:when>
											</c:choose>
									 id="storyPic1" />
<!-- 										<span>커플 사진</span> -->
									</figure>
								</div>
							</div>
							<div class="col-md-6 befold">
								<div class="marriage_text">
									<div class="form-group">
										<input type="text" class="form-control" id="story_one_title"
											name="story_one_title" placeholder="제목"
											value="${map.storyVo.story_one_title }">
									</div>
									<div class="form-group">
										<textarea class="form-control " id="story_one_con"
											name="story_one_con" rows="5" cols="10"
											placeholder="우리가 언제 처음 만난것은....">${map.storyVo.story_one_con }</textarea>
									</div>
									<br>
									<br>
									<div class="form-group">
										<div class="custom-file">
											<input type="file" class="custom-file-input"
												id="story_one_pic" name="multiFile" accept="image/*">
											<label class="custom-file-label" for="customFile">사진
												검색</label>
										</div>
									</div>
									<br>
								</div>
							</div>
						</div>
						<!-- end row d_flex -->
					</div>
					<!-- end blog-bg (stroy1) -->
					<!--story2 -->
					<div class="blog_bg" style="margin-top: 30px">
						<div class="row d_flex">
							<div class="col-md-6 text_align_center befold">
								<div class="blog_img">
									<figure>
										<img 
											<c:choose>
												<c:when test="${map.storyVo.story_two_pic == null }">
													src="/create_tempY/img/imagedisplay.png"
												</c:when>
												<c:when test="${map.storyVo.story_two_pic != null }">
													src="/create/displayImg?pic=${map.storyVo.story_two_pic }" 
												</c:when>
											</c:choose>
										id="stroyPic2" />
<!-- 										<span>사진 보여주기</span> -->
									</figure>
								</div>
							</div>
							<div class="col-md-6 padd_right right_float befold">
								<div class="marriage_text">
									<div class="form-group">
										<input type="text" class="form-control" id="story_two_title"
											name="story_two_title" placeholder="제목2"
											value="${map.storyVo.story_two_title }">
									</div>
									<div class="form-group">
										<textarea class="form-control " id="story_two_con"
											name="story_two_con" rows="5" cols="10"
											placeholder="우리가 평생 서로의 반려자가 되어주기로 한 이유는 말이야...">${map.storyVo.story_two_con }</textarea>
									</div>
									<br>
									<br>
									<div class="form-group">
										<div class="custom-file">
											<input type="file" class="custom-file-input"
												id="story_two_pic" name="multiFile" accept="image/*">
											<label class="custom-file-label" for="customFile">사진
												검색</label>
										</div>
									</div>
									<br>
								</div>
							</div>

						</div>
						<!-- end row d_flex -->
					</div>
					<!-- end of story2 -->
				</div>
				<!-- end of Our Story -->
				<!-- Q & A -->
				<div class="col-sm-12">
					<div class="marriage_text"
						style="margin-left: 20px; padding-bottom: 0px;">
						<h3 style="padding-bottom: 0px">
							<a href="#" class="fold"> <i class="fa fa-angle-double-down"
								aria-hidden="true" style="margin-right: 20px"></i></a> <strong>Q+A</strong>
						</h3>
						<hr>
					</div>
					<div class="blog_bg">
						<div class="row d_flex">
							<div class="col-md-12 befold">
								<div class="marriage_text">
									<c:choose>
										<c:when test="${userVo.pjnum == 0}">
											<div id="originQnA" style="text-align: right">
												<a class="col-md-12 delQnA" href="#" > 
												<i class="fa fa-trash-o delQnA" aria-hidden="true" style="display:none" >삭제</i>
												</a>
													<div class="form-group" style="display: none">
														<div class="col-md-12">
															<input type="text" class="form-control" name="qnos">
														</div>
													</div>
												<div class="form-group">
													<div class="col-md-12">
														<input type="text" class="form-control" name="arr_ques" placeholder="질문(50자이내)"> 
													</div>
												</div>
												<div class="form-group">
													<div class="col-md-12">
														<textarea class="form-control" name="arr_answers" rows="2"
															cols="30" placeholder="답변(200자이내)"></textarea>
													</div>
												</div>
											</div>
										</c:when>
										<c:when test="${userVo.pjnum == 1 }">
											<c:forEach var="qnaVo" items="${map.qnaVo }"
												varStatus="count">
												<div id="updateQnA" class="updateQnA"style="text-align: right">
												<a class="col-md-12" href="#"> <i
														class="fa fa-trash-o delQnA" aria-hidden="true"
													<c:choose>
														<c:when test="${ count.first}"> 
															style="display:none"
														</c:when>
														<c:when test="${not count.first}">
														</c:when>										
													</c:choose>>삭제</i>
													</a>		
													<div class="form-group" style="display: none">
														<div class="col-md-12">
															<input type="text" class="form-control" name="qnos" value="${qnaVo.qno }">
														</div>
													</div>
													<div class="form-group">
														<div class="col-md-12">
															<input type="text" class="form-control" name="arr_ques"
																placeholder="질문(50자이내)" value="${qnaVo.ques }">
														</div>
													</div>
													<div class="form-group">
														<div class="col-md-12">
															<textarea class="form-control" name="arr_answers"
																rows="2" cols="30" placeholder="답변(200자이내)">${qnaVo.answer}</textarea>
														</div>
													</div>
												</div>
											</c:forEach>
										</c:when>
									</c:choose>
									<div id="attachQnA"></div>
									<div>
										<a class="col-md-12" id="addQnA" href="#"><i
											class="fa fa-plus-square-o" aria-hidden="true">질문 + 답변 추가</i></a>
									</div>
								</div>
							</div>
						</div>
					</div>
					<!-- row-flex -->
				</div>
			</div>
			<!-- end of Q & A -->
			<!-- message -->
			<div class="col-sm-12">
				<div class="marriage_text"
					style="margin-left: 20px; padding-bottom: 0px;">
					<h3 style="padding-bottom: 0px">
						<a href="#" class="fold"> <i class="fa fa-angle-double-down"
							aria-hidden="true" style="margin-right: 20px"></i></a> <strong>Message</strong>
					</h3>
					<hr>
				</div>
				<div class="blog_bg margin_bottom30">
					<div class="row d_flex">
						<div class="col-md-6 text_align_center befold">
							<div class="blog_img">
								<figure>
									<img 
									<c:choose>
										<c:when test="${map.photoVo.mespic == null }">
											src="/create_tempY/img/imagedisplay.png"
										</c:when>
										<c:when test="${map.photoVo.mespic != null }">
											src="/create/displayImg?pic=${map.photoVo.mespic }"
										</c:when>
									</c:choose>
									 id="mesPic" />
<!-- 									<span>커플 사진</span> -->
								</figure>

							</div>
						</div>
						<div class="col-md-6 befold ">
							<div class="marriage_text">
								<div class="form-group">
									<div class="custom-file">
										<input type="file" class="custom-file-input" id="pick_mes"
											name="multiFile" accept="image/*"> <label
											class="custom-file-label" for="customFile">사진 검색</label>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- end of message -->
			<!-- Travel -->
			<div class="col-sm-12">
				<div class="marriage_text"
					style="margin-left: 20px; padding-bottom: 0px;">
					<h3 style="padding-bottom: 0px">
						<a href="#" class="fold"> <i class="fa fa-angle-double-down"
							aria-hidden="true" style="margin-right: 20px"></i></a> <strong>Travel</strong>
					</h3>
					<hr>
				</div>
				<div class="blog_bg margin_bottom30">
					<div class="row d_flex">
						<div class="col-md-6 text_align_center befold">
							<div class="blog_img">
								<figure>
									<img 
										<c:choose>
											<c:when test="${map.travelVo.mapPic == null }">
												src="/create_tempY/img/imagedisplay.png"
											</c:when>
											<c:when test="${map.travelVo.mapPic != null }">
												src="/create/displayImg?pic=${map.travelVo.mapPic}" 
											</c:when>
										</c:choose>
									id="mapPic" />
<!-- 									<span>오시는길 안내 사진</span> -->
								</figure>

							</div>
						</div>
						<div class="col-md-6 befold">
							<div class="marriage_text">
								<div class="form-group">
									<input type="text" class="form-control" id="wedPlace"
										name="wedPlace" placeholder="결혼식 장소 이름"
										value="${map.travelVo.wedPlace }">
								</div>
								<div class="form-group">
									<input type="text" class="form-control" id="wed_addr"
										name="tvl_addr" placeholder="결혼식 장소 주소"
										value="${map.travelVo.tvl_addr }">
								</div>
								<div class="form-group">
									<textarea class="form-control " id="tvlDetail" name="tvlDetail"
										rows="4" cols="15"
										placeholder="세부정보 안내(예를 들면, 교통정보, 주차정보, 음식정보)">${map.travelVo.tvlDetail }</textarea>
								</div>
								<br>
								<br>
								<div class="form-group">
									<div class="custom-file">
										<input type="file" class="custom-file-input" id="pick_map"
											name="multiFile" accept="image/*"> <label
											class="custom-file-label" for="customFile">사진 검색</label>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- end of Travel -->
			<!-- footer -->
			<div class="col-sm-12">
				<div class="marriage_text"
					style="margin-left: 20px; padding-bottom: 0px;">
					<h3 style="padding-bottom: 0px">
						<a href="#" class="fold"> <i class="fa fa-angle-double-down"
							aria-hidden="true" style="margin-right: 20px"></i></a> <strong>Footer</strong>
					</h3>
					<hr>
				</div>
				<div class="blog_bg margin_bottom30">
					<div class="row d_flex">
						<div class="col-md-6 text_align_center befold">
							<div class="blog_img">
								<figure>
									<img 
										<c:choose>
											<c:when test="${map.photoVo.footerpic == null }">
												src = "/create_tempY/img/imagedisplay.png"
											</c:when>
											<c:when test ="${map.photoVo.footerpic != null }">
												src="/create/displayImg?pic=${map.photoVo.footerpic}"
											</c:when>
										</c:choose>
									 id="footerPic" />
<!-- 									<span>footer 사진</span> -->
								</figure>

							</div>
						</div>
						<div class="col-md-6 befold">
							<div class="marriage_text">
								<div class="form-group">
									<input type="text" class="form-control" id="footer"
										name="footer" placeholder="예시 - 잘 살겠습니다"
										value="${map.photoVo.footer }">
								</div>
								<div class="form-group">
									<div class="custom-file">
										<input type="file" class="custom-file-input" id="pick_footer"
											name="multiFile" accept="image/*"> <label
											class="custom-file-label" for="customFile">사진 검색</label>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- end of footer -->
	  </form>
	</div>
	
	<!-- end class="row -->
	<div style="text-align:center; padding-bottom:100px">
		<c:if test="${userVo.pjnum == 1 }">
			<a type="button" class="btn btn-warning delTemp"
				href="/create/delete?userid=${userVo.userid }"><b>템플렛 삭제</b></a>
		</c:if>
		
	</div>
</div>
<!-- end class="container " -->
<!-- end blog -->
<!--  footer -->
<%@ include file="../../include/m_footer.jsp"%>