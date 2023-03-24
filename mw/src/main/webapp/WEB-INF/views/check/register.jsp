<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../include/m_header.jsp" %>
<!-- 부트스트랩CDN -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css"
	integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2"
	crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"
	integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
	crossorigin="anonymous"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-ho+j7jyWK8fNQe+A12Hb8AhRq26LrZ/JpcUGGOn+Y7RsweNrtN/tE3MoK7ZeZDyx"
	crossorigin="anonymous"></script>

<script>
$(document).ready(function(){
	
	//체크박스 값 넘기기
	$("#btnSave").click(function(e){
		e.preventDefault();		
		
		//첫번째 체크박스여부
		var v_hall = $("#v_hall").is(':checked');
		console.log("v_hall:",v_hall);
		if(v_hall='true'){
			$("#v_hall").val("1");
		}else if(v_hall='false'){
			$("#v_hall").val("0");
		}
		
		console.log($("#v_hall").val());
		
		//두번째 체크박스여부
		var v_dress = $("#v_dress").is(':checked');	
		if(v_dress='true'){
			$("#v_dress").val("1");
		}else{
			$("#v_dress").val("0");
		}
// 		console.log($("#v_dress").val());
		
		//세번째 체크박스여부
		var v_photo = $("#v_photo").is(':checked');	
		if(v_photo='true'){
			$("#v_photo").val("1");
		}else{
			$("#v_photo").val("0");
		}
		
		//네번째 체크박스여부
		var v_beauty = $("#v_beauty").is(':checked');	
		if(v_beauty='true'){
			$("#v_beauty").val("1");
		}else{
			$("#v_beauty").val("0");
		}
		
		//다섯번째 체크박스여부
		var v_shoot = $("#v_shoot").is(':checked');	
		if(v_shoot='true'){
			$("#v_shoot").val("1");
		}else{
			$("#v_shoot").val("0");
		}
		
		//여섯번째 체크박스여부
		var v_card = $("#v_card").is(':checked');	
		if(v_card='true'){
			$("#v_card").val("1");
		}else{
			$("#v_card").val("0");
		}
		
		//일곱번째 체크박스여부
		var v_helper = $("#v_helper").is(':checked');	
		if(v_helper='true'){
			$("#v_helper").val("1");
		}else{
			$("#v_helper").val("0");
		}
		
		//여덟번째 체크박스여부
		var v_flower = $("#v_flower").is(':checked');	
		if(v_flower='true'){
			$("#v_flower").val("1");
		}else{
			$("#v_flower").val("0");
		}
		
		//아홉번째 체크박스여부
		var v_final = $("#v_final").is(':checked');	
		if(v_final='true'){
			$("#v_final").val("1");
		}else{
			$("#v_final").val("0");
		}
		
		//열번째 체크박스여부
		var v_end = $("#v_end").is(':checked');	
		if(v_end='true'){
			$("#v_end").val("1");
		}else{
			$("#v_end").val("0");
		}
		
		$("#frmCheck").submit();
		

	});
});



</script>

	
<style>
h3, h1 {
	margin : 20px;
	text-align:center;
}

.td_day{
	size:50px;
}

.td_todo{
	size:50px;
}

#btnTwo{
	text-align:right;
}

.table{
 padding : 30px 0;

}


</style>	
	
	

	<!-- end banner -->
	<div class="back_re">
		<div class="container">
			<div class="row">
				<div class="col-md-12">
					<div class="title">
						<h2>Wedding Planner</h2>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- our plane -->	

	
	<!-- 체크리스트 -->

	<div class="container-fluid">
		<div class="row">
			<div class="col-md-12">
				<div class="row">
					<div class="col-md-1"></div>
					<div class="col-md-10">
						<form role="form" action="/check/register" method="post" id="frmCheck">
						<table class="table">
							<h3>웨딩체크리스트</h3>
							<h1>Wedding CheckList</h1>
							<thead>
								<tr>
									<th width="150">DAY</th>
									<th width="300">LIST</th>
									<th>CONTENT</th>
								</tr>
							</thead>
							<tbody>
