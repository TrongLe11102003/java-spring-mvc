<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="utf-8" />
                <title>Thanh toán - Laptopshop</title>
                <meta content="width=device-width, initial-scale=1.0" name="viewport" />

                <link rel="preconnect" href="https://fonts.googleapis.com" />
                <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
                <link
                    href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap"
                    rel="stylesheet" />

                <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
                <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
                    rel="stylesheet" />

                <link href="/client/lib/lightbox/css/lightbox.min.css" rel="stylesheet" />
                <link href="/client/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet" />

                <link href="/client/css/bootstrap.min.css" rel="stylesheet" />

                <link href="/client/css/style.css" rel="stylesheet" />
            </head>

            <body>
                <jsp:include page="../layout/header.jsp" />
                <div class="container-fluid py-5">
                    <div class="container py-5">
                        <div class="mb-3">
                            <nav aria-label="breadcrumb">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="/">Home</a></li>
                                    <li class="breadcrumb-item active" aria-current="page">Lịch sử mua hàng</li>
                                </ol>
                            </nav>
                        </div>
                        <div class="table-responsive">
                            <table class="table border">
                                <thead>
                                    <tr>
                                        <th scope="col">Sản phẩm</th>
                                        <th scope="col">Tên</th>
                                        <th scope="col">Giá cả</th>
                                        <th scope="col">Số lượng</th>
                                        <th scope="col">Thành tiền</th>
                                        <th scope="col">Trạng thái</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:if test="${empty orders}">
                                        <tr>
                                            <td colspan="6" class="text-center">Không có đơn hàng nào được tạo</td>
                                        </tr>
                                    </c:if>

                                    <c:forEach var="order" items="${orders}">
                                        <tr class="table-light">
                                            <td colspan="2"><strong>Order Id = ${order.id}</strong></td>
                                            <td>
                                                <strong>
                                                    <fmt:formatNumber type="number" value="${order.totalPrice}" /> đ
                                                </strong>
                                            </td>
                                            <td colspan="2"></td>
                                            <td><span class="badge bg-info text-dark">${order.status}</span></td>
                                        </tr>

                                        <c:forEach var="orderDetail" items="${order.orderDetails}">
                                            <tr>
                                                <th scope="row">
                                                    <div class="d-flex align-items-center">
                                                        <img src="/images/product/${orderDetail.product.image}"
                                                            class="img-fluid rounded-circle"
                                                            style="width: 70px; height: 70px" alt="" />
                                                    </div>
                                                </th>
                                                <td class="align-middle">
                                                    <a href="/product/${orderDetail.product.id}" target="_blank">
                                                        ${orderDetail.product.name}
                                                    </a>
                                                </td>
                                                <td class="align-middle">
                                                    <fmt:formatNumber type="number" value="${orderDetail.price}" /> đ
                                                </td>
                                                <td class="align-middle">${orderDetail.quantity}</td>
                                                <td class="align-middle">
                                                    <fmt:formatNumber type="number"
                                                        value="${orderDetail.price * orderDetail.quantity}" /> đ
                                                </td>
                                                <td></td>
                                            </tr>
                                        </c:forEach>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <jsp:include page="../layout/footer.jsp" />
                <a href="#" class="btn btn-primary border-3 border-primary rounded-circle back-to-top"><i
                        class="fa fa-arrow-up"></i></a>
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
                <script src="/client/lib/easing/easing.min.js"></script>
                <script src="/client/lib/waypoints/waypoints.min.js"></script>
                <script src="/client/lib/lightbox/js/lightbox.min.js"></script>
                <script src="/client/lib/owlcarousel/owl.carousel.min.js"></script>
                <script src="/client/js/main.js"></script>
            </body>

            </html>