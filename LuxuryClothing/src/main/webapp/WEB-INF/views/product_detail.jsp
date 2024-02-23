<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<%@ page import="com.smhrd.products.model.ProductsDTO"%>

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>상품 상세 정보</title>

<!-- 필요한 CSS 파일들을 여기에 추가 -->

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>


</head>

<body>

	<div style="margin-top: 100px"></div>

	<%@include file="header.jsp"%>
	
	<div class="container">

        <div class="product-image">
            <!-- 상품 이미지 -->
            <img src="${path}/resources/assets/images/products/${prod_mainImage.file_name}">
        </div>
        
        <c:forEach var="arr" items="${prod_subImages}" varStatus="status">
        	<img src="${path}/resources/assets/images/products/${arr.file_name}">
        </c:forEach>
        
        <div class="product-details">
        	<%-- <c:set var="product" value="<%=request.getAttribute("product_detail")%>"></c:set> --%>
        	
			<%--
        	ProductsDTO dto = (ProductsDTO)(request.getAttribute("prod_detail")); 
        	
        	String prod_name = dto.getProd_name();
        	String prod_price = dto.getProd_price();
        	String prod_category = dto.getProd_category();
        	String prod_desc = dto.getProd_desc();
        	String prod_option = dto.getProd_option();
        	String prod_status = dto.getProd_status();
        	
        	%> --%>
			<!-- 형변환 필요 object type이기 때문에 -->
			<c:set var="prod" value="${sessionScope.prod_detail}" />
			<%-- <c:set var="user" value="${sessionScope.user_result}"/> --%>
		
       	<form action="payment.do" method="get" id="payment">
            <h1>${prod.prod_name}</h1>
            <%-- <h1><%= prod_name %></h1>
            <h3><%= prod_price %></h1> --%>
            <hr>
            <div class="product-info">
                <div>
                    <span>가격 :</span>
                    <span>${prod.prod_price}</span>
                </div>
                <div>
                    <span>카테고리 :</span>
                    <span>${prod.prod_category}</span>
                </div>
                <br>
                <div>
                    <span>상세 정보 :</span>
                    <span>${prod.prod_option}</span>
                </div>
                <br>
                <div>
                    <span>제품 상태 :</span>
                    <span>${prod.prod_desc}</span>
                </div>
                <br>
                <div>
                    <span>외부상태</span>
                    <br>
                    <div class="condition">
                        <span>신품/</span>
                        <span>미사용</span>
                    </div>
                </div>
                <br>
                <div>
                    <span>내부상태</span>
                    <br>
                    <div class="condition">
                        <span>신품/</span>
                        <span>미사용</span>
                    </div>
                </div>
                <br>
                <div>
                    <span>부속품</span>
                    <span>더스크백, 케이스</span>
                </div>
                <br>
                <div>
                    <span>색상</span>
                    <span>블랙</span>
                </div>
            </div>
            <hr>
         </form>
         
            <div class="buttons">
                <button id="buyNow">바로 구매</button>
                <button class="cartPickList">장바구니</button>
                <button class="add-to-wishlist">찜하기</button>
            </div>
        </div>
    </div>
    
    <form action="cartPickList.do" id="insertForm" name="insertForm">
    	<input type="hidden" id="user_id" name="user_id" value="${user_result.user_id}">
    	<input type="hidden" id="prod_id" name="prod_id" value="${prod.prod_id}">
    </form>
		
    <%@include file="footer.jsp"%>
    
    <script type="text/javascript">
       var user = "${user_result}";
      
       <!-- 세션에 저장된 user_result 가져오기 -->
  
		$("#buyNow").on("click", function(){
			console.log("event")
			
			if(user == null || user == ""){
				window.location.href="loginpage.do"
			}else{
				$("#payment").submit();
			}
			
			
		});
		
		// 장바구니 버튼 클릭시 장바구니 상품 담기
		$(".cartPickList").on("click", function(){
			console.log("event")
			
			if(user == null || user == ""){
				window.location.href="loginpage.do"
			}else{
				// form 태그 실행
			 	var form = document.getElementById('insertForm');
			 	form.submit();
			}
		});
		
    	</script>

</body>
</html>