<%-- 
    Document   : viewStore
    Created on : Mar 16, 2013, 10:24:25 PM
    Author     : Bach Ngoc Son
--%>

<%@page import="java.util.Iterator"%>
<%@page import="com.hp.hpl.jena.rdf.model.*"%>
<%@page import="com.hp.hpl.jena.ontology.OntModel"%>
<%@page import="Query.Query"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
    String storeName = request.getParameter("storeName");
    OntModel model = Query.getOntologyModel(Query.inputFileName);
    Resource store = model.getResource(Query.ontologyNamespace + storeName);
    Property name = model.getProperty(Query.ontologyNamespace, "Name");
    Property address = model.getProperty(Query.ontologyNamespace, "Location");
    Property description = model.getProperty(Query.ontologyNamespace, "Description");
    Property website = model.getProperty(Query.ontologyNamespace, "website");
    String s = "Hiện nay chưa có thông tin này.";
    Statement temp;
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><% out.println(storeName.replace('_', ' '));%></title>
    </head>
    <body>
        <h1>Thông tin về <% out.println(storeName.replace('_', ' '));%> :</h1>
        <h2>Tên : <% out.println(store.getRequiredProperty(name).getObject());%> </h2>
        <h2>Địa chỉ : <% out.println(store.getRequiredProperty(address).getObject());%> </h2>
        <% temp = store.getProperty(description);%>
        <h2>Mô tả : <% if (temp == null) {
                out.println(s);
            } else {
                out.println(store.getRequiredProperty(description).getObject().toString());
            }%> </h2>
            <% temp = store.getProperty(website);%>
        <h2>Website : <% if (temp == null) {
                out.println(s);
            } else {
                out.println("<a href=\"" + store.getRequiredProperty(website).getObject().toString() + "\">" + storeName.replace('_', ' ') + "</a>");
                }%> </h2>
    </body>
</html>
