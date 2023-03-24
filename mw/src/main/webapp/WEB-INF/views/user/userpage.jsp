<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
      <meta charset="utf-8">
      <meta http-equiv="X-UA-Compatible" content="IE=edge">
      <!-- mobile metas -->
      <meta name="viewport" content="width=device-width, initial-scale=1">
      <meta name="viewport" content="initial-scale=1, maximum-scale=1">
      <!-- site metas -->
      <title>MW</title>
      <meta name="keywords" content="">
      <meta name="description" content="">
      <meta name="author" content="">
      <!-- bootstrap css -->
      <link rel="stylesheet" href="/css/bootstrap.min.css">
      <!-- style css -->
      <link rel="stylesheet" href="/css/style.css">
      <!-- Responsive-->
      <link rel="stylesheet" href="/css/responsive.css">
      <!-- fevicon -->
      <link rel="icon" href="/images/fevicon.png" type="image/gif" />
      <!-- Scrollbar Custom CSS -->
      <link rel="stylesheet" href="/css/jquery.mCustomScrollbar.min.css">
      <!-- Tweaks for older IEs-->
      <link rel="stylesheet" href="https://netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css">
      <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/fancybox/2.1.5/jquery.fancybox.min.css" media="screen">
      <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script><![endif]-->
	<!-- style스타일 입니다. -->
	<style>
	.form_menu{
	font-size:25px;
	}
	
	</style>
	</head>
   <!-- body -->
   <body class="main-layout inner_page">
      <!-- header -->
      <header class="full_bg">
         <!-- header inner -->
         <div class="header">
            <div class="container">
               <div class="row">
                  <div class="col-xl-3 col-lg-3 col-md-3 col-sm-3 col logo_section">
                     <div class="full">
                        <div class="center-desk">
                           <div class="logo">
                              <a href="/board/main">MW</a>
                           </div>
                        </div>
                     </div>
                  </div>
                  <div class="col-xl-9 col-lg-9 col-md-9 col-sm-9">
                     <nav class="navigation navbar navbar-expand-md navbar-dark ">
                        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarsExample04" aria-controls="navbarsExample04" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                        </button>
                        <div class="collapse navbar-collapse" id="navbarsExample04">
								<ul class="navbar-nav mr-auto">
									<li class="nav-item "><a class="nav-link"
										href="/board/main">Home</a></li>
									<li class="nav-item"><a class="nav-link"
										href="service.html">Planner</a></li>
									<li class="nav-item"><a class="nav-link" href="blog.html">Template</a>
									</li>
									<li class="nav-item"><a class="nav-link"
										href="contact.html">QnA</a></li>
									<li class="nav-item"><a class="nav-link"
										href="contact.html">Review</a></li>
								</ul>
							</div>
                        <ul class="search">
                           <li><a href="Javascript:void(0)"><i class="fa fa-search" aria-hidden="true"></i></a></li>
                        </ul>
                     </nav>
                  </div>
               </div>
            </div>
         </div>
         <!-- end header inner -->
         <!-- end header -->
         <!-- banner -->
      </header>
      <!-- table -->
      <div class="container-fluid">
	<div class="row">
		<div class="col-md-12">
		</div>
	</div>
	<div class="row">
		<div class="col-md-3">
			<div class="row">
				<div class="col-md-12">
				<p class="form_menu" style="margin-top: 15px;"> ${vo.userid}님 반갑습니다.</p>
				</div>
			</div>
			<hr>
			<div class="row">
				<div class="col-md-12">
				<a href="#" class="form_menu">MYPAGE로 가기</a>
				</div>
				<br>
			</div>
			<div class="row">
				<div class="col-md-12">
				<a href="#" class="form_menu">MY회원정보or플래너</a>
				</div>
				<br>
			</div>
			<div class="row">
				<div class="col-md-12">
				<a href="/user/inputpassword" class="form_menu">개인정보수정</a>
				</div>
				<br>
			</div>
			<div class="row">
				<div class="col-md-12">
				<a href="#" class="form_menu">주소록</a>
				</div>
				<br>
			</div>
			<hr>
			<div class="row">
				<div class="col-md-12">
				<a href="#" class="form_menu">회원탈퇴</a>
				</div>
				<br>
			</div>
		</div>
		<div class="col-md-9">
			<div class="jumbotron">
				<p>
				</p>
				<p>
				</p>
			</div>
		</div>
	</div>
</div>
      <!--  footer -->
      <footer>
         <div class="footer">
            <div class="copyright" style="margin-top:500px;">
               <div class="container">
                  <div class="row">
                     <div class="col-md-8 offset-md-2">
                        <p>© 2019 All Rights Reserved. <a href="https://html.design/"> Free Html Templates</a></p>
                     </div>
                  </div>
               </div>
            </div>
         </div>
      </footer>
      <!-- end footer -->
      <!-- Javascript files-->
      <script src="/js/jquery.min.js"></script>
      <script src="/js/bootstrap.bundle.min.js"></script>
      <script src="/js/jquery-3.0.0.min.js"></script>
      <!-- sidebar -->
      <script src="/js/jquery.mCustomScrollbar.concat.min.js"></script>
      <script src="/js/custom.js"></script>
   </body>
</html>