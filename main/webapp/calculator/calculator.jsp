<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*"%>

<% request.setCharacterEncoding("UTF-8"); %>
<% 
	String result = "";
	if (request.getAttribute("result") != null ) {
		result = (String)request.getAttribute("result");
	} 
%>
<!DOCTYPE html>
<head>
	<title>계산기</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
	<link rel="StyleSheet" type="text/css" href="./CSS.css">
<script>
	function display(op) {
		let result = document.getElementById("result");
		let rs = result.value;
		result.value = rs + op;
	}
	
	function check(){
	    let result = document.getElementById("result");
	    let rs = result.value;
	    let opCnt = 0; // 연산자 개수
	    let numCnt = 0; // 숫자 개수

	    for(let i = 0; i < rs.length; i++) {
	        if (!isNaN(rs.charAt(i)) && rs.charAt(i) !== ' ') { // 숫자일 경우
	            numCnt++;
	        } else if ("+-*/".includes(rs.charAt(i))) { // 연산자일 경우
	            opCnt++;
	        }
	    }

	    // 연산자가 2개 이상일 경우
	    if (opCnt > 1) {
	        alert("하나의 연산자만 사용 가능합니다!");
	        result.value = ""; // 결과 필드 초기화
	        return false;
	    }

	    // 올바른 식인지 확인 (숫자가 최소 2개, 연산자는 1개 필요)
	    if (numCnt < 2 || opCnt !== 1) {
	        alert("올바른 식을 입력해주세요!");
	        result.value = ""; // 결과 필드 초기화
	        return false;
	    }

	    return true;
	}

	
	function remove() {
		<% session.removeAttribute("result"); %>
		let result = document.getElementById("result");
		result.value = "";
	}

	
</script>
</head>
<body>
<h3 class="fw-bold my-3">🧮 계산기</h3>
<hr>
<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-4">
            <h6 class="text-center">⚠️양수만 계산이 가능하며, 연산자는 하나만 가능합니다.</h6>
            <h6 class="text-center">결과 출력 후 다시 계산은 가능합니다.</h6><br>
            <form action="./CalResult.cl" method="post" onsubmit="return check()">
            <table class="table table-bordered">
                <tr>
                    <td colspan="3">
                        <input type="text" class="form-control" id="result" name = "result" 
                        value ="<%=result %>" readonly>
                    </td>
                    <td>
                        <input type="button" onclick="remove()" class="btn btn-danger" value='C'></button>
                    </td>
                </tr>
                <tr>
                    <td><input type="button" class="btn btn-light" onclick="display('1')" value='1' ></button></td>
                    <td><input type="button" class="btn btn-light" onclick="display('2')" value='2'></button></td>
                    <td><input type="button" class="btn btn-light" onclick="display('3')" value='3'></button></td>
                    <td><input type="button" class="btn btn-secondary" onclick="display('+')" value='+'></button></td>
                </tr>
                <tr>
                    <td><input type="button" class="btn btn-light" onclick="display('4')" value='4'></button></td>
                    <td><input type="button" class="btn btn-light" onclick="display('5')" value='5'></button></td>
                    <td><input type="button" class="btn btn-light" onclick="display('6')" value='6'></button></td>
                    <td><input type="button" class="btn btn-secondary" onclick="display('-')" value='-'></button></td>
                </tr>
                <tr>
                    <td><input type="button" class="btn btn-light" onclick="display('7')" value='7'></button></td>
                    <td><input type="button" class="btn btn-light" onclick="display('8')" value='8'></button></td>
                    <td><input type="button" class="btn btn-light" onclick="display('9')" value='9'></button></td>
                    <td><input type="button" class="btn btn-secondary" onclick="display('*')" value='*'></button></td>
                </tr>
                <tr>
                    <td><input type="button" class="btn btn-light" onclick="display('0')" value='0'></button></td>
                    <td><input type="button" class="btn btn-light" onclick="display('.')" value='.'></button></td>
                    <td><input type="submit" class="btn btn-success" value='='></button></td>
                    <td><input type="button" class="btn btn-secondary" onclick="display('/')" value='/'></button></td>
                </tr>
            </table>
            </form>
            <input type="button" onclick="window.location.href='./CalList.cl'" value="계산 기록 보러가기"
            class="btn btn-warning my-3"/>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
	
</body>
</html>