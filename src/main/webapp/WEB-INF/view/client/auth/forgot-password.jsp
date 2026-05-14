<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="utf-8" />
            <title>Quên mật khẩu - Laptopshop</title>
            <link href="<c:url value='/css/styles.css'/>" rel="stylesheet" />
            <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        </head>

        <body class="bg-primary">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-lg-5">
                        <div class="card shadow-lg border-0 rounded-lg mt-5">
                            <div class="card-header">
                                <h3 class="text-center my-4">Khôi phục mật khẩu</h3>
                            </div>
                            <div class="card-body">
                                <form method="post" action="/forgot-password">
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                    <c:if test="${not empty error}">
                                        <div class="alert alert-danger p-2 small">${error}</div>
                                    </c:if>
                                    <div class="form-floating mb-3">
                                        <input class="form-control" name="email" type="email"
                                            placeholder="name@example.com" required />
                                        <label>Nhập địa chỉ Email của bạn</label>
                                    </div>
                                    <div class="d-flex align-items-center justify-content-between mt-4 mb-0">
                                        <a class="small" href="/login">Quay lại đăng nhập</a>
                                        <button type="submit" class="btn btn-primary">Gửi mã OTP</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </body>

        </html>