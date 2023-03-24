<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/m_header.jsp" %>
<style>
.a{
	height:500px;
}
.contact{
 min-height: 700px;
}
</style>
    <script>
      $(document).ready(function(){
    	var register_result = "${register_result}";
    	console.log(register_result);
    	if(register_result == "success"){
    		alert("회원가입되었습니다. 로그인해주세요.");
    	}
    	  
    	if("${update}"=="success"){
    		alert("정보가 변경되었습니다. 다시 로그인해주세요");	
    	}
    	if("${loginResult}" =="fail"){
   			alert("아이디 혹은 비밀번호가 맞지 않습니다.");
    	}
    	if("${loginResult}" =="withdraw"){
       		alert("탈퇴한 회원입니다.");
       	}
    	
    	
      });
      </script>
      <!-- end banner -->
      <div class="back_re">
         <div class="container">
            <div class="row">
               <div class="col-md-12">
                  <div class="title">
                     <h2>LOGIN</h2>
                  </div>
               </div>
            </div>
         </div>
      </div>
      <!--  contact -->
      <div class="contact" style="padding-top:80px">
         <div class="container">
            <div class="row d_flex">
            <div class="col-md-3"></div>
               <div class="col-md-6">
                  <form id="request" class="main_form" action="/user/login" method="post">
                     <div class="row">
                        <div class="col-md-12 ">
                           <input class="contactus" placeholder="아이디" type="text" name="userid"> 
                        </div>
                        <div class="col-md-12">
                           <input class="contactus" placeholder="비밀번호" type="password" name="userpw">                          
                        </div>
                       	<div class="col-md-3"><button type="submit" class="send_btn">로그인</button></div>
                       	<div class="col-md-3"><a type="button" class="send_btn" style="text-align:center" href="/user/register">회원가입</a></div>
                     </div>
                  </form>
               </div>
               
            </div>
         </div>
      </div>
      <!-- end contact -->
<%@ include file="../include/m_footer.jsp" %>