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

    public ForgotPasswordController(UserService userService, EmailService emailService,
            PasswordEncoder passwordEncoder) {
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
            model.addAttribute("error", "Email chưa được đăng ký !");
            return "client/auth/forgot-password";
        }

        String otp = String.valueOf((int) ((Math.random() * (999999 - 100000)) + 100000));

        session.setAttribute("otp", otp);
        session.setAttribute("email_reset", email);
        long expiryTime = System.currentTimeMillis() + (5 * 60 * 1000); // 5 phút
        session.setAttribute("otp_expiry", expiryTime);

        this.emailService.sendOtpEmail(email, otp);

        return "redirect:/reset-password";
    }

    @GetMapping("/reset-password")
    public String getResetPasswordPage() {
        return "client/auth/reset-password";
    }

    @PostMapping("/verify-otp")
    public String handleVerifyOtp(@RequestParam("otp") String userOtp, HttpSession session, Model model) {
        String sessionOtp = (String) session.getAttribute("otp");
        Long expiryTime = (Long) session.getAttribute("otp_expiry");
        long currentTime = System.currentTimeMillis();

        if (expiryTime == null || currentTime > expiryTime || sessionOtp == null || !sessionOtp.equals(userOtp)) {
            model.addAttribute("error", "Mã OTP không chính xác hoặc đã hết hạn!");
            return "client/auth/reset-password";
        }

        session.setAttribute("is_otp_verified", true);
        return "redirect:/reset-password/new-password";
    }

    @GetMapping("/reset-password/new-password")
    public String getNewPasswordPage(HttpSession session) {
        Boolean isVerified = (Boolean) session.getAttribute("is_otp_verified");
        if (isVerified == null || !isVerified) {
            return "redirect:/forgot-password";
        }
        return "client/auth/new-password";
    }

    @PostMapping("/reset-password/new-password")
    public String handleNewPassword(@RequestParam("newPassword") String newPassword,
            @RequestParam("confirmPassword") String confirmPassword,
            HttpSession session, Model model) {
        Boolean isVerified = (Boolean) session.getAttribute("is_otp_verified");
        if (isVerified == null || !isVerified) {
            return "redirect:/forgot-password";
        }

        if (!newPassword.equals(confirmPassword)) {
            model.addAttribute("error", "Mật khẩu xác nhận không khớp!");
            return "client/auth/new-password";
        }

        String email = (String) session.getAttribute("email_reset");
        User user = this.userService.getUserByEmail(email);
        if (user != null) {
            user.setPassword(this.passwordEncoder.encode(newPassword));
            this.userService.handleSaveUser(user);
        }

        session.removeAttribute("otp");
        session.removeAttribute("otp_expiry");
        session.removeAttribute("email_reset");
        session.removeAttribute("is_otp_verified");

        return "redirect:/login?resetSuccess";
    }
}