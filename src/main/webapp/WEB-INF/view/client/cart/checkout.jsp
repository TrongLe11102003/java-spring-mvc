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
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap" rel="stylesheet" />

    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet" />

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
                        <li class="breadcrumb-item active" aria-current="page">Thanh toán</li>
                    </ol>
                </nav>
            </div>

            <div class="table-responsive">
                <table class="table">
                    <thead>
                        <tr>
                            <th scope="col">Sản phẩm</th>
                            <th scope="col">Tên</th>
                            <th scope="col">Giá cả</th>
                            <th scope="col">Số lượng</th>
                            <th scope="col">Thành tiền</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="cartDetail" items="${cartDetails}">
                            <tr>
                                <th scope="row">
                                    <div class="d-flex align-items-center">
                                        <img src="/images/product/${cartDetail.product.image}" class="img-fluid me-5 rounded-circle" style="width: 80px; height: 80px" alt="" />
                                    </div>
                                </th>
                                <td>
                                    <p class="mb-0 mt-4">
                                        <a href="/product/${cartDetail.product.id}" target="_blank">
                                            ${cartDetail.product.name}
                                        </a>
                                    </p>
                                </td>
                                <td>
                                    <p class="mb-0 mt-4">
                                        <fmt:formatNumber type="number" value="${cartDetail.price}" /> đ
                                    </p>
                                </td>
                                <td>
                                    <div class="mt-4">
                                        ${cartDetail.quantity}
                                    </div>
                                </td>
                                <td>
                                    <p class="mb-0 mt-4">
                                        <fmt:formatNumber type="number" value="${cartDetail.price * cartDetail.quantity}" /> đ
                                    </p>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <div class="container py-5">
                <form action="/place-order" method="post">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

                    <div class="row">
                        <div class="col-md-7">
                            <h4>Thông Tin Người Nhận</h4>
                            <div class="mb-3">
                                <label class="form-label">Tên người nhận</label>
                                <input type="text" class="form-control" name="receiverName" required />
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Địa chỉ người nhận</label>
                                <input type="text" class="form-control" name="receiverAddress" required />
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Số điện thoại</label>
                                <input type="text" class="form-control" name="receiverPhone" required />
                            </div>

                            <a href="/cart" class="btn btn-outline-secondary mt-3">← Quay lại giỏ hàng</a>
                        </div>

                        <div class="col-md-5">
                            <div class="card p-4 bg-light">
                                <h4>Thông Tin Thanh Toán</h4>
                                <div class="d-flex justify-content-between mt-3">
                                    <span>Phí vận chuyển</span>
                                    <span>0 đ</span>
                                </div>
                                <div class="d-flex justify-content-between mt-3">
                                    <span>Hình thức</span>
                                    <span>Thanh toán khi nhận hàng (COD)</span>
                                </div>
                                <hr>
                                <div class="d-flex justify-content-between mb-4">
                                    <strong>Tổng số tiền</strong>
                                    <strong class="text-primary">
                                        <fmt:formatNumber value="${totalPrice}" type="number"/> đ
                                    </strong>
                                </div>
                                <button type="submit" class="btn border-secondary rounded-pill px-4 py-3 text-primary text-uppercase w-100">
                                    XÁC NHẬN THANH TOÁN
                                </button>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <jsp:include page="../layout/footer.jsp" />

    <a href="#" class="btn btn-primary border-3 border-primary rounded-circle back-to-top"><i class="fa fa-arrow-up"></i></a>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="/client/lib/easing/easing.min.js"></script>
    <script src="/client/lib/waypoints/waypoints.min.js"></script>
    <script src="/client/lib/lightbox/js/lightbox.min.js"></script>
    <script src="/client/lib/owlcarousel/owl.carousel.min.js"></script>
    <script src="/client/js/main.js"></script>
</body>
</html>