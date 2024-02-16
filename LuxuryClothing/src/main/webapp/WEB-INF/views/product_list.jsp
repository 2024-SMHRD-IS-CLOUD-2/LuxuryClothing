<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- 복붙코드 jsp : header 불러오기 ! ***** -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- 복붙코드 제이쿼리 : 제이쿼리 불러오기 ! ***** -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<link rel="stylesheet"
	href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>

<style type="text/css">
	.product_table{
		margin-left:auto;
		margin-right:auto;
		text-align: center;
	}
	.img{
		width: 200px;
		margin-left: 20px;
		margin-top: 60px;
	}
</style>
</head>

<body>
	<!-- 복붙코드 jsp : header 불러오기 ! ***** -->
	<%@include file="header.jsp"%>

	<form action="product_search.do">
		<!-- 여백용 공간 -->
		<div class="content_box">
			<div class="search_box">
				<h3 class="search_box">상품 검색</h3>
				<select class="search_box" name="rating" id="rating">
					<option value="전체 등급">전체 등급</option>
					<option value="A">A</option>
					<option value="B">B</option>
					<option value="C">C</option>
					<option value="D">D</option>
				</select> <select class="search_box" name="kind" id="kind">
					<option value="상품 종류">상품 종류</option>
					<option value="모자">모자</option>
					<option value="상의">상의</option>
					<option value="하의">하의</option>
					<option value="악세서리">악세서리</option>
				</select>

				<!-- 구매 희망가격 슬라이더 STR -->
				<div class="search_box">
					<label for="amount">구매 희망가격(원)</label> 
					<input type="text" id="amount" name="amount">
					<div>
						<div id="slider-range" class="slider-range"></div>
					</div>
				</div>
				<!-- 구매 희망가격 슬라이더 END -->
				<input class="search_box" type="text" id="searchInput"
					name="searchInput" placeholder="검색어를 입력하세요">
				<button onclick="searchProducts()">검색</button>
				<button id="reset">초기화</button>
				<div id="searchResults"></div>
			</div>
		</div>
	</form>


	<!-- ***** Men Area Starts ***** -->
		<div class="container">
			<div class="row">
				<div class="col-lg-6">
					<div class="section-heading">
						<h2>탑텐?</h2>
						<span>개쩌는 인기상품 10가지를 만나보세요</span>
					</div>
				</div>
			</div>
		</div>


		<table class="product_table">
		<c:forEach var="result" items="${result}" varStatus="status">
			<c:if test="${status.index % 5 == 0}">
			  	<tr>
			</c:if>
				    <th>
				    	<td>
					    	<a href="#">
							    <img class="img" src="${path}/resources/assets/images/men-01.jpg" ><br>
							    ${result.prod_grade} 
							    ${result.prod_name}<br>
							    ${result.prod_price}<br>
					    	</a>
				    	</td>
				    </th>
			<c:if test="${status.index % 5 == 4 || status.last}">
			  	</tr>
			</c:if>
		</c:forEach>
		</table>


		<!-- ***** Men Area Ends ***** -->

		<script>
 	<!-- 구매 희망가격 슬라이더 STR -->
	$( function() {
		$( "#slider-range" ).slider({
			range: true,
			min: 0,
			max: 5000000,
			values: [ 0, 5000000 ],
			step: 10000, // 증가 값 설정
			slide: function( event, ui ) {
			  $( "#amount" ).val( ui.values[ 0 ] + " ~ " + ui.values[ 1 ] );
			}
		});
		
		$( "#amount" ).val( $( "#slider-range" ).slider( "values", 0 ) +
		" ~ " + $( "#slider-range" ).slider( "values", 1 ) );
	});
	
	  
	<!-- 검색기록 남겨두기 STR -->
	 $(document).ready(function() {
		 
		// 이전 검색 기록 세팅하기
		// 1) 세션의 데이터 가져오기
        let prod_grade = "${serch.prod_grade}";
        let prod_category = "${serch.prod_category}";
        let prod_priceMin = "${serch.prod_priceMin}";
        let prod_priceMax = "${serch.prod_priceMax}";
        let prod_name = "${serch.prod_name}";
		console.log(prod_grade);
		console.log(prod_category);
		console.log(prod_priceMin);
		console.log(prod_priceMax);
		console.log(prod_name);
		
		// 2) 태그에 이전 검색 기록 대입하기(값 넣어주기)
		if (prod_grade == null && prod_category == null && prod_priceMin == null && prod_priceMax == null && prod_name == null) {
			// 첫 페이지 시작시 검색 값 세팅
			$('#rating').val("전체 등급").prop("selected",true);
			$('#kind').val("상품 종류").prop("selected",true);
			$('#amount').val('0 ~ 5000000');
			$('#searchInput').val("");
			console.log("검색 데이터 초기화");
		} else {
			$('#rating').val(prod_grade).prop("selected",true);
			$('#kind').val(prod_category).prop("selected",true);
			$('#amount').val(prod_priceMin + ' ~ ' + prod_priceMax);
			$('#searchInput').val(prod_name);
			console.log("검색 이전 데이터 세팅");
		}

		// 리셋버튼 누르면 초기화 시킴
		$("#reset").on("click", function () {
			$('#rating').val("전체 등급").prop("selected",true);
			$('#kind').val("상품 종류").prop("selected",true);
			$('#amount').val('0 ~ 5000000');
			$('#searchInput').val("");
		});
		
	 });   
	 
	 
 	</script>


		<!-- 복붙코드 jsp : footer 불러오기 ! ***** -->
	<%@include file="footer.jsp"%>
</body>
</html>