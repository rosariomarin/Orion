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
            
            
            
            
            function checkFile(formulario, archivo) { 
                extensiones_permitidas = new Array(".txt",".pdf"); 
                mierror = ""; 
                if (!archivo) { 
                    //Si no tengo archivo, es que no se ha seleccionado un archivo en el formulario 
                    mierror = "No file was selected"; 
                } else { 
                    //recupero la extensión de este nombre de archivo 
                    extension = (archivo.substring(archivo.lastIndexOf("."))).toLowerCase(); 
                    //alert (extension); 
                    //compruebo si la extensión está entre las permitidas 
                    permitida = false; 
                    for (var i = 0; i < extensiones_permitidas.length; i++) { 
                        if (extensiones_permitidas[i] == extension) { 
                            permitida = true; 
                            break; 
                        } 
                    } 
                    if (!permitida) { 
                        mierror = "Invalid file extension. \nOnly permited files are: " + extensiones_permitidas.join(); 
                    }else{ 
         	 //submito!
                        var valor=$("#selector").val();
                        if(valor != 0) {
                            formulario.submit(); 
                            return 1; 
                        } else {
                            alert("You can't select a Quality atribute")
                        }
                    } 
                } 
 
                alert (mierror); 
                return 0; 
            }
            $(document).ready(function(){
                $("#selector").change(function(){
                    var valor=$("#selector").val();
                    var texto=$("#selector option:selected").text();
                    var file=$("#inputFile").val();
                    var str = file.substring(12);
                    if(valor == 1)
                        $("#valorSeleccionado").html("Does the " + str + " promote "+texto+"?: ${res}");
                    else if (valor != 0) {
                        alert("This option is inavalible");
                        $("#selector").val(0);
                        // ejecutamos el evento change()
                        $("#selector").change();
                    }
                });
            })
            
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
			<li class="current"><a href="about.jsp">About the Project</a></li>
                        <li ><a href="Contact.jsp">Contact</a></li>
		</ul>
	</nav> <!-- #main-navigation -->
            
        <div id="content" role="main" class="span7">    
            <br>
            <font SIZE=4 face="Open Sans"><p align="justify"> The overall objective of this project is to assist novice architects, 
            specifically in the phase of definition of the architecture; developing a 
            method and a tool focused on the design pattern analysis. The analysis was 
            performed in order to answer the question whether certain pattern promotes 
            a quality attribute. In this thesis decided to work with the attribute 
            performance because it is an important quality attribute for practically 
            any type of system.</p></font>
        
        
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
