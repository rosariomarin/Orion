<%-- 
    Document   : index
    Created on : 7/05/2014, 12:35:26 AM
    Author     : QACG
--%>

<%@page import="com.cimat.patrones.dto.Pattern"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html xml:lang="en" xmlns="http://www.w3.org/1999/xhtml">
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
			<li ><a href="index.jsp">Home</a></li>
			<li ><a href="about.jsp">About the Project</a></li>
                        <li class="current"><a href="Contact.jsp">Contact</a></li>
		</ul>
	</nav> <!-- #main-navigation -->
            
        <div id="content" role="main" class="span7">    
            <br>
            <h3>Director of thesis : </h3>
            <font SIZE=2 face="Open Sans">Dr. Perla Velasco Elizondo.</font>
            <h3>E-mail : </h3>
            <font SIZE=2 face="Open Sans"><a href="#" title="Director of thesis">pvelasco@uaz.edu.mx</a></font>
            <br>
            <h3>Author : </h3>
            <font SIZE=2 face="Open Sans">María del Rosario Marín Piña.</font>
            <h3>E-mail : </h3>
            <font SIZE=2 face="Open Sans"><a href="#" title="Author">maria.marin@cimat.mx</a></font>    
            
            
        
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
