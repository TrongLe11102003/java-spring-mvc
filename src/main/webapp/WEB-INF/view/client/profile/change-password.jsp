<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8" />
            <meta name="viewport" content="width=device-width, initial-scale=1.0" />
            <title>Đổi mật khẩu - Laptopshop</title>

            <link rel="preconnect" href="https://fonts.googleapis.com" />
            <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
            <link
                href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap"
                rel="stylesheet" />
            <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
            <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet" />
            <link href="/client/css/bootstrap.min.css" rel="stylesheet" />
            <link href="/client/css/style.css" rel="stylesheet" />
        </head>

        <body>
            <jsp:include page="../layout/header.jsp" />

            <div class="container-fluid py-5 mt-5">
                <div class="container py-5">
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="/">Trang chủ</a></li>
                            <li class="breadcrumb-item active" aria-current="page">Đổi mật khẩu</li>
                        </ol>
                    </nav>

                    <div class="row g-4">
                        <div class="col-lg-3">
                            <div class="p-4 border rounded shadow-sm bg-light">
                                <div class="text-center mb-4">
                                    <img src="${sessionScope.avatar}" class="img-fluid rounded-circle border"
                                        style="width: 100px; height: 100px; object-fit: cover;" alt="Avatar">
                                    <h5 class="mt-3">${sessionScope.fullName}</h5>
                                </div>
                                <div class="list-group list-group-flush">
                                    <a href="/profile" class="list-group-item list-group-item-action">
                                        <i class="bi bi-person me-2"></i> Hồ sơ
                                    </a>
                                    <a href="/change-password" class="list-group-item list-group-item-action active">
                                        <i class="bi bi-key me-2"></i> Đổi mật khẩu
                                    </a>
                                </div>
                            </div>
                        </div>

                        <div class="col-lg-9">
                            <div class="p-4 border rounded shadow-sm bg-white">
                                <h4 class="mb-4">Thay đổi mật khẩu</h4>

                                <c:if test="${not empty error}">
                                    <div class="alert alert-danger">${error}</div>
                                </c:if>

                                <form action="/change-password" method="post" id="changePasswordForm">
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

                                    <div class="row g-3">
                                        <div class="col-md-8">
                                            <label class="form-label">Mật khẩu hiện tại</label>
                                            <div class="input-group">
                                                <input type="password" class="form-control" name="oldPassword" required>
                                                <span class="input-group-text"><i
                                                        class="bi bi-eye-slash toggle-password"></i></span>
                                            </div>
                                        </div>

                                        <div class="col-md-8">
                                            <label class="form-label">Mật khẩu mới</label>
                                            <div class="input-group">
                                                <input type="password" class="form-control" id="newPassword"
                                                    name="newPassword" required>
                                                <span class="input-group-text"><i
                                                        class="bi bi-eye-slash toggle-password"></i></span>
                                            </div>
                                        </div>

                                        <div class="col-md-8">
                                            <label class="form-label">Xác nhận mật khẩu mới</label>
                                            <div class="input-group">
                                                <input type="password" class="form-control" id="confirmPassword"
                                                    name="confirmPassword" required>
                                                <span class="input-group-text"><i
                                                        class="bi bi-eye-slash toggle-password"></i></span>
                                            </div>
                                            <div id="passwordError" class="text-danger small mt-1"
                                                style="display:none;">
                                                Mật khẩu xác nhận không khớp!
                                            </div>
                                        </div>

                                        <div class="col-12 mt-4">
                                            <button type="submit"
                                                class="btn btn-primary px-4 py-2 text-white rounded-pill">
                                                Cập nhật mật khẩu
                                            </button>
                                            <a href="/profile" class="btn btn-light px-4 py-2 rounded-pill ms-2">Hủy
                                                bỏ</a>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <jsp:include page="../layout/footer.jsp" />

            <!-- JavaScript Libraries -->
            <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
            <script src="/client/lib/easing/easing.min.js"></script>
            <script src="/client/lib/waypoints/waypoints.min.js"></script>
            <script src="/client/lib/lightbox/js/lightbox.min.js"></script>
            <script src="/client/lib/owlcarousel/owl.carousel.min.js"></script>
            <script src="/client/js/main.js"></script>
        </body>

        </html>