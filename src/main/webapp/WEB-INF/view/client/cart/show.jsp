<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="utf-8" />
                    <title>Giỏ hàng - Laptopshop</title>
                    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
                    <link
                        href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap"
                        rel="stylesheet" />
                    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
                    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
                        rel="stylesheet" />
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
                                        <li class="breadcrumb-item active" aria-current="page">Chi tiết Giỏ Hàng</li>
                                    </ol>
                                </nav>
                            </div>

                            <form action="/confirm-checkout" method="post">
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

                                <div class="table-responsive">
                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th scope="col">Chọn</th>
                                                <th scope="col">Sản phẩm</th>
                                                <th scope="col">Tên</th>
                                                <th scope="col">Giá cả</th>
                                                <th scope="col">Số lượng</th>
                                                <th scope="col">Thành tiền</th>
                                                <th scope="col">Xử lý</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="cartDetail" items="${cartDetails}">
                                                <tr>
                                                    <td>
                                                        <div class="mt-4">
                                                            <input class="form-check-input" type="checkbox"
                                                                name="cartDetailIds" value="${cartDetail.id}">
                                                        </div>
                                                    </td>

                                                    <input type="hidden" name="idArray" value="${cartDetail.id}" />
                                                    <input type="hidden" id="quantity-${cartDetail.id}"
                                                        name="quantityArray" value="${cartDetail.quantity}" />

                                                    <th scope="row">
                                                        <div class="d-flex align-items-center">
                                                            <img src="/images/product/${cartDetail.product.image}"
                                                                class="img-fluid me-5 rounded-circle"
                                                                style="width: 80px; height: 80px" alt="" />
                                                        </div>
                                                    </th>
                                                    <td>
                                                        <p class="mb-0 mt-4">
                                                            <a href="/product/${cartDetail.product.id}"
                                                                target="_blank">${cartDetail.product.name}</a>
                                                        </p>
                                                    </td>
                                                    <td>
                                                        <p class="mb-0 mt-4">
                                                            <fmt:formatNumber type="number"
                                                                value="${cartDetail.price}" /> đ
                                                        </p>
                                                    </td>
                                                    <td>
                                                        <div class="input-group quantity mt-4" style="width: 100px">
                                                            <div class="input-group-btn">
                                                                <button type="button"
                                                                    class="btn btn-sm btn-minus rounded-circle bg-light border">
                                                                    <i class="fa fa-minus"></i>
                                                                </button>
                                                            </div>
                                                            <input type="text"
                                                                class="form-control form-control-sm text-center border-0"
                                                                value="${cartDetail.quantity}"
                                                                data-cart-detail-id="${cartDetail.id}"
                                                                data-cart-detail-price="${cartDetail.price}" />
                                                            <div class="input-group-btn">
                                                                <button type="button"
                                                                    class="btn btn-sm btn-plus rounded-circle bg-light border">
                                                                    <i class="fa fa-plus"></i>
                                                                </button>
                                                            </div>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <p class="mb-0 mt-4" data-cart-detail-id="${cartDetail.id}">
                                                            <fmt:formatNumber type="number"
                                                                value="${cartDetail.price * cartDetail.quantity}" /> đ
                                                        </p>
                                                    </td>
                                                    <td>
                                                        <button type="button"
                                                            class="btn btn-md rounded-circle bg-light border mt-4"
                                                            onclick="handleDelete('${cartDetail.id}')">
                                                            <i class="fa fa-times text-danger"></i>
                                                        </button>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>

                                <div class="mt-5 row g-4 justify-content-start">
                                    <div class="col-12 col-md-8">
                                        <div class="bg-light rounded p-4">
                                            <h1 class="display-6 mb-4">Thông tin <span class="fw-normal">Đơn hàng</span>
                                            </h1>
                                            <div class="d-flex justify-content-between mb-4">
                                                <h5 class="mb-0 me-4">Tổng tiền (đã chọn):</h5>
                                                <p class="mb-0" data-cart-total-price="0">0 đ</p>
                                            </div>
                                            <button type="submit"
                                                class="btn border-secondary rounded-pill px-4 py-3 text-primary text-uppercase w-100">
                                                Xác nhận thanh toán
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>

                    <form id="deleteForm" method="post" style="display:none;">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                    </form>

                    <jsp:include page="../layout/footer.jsp" />

                    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
                    <script src="/client/js/main.js"></script>
                    <script>
                        function handleDelete(id) {
                            const form = document.getElementById('deleteForm');
                            form.action = '/delete-cart-product/' + id;
                            form.submit();
                        }
                    </script>
                </body>

                </html>