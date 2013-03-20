<%-- 
    Document   : index
    Created on : Mar 6, 2013, 11:25:31 AM
    Author     : Bach Ngoc Son
--%>

<%@page import="com.hp.hpl.jena.rdf.model.*"%>
<%@page import="com.hp.hpl.jena.ontology.OntModel"%>
<%@page import="Query.Query"%>
<%
    Model defaultModel = Query.getModel(Query.inputFileName);
    OntModel model = Query.getOntologyModel(Query.inputFileName);
    Property type = model.getProperty(Query.rdfNamespace, "type");
    Property subClassOf = model.getProperty(Query.rdfSchemaNamespace, "subClassOf");
    Property đồ = model.getProperty(Query.ontologyNamespace, "thực_phẩm");
    Property store = model.getProperty(Query.ontologyNamespace, "quán");
    Property food = model.getProperty(Query.ontologyNamespace, "đồ_ăn");
    Property drink = model.getProperty(Query.ontologyNamespace, "đồ_uống");
    Property misc = model.getProperty(Query.ontologyNamespace, "linh_tinh");
    Property name = model.getProperty(Query.ontologyNamespace, "Name");
    String urlNamespace = request.getContextPath() + "/viewStore/";
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" type="text/css" href="style.css"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ẩm thực Bách Khoa</title>
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
        <div id="browse-area">
            <div id="left" class="column">
                <div class="title"><span>Danh sách các quán ăn</span></div>
                <div class="content">
                <%
                    Resource quán;
                    ResIterator stores = model.listResourcesWithProperty(type, store);
                    if (!stores.hasNext()) {
                        out.println("Không tìm thấy quán nào.");
                    } else {
                        while (stores.hasNext()) {
                            quán = stores.nextResource();
                            out.println("<a href=\"" + urlNamespace + quán.getLocalName() + "\">" + quán.getRequiredProperty(name).getObject().toString() + "</a><br/>");
                        }
                    }
                %>
                </div>
            </div>
            <div id="center" class="column">
                <div class="title"><span>Danh sách món</span></div>
                <div class="content">
                <%
                    Resource rsc;
                    ResIterator đồ_ăn = model.listResourcesWithProperty(type, food);
                    if (đồ_ăn.hasNext()) {
                        out.println("<b>Đồ ăn : </b>");
                    }
                    while (đồ_ăn.hasNext()) {
                        rsc = đồ_ăn.nextResource();
                        out.println("<br/>" + rsc.getRequiredProperty(name).getObject().toString());
                    }
                    ResIterator đồ_uống = model.listResourcesWithProperty(type, drink);
                    if (đồ_uống.hasNext()) {
                        out.println("<br/><br/><b>Đồ uống : </b>");
                    }
                    while (đồ_uống.hasNext()) {
                        rsc = đồ_uống.nextResource();
                        out.println("<br/>" + rsc.getRequiredProperty(name).getObject().toString());
                    }
                    ResIterator linh_tinh = model.listResourcesWithProperty(type, misc);
                    if (linh_tinh.hasNext()) {
                        out.println("<br/><br/><b>Đồ lặt vặt : </b>");
                    }
                    while (linh_tinh.hasNext()) {
                        rsc = linh_tinh.nextResource();
                        out.println("<br/>" + rsc.getRequiredProperty(name).getObject().toString());
                    }
                %>
                </div>
            </div>
            <div id="right" class="column">
                <div class="title"><span>Loại thực phẩm</span></div>
                <div class="content">
                <%
                    Query.printChildResources(subClassOf, đồ, defaultModel, out);
                %>
                </div>
            </div>
        </div>
        <footer>
            <div id="contact-information">
            Contact Information :
            <br/>Author : Bạch Ngọc Sơn
            <br/>Email : <a href="mailto:bachngocson0812@gmail.com">bachngocson0812@gmail.com</a>
            </div>
            <div id="admin-login">
                <a href="">Login to admin area</a>
            </div>
        </footer>
    </body>
</html>