/*
* To change this license header, choose License Headers in Project Properties.
* To change this template file, choose Tools | Templates
* and open the template in the editor.
*/

package com.cimat.patrones.action;

import com.cimat.patrones.dto.Pattern;
import com.cimat.patrones.log.Log;
import gate.Annotation;
import gate.AnnotationSet;
import gate.Corpus;
import gate.Document;
import gate.Factory;
import gate.Gate;
import gate.LanguageAnalyser;
import gate.creole.ExecutionException;
import gate.creole.ResourceInstantiationException;
import gate.creole.SerialAnalyserController;
import gate.util.persistence.PersistenceManager;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.net.MalformedURLException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.Set;


/**
 *
 * @author QACG
 */
public class AnalizadorPatrones {
    
    private SerialAnalyserController controller;
    private Document doc;
    private AnnotationSet sentences;
    private AnnotationSet patrones;
    private String patron;
    
    public AnalizadorPatrones() {
    }
    
    public AnalizadorPatrones(String fileConfig, String doc) {
        
        loadAnalizator(fileConfig);
        try {
            this.doc = Factory.newDocument(new File(doc).toURI().toURL());
        }catch(MalformedURLException e){
            System.err.println("Error al cargar el archivo");
        } catch (ResourceInstantiationException e) {
            System.err.println("Error al cargar el archivo");
        }
    }
    
    
    public String getIds(String patron){
        try{
            Log.log.debug(" ---------------------- Analizando parrafos ----------------------");
            sentences = doc.getAnnotations().get("Sentence");
            patrones = doc.getAnnotations().get(patron);
            Log.log.debug("Sentences: " + sentences.size());
            Log.log.debug(patron + ": " + patrones.size());
            String ids  = "";
            for (Annotation annotation : sentences) {
                boolean s = false;
                for (Annotation ann : patrones) {
                    if(ann.getStartNode().getId() >= annotation.getStartNode().getId() &&  ann.getEndNode().getId() <= annotation.getEndNode().getId()){
                        s = true;
                    }
                }
                if(s)
                    ids += annotation.getId() + ",";
            }
            if(ids.equals("")) {
                ids = null;
                Log.log.info("No se encontro ningun patron de " + patron);
            } else {
                Log.log.info("Se encontraron " + ids.split(",").length + " parrafos del tipo " + patron);
                this.patron = patron;
            }
            return ids;
        }catch(Exception e ){
            Log.log.error(getClass(),e);
            return null;
        }
        
        
    }
    
    public String execute(){
        try{
            System.out.println("Ejecutando Gate");
            System.out.println(". . .");
            controller.execute();
            System.out.println("Found annotations of the following types: " +
                    doc.getAnnotations().getAllTypes());
            String out = "Ejecutando Gate .... </br>";
            out += "Found annotations of the following types: " +
                    doc.getAnnotations().getAllTypes();
            return out;
        }catch(ExecutionException e){
            e.printStackTrace();
            return "Error";
        }
    }
    
    public void writeOutput(String ids){
        OutputStreamWriter out = null;
        try{
            File outputFile = new File("output.xml");
            FileOutputStream fos = new FileOutputStream(outputFile);
            BufferedOutputStream bos = new BufferedOutputStream(fos);
            out = new OutputStreamWriter(bos);
            
            System.out.println("Escritura de los archivso");
            String [] parrafos = ids.split(",");
            for (String id : parrafos) {
                System.out.println("id: " + id);
                Set parrafo = new HashSet();
                parrafo.add(sentences.get(Integer.parseInt(id)));
                out.write(doc.toXml(parrafo,true)+"\r\n"+"\r\n");
            }
            System.out.println("Se genero el archvio output.xml");
        }catch(Exception e){
            System.err.println("Error al cargar el archivo");
        } finally {
            try {
                out.close();
            } catch (IOException ex) {
                System.err.println("Error al cerrar la lectura");
            }
        }
    }
    
