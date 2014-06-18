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
<html>
    <head>
        <meta charset="utf-8">
        <title>Patterns Analizer</title>
        <link href="css/ui-lightness/jquery-ui-1.10.4.custom.css" rel="stylesheet">
        <script src="js/jquery-1.10.2.js"></script>
        <script src="js/jquery-ui-1.10.4.custom.js"></script>
        <link rel="stylesheet" href="css/lightness/themes/ui-lightness/jquery-ui.css">
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
                            alert ("Processing File."); 
                            formulario.submit(); 
                            return 1; 
                        } else {
                            alert("You can't select a Quality atribute")
                        }
                    } 
                } 
   //si estoy aqui es que no se ha podido submitir 
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
                margin: 50px;
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
        <h2>Patterns Analizer</h2>
        <form name = "frmLoadFile" method="POST" 
              action="${pageContext.servletContext.contextPath}/ServletAnalizarTexto" 
              enctype="multipart/form-data">
            <input type="file" id = "inputFile" name="inputFile" />
            <br>
            <input type=button value = "Execute "name="btnCargar" value="load" 
                   onclick="checkFile(this.form, this.form.inputFile.value);"
                   />
            <br>
            <br>
            <select name='selector' id='selector'>
                <option value='0' default selected>Select a quality atribute</option>
                <option value='1'>Perfomance</option>
                <option value='2'>Security</option>
                <option value='3'>Portability</option>
            </select>   
            <br>
            <!-- mostramos el valor seleccionado en cada momento -->
            <h3><p id='valorSeleccionado'></p></h3>
            
        </form>
        
        <br>
        
        
        
        <% if ("POST".equalsIgnoreCase(request.getMethod()))  {%>
            
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
            <h4><a href="DownloadFile.jsp" target="_blank">link del xml</a></h4>
        <%} %>
        
    
    
</body>
</html>
