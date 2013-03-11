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
    Property location = model.getProperty(ontologyNamespace + "Location");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Search Result</title>
    </head>
    <body>
        <h2>Bạn đang tìm : <b><% out.println(query.trim().toLowerCase().replaceAll(" +", " "));%></b></h2>
        <h2>Kết quả tìm kiếm : </h2>
        <ul>
            <%
                // resIt : iterator to list of food that have type query
                ResIterator resIt = model.listResourcesWithProperty(type, rsc);
                Resource dish, store;
                ResIterator storeIt;
                if (!resIt.hasNext()) {
                    out.println("Không tìm thấy thứ cần tìm.");
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
                        out.println("<br/> - " + store.getRequiredProperty(name).getObject().toString()
                                + " _ " + store.getRequiredProperty(location).getObject().toString());
                    }
                }
            %>            
        </ul>
    </body>
</html>
