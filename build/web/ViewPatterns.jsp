    <%-- 
    Document   : ViewPatterns
    Created on : 15/06/2014, 02:20:36 PM
    Author     : QACG
--%>

<%@page import="com.cimat.patrones.dto.Pattern"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Pattern Analizer</title>
        <link href="css/ui-lightness/jquery-ui-1.10.4.custom.css" rel="stylesheet">
        <script src="js/jquery-1.10.2.js"></script>
        <script src="js/jquery-ui-1.10.4.custom.js"></script>
        <meta name="viewport" content="width=device-width">

	<link href="style.css" rel="stylesheet">

	<!-- Load Open Sans and Merriweather from Google Fonts
		For optimal performance, customize it to load the styles you need:
		http://goo.gl/QufgJ
	-->
	<link href="//fonts.googleapis.com/css?family=Open+Sans:400italic,700italic,400,700|Merriweather:400,700,900" rel="stylesheet">

	<!-- All JavaScript at the bottom, except for Modernizr
		Modernizr enables HTML5 elements & feature detects; It includes Respond, a polyfill for min/max-width CSS3 Media Queries
		For optimal performance, use a custom Modernizr build: www.modernizr.com/download/ -->
	<script src="js/modernizr-2.6.1.min.js"></script>
        
            
        <script>
            $(function() {
                $("#accordion1").accordion({
                    collapsible  : true,
                    active       : false,
                    heightStyle  : "content",
                    navigation   : true
                }); 
                $("#accordion2").accordion({
                    collapsible  : true,
                    active       : false,
                    heightStyle  : "content",
                    navigation   : true
                }); 
                
            });
            $(function() {
                $( document ).tooltip();
            });
            
        </script>
        
        
        <style>
            body{
                font: 62.5% "Trebuchet MS", sans-serif;
            }
            .demoHeaders {
                margin-top: 2em;
            }
            #dialog-link {
                padding: .4em 1em .4em 20px;
                text-decoration: none;
                position: relative;
            }
            #dialog-link span.ui-icon {
                margin: 0 5px 0 0;
                position: absolute;
                left: .2em;
                top: 50%;
                margin-top: -8px;
            }
            #icons {
                margin: 0;
                padding: 0;
            }
            #icons li {
                margin: 2px;
                position: relative;
                padding: 4px 0;
                cursor: pointer;
                float: left;
                list-style: none;
            }
            #icons span.ui-icon {
                float: left;
                margin: 0 4px;
            }
            .fakewindowcontain .ui-widget-overlay {
                position: absolute;
            }
            
        </style>
        
        
    </head>
    
    <body>
        
        
        <header id="master-header" class="clearfix" role="banner">

		<hgroup>
			<h1 id="site-title"><a href="#" title="Your Site Name">ORION</a></h1>      
                        <h2><font color ="F6A828" size = 4>Pattern Analizer</font></h2>
		</hgroup>

	</header> <!-- #master-header -->
        
        <div id="main" class="row clearfix">
            <!-- Main navigation -->
	<nav class="main-navigation clearfix span12" role="navigation">
		<h3 class="assistive-text">Main menu</h3>
		<ul>
			<li class="current"><a href="index.jsp">Home</a></li>
			<li ><a href="about.jsp">About the Project</a></li>
                        <li ><a href="Contact.jsp">Contact</a></li>
		</ul>
	</nav> <!-- #main-navigation -->
            
        <div id="content" role="main" class="span7">    
        
            
            
        <h3>${question}</h3>
        <br>
        <h3>The following promotes were found ... ${numPromotes}</h3>
            <div id="accordion1">
            <%
                Map<String,ArrayList<Pattern>> promotes = (Map)request.getAttribute("promotes");
                request.getSession().setAttribute("listP", promotes );
                for (String key : promotes.keySet()) {
                    if(promotes.get(key) != null){
                        out.print("<h3>" + key +"</h3>");
                        out.print("<div><p>");
                        //out.print(patrones.get(key));
                        ArrayList<Pattern> patron = promotes.get(key);
                        out.print("<ui>");
                        for(Pattern p : patron){
                            out.print("<li type=\"circle\"><a href=\"ShowFile.jsp?id=" 
                                    + p.getId() + "&pos=" + p.getPos() +"&pattern=" + key +"&type=promotes\">Link to Text</a></br>");
                            out.print(p.getParagraph() + "</li>");
                        }
                        out.print("</ui>");
                        out.print("</p></div>");
                    }
                }
            %>
            </div>
            <br>
            <h3>The following inhibits were found ... ${numInhibits}</h3>
            <div id="accordion2">
            <%
                Map<String,ArrayList<Pattern>> inhibits = (Map)request.getAttribute("inhibits");
                
                request.getSession().setAttribute("listI", inhibits );
                for (String key : inhibits.keySet()) {
                    if(inhibits.get(key) != null){
                        out.print("<h3>" + key +"</h3>");
                        out.print("<div><p>");
                        //out.print(patrones.get(key));
                        ArrayList<Pattern> patron = inhibits.get(key);
                        out.print("<ui>");
                        for(Pattern p : patron){
                            out.print("<li type=\"circle\"><a href=\"ShowFile.jsp?id=" 
                                    + p.getId() + "&pos=" + p.getPos() +"&pattern=" + key +"&type=inhibits\">Link to Text</a></br>");
                            out.print(p.getParagraph() + "</li>");
                        }
                        out.print("</ui>");
                        out.print("</p></div>");
                    }
                }
            %>
            </div>
            <br>
            <h4><a href="DownloadFile.jsp" target="_blank">Download XML</a></h4>
            
            <input type="button" value="Return" name="Back2" onclick="history.back()" />
            </div> <!-- #content -->
      </div> <!-- #main -->
      <footer id="footer" role="contentinfo">
		<!-- You're free to remove the credit link to Jayj.dk in the footer, but please, please leave it there :) -->
		<p>
			Copyright &copy; 2014 <a href="#">Cimat</a>
			<span class="sep">|</span>
			Author: <a href="#" title="Design by">I.S.C María del Rosario Marín Piña</a> 
                        <span class="sep">|</span>
                        version 1.0
		</p>
	</footer> <!-- #footer -->          
    </body>
</html>
