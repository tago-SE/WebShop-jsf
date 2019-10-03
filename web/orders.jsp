<%@ page import="static view.Commands.*" %>
<%@ page import="view.viewmodels.User" %>
<%@ page import="static view.Pages.*" %>
<%@ page import="view.viewmodels.Order" %>
<%@ page import="java.util.List" %>
<%@ page import="view.viewmodels.OrderItem" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Orders</title>
</head>
<body>
<%
    User user = (User) session.getAttribute(ARG_CURR_USER);
    if (user == null)
    {
        response.sendRedirect(LOGIN_JSP);
        return;
    }
%>
<div style="color:#00FF00;">${successResponse}</div><br>
<div style="color:#FF0000;">${errorResponse}</div><br>
<table>
    <tr>
        <!-- Logout -->
        <form method="post" action="Users">
            <input type="hidden" name=<%=  COMMAND%> value=<%=  LOGOUT_COMMAND%>>
            <input type="submit" value="logout">
        </form>
        <!-- Go Home -->
        <form method="post" action=<%=USERS_SERVLET%>>
            <input type="hidden" name=<%=  COMMAND%> value=<%=  GOTO_CMD%>>
            <input type="hidden" name=<%=REDIRECT_ARG%> value=<%=HOME_JSP%>>
            <input type="submit" value="home">
        </form>
    </tr><tr>
    <form method="post" action=<%=SHOPPING_SERVLET%>>
        <input type="hidden" name=<%=COMMAND%> value=<%=GET_ALL_ORDERS%>>
        <input type="hidden" name=<%=REDIRECT_ARG%> value=<%=ORDERS_JSP%>>
        <input type="submit" value="Refresh">
    </form>
</tr>
</table>

<table>
    <th>id</th><th>username</th><th>status</th><th>cost</th><th>sent</th><th>delivered</th>
<%
    List<Order> orders = (List<Order>) session.getAttribute(ORDERS_ARG);
    if (orders != null)
    {
        for (Order order : orders)
        {
%>
        <tr>
            <td><%=order.id%></td>
            <td><%=order.user.name%></td>
            <td><%=order.status%></td>
            <td><%=order.cost%></td>
            <td><%=order.sent%></td>
            <td><%=order.delivered%></td>
        </tr>
        <tr>
        <table>
<%
            for (OrderItem item : order.orderItems)
            {
%>
                <tr>[(<%=item.item.id%>)<%=item.item.name%> x<%=item.amount%>]</tr>
<%
            }
%>
        </table>
        </tr>
<%
        }
    }
%>
</table>
</body>
</html>
