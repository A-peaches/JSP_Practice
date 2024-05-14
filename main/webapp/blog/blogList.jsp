<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*"%>

<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<head>
	<title>블로그 목록</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
	<link rel="StyleSheet" type="text/css" href="../CSS.css">
	<style>
		h3 {
			font-weight : bold;
		}
		* {
			font-family : "Gowun Batang";
			text-align : center;
		}
	</style>
	<style>
		td {
			padding : 5px 5px 5px 5px;
		}
	</style>
<body onload="initialLoad()">
	<h3 class="my-3">블로그 목록</h3><hr>
	<div style="width : 80%; margin:auto;">
		<div class="my-3 d-flex justify-content-left">
		<input type="text" id="query" class="form-control" value="여행" style="width:20%">
		<input type="button" id="searchBtn" class="btn btn-success mx-3" value="검색"/>
		</div>
	</div>
	<table id="blogList" class="table table-striped table-hover" style="width:80%; margin:auto;">
	<tbody>
		<tr>
			<td>사진</td>
			<td>블로그이름</td>
			<td>내용</td>
			<td>날짜</td>
		</tr>
	</tbody>
	</table>
	<div class="my-3">
		<input type="button" id="prevBtn" value="이전" class="btn btn-secondary" />
		<span id="currentPage" class="mx-3">1</span>
		<input type="button" id="nextBtn" value="다음" class="btn btn-secondary" />
	</div>
	<script type = "text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"
	intergrity="sha256-QWo7LDvxnWT2tbbQ97853yJnYU3WhH/C8ycbRAkjPDc="
	crossorigin="anonymous"></script>
	<script type = "text/javascript">
	
	$(document).ready(function() {
	    var currentPage = 1; // 초기 페이지
	    var totalPages = 50; // 총 페이지 수, 실제로는 서버에서 받아와야 하는 값
	    var query = $("#query").val() || "여행"; // 초기 검색어 설정
	    
	    loadPage(currentPage); // 페이지 로딩 시 최초 검색 수행

	    $('#prevBtn').click(function() {
	        if (currentPage > 1) {
	            currentPage--;
	            $('#currentPage').text(currentPage);
	            loadPage(currentPage);
	        }
	    });

	    $('#nextBtn').click(function() {
	        if (currentPage < totalPages) {
	            currentPage++;
	            $('#currentPage').text(currentPage);
	            loadPage(currentPage);
	        }
	    });

	    $('#searchBtn').click(function() {
	        query = $("#query").val(); // 검색 버튼 클릭 시 새로운 검색어로 업데이트
	        if (!query) {
	            alert("검색어를 입력해주세요!");
	            return;
	        }
	        currentPage = 1; // 검색어가 변경되면 첫 페이지로 리셋
	        loadPage(currentPage);
	    });
	});

	function loadPage(page) {
		var query = $("#query").val()
		
	    $.ajax({
	        method: "GET",
	        url: "https://dapi.kakao.com/v2/search/blog",
	        data: {
	            query: query, // 현재 검색어 사용
	            page: page,
	            size: 10
	        },
	        headers: { Authorization: "KakaoAK MyAppKey" },
	        success: function(response) {
	            console.log(response);
	            let $tableBody = $('#blogList tbody');
	            $tableBody.empty();
				
	            response.documents.forEach(function(doc) {
	                let thumbnail = doc.thumbnail ? doc.thumbnail : "https://via.placeholder.com/100";
	                var $row = $('<tr>');
					$row.append($('<td>').html('<a href="'+doc.url+'"><img src="'+thumbnail+'" alt="Thumbnail" style="width:100px"></a></td>'));
	                $row.append($('<td>').text(doc.blogname));
	                $row.append($('<td>').html(doc.contents));
	                $row.append($('<td>').text(new Date(doc.datetime).toLocaleString()));
	                $tableBody.append($row);
	            });
	        },
	        error: function(error) {
	            console.log("Failed: ", error);
	        }
	    });
	}
	
	function initialLoad() {
	    $.ajax({
	        method: "GET",
	        url: "https://dapi.kakao.com/v2/search/blog",
	        data: { query: "여행" }, // 초기 쿼리로 '여행' 설정
	        headers: { Authorization: "KakaoAK MyAppKey" }
	    })
	    .done(function(res){ //검색 결과 담아줌 
			console.log(res);
			let $tableBody = $('#blogList tbody');
			$tableBody.empty();
			
			res.documents.forEach(function(doc) {
				let thumbnail = doc.thumbnail ? doc.thumbnail :"https://via.placeholder.com/100";
				var $row = $('<tr>');
				$row.append($('<td>').html('<a href="'+doc.url+'"><img src="'+thumbnail+'" alt="Thumbnail" style="width:100px"></a></td>'));
                $row.append($(`<td style="font-weight : bold">`).text(doc.blogname));
                $row.append($('<td>').html(doc.contents));
                $row.append($('<td>').text(doc.datetime));
                $tableBody.append($row);
			})
		})
		.fail(function(jpXHR, textStatus){
			console.log("Failed : " + textStatus);
		});
	}
	</script>
	<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
	
</body>
</html>