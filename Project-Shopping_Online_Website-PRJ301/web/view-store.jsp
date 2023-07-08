<%-- Created on : Jul 4, 2023, 8:43:08 PM by DuyDuc94--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import = "java.util.*" %>
<%@page import = "model.*" %>
<%@page import = "dal.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <!-- Google font -->
        <link href="https://fonts.googleapis.com/css?family=Montserrat:400,500,700" rel="stylesheet"/>
        <!-- Bootstrap -->
        <link type="text/css" rel="stylesheet" href="templates/css/bootstrap.min.css" />
        <!-- Slick -->
        <link type="text/css" rel="stylesheet" href="templates/css/slick.css" />
        <link type="text/css" rel="stylesheet" href="templates/css/slick-theme.css" />
        <!-- nouislider -->
        <link type="text/css" rel="stylesheet" href="templates/css/nouislider.min.css" />
        <!-- Font Awesome Kit v5 -->
        <script src="https://kit.fontawesome.com/db3e6c46fb.js" crossorigin="anonymous"></script>
        <!-- Custom stlylesheet -->
        <link type="text/css" rel="stylesheet" href="templates/css/style.css" />
        <title>Home Page</title>
    </head>

    <body>
        <%@include file="templates/header.jsp" %>

        <%
            CategoryDAO cateDAO = new CategoryDAO();
            List<Category> categories = cateDAO.getCategories();
        %>

        <c:set var="listCategories" value="<%=categories%>"/>
        <c:set var="listBrands" value="${requestScope['listBrands']}" />
        <c:set var="listProducts" value="${requestScope['listProducts']}" />

        <c:set var="categoryChecked" value="${requestScope['categoryChecked']}" />
        <c:set var="brandChecked" value="${requestScope['brandChecked']}" />

        <!-- BREADCRUMB -->
        <div id="breadcrumb" class="section">
            <div class="container">
                <div class="row">
                    <div class="col-md-12">
                        <ul class="breadcrumb-tree">
                            <h3 class="breadcrumb-header">Store</h3>
                            <li class="active"><a href="homepage">Home</a></li>
                                <c:if test="${categoryChecked!='All'}">
                                <li><a href="search?category=All">All Categories</a></li>
                                </c:if>
                                <c:if test="${categoryChecked!=null}">
                                <li><a href="search?category=${categoryChecked}">${categoryChecked}</a></li>
                                </c:if>
                                <c:if test="${brandChecked!=null}">
                                <li class="active"><a href="#">${brandChecked}</a></li>
                                </c:if>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <!-- /BREADCRUMB -->

        <!-- SECTION -->
        <div class="section">
            <!-- container -->
            <div class="container">
                <!-- row -->
                <div class="row">
                    <!-- ASIDE -->
                    <form action="search" method="get" id="search">
                        <div id="aside" class="col-md-3">

                            <!-- Aside-widget List Categories-->
                            <div class="aside">
                                <h3 class="aside-title">Categories</h3>
                                <div class="checkbox-filter">
                                    <c:forEach var="category" items="${listCategories}">
                                        <div class="input-checkbox">
                                            <input type="radio" name="category" value="${category.getName()}" id="${category.getID()}" onclick="window.location.href = 'search?category=${category.getName()}'" ${category.getName()==categoryChecked?'checked':''}>
                                            <label for="${category.getID()}">
                                                <span></span>
                                                ${category.getName()}
                                                <small>(${category.getQuantity()})</small>
                                            </label>
                                        </div>
                                    </c:forEach>
                                    </form>
                                </div>
                            </div>
                            <!-- Aside-widget List Categories-->

                            <!-- Aside-widget List Brand-->
                            <c:if test="${listBrands.size()!=0}">
                                <div class="aside">
                                    <h3 class="aside-title">Brand</h3>
                                    <c:forEach var="brand" items="${listBrands}">
                                        <div class="checkbox-filter">
                                            <div class="input-checkbox">
                                                <input name="brand" value="${brand.getName()}" type="radio" id="${brand.getName()}" onchange="$('#search').submit();" ${brand.getName()==brandChecked?'checked':''}>
                                                <label for="${brand.getName()}">
                                                    <span></span>
                                                    ${brand.getName()}
                                                    <small>(${brand.getQuantity()})</small>
                                                </label>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </c:if>
                            <!-- Aside-widget List Brand-->
                        </div>
                    </form>
                    <!-- /ASIDE -->

                    <!-- STORE -->
                    <div id="store" class="col-md-9">
                        <!-- store top filter -->
                        <div class="store-filter clearfix">
                            <div class="store-sort">
                                <label>
                                    Sort By:
                                    <select name="type" class="input-select">
                                        <option value="name">Name</option>
                                        <option value="price">Price</option>
                                        <option value="sold">Sold</option>
                                    </select>
                                </label>
                                <input type="radio" name="sortType" value="ascending" id="ascending">
                                <label for="ascending">Ascending</label>
                                <input type="radio" name="sortType" value="descending" id="descending">
                                <label for="descending">Descending</label>
                            </div>
                        </div>
                        <!-- /store top filter -->

                        <!-- store products -->
                        <div class="row">
                            <c:if test="${listProducts.size()==0}">
                                <p class="text-center" style="color: red">No products found</p>
                            </c:if>
                            <!-- product -->
                            <c:forEach var="product" items="${listProducts}">
                                <div class="col-md-4 col-xs-6">
                                    <%@include file="templates/product-tab.jsp" %>
                                </div>
                                <!--<div class="clearfix visible-sm visible-xs"></div>-->
                            </c:forEach>
                            <!-- /product -->
                            <!--<div class="clearfix visible-lg visible-md visible-sm visible-xs"></div>-->
                        </div>
                        <!-- /store products -->

                        <!-- store paging -->
                        <c:if test="${listProducts.size()>0}">
                            <div class="store-filter clearfix">
                                <span class="store-qty">Showing ${listProducts.size()} products</span>
                                <ul class="store-pagination">
                                    <c:set var="numOfPage" value="${requestScope['numOfPage']}"/>
                                    <c:set var="currPage" value="${requestScope['currPage']}"/>
                                    <c:forEach var="i" begin="1" end="${numOfPage}">
                                        <c:if test="${brandChecked!=null}">
                                            <li class="${currPage==i?'active':''}">
                                                <a href="search?category=${categoryChecked}&brand=${brandChecked}&page=${i}">${i}</a>
                                            </li>
                                        </c:if>
                                        <c:if test="${brandChecked==null}">
                                            <li class="${currPage==i?'active':''}">
                                                <a href="search?category=${categoryChecked}&page=${i}">${i}</a>
                                            </li>
                                        </c:if>
                                    </c:forEach>
                                    <c:if test="${currPage!=numOfPage}">
                                        <c:if test="${brandChecked!=null}">
                                            <li>
                                                <a href="search?category=${categoryChecked}&brand=${brandChecked}&page=${currPage+1}"><i class="fa fa-angle-right"></i></a>
                                            </li>
                                        </c:if>
                                        <c:if test="${brandChecked==null}">
                                            <li>
                                                <a href="search?category=${categoryChecked}&page=${currPage+1}"><i class="fa fa-angle-right"></i></a>
                                            </li>
                                        </c:if>
                                    </c:if>
                                </ul>
                            </div>
                        </c:if>
                        <!-- /store paging -->
                    </div>
                    <!-- /STORE -->
                </div>
            </div>
        </div>
        <!-- /SECTION -->

        <!-- FOOTER -->
        <%@include file="templates/footer.jsp" %>
        <!-- /FOOTER -->

        <!-- jQuery Plugins -->
        <script src="templates/js/jquery.min.js"></script>
        <script src="templates/js/bootstrap.min.js"></script>
        <script src="templates/js/slick.min.js"></script>
        <script src="templates/js/nouislider.min.js"></script>
        <script src="templates/js/jquery.zoom.min.js"></script>
        <script src="templates/js/main.js"></script>
        <!-- /jQuery Plugins -->
    </body>
</html>
