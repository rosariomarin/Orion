  

<%@ page  import="java.io.FileInputStream" %>
<%@ page  import="java.io.BufferedInputStream"  %>
<%@ page  import="java.io.File"  %>
<%@ page import="java.io.IOException" %>


<%

   // you  can get your base and parent from the database
   String base="e1";
   String parent="e2";   
   String filename=parent+"_codemiles.zip";
// you can  write http://localhost
   String filepath="http://www.codemiles.com/example/"+base+"/";

BufferedInputStream buf=null;
   ServletOutputStream myOut=null;

try{

myOut = response.getOutputStream( );
     File myfile = new File(getClass().getResource("/com/cimat/outxml/output.xml").getFile());
     
     //set response headers
     response.setContentType("text/plain");
     
     response.addHeader(
        "Content-Disposition","attachment; filename="+myfile.getName() );

     response.setContentLength( (int) myfile.length( ) );
     
     FileInputStream input = new FileInputStream(myfile);
     buf = new BufferedInputStream(input);
     int readBytes = 0;

     //read from the file; write to the ServletOutputStream
     while((readBytes = buf.read( )) != -1)
       myOut.write(readBytes);

} catch (IOException ioe){
     
        throw new ServletException(ioe.getMessage( ));
         
     } finally {
         
     //close the input/output streams
         if (myOut != null)
             myOut.close( );
          if (buf != null)
          buf.close( );
         
     }

   
   
%>
  - See more at: http://www.codemiles.com/servlets-jsp/jsp-to-download-file-t17.html#sthash.FfsdmDXw.dpuf