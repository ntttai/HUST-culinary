<%-- 
    Document   : search_result
    Created on : Mar 6, 2013, 6:00:44 PM
    Author     : Bach Ngoc Son
--%>
<%@page import="com.hp.hpl.jena.ontology.OntModel"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.hp.hpl.jena.util.FileManager"%>
<%@page import="java.io.InputStream"%>
<%@page import="com.hp.hpl.jena.rdf.model.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String inputFileName = "C:\\Users\\Bach Ngoc Son\\Ontology1362538448108\\Ontology1362538448108.owl";
    String ontologyNamespace = "http://www.semanticweb.org/ontologies/2013/2/6/Ontology1362538448108.owl#";
    String rdfNamespace = "http://www.w3.org/1999/02/22-rdf-syntax-ns#";
    OntModel model = ModelFactory.createOntologyModel();
    InputStream in = FileManager.get().open(inputFileName);
    if (in == null) {
        throw new IllegalArgumentException(
                "File: " + inputFileName + " not found.");
    }
    model.read(in, null);
    request.setCharacterEncoding("UTF-8");
    String query = request.getParameter("query");
    Resource rsc = model.getResource(ontologyNamespace + query.trim().toLowerCase().replaceAll(" +", "_"));
    Property type = model.getProperty(rdfNamespace + "type");
    Property sell = model.getProperty(ontologyNamespace + "sell");
    Property name = model.getProperty(ontologyNamespace + "Name");
    String processedQuery = query.trim().toLowerCase().replaceAll(" +", " ");
%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" type="text/css" href="style.css"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Kết quả tìm kiếm</title>
    </head>
    <body>
        <header>Chào mừng bạn đến với website ẩm thực Bách Khoa!</header>
        <img id="logo" src="images/Logo.png"/>
        <div id="search-area">
            <form action="search_result.jsp" method="POST" name="query">
                <input size="100" type="text" name="query"/>
                <input type="submit" name="Tìm kiếm" value="Tìm kiếm"/>
            </form>
        </div>
        <h2>Bạn đang tìm : <b><% out.println(processedQuery);%></b></h2>
        <h2>Kết quả tìm kiếm : </h2>
        <%
            // resIt : iterator to list of food that have type query
            ResIterator resIt = model.listResourcesWithProperty(type, rsc);
            Resource dish, store;
            ResIterator storeIt;
            boolean hasList;
            hasList = resIt.hasNext();
            if (hasList) {
                out.println("Tìm thấy \"" + processedQuery + "\" trong loại thực phẩm : <br/><ul>");
            }
            while (resIt.hasNext()) {
                dish = resIt.nextResource();

                //print out dish name
                out.println("<li><b>" + dish.getRequiredProperty(name).getObject().toString() + "</b></li>");

                //find all store sell that dish
                storeIt = model.listResourcesWithProperty(sell, dish);

                if (!storeIt.hasNext()) {
                    out.println("Không tìm thấy quán bán đồ này hoặc chưa được cập nhật.");
                } else {
                    out.println("Được bán ở : ");
                }

                //list all store
                while (storeIt.hasNext()) {
                    store = storeIt.nextResource();
                    out.println("<br/> - " + store.getRequiredProperty(name).getObject().toString());
                }
            }
            if (hasList) {
                out.println("</ul>");
            }
            
            
            /// some process to identify finding what
            
            
            
            
            
            hasList = false;
            resIt = model.listResourcesWithProperty(name, query);
            hasList = resIt.hasNext();
            if (hasList) {
                out.println("Tìm thấy \"" + processedQuery + "\" trong tên thực phẩm, các quán bán loại thực phẩm trên là : <br/><ul>");
            }
            while (resIt.hasNext()) {
                storeIt = model.listResourcesWithProperty(sell, resIt.nextResource());
                while (storeIt.hasNext()) {
                    store = storeIt.nextResource();
                    out.println("<li>" + store.getRequiredProperty(name).getObject().toString() + "</li>");
                }
            }
            if (hasList) {
                out.println("</ul>");
            }
            
            
            
            /// some process to identify finding what
            
            hasList = false;
            resIt = model.listResourcesWithProperty(name, query);
            hasList = resIt.hasNext();
            if (hasList) {
                out.println("Tìm thấy quán \"" + processedQuery + "\" : <br/><ul>");
            }
            while (resIt.hasNext()) {
                store = resIt.nextResource();
                out.println("<li>" + store.getRequiredProperty(name).getObject().toString() + "</li>");
            }
            if (hasList) {
                out.println("</ul>");
            }
        %>       
    </body>
</html>
