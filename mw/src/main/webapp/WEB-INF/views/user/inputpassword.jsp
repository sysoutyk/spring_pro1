<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/m_header.jsp" %>

<style>
.form_menu {
	font-size: 25px;
}
.active{
	color:gray;
}
</style>
<!-- script입니다. -->
<script>
	$(document).ready(function(){
		if("${checkPw}" == "wrong"){
			alert("비밀번호가 틀립니다.");
		}
// 		var path = window.location.href;
// 		console.log(path);
// 		var slashIndex = path.lastIndexOf("/");
// 		console.log(slashIndex);
// 		var prevpage = path.substring(slashIndex+1);
// 		console.log(prevpage);
// 		var nowpage;
// 		switch(prevpage){
// 		case mypage:
// 			nowpage = ("#mypage");
// 			console.log("mypage");
// 			break;
// 		case inputpassword:
// 			nowpage = ("#editinfo");
// 			console.log("editinfo");
// 			break;
// 		}
// 		  var activeCtg = $(".nav-link.active");
// 	   	  if (activeCtg.length == 1) {
// 	   		  activeCtg.removeClass("active");
// 	   	  }
// 		nowpage.addCalss("active");
// 	});
	
	</script>
	
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
	<div class="container-fluid" style="min-height: 800px;">
		<div class="row">
			<div class="col-md-3">
				<div class="row">
					<div class="col-md-12">
						<p class="form_menu" style="margin-top: 15px; color:black">${loginInfo.userid }
							님 반갑습니다.</p>
					</div>
				</div>
				<hr>
				<div class="row">
					<div class="col-md-12">
					<ul class=" navbar-nav mr-auto">
						<li class="nav-item"><a href="/user/mypage" class="form_menu nav-link " id="mypage">마이페이지</a></li>
						<li style="margin-left:30px">
							<a href="/user/mypage" > - 하객질문
								<span class="badge badge-dark">${unreadQues }</span>
							</a>
						</li>
						<li style="margin-left:30px;">
							<a href="/user/guestmes"> - 하객쪽지
								<span class="badge badge-dark">${unreadMes }</span>
							</a>
						</li>
					</ul>				
				</div>
					<div class="col-md-12">
						<ul class=" navbar-nav mr-auto">
						<li class="nav-item"><a href="/user/inputpassword" class="form_menu nav-link active" id="editinfo">개인정보수정</a></li>
					</ul>	
					</div>
					<br>
				</div>
			</div>

			<div class="col-md-9" id="checkPwdiv">
				<form action="/user/userinfo" method="post">
					<div class="form-group">
						<label for="exampleInputEmail1"
							style="font-size: 25px; margin-top: 150px;"> 비밀번호를 입력해주세요
						</label> <input type="password" class="form-control"
							style="width: 526.5px; margin-top: 15px;" id="userpw"
							name="userpw">
						<button type="submit" class="btn btn-primary" id="btnsubmit"
							style="margin-top: 20px; margin-left: 445px;">확인</button>
					</div>
				</form>
			</div>
		</div>
	</div>
<%@ include file="../include/m_footer.jsp" %>