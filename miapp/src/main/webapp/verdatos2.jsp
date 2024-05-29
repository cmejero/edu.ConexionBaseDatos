<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@page import="mipk.beanDB"%>
<%@page import="java.sql.SQLException"%>

<%
try {  //AQUI VA EL CONTROL DE SESION
	String acceso = session.getAttribute("attributo1").toString();
 	if (!acceso.equals("1")) response.sendRedirect("cerrarsesion.jsp");
} catch (Exception e) {
	response.sendRedirect("cerrarsesion.jsp");
}

beanDB db = new beanDB();
boolean okdb = false;
String resultado = "";

try {
	db.conectarBD();
	okdb = true;
} catch (Exception e) {
	okdb = false;
	//e.printStackTrace();
}
if (okdb) {
	String query=" select nombre, nombre_juego, nombre_genero, precioCompra, marcatiempo from clientes join compras on (idCliente = cliente_Id) join videojuegos on (videojuego_Id = idVideojuego) join generos on (idGenero= genero_id) where precioCompra < 10";
			


	String [][] tablares = null;
	try {
		tablares = db.resConsultaSelectA3(query);
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	if (tablares != null) {
		
		resultado = "<table style='border: 1px solid black'; text-align: center>";
		for (int i=0; i<tablares.length;i++) { //g es una variable tipo grupo que va recorriendo la lista
			resultado += "<tr style='border: 1px solid black;'>";
			resultado += "<td style='border: 1px solid black; background-color: #AED6F1 '>" + tablares[i][0] + "</td>";
			resultado += "<td style='border: 1px solid black;background-color: #AED6F1'>" + tablares[i][1] + "</td>";
			resultado += "<td style='border: 1px solid black;background-color: #AED6F1'>" + tablares[i][2] + "</td>";
			resultado += "<td style='border: 1px solid black;background-color: #AED6F1'>" + tablares[i][3] + "</td>";
			resultado += "<td style='border: 1px solid black;background-color: #AED6F1'>" + tablares[i][4] + "</td>";
			resultado += "</tr>";
		}
		resultado += "</table>";
		
	}
	db.desconectarBD();
}
else {
	resultado = "<div style='color: darkred; font-weight: bold;'>ERROR: No se pudo conectar con la BBDD</div>";
}


%>
<html>
<head>

<link rel="stylesheet" href="common/general.css">

</head>
<body>
<h1><%=session.getAttribute("attributo2") %>: Estos son los datos datos</h1>
<hr/>
<p><a href="bienvenido.jsp">Página principal</a></p>
<p><a href="cerrarsesion.jsp">Salir</a></p>
<hr/>

<table style='border: 1px solid black; text-align: center; margin-left: 27%; border-collapse: collapse'><caption style='margin-bottom: 1%; margin-top: 2%; color: white'><b><i><u>- Compra videojuegos con un precio inferior a 10€ -</u></i></b></caption><thead><tr><th style='border: 1px solid black;background-color:#5DADE2'>Nombre</th><th style='border: 1px solid black;background-color:#5DADE2'>Videojuego</th><th style='border: 1px solid black;background-color:#5DADE2'>Genero</th><th style='border: 1px solid black; background-color:#5DADE2'>Precio compra</th><th style='border: 1px solid black; background-color:#5DADE2'>Fecha compra</th></tr></thead>
<tbody  <%=resultado %></tbody>
</table>




</body></html>