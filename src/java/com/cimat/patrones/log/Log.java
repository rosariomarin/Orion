/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.cimat.patrones.log;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;



/**
 *
 * @author QACG
 */
public class Log {
    public static final Logger log = Logger.getLogger(Log.class);
    static{
        PropertyConfigurator.configure(Log.class.getResource(
    "/properties/log4j.properties"));
    }
    
    public Log(){
        PropertyConfigurator.configure(Log.class.getResource(
    "/properties/log4j.properties"));
    }
    
}
