<%-- <%@page import="java.sql.SQLException"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List" %>
<%@ page import="dao.ArtDao" %>
<%@ page import="bean.ArtBean" %>
<% 
String email = (String) session.getAttribute("email");
if (email == null) {
    response.sendRedirect("log.jsp");
    return;
}
%>
<%
    // Declare DAO and query
    ArtDao artDAO = new ArtDao();
    List<ArtBean> artworkList = new ArrayList<>();
    String query = request.getParameter("query");
    
    try {
        if (query != null && !query.isEmpty()) {
            // Search for artworks based on the query
            artworkList = artDAO.searchArtworks(query);
        } else {
            // Default artwork fetch (optional, if you want to show popular ones when no search)
            artworkList = artDAO.getAllArtworks();
        }
    } catch (SQLException e) {
        e.printStackTrace();
        request.setAttribute("errorMessage", "An error occurred while fetching artworks.");
    }

    // Pass data to the page
    request.setAttribute("artworks", artworkList);
    request.setAttribute("searchQuery", query);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Search Results</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
<style type="text/css">
        footer {
            background-color: #f8f9fa;
            padding: 1rem 0;
            text-align: center;
        }
        .navbar .nav-item {
            padding-right: 20px;
        }
        .search-table td,
        .search-table th {
            vertical-align: middle;
        }
        .search-table .product-img {
            width: 120px;
            height: auto;
        }
        .search-summary {
            border-left: 2px solid #f1f1f1;
            padding-left: 20px;
        }
        .summary-item {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
        }
        .summary-item h5 {
            margin-bottom: 0;
        }
        .search-btn {
            background-color: #f8f9fa;
            border: 1px solid #ddd;
            width: 100%;
            padding: 12px;
            color: #0a0a0a;
        }
        .search-btn:hover {
            background-color: #007bff;
            color: white;
            border-color: #007bff;
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <div class="container-fluid">
            <h3>Artevo</h3>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item"><a class="nav-link" href="home.jsp">Home</a></li>
                    <li class="nav-item"><a class="nav-link" href="shoppingCart.jsp">Shopping Cart</a></li>
                    <li class="nav-item"><a class="nav-link" href="logout.jsp">Logout</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Search Results -->
    <div class="container my-5">
        <h2 class="text-center text-danger mb-4">
            <% if (query != null && !query.isEmpty()) { %>
                Search Results for: "<%= query %>"
            <% } else { %>
                Popular Artworks
            <% } %>
        </h2>

        <div class="row">
            <c:choose>
                <c:when test="${empty artworks}">
                    <div class="alert alert-warning text-center" role="alert">
                        No artworks found. Try searching for something else!
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach var="artwork" items="${artworks}">
                        <div class="col-md-4 mb-4">
                            <a href="artworkDetail.jsp?artId=${artwork.artId}" class="text-decoration-none">
                                <div class="card art-card">
                                    <img src="uploads/${artwork.artId}.jpg" class="card-img-top" alt="${artwork.artTitle}">
                                    <div class="card-body">
                                        <h5 class="card-title">${artwork.artTitle}</h5>
                                        <p class="card-text">${artwork.artistName}</p>
                                        <h5 class="card-title">&#8377; ${artwork.artPrice}</h5>
                                        <a href="cart.jsp?artId=${artwork.artId}" class="btn btn-danger">Add to Cart</a>
                                    </div>
                                </div>
                            </a>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
    </div>



    <!-- Footer -->
    <footer>
        <p>&copy; 2024 Artevo. All Rights Reserved.</p>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
 --%>
 
<%--  <%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dao.ArtDao" %>
<%@ page import="bean.ArtBean" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<% 
    String email = (String) session.getAttribute("email");
    if (email == null) {
        response.sendRedirect("log.jsp");
        return;
    }

    // Declare DAO and query
    ArtDao artDAO = new ArtDao();
    List<ArtBean> artworkList = new ArrayList<>();
    String query = request.getParameter("query");
    
    String orderBy="";	
    
    try {
        if (query != null && !query.isEmpty()) {
            // Search for artworks based on the query
            artworkList = artDAO.searchProductByName(query);
        }/*  else {
            // Default artwork fetch (optional, if you want to show popular ones when no search)
            artworkList = artDAO.getAllArtworks();
        } */
    } catch (Exception e) {
        e.printStackTrace();
        request.setAttribute("errorMessage", "An error occurred while fetching artworks.");
    }

    // Pass data to the page
    request.setAttribute("artworks", artworkList);
    request.setAttribute("searchQuery", query);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Search Results</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style type="text/css">
        footer {
            background-color: #f8f9fa;
            padding: 1rem 0;
            text-align: center;
        }
        .navbar .nav-item {
            padding-right: 20px;
        }
        .search-table td,
        .search-table th {
            vertical-align: middle;
        }
        .search-table .product-img {
            width: 120px;
            height: auto;
        }
        .search-summary {
            border-left: 2px solid #f1f1f1;
            padding-left: 20px;
        }
        .summary-item {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
        }
        .summary-item h5 {
            margin-bottom: 0;
        }
        .search-btn {
            background-color: #f8f9fa;
            border: 1px solid #ddd;
            width: 100%;
            padding: 12px;
            color: #0a0a0a;
        }
        .search-btn:hover {
            background-color: #007bff;
            color: white;
            border-color: #007bff;
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <div class="container-fluid">
            <h3>Artevo</h3>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item"><a class="nav-link" href="home.jsp">Home</a></li>
                    <li class="nav-item"><a class="nav-link" href="shoppingCart.jsp">Shopping Cart</a></li>
                    <li class="nav-item"><a class="nav-link" href="logout.jsp">Logout</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Search Results -->
    <div class="container my-5">
        <h2 class="text-center text-danger mb-4">
            <% if (query != null && !query.isEmpty()) { %>
                Search Results for: "<%= query %>"
            <% } else { %>
                Popular Artworks
            <% } %>
        </h2>

        <div class="row">
            <c:choose>
                <c:when test="${empty artworks}">
                    <div class="alert alert-warning text-center" role="alert">
                        No artworks found. Try searching for something else!
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach var="artwork" items="${artworks}">
                        <div class="col-md-4 mb-4">
                            <a href="artworkDetail.jsp?artId=${artwork.artId}" class="text-decoration-none">
                                <div class="card art-card">
                                    <img src="uploads/${artwork.artId}.jpg" class="card-img-top" alt="${artwork.artTitle}">
                                    <div class="card-body">
                                        <h5 class="card-title">${artwork.artTitle}</h5>
                                        <p class="card-text">${artwork.artistName}</p>
                                        <h5 class="card-title">&#8377; ${artwork.artPrice}</h5>
                                        <a href="cart.jsp?artId=${artwork.artId}" class="btn btn-danger">Add to Cart</a>
                                    </div>
                                </div>
                            </a>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- Footer -->
    <footer>
        <p>&copy; 2024 Artevo. All Rights Reserved.</p>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
  --%>


<%-- <%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dao.ArtDao" %>
<%@ page import="bean.ArtBean" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<% 
    String email = (String) session.getAttribute("email");
    if (email == null) {
        response.sendRedirect("log.jsp");
        return;
    }

    // Declare DAO and query
    ArtDao artDAO = new ArtDao();
    List<ArtBean> artworkList = new ArrayList<>();
    String query = request.getParameter("query");
    
    try {
        if (query != null && !query.isEmpty()) {
            // Search for artworks based on the query
            artworkList = artDAO.searchProductByName(query); // Call the correct DAO method
        } else {
            // Default artwork fetch (optional, if you want to show popular ones when no search)
            // artworkList = artDAO.getAllArtworks(); // Optional: Implement if needed
        }
    } catch (SQLException e) {
        e.printStackTrace();
        request.setAttribute("errorMessage", "An error occurred while fetching artworks.");
    }

    // Pass data to the page
    request.setAttribute("artworks", artworkList);
    request.setAttribute("searchQuery", query);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Search Results</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style type="text/css">
        footer {
            background-color: #f8f9fa;
            padding: 1rem 0;
            text-align: center;
        }
        .navbar .nav-item {
            padding-right: 20px;
        }
        .search-table td,
        .search-table th {
            vertical-align: middle;
        }
        .search-table .product-img {
            width: 120px;
            height: auto;
        }
        .search-summary {
            border-left: 2px solid #f1f1f1;
            padding-left: 20px;
        }
        .summary-item {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
        }
        .summary-item h5 {
            margin-bottom: 0;
        }
        .search-btn {
            background-color: #f8f9fa;
            border: 1px solid #ddd;
            width: 100%;
            padding: 12px;
            color: #0a0a0a;
        }
        .search-btn:hover {
            background-color: #007bff;
            color: white;
            border-color: #007bff;
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <div class="container-fluid">
            <h3>Artevo</h3>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item"><a class="nav-link" href="home.jsp">Home</a></li>
                    <li class="nav-item"><a class="nav-link" href="shoppingCart.jsp">Shopping Cart</a></li>
                    <li class="nav-item"><a class="nav-link" href="logout.jsp">Logout</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Search Results -->
    <div class="container my-5">
        <h2 class="text-center text-danger mb-4">
            <% if (query != null && !query.isEmpty()) { %>
                Search Results for: "<%= query %>"
            <% } else { %>
                Popular Artworks
            <% } %>
        </h2>

        <div class="row">
            <c:choose>
                <c:when test="${empty artworks}">
                    <div class="alert alert-warning text-center" role="alert">
                        No artworks found. Try searching for something else!
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach var="artwork" items="${artworks}">
                        <div class="col-md-4 mb-4">
                            <a href="artworkDetail.jsp?artId=${artwork.artId}" class="text-decoration-none">
                                <div class="card art-card">
                                    <img src="uploads/${artwork.artId}.jpg" class="card-img-top" alt="${artwork.artTitle}">
                                    <div class="card-body">
                                        <h5 class="card-title">${artwork.artTitle}</h5>
                                        <p class="card-text">${artwork.artistName}</p>
                                        <h5 class="card-title">&#8377; ${artwork.artPrice}</h5>
                                        <a href="cart.jsp?artId=${artwork.artId}" class="btn btn-danger">Add to Cart</a>
                                    </div>
                                </div>
                            </a>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- Footer -->
    <footer>
        <p>&copy; 2024 Artevo. All Rights Reserved.</p>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
   --%>
   
<%--    
<%@ page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dao.ArtDao" %>
<%@ page import="bean.ArtBean" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<% 
    String email = (String) session.getAttribute("email");
    if (email == null) {
        response.sendRedirect("log.jsp");
        return;
    }

    // Declare DAO and query
    ArtDao artDAO = new ArtDao();
    List<ArtBean> artworkList = new ArrayList<>();
    String query = request.getParameter("query");
    
    try {
        if (query != null && !query.isEmpty()) {
            // Search for artworks based on the query
            artworkList = artDAO.searchProductByName(query);
        }
    } catch (SQLException e) {
        e.printStackTrace();
        request.setAttribute("errorMessage", "An error occurred while fetching artworks.");
    }

    // Pass data to the page
    request.setAttribute("artworks", artworkList);
    request.setAttribute("searchQuery", query);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Search Results</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style type="text/css">
        footer {
            background-color: #f8f9fa;
            padding: 1rem 0;
            text-align: center;
        }
        .navbar .nav-item {
            padding-right: 20px;
        }
        .search-table td,
        .search-table th {
            vertical-align: middle;
        }
        .search-table .product-img {
            width: 120px;
            height: auto;
        }
        .search-summary {
            border-left: 2px solid #f1f1f1;
            padding-left: 20px;
        }
        .summary-item {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
        }
        .summary-item h5 {
            margin-bottom: 0;
        }
        .search-btn {
            background-color: #f8f9fa;
            border: 1px solid #ddd;
            width: 100%;
            padding: 12px;
            color: #0a0a0a;
        }
        .search-btn:hover {
            background-color: #007bff;
            color: white;
            border-color: #007bff;
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <div class="container-fluid">
            <h3>Artevo</h3>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item"><a class="nav-link" href="home.jsp">Home</a></li>
                    <li class="nav-item"><a class="nav-link" href="shoppingCart.jsp">Shopping Cart</a></li>
                    <li class="nav-item"><a class="nav-link" href="logout.jsp">Logout</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Search Results -->
    <div class="container my-5">
        <h2 class="text-center text-danger mb-4">
            <% if (query != null && !query.isEmpty()) { %>
                Search Results for: "<%= query %>"
            <% } else { %>
                Popular Artworks
            <% } %>
        </h2>

        <div class="row">
            <c:choose>
                <c:when test="${empty artworks}">
                    <div class="alert alert-warning text-center" role="alert">
                        No artworks found. Try searching for something else!
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach var="artwork" items="${artworks}">
                        <div class="col-md-4 mb-4">
                            <a href="artworkDetail.jsp?artId=${artwork.artId}" class="text-decoration-none">
                                <div class="card art-card">
                                    <img src="uploads/${artwork.artId}.jpg" class="card-img-top" alt="${artwork.artTitle}">
                                    <div class="card-body">
                                        <h5 class="card-title">${artwork.artTitle}</h5>
                                        <p class="card-text">${artwork.artistName}</p>
                                        <h5 class="card-title">&#8377; ${artwork.artPrice}</h5>
                                        <a href="cart.jsp?artId=${artwork.artId}" class="btn btn-danger">Add to Cart</a>
                                    </div>
                                </div>
                            </a>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- Footer -->
    <footer>
        <p>&copy; 2024 Artevo. All Rights Reserved.</p>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
    --%>
<%@ page import="java.sql.SQLException" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List" %>
<%@ page import="dao.ArtDao" %>
<%@ page import="bean.ArtBean" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    String query = request.getParameter("query");
    ArtDao artDao = new ArtDao();
    List<ArtBean> artworks = null;
    
    if (query != null && !query.trim().isEmpty()) {
        try {
            artworks = artDao.searchArtworks(query);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred while fetching artworks.");
        }
    }
    request.setAttribute("artworks", artworks);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Search Artworks</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <!-- Search Form -->
    <div class="container my-5">
        <h2 class="text-center">Search Artworks</h2>
        <form method="get" action="search.jsp">
            <div class="input-group mb-4">
                <input type="text" class="form-control" placeholder="Search by title, artist, or genre" name="query" value="<%= query != null ? query : "" %>">
                <button class="btn btn-primary" type="submit">Search</button>
            </div>
        </form>
        
        <c:choose>
                <c:when test="${empty artworks}">
        <div class="alert alert-warning text-center" role="alert">
            No artworks found for "<%= query %>". Try a different search.
        </div>
            </c:when>
            <c:otherwise>			
                <div class="row">
                    <c:forEach var="artwork" items="${artworks}">
                        <div class="col-md-4 mb-4">
                            <div class="card">
                                <img src="uploads/${artwork.uploadImage}" class="card-img-top" alt="${artwork.artTitle}">
                                <div class="card-body">
                                    <h5 class="card-title">${artwork.artTitle}</h5>
                                    <p class="card-text">${artwork.artistName}</p>
                                    <p class="card-text">Genre: ${artwork.artGenre}</p>
                                    <p class="card-text">Price: ₹${artwork.artPrice}</p>
                                    <a href="artworkDetail.jsp?artId=${artwork.artId}" class="btn btn-info">View Details</a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
