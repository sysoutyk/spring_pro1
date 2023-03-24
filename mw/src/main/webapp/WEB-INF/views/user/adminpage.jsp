<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/m_header.jsp" %>
<!-- style스타일 입니다. -->
<style>
.form_menu {
	font-size: 25px;
}
</style>
</head>
<!-- script입니다. -->
<script>
	$(document).ready(function(){
		$("#btnmodify").click(function(e){
			e.preventDefault();
			$("#frminfo").attr("method", "post"); 
			$("#frminfo").attr("action","/user/modify").submit();
		});
		$("#btnwithdraw").click(function(e){
			e.preventDefault();
			if (confirm("정말로 삭제하시겠습니까?")) {
				  txt = "네";
					$("#frminfo").attr("method", "post"); 
					$("#frminfo").attr("action", "/user/withdraw").submit();
				} else {
				  txt = "아니오";
				}
		
		});
	});
	</script>
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
							<button class="navbar-toggler" type="button"
								data-toggle="collapse" data-target="#navbarsExample04"
								aria-controls="navbarsExample04" aria-expanded="false"
								aria-label="Toggle navigation">
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
									<li class="nav-item"><a class="nav-link"
										href="/user/logout">logout</a></li>
								</ul>
							</div>
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
			<div class="col-md-12"></div>
		</div>
		<div class="row">
			<div class="col-md-3">
				<div class="row">
					<div class="col-md-12">
						<a href="#" class="form_menu">메인보드</a>
					</div>
					<br>
				</div>
			</div>
			<div class="col-md-9">
				<div class="col-md-12">
					<div class="row">

						<div class="col-md-6">
							<table class="table table-striped table-hover">
								<thead>
									<tr>
										<th>#</th>
										<th>Product</th>
										<th>Payment Taken</th>
										<th>Status</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>1</td>
										<td>TB - Monthly</td>
										<td>01/04/2012</td>
										<td>Default</td>
									</tr>
								</tbody>
							</table>
						</div>
						<div class="col-md-6">
							<table class="table">
								<thead>
									<tr>
										<th>#</th>
										<th>Product</th>
										<th>Payment Taken</th>
										<th>Status</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>1</td>
										<td>TB - Monthly</td>
										<td>01/04/2012</td>
										<td>Default</td>
									</tr>
									<tr class="table-active">
										<td>1</td>
										<td>TB - Monthly</td>
										<td>01/04/2012</td>
										<td>Approved</td>
									</tr>
									<tr class="table-success">
										<td>2</td>
										<td>TB - Monthly</td>
										<td>02/04/2012</td>
										<td>Declined</td>
									</tr>
									<tr class="table-warning">
										<td>3</td>
										<td>TB - Monthly</td>
										<td>03/04/2012</td>
										<td>Pending</td>
									</tr>
									<tr class="table-danger">
										<td>4</td>
										<td>TB - Monthly</td>
										<td>04/04/2012</td>
										<td>Call in to confirm</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

<%@ include file="../include/m_footer.jsp" %>