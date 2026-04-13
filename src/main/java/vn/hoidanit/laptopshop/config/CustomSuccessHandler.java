package vn.hoidanit.laptopshop.config;

import java.io.IOException;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.WebAttributes;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.hoidanit.laptopshop.domain.User;
import vn.hoidanit.laptopshop.service.UserService;

public class CustomSuccessHandler implements AuthenticationSuccessHandler{
    private UserService userService;

    public void setUserService(UserService userService) {
        this.userService = userService;
    }
    private RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();
    protected String determineTargetUrl(final Authentication authentication) {

        Map<String, String> roleTargetUrlMap = new HashMap<>();
        roleTargetUrlMap.put("ROLE_USER", "/");
        roleTargetUrlMap.put("ROLE_ADMIN", "/admin");

        final Collection<? extends GrantedAuthority> authorities = authentication.getAuthorities();
        for (final GrantedAuthority grantedAuthority : authorities) {
            String authorityName = grantedAuthority.getAuthority();
            if(roleTargetUrlMap.containsKey(authorityName)) {
                return roleTargetUrlMap.get(authorityName);
            }
        }

        return "/";
    }
    // protected void clearAuthenticationAttributes(HttpServletRequest request, Authentication authentication) {
    //     HttpSession session = request.getSession(false);
    //     if (session == null) {
    //         return;
    //     }
    //     session.removeAttribute(WebAttributes.AUTHENTICATION_EXCEPTION);
    //     String email = authentication.getName();
    //     User user = this.userService.getUserByEmail(email);
    //     if (user != null) {
    //         session.setAttribute("fullName", user.getFullName());
    //         session.setAttribute("avatar", user.getAvatar());
    //         session.setAttribute("id", user.getId());
    //         session.setAttribute("email", user.getEmail());
            
    //         int sum = user.getCart() == null ? 0 : user.getCart().getSum();
    //         session.setAttribute("sum", sum);

    //     }
        
    // }

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
            Authentication authentication) throws IOException, ServletException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            String email = getEmailFromAuthentication(authentication);
            
            User user = this.userService.getUserByEmail(email);

            if (user != null) {
                session.setAttribute("id", user.getId());
                session.setAttribute("fullName", user.getFullName());
                session.setAttribute("email", user.getEmail());
                
                String avatar = user.getAvatar();
                if (avatar != null && (avatar.startsWith("http") || (avatar.startsWith("https")))) {
                    session.setAttribute("avatar", avatar);
                } else {
                    session.setAttribute("avatar", "/images/avatar/" + (avatar != null ? avatar : "default.png"));
                }

                int sum = (user.getCart() == null) ? 0 : user.getCart().getSum();
                session.setAttribute("sum", sum);
            }
            
            session.removeAttribute(WebAttributes.AUTHENTICATION_EXCEPTION);
        }
        String targetUrl = determineTargetUrl(authentication);

        if (response.isCommitted()) {
            return;
        }

        redirectStrategy.sendRedirect(request, response, targetUrl);
        // clearAuthenticationAttributes(request, authentication);
    }

    private String getEmailFromAuthentication(Authentication authentication) {
        Object principal = authentication.getPrincipal();
        if (principal instanceof OAuth2User oAuth2User) {
            return oAuth2User.getAttribute("email");
        }
        return authentication.getName();
    }
    
}
