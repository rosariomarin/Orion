/*
* To change this license header, choose License Headers in Project Properties.
* To change this template file, choose Tools | Templates
* and open the template in the editor.
*/

package com.cimat.patrones.servlets;

import com.cimat.patrones.action.AnalizadorPatrones;
import static com.cimat.patrones.action.AnalizadorPatrones.initGate;
import com.cimat.patrones.dto.Pattern;
import com.cimat.patrones.log.Log;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.jasper.tagplugins.jstl.core.ForEach;
import org.apache.tomcat.util.http.fileupload.FileItem;
import org.apache.tomcat.util.http.fileupload.FileItemFactory;
import org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory;
import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;

/**
 *
 * @author QACG
 */
@WebServlet(name = "ServletAnalizarTexto", urlPatterns = {"/ServletAnalizarTexto"})
public class ServletAnalizarTexto extends HttpServlet {
    
    private Properties prop;
    
    
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            
            Log.log.info("-----------------Values--------------------------------");
            for(String value: request.getParameterMap().keySet()){
                Log.log.info(value + ": " + request.getParameterMap().get(value));
            }
            
            if(initGate()){
                
                request.setAttribute("GateStatus", true);
                
                FileItemFactory factory = new DiskFileItemFactory();
                ServletFileUpload upload = new ServletFileUpload(factory);
                Map<String,List<FileItem>> map = upload.parseParameterMap(request);
                
                File file = this.getFile(map);
                
                AnalizadorPatrones obj = new AnalizadorPatrones();
                
                obj.loadAnalizator("/Config/ANNIE_with_defaults.gapp");
                obj.addGazetter("/Config/Gazzetter/lists.def");
                obj.addJape("/Config/main.jape");
                obj.setDocumentFile(file);
                
                obj.execute();
                
                Map<String,ArrayList<Pattern>> promotes = new LinkedHashMap<String, ArrayList<Pattern>>();
                Map<String,ArrayList<Pattern>> inhibits = new LinkedHashMap<String, ArrayList<Pattern>>();
                String r;
                int numPromotes=0;
                int numInhibits=0;
                
                loadProperties();
                String ids;
                
                String []p = prop.getProperty("promotes").split(",");
                for (String token : p) {
                    ids = obj.getIds(token);
                    ArrayList a =  obj.getPatterns(ids);
                    if(a != null) {
                        numPromotes += a.size();
                        promotes.put(token,a);
                    }    
                }
                
                String []i = prop.getProperty("inhibits").split(",");
                for (String token : i) {
                    ids = obj.getIds(token);
                    ArrayList a =  obj.getPatterns(ids);
                    if(a != null) {
                        numInhibits += a.size();
                        inhibits.put(token, a);
                    }
                }
                
                if(numPromotes > numInhibits){
                    r = "Yes";
                } else {
                    r = "No";
                }
                
                
                
                request.setAttribute("question", "The " + file.getName() +" promotes Perfomance? <a href=\"#\">" + r +"</a>");
                request.setAttribute("promotes", promotes);
                request.setAttribute("inhibits", inhibits);
                request.setAttribute("numPromotes", numPromotes);
                request.setAttribute("numInhibits", numInhibits);
                request.setAttribute("res", r);
                request.setAttribute("fileName", file.getName());
                request.setAttribute("xml", getClass().getResource("/com/cimat/outxml/output.xml").getPath());
                obj.writeOutput();
                //for te filedownload
                //response.setContentType("application/octet-stream");
                //response.setHeader("Content-Disposition","attachment;filename="+file);
                RequestDispatcher rd = request.getRequestDispatcher("/ViewPatterns.jsp");
                rd.forward(request, response);
            } else {
                Log.log.info("Gate no se pudo inicializar");
                request.setAttribute("GateStatus", null);
            }
            
        } catch (Exception e){
            Log.log.error(getClass(), e);
            request.setAttribute("GateStatus", null);
            out.print(e);
        }
        finally {
            out.close();
        }
        
    }
    
    private File getFile(Map<String,List<FileItem>> map){
        try{
            List<FileItem> items = map.get("inputFile");
// Se recorren todos los items, que son de tipo FileItem
            File resultado = null;
            for (FileItem item : items) {
                // Hay que comprobar si es un campo de formulario. Si no lo es, se guarda el fichero
                // subido donde nos interese
                
                if (!item.isFormField()) {
                    // No es campo de formulario, guardamos el fichero en algún sitio
                    //resultado = item.getString();
                    
                    //String path =getServletContext().getRealPath("\\")+ "corpus/"; 
                    String path = getClass().getResource("/com/cimat/patrones/files/").getPath();
                    resultado = new File(path + item.getName()); 
                    item.write(resultado);
                    
                    break;
                } else {
                    // es un campo de formulario, podemos obtener clave y valor
                    String key = item.getFieldName();
                    String valor = item.getString();
                }
            }
            return resultado;
        } catch (Exception ex) {
            Log.log.error(getClass(), ex);
            return null;
        }
    }
    
    private void loadProperties(){
        InputStream istream = null;
        prop = new Properties();
        try{
            istream = getClass().getResource("/properties/Patterns.properties").openStream();
            prop.load(istream);	
        }catch(Exception e){
        }
        
    }
    
    
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        out.print("entra get");
        out.close();
    }
    
    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        out.print("entra post");
        out.close();
    }
    
    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
    
}
