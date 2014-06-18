<%-- 
    Document   : ShowFile
    Created on : 12/05/2014, 01:18:08 AM
    Author     : QACG
--%>

<%@page import="java.util.Map"%>
<%@page import="com.cimat.patrones.dto.Pattern"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>${fileName}</title>
       <link rel="stylesheet" href="css/ui-lightness/themes/ui-lightness/jquery-ui.css"> 
        <script src="js/jquery-1.10.2.js"></script>
        <script src="js/jquery-ui-1.10.4.custom.js"></script>
        <link rel="stylesheet" href="css/lightness/themes/ui-lightness/jquery-ui.css">
        <script>
            $(function() {
                $( "#tabs" ).tabs();
            });
        </script>
        <style>
            body{
                font: 62.5% "Trebuchet MS", sans-serif;
                margin: 50px;
            }
            .demoHeaders {
                margin-top: 2em;
            }
        </style>
    </head>
    <body>
        <div id="tabs">
            <ul>
                <li><a href="#tabs-1">Pattern</a></li>
            </ul>
                <div id="tabs-1">
                    <p>
                        <% 
                         Map<String,ArrayList<Pattern>> patrones;   
                         if(request.getParameter("type").equals("promotes"))  { 
                            patrones = (Map<String,ArrayList<Pattern>>)request.getSession().getAttribute("listP");
                         } else {
                            patrones = (Map<String,ArrayList<Pattern>>)request.getSession().getAttribute("listI");
                         }
                         int pos = Integer.parseInt(request.getParameter("pos"));
                         String text = patrones.get(request.getParameter("pattern")).get(pos).getText();
                         out.print(text);
                        %>
                    </p>
                </div>
        </div>
        <br>
        <input type="button" value="Return" name="Back2" onclick="history.back()" />

                    
    </body>
</html>
