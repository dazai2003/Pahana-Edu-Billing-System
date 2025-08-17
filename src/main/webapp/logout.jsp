<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    session.invalidate(); // Logs out the user by clearing the session
    response.sendRedirect("login.jsp"); // Redirects to login page
%>
