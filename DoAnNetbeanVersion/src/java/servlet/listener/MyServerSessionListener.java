/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package servlet.listener;

import jakarta.servlet.*;
import jakarta.servlet.http.*;

/**
 *
 * @author DELL
 */
public class MyServerSessionListener implements HttpSessionListener {
    public void sessionCreated(HttpSessionEvent sessionEvent)
    {
        System.out.println("Session Created:: ID=" + sessionEvent.getSession().getId());
    }
    public void sessionDestroyed(HttpSessionEvent sessionEvent)
    {
        System.out.println("Session Destroyed:: ID=" + sessionEvent.getSession().getId());
    
    }
}