    public void writeOutput() {
        OutputStreamWriter out = null;
        try{
            AnnotationSet defaultAnnots = doc.getAnnotations();
            String docXMLString = doc.toXml(defaultAnnots,false);
            File outputFile = new File(getClass().getResource("/com/cimat/outxml/output.xml").getFile());
            FileOutputStream fos = new FileOutputStream(outputFile);
            BufferedOutputStream bos = new BufferedOutputStream(fos);
            out = new OutputStreamWriter(bos);
            out.write(docXMLString);
            System.out.println("Se genero el archvio output.xml");
        }catch(Exception e){
            e.printStackTrace();
        } finally {
            try {
                out.close();
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }
    
    
    public String getSentencesText(String ids){
        try{
            if (ids == null)
                Log.log.info("is null ids");
            
            String resul = "";
            String [] parrafos = ids.split(",");
            for (String id : parrafos) {
                Set parrafo = new HashSet();
                parrafo.add(sentences.get(Integer.parseInt(id)));
                Log.log.debug("********Sentencia: " + parrafo);
                
                String temp = doc.toXml(parrafo, false);
                Log.log.debug("Temporal-----------\n" + temp);
                //temp = this.getInfoLabel(temp, "<paragraph>");
                temp = this.getInfoLabel(temp, "<Sentence>");
                temp = temp.replaceAll("\n", "");
                temp = temp.replaceAll("\r", "");
                resul += temp + "</br>";
            }
            return resul;
        }catch(Exception e){
            Log.log.error(getClass(),e);
            return null;
        }
    }
    public ArrayList<Pattern> getPatterns(String ids){
        try{
            if (ids == null){
                Log.log.info("is null ids");
                return null;
            } else {
                ArrayList<Pattern> patterns = new ArrayList<Pattern>();
                int indice = 0;
                String [] parrafos = ids.split(",");
                String resul;
                for (String id : parrafos) {
                    Pattern pattern = new Pattern();
                    Set parrafo = new HashSet();
                    parrafo.add(sentences.get(Integer.parseInt(id)));
                    String xml = doc.toXml(parrafo, false);
                    
                    pattern.setText(xml);
                    pattern.setText(pattern.getText().replaceAll("<Sentence>", "<P style=\"COLOR: #ffffff; BACKGROUND-COLOR: #6f90b8\">"));
                    pattern.setText(pattern.getText().replaceAll("</Sentence>", "</P>"));

                    //temp = this.getInfoLabel(temp, "<paragraph>");
                    String temp = this.getInfoLabel(xml, "<Sentence>");
                    temp = temp.replaceAll("\n", "");
                    temp = temp.replaceAll("\r", "");
                    resul = temp;
                    pattern.setPos(indice++);
                    pattern.setId(id);
                    
                    pattern.setParagraph(resul);
                    patterns.add(pattern);
                }
                return patterns;
            }
        }catch(Exception e){
            Log.log.error(getClass(),e);
            return null;
        }
    }
    
    
    
    
    
    
    
    public String getSentence(String id){
        try{
            if (id == null) {
                Log.log.info("is null ids");
                return null;
            }
            else {
                String resul = "";
                Set parrafo = new HashSet();
                parrafo.add(sentences.get(Integer.parseInt(id)));
                Log.log.debug("********Sentencia: " + parrafo);
                String temp = doc.toXml(parrafo, false);
                Log.log.debug("Temporal-----------\n" + temp);
                //temp = this.getInfoLabel(temp, "<paragraph>");
                temp = this.getInfoLabel(temp, "<Sentence>");
                temp = temp.replaceAll("\n", "");
                temp = temp.replaceAll("\r", "");
                resul += temp ;
                return resul;
            }
        }catch(Exception e){
            Log.log.error(getClass(),e);
            return null;
        }
    }
    
    
    public boolean loadDoc(String doc){
        try {
            this.doc = Factory.newDocument(new File(doc).toURI().toURL());
            Corpus corpus = Factory.newCorpus(null);
            corpus.add(this.doc);
            controller.setCorpus(corpus);
            return true;
        }catch(Exception e){
            return false;
        }
    }
    
    
    
    public boolean loadAnalizator (String fileConfig){
        try {
            controller = (SerialAnalyserController)PersistenceManager.loadObjectFromUrl(getClass().getResource(fileConfig));
            return true;
        }catch(Exception e){
            e.printStackTrace();
            return false;
        }
    }
    
    public boolean addGazetter(String fileGazetter){
        try {
            LanguageAnalyser gazetter = (LanguageAnalyser)Factory.createResource(
                    "gate.creole.gazetteer.DefaultGazetteer", gate.Utils.featureMap(
                            "listsURL", getClass().getResource(fileGazetter),
                            "encoding", "UTF-8")); // ensure this matches the file
            controller.add(gazetter);
            return true;
        } catch (Exception e){
            return false;
        }
    }
    
    public boolean addJape(String fileJape){
        try {
            LanguageAnalyser jape = (LanguageAnalyser)Factory.createResource(
                    "gate.creole.Transducer", gate.Utils.featureMap(
                            "grammarURL", getClass().getResource(fileJape),
                            "encoding", "UTF-8")); // ensure this matches the file
            controller.add(jape);
            return true;
        } catch (Exception e){
            return false;
        }
    }
    
    public static boolean initGate(){
        try {
// initialise GATE
            if(Gate.getGateHome() == null)
                Gate.setGateHome(new File("C:\\Program Files\\GATE_Developer_7.1"));
            Gate.init();
            
            
// load ANNIE plugin - you must do this before you can create tokeniser
// or JAPE transducer resources.
            Gate.getCreoleRegister().registerDirectories(
                    new File(Gate.getPluginsHome(), "ANNIE").toURI().toURL());
            return true;
        } catch (Exception e){
            Log.log.error(AnalizadorPatrones.class, e);
            
            return false;
        }
    }
    
    public String getXMLfromToken(String token){
        AnnotationSet defaultAnnots = doc.getAnnotations();
        
        Set annotationsToWrite = new HashSet();
        
        // extract all the annotations of each requested type and add them to
        // the temporary set
        System.out.println("Annotationset of : " + token );
        AnnotationSet annotsOfThisType =
                defaultAnnots.get(token);
        if(annotsOfThisType != null) {
            annotationsToWrite.addAll(annotsOfThisType);
        }
        // create the XML string using these annotations
        return doc.toXml(annotationsToWrite);
    }
    public String getInfoLabel(String s,String label){
        int inicio = s.indexOf(label);
        inicio += label.length();
        int fin = s.indexOf(label.replaceAll("<", "</"));
        if (fin != -1)
            return s.substring(inicio, fin);
        else
            return null;
    }
    public static void main(String[] args) throws Exception {
        
        if(initGate()){
            AnalizadorPatrones obj = new AnalizadorPatrones();
            
            obj.loadAnalizator("C:\\Users\\QACG\\Documents\\Config\\ANNIE_with_defaults.gapp");
            obj.addGazetter("C:\\Users\\QACG\\Documents\\Config\\Gazzetter\\lists.def");
            
            obj.addJape("C:\\Users\\QACG\\Documents\\Config\\Auxiliary.jape");
            obj.addJape("C:\\Users\\QACG\\Documents\\Config\\clean.jape");
            //obj.addJape("C:\\Users\\QACG\\Documents\\Config\\Inhibits_Decision.jape");
            //obj.addJape("C:\\Users\\QACG\\Documents\\Config\\Inhibits_Rules.jape");
            obj.addJape("C:\\Users\\QACG\\Documents\\Config\\Keywords.jape");
            obj.addJape("C:\\Users\\QACG\\Documents\\Config\\Promotes.jape");
            obj.addJape("C:\\Users\\QACG\\Documents\\Config\\Promotes_Decision.jape");
            obj.addJape("C:\\Users\\QACG\\Documents\\Config\\Promotes_Rules.jape");
            obj.addJape("C:\\Users\\QACG\\Documents\\Config\\Promotes_Sentences.jape");
            obj.addJape("C:\\Users\\QACG\\Documents\\Config\\QualityAttribute.jape");
            obj.addJape("C:\\Users\\QACG\\Documents\\Config\\main.jape");
            
            obj.loadDoc("C:\\Users\\QACG\\Documents\\Pipes and Filters_ Posa.txt");
            
            obj.execute();
            String ids;
            
            ids = obj.getIds("Promotes_01");
            String salida1 = ids != null ? obj.getSentencesText(ids) : "No se encontraron patrones\n ";
            System.out.println();
            
            ids = obj.getIds("Promotes_02");
            String salida2 = ids != null ? obj.getSentencesText(ids) : "No se encontraron patrones\n ";
            System.out.println();
            
            ids = obj.getIds("Promotes_03");
            String salida3 = ids != null ? obj.getSentencesText(ids) : "No se encontraron patrones\n ";
            System.out.println();
            
            ids = obj.getIds("Promotes_04");
            String salida4 = ids != null ? obj.getSentencesText(ids) : "No se encontraron patrones\n ";
            System.out.println();
            
            ids = obj.getIds("Promotes_05");
            String salida5 = ids != null ? obj.getSentencesText(ids) : "No se encontraron patrones\n ";
            System.out.println();
            
            System.out.println("Salida 1 : \n" + salida1);
            System.out.println("Salida 2 : \n" + salida2);
            System.out.println("Salida 3 : \n" + salida3);
            System.out.println("Salida 4 : \n" + salida4);
            System.out.println("Salida 5 : \n" + salida5);
            System.out.println("------ metodo --------");
            //obj.metodo();
            
            
        } else {
            System.out.println("Gate no pudo ser inicializado.");
        }
        
    }
    
    public boolean setDocumentContend(String contenido){
        try {
            this.doc = Factory.newDocument(contenido);
            Corpus corpus = Factory.newCorpus(null);
            corpus.add(this.doc);
            controller.setCorpus(corpus);
            return true;
        }catch(Exception e){
            return false;
        }
    }
    
    public boolean setDocumentFile(File f){
        try {
            this.doc = Factory.newDocument(f.toURI().toURL());
            Corpus corpus = Factory.newCorpus(null);
            corpus.add(this.doc);
            controller.setCorpus(corpus);
            return true;
        }catch(Exception e){
            return false;
        }
    }
    
    public String getXML(){
        return doc.toXml();
    }
    
    public String getStringDoc(){
        return doc.toString();
    }
}
