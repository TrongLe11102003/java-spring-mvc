package vn.hoidanit.laptopshop.controller.client;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpSession;
import vn.hoidanit.laptopshop.domain.User;
import vn.hoidanit.laptopshop.service.EmailService;
import vn.hoidanit.laptopshop.service.UserService;

@Controller
public class ForgotPasswordController {

    private final UserService userService;
    private final EmailService emailService;
    private final PasswordEncoder passwordEncoder;

    public ForgotPasswordController(UserService userService, EmailService emailService, PasswordEncoder passwordEncoder) {
        this.userService = userService;
        this.emailService = emailService;
        this.passwordEncoder = passwordEncoder;
    }

    @GetMapping("/forgot-password")
    public String getForgotPasswordPage() {
        return "client/auth/forgot-password";
    }

    @PostMapping("/forgot-password")
    public String handleForgotPassword(@RequestParam("email") String email, HttpSession session, Model model) {
        User user = this.userService.getUserByEmail(email);
        if (user == null) {
            model.addAttribute("error", "Email này chưa được đăng ký!");
            return "client/auth/forgot-password";
        }

        String otp = String.valueOf((int) ((Math.random() * (999999 - 100000)) + 100000));
        session.setAttribute("otp", otp);
        session.setAttribute("email_reset", email);
        long expiryTime = System.currentTimeMillis() + (5 * 60 * 1000); 
        session.setAttribute("otp_expiry", expiryTime);

        this.emailService.sendOtpEmail(email, otp);
        return "redirect:/reset-password";
    }

    @GetMapping("/reset-password")
    public String getResetPasswordPage() {
        return "client/auth/reset-password";
    }

    @PostMapping("/reset-password")
    public String handleResetPassword(@RequestParam("otp") String userOtp,
                                      @RequestParam("newPassword") String newPassword,
                                      @RequestParam("confirmPassword") String confirmPassword,
                                      HttpSession session, Model model) {
        String sessionOtp = (String) session.getAttribute("otp");
        String email = (String) session.getAttribute("email_reset");
        Long expiryTime = (Long) session.getAttribute("otp_expiry");
        long currentTime = System.currentTimeMillis();
        if (expiryTime == null || currentTime > expiryTime) {
            model.addAttribute("error", "Mã OTP không chính xác hoặc đã hết hạn!");
            session.removeAttribute("otp");
            return "client/auth/reset-password";
        }

        if (sessionOtp == null || !sessionOtp.equals(userOtp)) {
            model.addAttribute("error", "Mã OTP không chính xác hoặc đã hết hạn!");
            return "client/auth/reset-password";
        }

        if (!newPassword.equals(confirmPassword)) {
            model.addAttribute("error", "Mật khẩu xác nhận không khớp!");
            return "client/auth/reset-password";
        }

        User user = this.userService.getUserByEmail(email);
        user.setPassword(this.passwordEncoder.encode(newPassword));
        this.userService.handleSaveUser(user);

        session.removeAttribute("otp");
        session.removeAttribute("otp_expiry");
        session.removeAttribute("email_reset");

        return "redirect:/login?resetSuccess";
    }
}
