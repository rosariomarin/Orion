package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.io.FileInputStream;
import java.io.BufferedInputStream;
import java.io.File;
import java.io.IOException;

public final class ExampleFile_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write("/*\n");
      out.write("By : Sami & El-dib\n");
      out.write("*/\n");
      out.write("\n");
      out.write("\n");
      out.write("   \n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");


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

   
   

      out.write("\n");
      out.write("  - See more at: http://www.codemiles.com/servlets-jsp/jsp-to-download-file-t17.html#sthash.FfsdmDXw.dpuf");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
