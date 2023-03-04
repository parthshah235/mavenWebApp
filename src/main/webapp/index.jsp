<%@ page import="java.time.LocalTime" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.util.Locale" %>
<%
    LocalTime now = LocalTime.now();
    String time = now.format(DateTimeFormatter.ofPattern("HH:mm"));
    String greeting;
    if (now.isBefore(LocalTime.NOON)) {
        greeting = "Good morning";
    } else {
        greeting = "Good afternoon";
    }
    String name = "Parth";
    String message = String.format("%s, %s, Welcome to COMP367! It's currently %s.", greeting, name, time);
%>
<h1><%= message %></h1>
