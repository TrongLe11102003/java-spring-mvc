<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <title>Thanh toán - Laptopshop</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <link href="/client/css/bootstrap.min.css" rel="stylesheet" />
    <link href="/client/css/style.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
</head>

<body>
    <jsp:include page="../layout/header.jsp" />

    <div class="container-fluid py-5">
        <div class="container py-5">
            <h1 class="mb-4">Thông tin thanh toán</h1>
            <div class="row g-5">
                <div class="col-md-12 col-lg-6 col-xl-7">
                    <div class="table-responsive">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th scope="col">Sản phẩm</th>
                                    <th scope="col">Tên</th>
                                    <th scope="col">Giá</th>
                                    <th scope="col">Số lượng</th>
                                    <th scope="col">Tổng</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="cartDetail" items="${cartDetails}">
                                    <tr>
                                        <th scope="row">
                                            <img src="/images/product/${cartDetail.product.image}" class="img-fluid rounded-circle" style="width: 50px; height: 50px;" alt="">
                                        </th>
                                        <td>${cartDetail.product.name}</td>
                                        <td><fmt:formatNumber value="${cartDetail.price}" type="number"/> đ</td>
                                        <td>${cartDetail.quantity}</td>
                                        <td><fmt:formatNumber value="${cartDetail.price * cartDetail.quantity}" type="number"/> đ</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>

                <div class="col-md-12 col-lg-6 col-xl-5">
                    <form action="/place-order" method="post">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                        
                        <c:forEach var="cd" items="${cartDetails}">
                            <input type="hidden" name="selectedCartDetailIds" value="${cd.id}" />
                        </c:forEach>

                        <div class="mb-3">
                            <label class="form-label">Tên người nhận</label>
                            <input type="text" class="form-control" name="receiverName" value="${user.fullName}" required />
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Địa chỉ cụ thể</label>
                            <input type="text" class="form-control" name="receiverAddress" value="${user.address}" required />
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Số điện thoại</label>
                            <input type="text" class="form-control" name="receiverPhone" value="${user.phone}" required />
                        </div>

                        <div class="bg-light p-4 rounded">
                            <div class="d-flex justify-content-between mb-2">
                                <h5>Tổng cộng:</h5>
                                <h5 class="text-primary"><fmt:formatNumber value="${totalPrice}" type="number"/> đ</h5>
                            </div>
                            <button type="submit" class="btn btn-primary w-100 py-3 text-uppercase">Đặt hàng ngay</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="../layout/footer.jsp" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>