<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <title>Đặt lại mật khẩu - Laptopshop</title>
    
    <link href="<c:url value='/css/styles.css'/>" rel="stylesheet" />
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
</head>
<body class="bg-primary">
    <div id="layoutAuthentication">
        <div id="layoutAuthentication_content">
            <main>
                <div class="container">
                    <div class="row justify-content-center">
                        <div class="col-lg-5">
                            <div class="card shadow-lg border-0 rounded-lg mt-5">
                                <div class="card-header">
                                    <h3 class="text-center font-weight-light my-4">Đặt lại mật khẩu</h3>
                                </div>
                                <div class="card-body">
                                    <form method="post" action="/reset-password">
                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                        
                                        <c:if test="${not empty error}">
                                            <div class="alert alert-danger p-2 small">${error}</div>
                                        </c:if>

                                        <div class="form-floating mb-3">
                                            <input class="form-control" id="inputOtp" name="otp" 
                                                   type="text" placeholder="OTP Code" required />
                                            <label for="inputOtp">Mã OTP</label>
                                        </div>

                                        <div class="form-floating mb-3">
                                            <input class="form-control" id="inputNewPassword" name="newPassword" 
                                                   type="password" placeholder="New Password" required />
                                            <label for="inputNewPassword">Mật khẩu mới</label>
                                        </div>

                                        <div class="form-floating mb-3">
                                            <input class="form-control" id="inputConfirmPassword" name="confirmPassword" 
                                                   type="password" placeholder="Confirm Password" required />
                                            <label for="inputConfirmPassword">Xác nhận mật khẩu</label>
                                        </div>

                                        <div class="d-grid mt-4 mb-0">
                                            <button type="submit" class="btn btn-primary btn-block">Cập nhật mật khẩu</button>
                                        </div>
                                    </form>
                                </div>
                                <div class="card-footer text-center py-3">
                                    <div class="small">
                                        <a href="/login">Quay lại trang đăng nhập</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
    <script src="<c:url value='/js/scripts.js'/>"></script>
</body>
</html>