package com.cimat.patrones.io;

/*
* To change this license header, choose License Headers in Project Properties.
* To change this template file, choose Tools | Templates
* and open the template in the editor.
*/

import com.cimat.patrones.log.Log;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.tomcat.util.http.fileupload.FileItem;
import org.apache.tomcat.util.http.fileupload.FileItemFactory;
import org.apache.tomcat.util.http.fileupload.FileUploadException;
import org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory;
import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;

/**
 *
 * @author QACG
 */
@WebServlet(urlPatterns = {"/ReadFile"})
public class ReadFile extends HttpServlet {
    
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
        try {
            
            
            FileItemFactory factory = new DiskFileItemFactory();
            ServletFileUpload upload = new ServletFileUpload(factory);
            
            
// req es la HttpServletRequest que recibimos del formulario.
// Los items obtenidos serán cada uno de los campos del formulario,
// tanto campos normales como ficheros subidos.
            Map<String,List<FileItem>> map = upload.parseParameterMap(request);
            //System.out.println("Map2: " + map);
            //Logger.getLogger(ReadFile.class.getName()).log(Level.INFO, null, "Map: " + map);
            //Log log = new Log();
            Log.log.debug("Map: " + map);
            List<FileItem> items = map.get("inputFile");
            Log.log.debug("list: " + items.size());
// Se recorren todos los items, que son de tipo FileItem
            for (FileItem item : items) {
                
                
                // Hay que comprobar si es un campo de formulario. Si no lo es, se guarda el fichero
                // subido donde nos interese
                if (!item.isFormField()) {
                    // No es campo de formulario, guardamos el fichero en algún sitio
                    String fileName = item.getName();
                    
                    String contentType = item.getContentType();
                    long size = item.getSize();
                    request.setAttribute("fileName", fileName);
                    request.setAttribute("contentType", contentType);
                    request.setAttribute("size", size);
                    request.setAttribute("contenido", item.getString());
                    break;
                } else {
                    // es un campo de formulario, podemos obtener clave y valor
                    String key = item.getFieldName();
                    String valor = item.getString();
                }
            }
            RequestDispatcher rd = request.getRequestDispatcher("/index.jsp");
            rd.forward(request, response);
        } catch (FileUploadException ex) {
            Log.log.error(getClass(), ex);
        }
        //Logger.getLogger(ReadFile.class.getName()).log(Level.SEVERE, null, ex);
        //}
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
