package vn.hoidanit.laptopshop.controller.client;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import vn.hoidanit.laptopshop.domain.User;
import vn.hoidanit.laptopshop.service.UploadService;
import vn.hoidanit.laptopshop.service.UserService;

@Controller
public class ProfileController {
    private final UploadService uploadService;
    private final UserService userService;
    private final PasswordEncoder passwordEncoder;

    

    public ProfileController(UploadService uploadService, UserService userService, PasswordEncoder passwordEncoder) {
        this.uploadService = uploadService;
        this.userService = userService;
        this.passwordEncoder = passwordEncoder;
    }


    @PostMapping("/profile/update")
    public String handleUpdateProfile(@ModelAttribute("user") User user, 
                                 @RequestParam("avatarFile") MultipartFile file,
                                 HttpServletRequest request) {
        User currentUser = this.userService.getUserById(user.getId());
        if (currentUser != null) {
            currentUser.setFullName(user.getFullName());
            currentUser.setAddress(user.getAddress());
            currentUser.setPhone(user.getPhone());
        
            if (!file.isEmpty()) {
                String avatar = this.uploadService.handleSaveUploadFile(file, "avatar");
                currentUser.setAvatar(avatar);
                request.getSession().setAttribute("avatar", "/images/avatar/" + avatar);            
            }
            this.userService.handleSaveUser(currentUser);
            request.getSession().setAttribute("fullName", currentUser.getFullName());
            
        }
        return "redirect:/profile";
    }

    @GetMapping("/change-password")
    public String getChangePasswordPage(Model model) {
        return "client/profile/change-password";
    }

    @PostMapping("/change-password")
    public String handleChangePassword(HttpServletRequest request,
                                   @RequestParam("oldPassword") String oldPassword,
                                   @RequestParam("newPassword") String newPassword,
                                   @RequestParam("confirmPassword") String confirmPassword,
                                   Model model) {
        HttpSession session = request.getSession(false);
        String email = (String) session.getAttribute("email");
        User currentUser = this.userService.getUserByEmail(email);

        if (!passwordEncoder.matches(oldPassword, currentUser.getPassword())) {
            model.addAttribute("error", "Mật khẩu cũ không chính xác");
            return "client/profile/change-password";
        }

        if (!newPassword.equals(confirmPassword)) {
            model.addAttribute("error", "Mật khẩu mới và xác nhận không khớp");
            return "client/profile/change-password";
        }

        currentUser.setPassword(this.passwordEncoder.encode(newPassword));
        this.userService.handleSaveUser(currentUser);

        return "redirect:/profile?changePasswordSuccess";
    }
}
