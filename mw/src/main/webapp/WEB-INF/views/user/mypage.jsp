<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/m_header.jsp"%>
<!-- style스타일 입니다. -->
<style>
.form_menu {
	font-size: 25px;
}
.active{
	
	color: gray;
}
</style>
</head>
<!-- script입니다. -->
<script>
$(document).ready(function() {
	var page = ${pagingDto.page};
	console.log("page: " + page);
	$("#checkAll").click(function(){
		$(".chkques").trigger("click");
	});
	var recipient = "${loginInfo.userid}";
// 	$(".question").click(function() {
// 		var selected_ques = $(this).text();
// 		var qno = parseInt($(this).parent().prev().prev().text());
// 		console.log("qno: " + qno);
		
// 	});//.question(click)
	
	//질문 선택
	$(".chkques").click(function(){
		var chkqno = $(this).parent().parent().next().text();
		console.log("chkqno: " + chkqno);
		$(this).attr("data-no", chkqno);
		var selected_ques = $(this).prop("checked");
		console.log("selected_ques: " + selected_ques);
		//질문삭제
		$("#delques").click(function(e){
			e.preventDefault();
			var arr_qno = [];
			 $(".chkques").each(function(){
				var checked = $(this).is(":checked"); 
				console.log("checked: " + checked);
				if(checked){
					var qno = parseInt($(this).attr("data-no"));
					console.log("qno: ", qno);
					arr_qno.push(parseInt(qno));
					console.log("arr_qno: " + arr_qno);
				};
			
				var url = "/yguest/deleachques";
				console.log("sData arr_qno: " + arr_qno);
				var page = "${pagingDto.page}";
				var perPage = "${pagingDto.perPage}";
				var sData = {
						"arr_qno": arr_qno,
						"recipient": recipient,
						"page": page,
						"perPage": perPage
				}
				console.log(sData);
				$.post(url, sData, function(rData){
					if(rData == true){
						
						 window.location.reload();
					}
				});
			 });
		});
	});//.chkques(function())
	
	//질문 읽은후
	$(".question").click(function(){
		var clicked_ques = $(this);
		console.log("clicked_ques: " + clicked_ques);
		$("#myModalLabel").text(clicked_ques.text());
		var url_isread = "/yguest/isread";
		var qno = $(this).parent().prev().prev().text();
		var sData_isread = {
				"recipient": recipient,
				"qno": qno
		}
		$.get(url_isread, sData_isread, function(rData_isread){
			console.log("rData_isread: " + rData_isread);
			if(rData_isread == 'unread' || rData_isread == ''){
				var url = "/yguest/update";
				console.log("click ques qno: " + qno);
				var readstat = "read";
				var sData = {
						"readstat" : readstat,
						"recipient": recipient,
						"qno": qno
				};
				$.post(url,sData, function(rData){
					console.log(rData);
					if(rData == true){
						clicked_ques.attr("data-click", "clicked");
						var afterRead = clicked_ques.find("b").text();
						clicked_ques.text(afterRead);
						
						$("#modal-822505").trigger("click");
						$("#sendReply").on("click", function(){
							var answer = $("#answer").val();
							console.log("answer: " + answer);
							var url_reply = "/yguest/update";
							var sData_reply = {
									"qno": qno,
									"answer" : answer, 
									"recipient": recipient
							};
							$.post(url_reply, sData_reply, function(rData_reply){
								if(rData_reply == true){
									$("#closeReply").trigger("click");
									 window.location.reload();
								};
							});
						});
					};
				});
			}else{
				$("#modal-822505").trigger("click");
				$("#sendReply").on("click", function(){
					var answer = $("#answer").val();
					console.log("answer: " + answer);
					var url_reply = "/yguest/update";
					var sData_reply = {
							"qno": qno,
							"answer" : answer, 
							"recipient": recipient
					};
					$.post(url_reply, sData_reply, function(rData_reply){
						if(rData_reply == true){
							$("#closeReply").trigger("click");
							 window.location.reload();
						};
					});
				});
				
			};//else
		});
	
	});//$(".question").click
	
	//pagination 이전버튼
	$("#prev").click(function(){
		var prevpage = parseInt(${pagingDto.page})-1;
		console.log("prevpage: " + prevpage);
		$("#frmPaging").find("input[name=page]").val(prevpage);
		$("#frmPaging").attr("action", "/user/mypage").submit();
	});
	//pagination 다음버튼 
	$("#next").click(function(){
		var nextpage = parseInt(${pagingDto.page})+1;
		console.log("nextpage: " + nextpage);
		$("#frmPaging").find("input[name=page]").val(nextpage);
		$("#frmPaging").attr("action", "/user/mypage").submit();
	});
// 	var path = window.location.href;
// 	console.log(path);
// 	var slashIndex = path.lastIndexOf("/");
// 	console.log(slashIndex);
// 	var prevpage = path.substring(slashIndex+1);
// 	console.log(prevpage);
// 	var nowpage;
// 	switch(prevpage){
// 	case mypage:
// 		nowpage = $("#mypage");
// 		console.log("mypage");
// 		break;
// 	case inputpassword:
// 		nowpage = $("#editinfo");
// 		console.log("editinfo");
// 		break;
// 	}
// 	  var activeCtg = $(".nav-link.active");
//    	  if (activeCtg.length == 1) {
//    		  activeCtg.removeClass("active");
//    	  }
// 	nowpage.addCalss("active");
	
});
</script>
<%@include file="../include/ypagingparam.jsp" %>
<!-- end banner -->
<div class="back_re">
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<div class="title">
					<h2>마이페이지</h2>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- table -->
