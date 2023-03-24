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
	$(".chkmes").click(function(){
		var chkbno = $(this).parent().parent().next().text();
		console.log("chkbno: " + chkbno);
		$(this).attr("data-no", chkbno);
		var selected_mes = $(this).prop("checked");
		console.log("selected_mes: " + selected_mes);
		//질문삭제
		$("#delmes").click(function(e){
			e.preventDefault();
			var arr_bno = [];
			 $(".chkmes").each(function(){
				var checked = $(this).is(":checked"); 
				console.log("checked: " + checked);
				if(checked){
					var bno = parseInt($(this).attr("data-no"));
					console.log("bno: ", bno);
					arr_bno.push(parseInt(bno));
					console.log("arr_bno: " + arr_bno);
				};
			
				var url = "/yguest/delmes";
				var page = "${pagingDto.page}";
				var perPage = "${pagingDto.perPage}";
				var sData = {
						"arr_bno": arr_bno,
						"recipient": recipient,
						"page": page,
						"perPage": perPage
				}
				console.log(sData);
				$.get(url, sData, function(rData){
					if(rData == true){
						
						 window.location.reload();
					}
				});
			 });
		});
	});//.chkques(function())
	
	//쪽지 메세지 읽기
	$(".message").click(function(){
		var clicked_mes = $(this);
		console.log("clicked_mes: " + clicked_mes.text().trim());
		var url_is_mesread = "/yguest/ismesread";
		var bno = $(this).parent().parent().find("td[class=bno]").text();
		var rstat = "read";
		console.log("bno" + bno);
		var sData_is_mesread = {
				"recipient": recipient,
				"bno": bno
		}
		$.get(url_is_mesread, sData_is_mesread, function(rData_is_mesread){
			console.log("rData_is_mesread: " + rData_is_mesread);
			if(rData_is_mesread == 'read'){
				console.log(clicked_mes);
				var fullmessage = clicked_mes.parent().parent().find("td[class=fullmessage]").text();
				console.log("fullmessage " + fullmessage);
				$("#message").text(fullmessage);
				$("#modal-822505").trigger("click");
			}else if(rData_is_mesread != 'read'){
					var url = "/yguest/updatemes";
					var message = clicked_mes.text().trim();
					var sData = {
							"bno": bno,
							"rstat": rstat,
							"message" : message,
							"recipient": recipient		
					};
					$.post(url,sData, function(rData){
						console.log(rData);
						if(rData == true){
							var afterRead = clicked_mes.find("b").text();
							clicked_mes.text(afterRead);
							var fullmessage = clicked_mes.parent().parent().find("td[class=fullmessage]").text();
							console.log(fullmessage);
							$("#message").text(fullmessage);
							$("#modal-822505").trigger("click");
						};
					});
				}	
			});
		
		$("#editmes").on("click", function(){
			var message = $("#message").val();
			console.log("message: " + message);
			var url_reply = "/yguest/updatemes";
			var sData_reply = {
					"bno": bno,
					"message" : message, 
					"rstat": rstat,
					"recipient": recipient
			};
			$.post(url_reply, sData_reply, function(rData_reply){
				if(rData_reply == true){
					$("#closeReply").trigger("click");
					 window.location.reload();
				};
			});
		});

	
	});//$(".message").click
	
	//pagination 이전버튼
	$("#prev").click(function(){
		var prevpage = parseInt(${pagingDto.page})-1;
		console.log("prevpage: " + prevpage);
		$("#frmPaging").find("input[name=page]").val(prevpage);
		$("#frmPaging").attr("action", "/user/guestmes").submit();
	});
	//pagination 다음버튼 
	$("#next").click(function(){
		var nextpage = parseInt(${pagingDto.page})+1;
		console.log("nextpage: " + nextpage);
		$("#frmPaging").find("input[name=page]").val(nextpage);
		$("#frmPaging").attr("action", "/user/guestmes").submit();
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
	
	//업로드 승인하기
	$(".btnupload").click(function(e){
		e.preventDefault();
		var url = "/yguest/upload";
		var bno = $(this).parent().parent().find("td[class=bno]").text();
		console.log(bno);
		var uploadstat = 'upload';
		var sData = {
				"uploadstat": uploadstat,
				"bno": bno,
				"recipient":recipient
		};
		$.post(url, sData, function(rData){
			console.log("rData: " + rData);
			if(rData == true){
				window.location.reload();
			}
			 
		});
		
	});
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
						<li style="margin-left:30px">
							<a href="/user/mypage" > - 하객질문
								<span class="badge badge-dark">${unreadQues }</span>
							</a>
						</li>
						<li style="margin-left:30px;">
							<a href="/user/guestmes" class="active"> - 하객쪽지
								<span class="badge badge-dark">${unreadMes }</span>
							</a>
						</li>
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
			
				<h2 style="margin-top:30px">하객 쪽지</h2>
				<div class="row">
					<div class="col-md-12">
						<a id="modal-822505" href="#modal-container-822505" role="button"
							class="btn" data-toggle="modal" style="display:none" >Launch
							demo modal</a>
						<div class="modal fade" id="modal-container-822505" role="dialog"
							aria-labelledby="myModalLabel" aria-hidden="true">
							<div class="modal-dialog" role="document">
								<div class="modal-content">
									<div class="modal-header">
										<h5 class="modal-title" id="myModalLabel">쪽지 </h5>
										<button type="button" class="close" data-dismiss="modal">
											<span aria-hidden="true">×</span>
										</button>
									</div>
									<div class="modal-body">
										<textarea class="form-control" rows="5" id="message"></textarea>
									</div>
									<div class="modal-footer">
									<button type="button" class="btn btn-secondary" data-dismiss="modal" id="editmes">수정완료</button>
										<button type="button" class="btn btn-secondary" data-dismiss="modal" id="close">닫기</button>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div  style="margin-left:800px">
				<b>
					<c:choose>
						<c:when test="${pagingDto.count == 0 }">
							0
						</c:when>
						<c:otherwise>
						${pagingDto.startRow } 
						</c:otherwise>
					</c:choose>
						-
				<c:choose>
					<c:when test="${pagingDto.page == pagingDto.totalPage }">
						${pagingDto.count}
					</c:when>
					<c:when test="${pagingDto.count == 0 }">
						0
					</c:when>
					<c:otherwise>
						${pagingDto.endRow }
					</c:otherwise>
				</c:choose>
				 of ${pagingDto.count } </b>
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
						<a href="#" id="delmes"><i class="fa fa-trash" aria-hidden="true" style="margin-left:30px"></i></a>
						<a href="#" id="registermes"><i class="fa fa-paper-plane" aria-hidden="true" style="margin-left:30px"></i></a>
				</div>
				<table class="table" style="margin-right:250px">
					<thead>
						<tr>
							<th></th>
							<th style="display:none">글번호</th>
							<th>보낸이</th>
							<th>내용</th>
							<th>사진</th>
							<th>보낸날짜</th>
							<th>업로드현황</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="list" items="${list }">
							<tr>
								<td>
									<div class="form-check">
										<input class="form-check-input chkmes" type="checkbox" 
											name="option1" value="something">
									</div>
								</td>
								<td class="bno" style="display:none">${list.bno }</td>
								<td>${list.writer }</td>
								<td class="fullmessage" style="display:none">${list.message }</td>
								<td>
									<a href="#" class="message" >
									<c:choose>
										<c:when test="${list.rstat eq 'read'}">
											<c:choose>
												<c:when test="${list.message.length() > 3 }">
													${list.message.substring(0,3) }..
												</c:when>
												<c:otherwise>
													${list.message }
												</c:otherwise>
											</c:choose>
										</c:when>
										<c:when test="${list.rstat ne 'read' }">
											<c:choose>
												<c:when test="${list.message.length() > 3 }">
													<b>${list.message.substring(0,3) }..</b>
												</c:when>
												<c:otherwise>
													<b>${list.message }</b>
												</c:otherwise>
											</c:choose>
											
										</c:when>
									</c:choose>
										
									</a>
								</td>
								<td><img src="/create/displayImg?pic=${list.mespic }" width="100" height="150"></td>
								<td>${list.writedate }</td>
								<td>
									<c:choose>
										<c:when test="${list.uploadstat eq null }">
											<a type="button" class="btn btn-secondary btnupload" href="#" >업로드</a>
										</c:when>
										<c:when test="${list.uploadstat ne null }">
											업로드 완료
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