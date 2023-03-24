<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/m_header.jsp" %>
<script>
	$(document).ready(function() {
		var checkId = "";
		var inputId = "";
		$("#btncheckId").click(function() {
			console.log("중복 체크 클릭 확인");
			inputId = $("#userid").val();
			console.log("입력한 아이디 값", inputId);
			var url = "/user/isExistId"
			var sData = {
				"inputId" : inputId
			}
			$.get(url, sData, function(rData) {
				if (inputId != "" && rData == "false") {
					alert("아이디 사용 가능");
					$("#btncheckId").attr("value", inputId);
				} else {
					alert("아이디 사용 불가능");
				}
			});
		});
	
		$("#btncheckUrl").click(function(e){
			e.preventDefault();
			console.log("url중복확인");
			var inputUrl = $("#url").val();
			console.log("입력한 url: " + inputUrl);
			var url_chk = "/user/isExistUrl";
			var sData_chkurl = {
					"url" : inputUrl
			};
			$.get(url_chk, sData_chkurl, function(rData){
				console.log(rData);
				if(rData == false){
					alert("url 사용 가능");
					$("#btncheckUrl").attr("data-url", inputUrl);
				}else{
					alert("이미 사용중인 url입니다");
				}
			});
		}); 
		
		// 글자색 추가 + 코드 완성
		$("#chkuserpw").keyup(function() {
			var pw1 = $("#userpw").val();
			var pw2 = $(this).val();
			if (pw1 == pw2) {
				$("#pwcheckok").css("color", "blue");
				$("#pwcheckok").text("비밀번호가 같습니다.");
			} else {
				$("#pwcheckok").css("color", "red");
				$("#pwcheckok").text("비밀번호가 일치하지 않습니다.");
			}
		});
		
		$("#btnsignin").click(function(e) {
			checkId = $("#btncheckId").val();
			inputId = $("#userid").val();
			if (checkId == inputId) {
				console.log("true");
			} else {
				event.preventDefault();
				console.log("false");
				alert("아이디 중복 체크를 해주세요");
			}
		});
		
		// 유효성 검사 추가
		$("#frmRegister").submit(function(){
			if($("#userpw").val().trim() == ""){
				alert("비밀번호를 입력해주세요.");
				$("#userpw").focus();
				return false;
			} else if($("#username").val().trim() == ""){
				alert("이름을 입력해주세요.");
				$("#username").focus();
				return false;
			} else if($("#email").val().trim() == ""){
				alert("이메일을 입력해주세요.");
				$("#email").focus();
				return false;
			} else if($("#phonenum").val().trim() == ""){
				alert("전화번호를 입력해주세요.");
				$("#phonenum").focus();
				return false;
			} else if($("#userpw").val().trim() != $("#chkuserpw").val().trim()){
				alert("비밀번호가 일치하지 않습니다.");
				return false;
			}else if($("#url").val().trim() == ""){
				alert("url 이름을 입력해주세요");
				$("#url").focus();
				return false;
			}
		});
		
		
	});
</script> 	

	<div class="back_re">
		<div class="container">
			<div class="row">
				<div class="col-md-12">
					<div class="title">
						<h2>회원가입</h2>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--  contact -->

	<!-- new template -->
	<div class="container-fluid" style="padding:30px">
		<div class="row">
			<div class="col-md-4"></div>
			<div class="col-md-4">
				<form id="frmRegister" action="/user/register_run" method="post">
					<div class="form-group">
						<label for="userid">아이디&nbsp<i class="fa fa-asterisk" aria-hidden="true" style="color:red; font-size:8px"></i></label> <input type="text"
							class="form-control" id="userid" placeholder="아이디" name="userid">
						<button type="button" class="btn btn-primary btn-sm"
							id="btncheckId" style="margin-top:20px">아이디 중복 확인</button>
					</div>
					<div class="form-group">
						<label for="userpw">비밀번호&nbsp<i class="fa fa-asterisk" aria-hidden="true" style="color:red; font-size:8px"></i></label> <input type="password"
							class="form-control" id="userpw" placeholder="비밀번호" name="userpw">
					</div>
					<div class="form-group">
						<label for="chkuserpw">비밀번호 확인&nbsp<i class="fa fa-asterisk" aria-hidden="true" style="color:red; font-size:8px"></i></label> <input type="password"
							class="form-control" id="chkuserpw" placeholder="비밀번호 확인">
						<p style="font-size: 12px" id="pwcheckok"></p>
					</div>
					<div class="form-group">
						<label for="username">이름&nbsp<i class="fa fa-asterisk" aria-hidden="true" style="color:red; font-size:8px"></i></label> <input type="text"
							class="form-control" id="username" placeholder="이름"
							name="username">
					</div>
					<div class="form-group">
						<label for="email">이메일&nbsp<i class="fa fa-asterisk" aria-hidden="true" style="color:red; font-size:8px"></i></label> <input type="email"
							class="form-control" id="email" placeholder="이메일" name="email">
					</div>
					<div class="form-group">
						<label for="phonenum">전화번호&nbsp<i class="fa fa-asterisk" aria-hidden="true" style="color:red; font-size:8px"></i></label> <input type="tel"
							class="form-control" id="phonenum" name="phonenum"
							placeholder="'-'빼고 입력해주세요.">
					</div>
					<div class="form-group">
						<label for="url">Url 이름</label><i class="fa fa-asterisk" aria-hidden="true" style="color:red; font-size:8px"></i><br>
<!-- 						<input type="text" value="/board/pageaddr" class="form-control" readonly> -->
						<input type="text" class="form-control" id="url" name="url" placeholder="예시) kim&lee2023">
						<a type="button" class="btn btn-primary btn-sm"
							id="btncheckUrl" style="margin-top:20px" href="#">Url 중복 확인</a>
							
					</div>
					<button type="submit" id="btnsignin" class="btn btn-primary">가입하기</button>
				</form>
			</div>
			<div class="col-md-4"></div>
		</div>
	</div>
	<!-- //new template -->
	<!-- end contact -->
<%@ include file="../include/m_footer.jsp" %>