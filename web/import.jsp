<%-- 
    Document   : import
    Created on : Mar 20, 2013, 10:23:52 PM
    Author     : Bach Ngoc Son
--%>
<%@page import="org.jsoup.Connection"%>
<%@page import="org.jsoup.select.Elements"%>
<%@page import="org.jsoup.nodes.Document"%>
<%@page import="org.jsoup.Jsoup"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Import</title>
    </head>
    <body>
        <form method="POST" name="import_form">
            <label>Nhập vào đường dẫn đến trang web muốn truy xuất dữ liệu<br/>Ví dụ : <a href="http://24h.com.vn/am-thuc-c460.html">http://24h.com.vn/am-thuc-c460.html</a></label>
            <br/>
            <input size="100" type="text" name="import_url"/>
            <input type="submit" value="Phân tích"/>
        </form>
    </body>
    <%
        if (request.getMethod() == "POST") {
            request.setCharacterEncoding("UTF-8");
            String import_url = request.getParameter("import_url");
            out.println("Bạn đang truy xuất thông tin từ đường dẫn : <a href=\"" + import_url + "\">" + import_url + "</a>");
            Document doc;
            try {
                doc = Jsoup.connect(import_url).timeout(10000).get();
                Elements languages = doc.select(".tin-anh");
                out.println(languages);
            } catch (Exception e) {
                out.println("An error occurred : " + e.getClass().getSimpleName() + " : " + e.getMessage());
            }
        }
    %>
</html>