<!-- 								<tr> -->
<!-- 									<td class="td_day"> 본인 이름 </td> -->
<!-- 									<td><input type="text" id="userid" name="userid"></td> -->
<!-- 									<td>데이터 입력 테스트용 입니다.</td> -->
<!-- 								</tr> -->
								<tr>
									<td class="td_day"> D-180 </td>
									<td class="td_todo"><input type="checkbox" id="v_hall" name="v_hall"> 결혼예식장 알아보기 </td>
									<td> 예식일이 결정되면, 약 3~6개월 전부터 예식장 예약하는 것이 좋으며,
									 예식장 선택시에는 양가 하객수와 주차/교통편, 예식간격/홀 분위기, 가격을 고려하는 것이 권해드립니다.</td>
								</tr>
								<tr class="table-active">
									<td class="td_day"> D-120 </td>
									<td class="td_todo"><input type="checkbox" id="v_dress" name="v_dress"> 드레스샵 결정하기 </td>
									<td> 예식일 2~3개월 전에 예약하는 것이 좋으며, 웨딩촬영일/본식일정, 대여비용을 고려하는 것을 권해드리고,
									 샵 방문시 웨딩드레스에 어울리는 모습으로 방문하시거나 최신 트렌드를 미리 수집하고 가시는 것도 좋습니다. </td>
								</tr>
								<tr class="table-active">
									<td></td>
									<td class="td_todo" ><input type="checkbox" id="v_photo" name="v_photo"> 촬영 스튜디오 결정하기 </td>
									<td> 예식일 2개월 전에 예약하는 것이 좋으며, 스튜디오의 사진 분위기, 야외/실내 위주, 본식 영상 제공여부,
									사진 컷수를 고려하여 선택하는 것을 권해드립니다. </td>
								</tr>
								<tr class="table-active">
									<td></td>
									<td class="td_todo" ><input type="checkbox" id="v_beauty" name="v_beauty"> 헤어/메이크업샵 결정하기 </td>
									<td> 예식일 2개월 전에 예약하는 것이 좋으며, 예식장과의 거리, 헤어/메이크업샵의 포트폴리오를 고려하여 선택하는 것을
									권해드립니다.</td>
								</tr>

								<tr class="table-active">
									<td class="td_day" > D-50 </td>
									<td class="td_todo"><input type="checkbox" id="v_shoot" name="v_shoot"> 스튜디오 웨딩촬영하기 </td>
									<td> 사진 촬영후, 대략 35일 내외의 시간이 소요되므로 여유있게 준비하셔서 완성도 있는 앨범을
									받아보시길 바랍니다. </td>
								</tr>
								<tr>
									<td class="td_day"> D-30 </td>
									<td class="td_todo"><input type="checkbox" id="v_card" name="v_card"> 청첩장 주문하기 </td>
									<td> 결혼식에 참석할 사람들을 미리 선정해 청첩장을 주문해야 합니다. 완선된 청첩장은 약 1달~보름정도
									전부터는 하객분들께 발송하시길 바랍니다. </td>
								</tr>
								<tr>
									<td></td>
									<td class="td_todo"><input type="checkbox" id="v_helper" name="v_helper"> 주례/사회자/도우미 섭외하기 </td>
									<td> 결혼식의 주례자, 사회를 맡아줄 사회자, 축가단/축주단/들러리 등 결혼식 전반에 걸쳐 도움을 주는
									사람들을 선정하길 바랍니다. </td>
								</tr>
								<tr class="table-active">
									<td class="td_day" > D-7 </td>
									<td class="td_todo"><input type="checkbox" id="v_flower" name="v_flower"> 본식 드레스 가봉 및 부케 선정하기 </td>
									<td> 예식일 보름~1주일 전에 드레스 샵을 방문해, 최종적으로 드레스와 예복을 입어보고 확인하시길 바라며,
									드레스/예복과 예식장 분위기에 맞는 색과 디자인의 부케를 주문하시길 바랍니다. </td>
								</tr>
								<tr class="table-active">
									<td class="td_day" ></td>
									<td class="td_todo"><input type="checkbox" id="v_final" name="v_final"> 예식 최종확인하기 </td>
									<td> 예식장과 드레스, 본식 사진 촬영, 피로연, 메이크업/헤어샵에 전화 혹은 문의후 일정을 정확히
									확인하시길 바랍니다. </td>
								</tr>
								<tr>
									<td>D-day</td>
									<td class="td_todo"><input type="checkbox" id="v_end" name="v_end" > ♥ </td>
									<td> ♥ </td>
								</tr>
							</tbody>
						</table>
						<div id="btnTwo">
						<input type="button" value="인쇄하기" id="print" onclick="window.print()"/>
<!-- 						<input type="button" value="저장하기" id="btnSave"/> -->
						</div>
					</form>	
					</div>
					
					<div class="col-md-1"></div>
				</div>
			</div>
		</div>
	</div>








<%@ include file="../include/m_footer.jsp" %>