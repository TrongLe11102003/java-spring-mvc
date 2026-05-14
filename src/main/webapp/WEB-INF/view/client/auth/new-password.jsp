<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="utf-8" />
            <title>Đặt lại mật khẩu - Laptopshop</title>
            <link href="<c:url value='/css/styles.css'/>" rel="stylesheet" />
        </head>

        <body class="bg-primary">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-lg-5">
                        <div class="card shadow-lg border-0 rounded-lg mt-5">
                            <div class="card-header">
                                <h3 class="text-center my-4">Mật khẩu mới</h3>
                            </div>
                            <div class="card-body">
                                <form method="post" action="/reset-password/new-password">
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                    <c:if test="${not empty error}">
                                        <div class="alert alert-danger p-2 small">${error}</div>
                                    </c:if>
                                    <div class="form-floating mb-3">
                                        <input class="form-control" name="newPassword" type="password" required />
                                        <label>Mật khẩu mới</label>
                                    </div>
                                    <div class="form-floating mb-3">
                                        <input class="form-control" name="confirmPassword" type="password" required />
                                        <label>Xác nhận mật khẩu mới</label>
                                    </div>
                                    <div class="d-grid mt-4 mb-0">
                                        <button type="submit" class="btn btn-primary">Cập nhật mật khẩu</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </body>

        </html>