<div class="container-fluid" style="min-height: 700px;">
	<div class="row">
		<div class="col-md-12"></div>
	</div>
	<div class="row">
		<div class="col-md-3">
			<div class="row">
				<div class="col-md-12">
					<p class="form_menu" style="margin-top: 15px; color: black">${loginInfo.userid}
						님 반갑습니다.</p>
				</div>
			</div>
			<hr>
			<div class="row">
				<div class="col-md-12">
					<ul class=" navbar-nav mr-auto">
						<li class="nav-item "><a href="/user/mypage" class="form_menu nav-link active" id="mypage">마이페이지</a></li>
						<li style="margin-left:30px"><a href="/user/mypage" class="active"> - 하객질문
						<span class="badge badge-dark">${unreadQues }</span></a></li>
						<li style="margin-left:30px;"><a href="/user/guestmes"> - 하객쪽지
						<span class="badge badge-dark">${unreadMes }</span></a></li>
					</ul>				
				</div>
				<div class="col-md-12">
					<ul class=" navbar-nav mr-auto">
						<li class="nav-item"><a href="/user/inputpassword" class="form_menu nav-link" id="editinfo">개인정보수정</a></li>
					</ul>				
				</div>
				<br>
			</div>
		</div>
		
			
		<div class="col-md-9" style="padding: 20px">
			<div class="col-md-12">
				<c:choose>
					<c:when test="${1 eq loginInfo.pjnum && loginInfo.temptype eq 'Y'}">
						<!-- 만들던 프로젝트가 있는 경우 -->
						<a class="read_more" href="/create/updateform">진행중인 프로젝트</a>
						<a class="read_more" href="/create/invite?url=${url }">청첩장 보기</a>
					</c:when>
				<c:otherwise>
					<!-- 만들던 프로젝트가 없는 경우 -->
					<a class="read_more" href="/create/choose_temp"
						>청첩장 만들기</a>
				</c:otherwise>
			  </c:choose>
			
				<h2 style="margin-top:30px">하객 질문</h2>
				<div class="row">
					<div class="col-md-12">
						<a id="modal-822505" href="#modal-container-822505" role="button"
							class="btn" data-toggle="modal" style="display: none">Launch
							demo modal</a>
						<div class="modal fade" id="modal-container-822505" role="dialog"
							aria-labelledby="myModalLabel" aria-hidden="true">
							<div class="modal-dialog" role="document">
								<div class="modal-content">
									<div class="modal-header">
										<h5 class="modal-title" id="myModalLabel">답글창</h5>
										<button type="button" class="close" data-dismiss="modal">
											<span aria-hidden="true">×</span>
										</button>
									</div>
									<div class="modal-body">
										<textarea class="form-control" rows="5" id="answer"></textarea>
									</div>
									<div class="modal-footer">
										<button type="button" class="btn btn-primary" id="sendReply">보내기</button>
										<button type="button" class="btn btn-secondary" data-dismiss="modal" id="closeReply">취소</button>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div  style="margin-left:800px">
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
				<div class="form-check" style="margin-left:15px">
					<input class="form-check-input" type="checkbox" id="checkAll"
						name="option1" value="something">
						<a href="#" id="delques"><i class="fa fa-trash" aria-hidden="true" style="margin-left:30px"></i></a>
				</div>
				<table class="table" style="margin-right:250px">
					<thead>
						<tr>
							<th></th>
							<th style="display:none">글번호</th>
							<th>보낸이</th>
							<th>질문</th>
							<th>보낸날짜</th>
							<th>답장날짜</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="list" items="${list }">
							<tr>
								<td>
									<div class="form-check">
										<input class="form-check-input chkques" type="checkbox" 
											name="option1" value="something">
									</div>
								</td>
								<td class="qno" style="display:none">${list.qno }</td>
								<td>${list.sender }</td>
								<td>
									<a href="#" class="question">
									<c:choose>
										<c:when test="${list.readstat eq 'read' }">
											${list.question }
										</c:when>
										<c:when test="${list.readstat ne 'read' }">
											<b>${list.question }</b>
										</c:when>
									</c:choose>
										
									</a>
								</td>
								<td>${list.writedate }</td>
								<td>
									<c:choose>
										<c:when test="${list.replydate eq null }">
											--/--/--
										</c:when>
										<c:when test="${list.replydate ne null }">
											${list.replydate }
										</c:when>
									</c:choose>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
		<div class="col-md-12" style="text-align:center">
			
		</div>
			</div>
		</div>

	</div>

</div>
<%@ include file="../include/m_footer.jsp"%>