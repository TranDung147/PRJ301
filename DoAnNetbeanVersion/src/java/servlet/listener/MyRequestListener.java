/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package servlet.listener;

import jakarta.servlet.*;

/**
 *
 * @author DELL
 */
public class MyRequestListener implements ServletRequestListener{
    public void requestDestroyed(ServletRequestEvent servletRequestEvent)
    {
        ServletRequest servletRequest
            = servletRequestEvent.getServletRequest();
        System.out.println(
            "ServletRequest destroyed. Remote IP="
            + servletRequest.getRemoteAddr());
    }
    public void requestInitialized(ServletRequestEvent servletRequestEvent)
    {
        ServletRequest servletRequest
            = servletRequestEvent.getServletRequest();
        System.out.println(
            "ServletRequest initialized. Remote IP="
            + servletRequest.getRemoteAddr());
    }
}
