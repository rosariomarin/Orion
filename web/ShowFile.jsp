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
        <meta charset="utf-8">
        <title>Orion</title>
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
        
        <header id="master-header" class="clearfix" role="banner">

		<hgroup>
			<h1 id="site-title"><a href="#" title="Your Site Name">Orion</a></h1>
                        
		</hgroup>

	</header> <!-- #master-header -->
        
        <div id="main" class="row clearfix">
            <!-- Main navigation -->
	<nav class="main-navigation clearfix span12" role="navigation">
		<h3 class="assistive-text">Main menu</h3>
		<ul>
			<li class="current"><a href="index.jsp">Home</a></li>
                        <li ><a href="about.jsp">About</a></li>
		</ul>
	</nav> <!-- #main-navigation -->
            
        <div id="content" role="main" class="span7">    
        
        
        
        <h2>${fileName}</h2><br>
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

        </div> <!-- #content -->
      </div> <!-- #main -->
      <footer id="footer" role="contentinfo">
		<!-- You're free to remove the credit link to Jayj.dk in the footer, but please, please leave it there :) -->
		<p>
			Copyright &copy; 2014 <a href="#">Cimat</a>
			<span class="sep">|</span>
			Author: <a href="#" title="Design by">María del Rosario Marín Piña</a> 
                        <span class="sep">|</span>
                        version 1.0
		</p>
	</footer> <!-- #footer -->                      
    </body>
</html>
