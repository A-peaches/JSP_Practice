<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="com.cal.db.*" %>

<% request.setCharacterEncoding("UTF-8"); 
   int pageInt = 1;
   int itemsPerPage = 10; // 페이지 당 항목 수
   String pageStr = request.getParameter("page");
   if (pageStr != null && !pageStr.isEmpty()) {
	   pageInt = Integer.parseInt(pageStr);
   }
   ArrayList<CalBean> calList = (ArrayList<CalBean>) request.getAttribute("calList");
   int totalItems = calList.size();
   int totalPages = (int) Math.ceil(totalItems / (double) itemsPerPage);

   int startItem = (pageInt - 1) * itemsPerPage;
   int endItem = startItem + itemsPerPage;
   if (endItem > totalItems) endItem = totalItems;
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>계산 기록</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <link rel="stylesheet" type="text/css" href="./CSS.css">
</head>
<body>
    <h3 class="fw-bold my-3">📑 계산 기록</h3>
    <hr>
    <table class="table table-hover w-50">
        <tr>
            <td>No</td>
            <td>Date</td>
            <td>Cause</td>
            <td>Result</td>
        </tr>
        <% for (int i = startItem; i < endItem; i++) {
            CalBean calBean = calList.get(i); %>
            <tr>
                <td><%= calBean.getCal_no() %></td>
                <td><%= calBean.getCal_date() %></td>
                <td><%= calBean.getCal_op() %></td>
                <td><%= calBean.getCal_result() %></td>
            </tr>
        <% } %>
    </table>
    <!-- 페이지네이션 -->
    <nav class="d-flex justify-content-center">
        <ul class="pagination">
            <% for (int i = 1; i <= totalPages; i++) { %>
                <li class="page-item <%= i == pageInt ? "active" : "" %>">
                    <a class="page-link" href="?page=<%= i %>"><%= i %></a>
                </li>
            <% } %>
        </ul>
    </nav>
    <input type="button" class="btn btn-warning my-3" onclick="window.location.href='./Calculator.cl'" value="이전"/>
</body>
</html>
