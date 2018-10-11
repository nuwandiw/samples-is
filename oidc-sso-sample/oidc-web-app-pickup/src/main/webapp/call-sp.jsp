<%@ page import="org.apache.http.HttpEntity" %>
<%@ page import="org.apache.http.HttpResponse" %>
<%@ page import="org.apache.http.impl.client.CloseableHttpClient" %>
<%@ page import="org.apache.http.client.methods.HttpPost" %>
<%@ page import="org.apache.http.entity.StringEntity" %>
<%@ page import="org.wso2.sample.identity.oauth2.SampleContextEventListener" %>
<%@ page import="java.util.Properties" %>
<%@ page import="org.apache.http.impl.client.HttpClientBuilder" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<%
    Properties properties = SampleContextEventListener.getProperties();
    String spUrl = properties.getProperty("riskUrl");

    String username = request.getParameter("username");
    String sessionState = request.getParameter("session_state");

CloseableHttpClient httpClient = HttpClientBuilder.create().build();

try {
    HttpPost postRequest = new HttpPost(spUrl);
    StringEntity params =new StringEntity("{\"event\":{\"username\":\"" + username + "\",\"transaction\":\"1\"}} ");
    postRequest.addHeader("content-type", "application/json");
    postRequest.addHeader("Accept", "application/json");
    postRequest.setEntity(params);
    httpClient.execute(postRequest);
%>
<script type="text/javascript">
    window.location = "home.jsp?session_state=<%=sessionState%>&cancelled=true";
</script>
<%
    } catch (Exception e) {
%>

<script type="text/javascript">
    window.location = "index.jsp";
</script>

<%
    } finally {
        httpClient.close();
    }
%>
