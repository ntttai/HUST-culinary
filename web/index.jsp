<%-- 
    Document   : index
    Created on : Mar 6, 2013, 11:25:31 AM
    Author     : Bach Ngoc Son
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Apache Jena</title>
    </head>
    <body>
        <h1>Welcome to Jena Project!</h1>
        <form action="search_result.jsp" method="POST" name="query" >
            <label>Enter Food Type : </label>
            <input type="text" name="query"/>
            <input type="submit" name="Submit"/>
        </form>
    </body>
</html>
