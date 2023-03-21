# Use a base image with Java and Tomcat installed
FROM tomcat:9-jdk8-corretto

# Copy the JSP file to the container
COPY src/main/webapp/index.jsp /usr/local/tomcat/webapps/ROOT/index.jsp

# Expose port 8080
EXPOSE 8080

# Start Tomcat with support for JSP files
CMD ["catalina.sh", "run"]
