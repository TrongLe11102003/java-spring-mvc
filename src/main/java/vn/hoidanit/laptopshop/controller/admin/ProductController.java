package vn.hoidanit.laptopshop.controller.admin;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import jakarta.validation.Valid;
import vn.hoidanit.laptopshop.domain.Product;
import vn.hoidanit.laptopshop.service.ProductService;
import vn.hoidanit.laptopshop.service.UploadService;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;




@Controller
public class ProductController {
    private UploadService uploadService;
    private ProductService productService;
    
    public ProductController(UploadService uploadService, ProductService productService) {
        this.uploadService = uploadService;
        this.productService = productService;
    }
    @GetMapping("/admin/product")
    public String getProduct(Model model) {
        List<Product> prs = this.productService.fetchProducts();
        model.addAttribute("products", prs);
        return "admin/product/show";
    }
    @GetMapping("/admin/product/create")
    public String getCreateProductPage(Model model) {
        model.addAttribute("newProduct", new Product());
        return "admin/product/create";
    }
    @PostMapping("/admin/product/create")
    public String handleCreateProduct(@ModelAttribute("newProduct") @Valid Product pr,BindingResult newProductBindingResult, @RequestParam("hoidanitFile") MultipartFile file) {
        if (newProductBindingResult.hasErrors()) {
            return "/admin/product/create";
        }    
        String image = this.uploadService.handleSaveUploadFile(file, "product");
        pr.setImage(image);
        this.productService.createProduct(pr);
        return "redirect:/admin/product";
    }
    
    @RequestMapping("/admin/product/{id}")
    public String getProductDetailPage(Model model, @PathVariable long id) {
        Product pr = this.productService.fetchProductById(id).get();
        model.addAttribute("product", pr);
        model.addAttribute("id", id);
        return "/admin/product/detail";
    }

    @GetMapping("/admin/product/delete/{id}")
    public String getDeleteProductPage(Model model, @PathVariable long id) {

        model.addAttribute("id", id);
        model.addAttribute("newProduct", new Product());
        return "/admin/product/delete";
    }
    @PostMapping("/admin/product/delete")
    public String postDeleteProduct(Model model, @ModelAttribute("newProduct") Product eric) {
        this.productService.deleteProduct(eric.getId());
        return "redirect:/admin/product";
    }
    @RequestMapping("/admin/product/update/{id}")
    public String getUpdateProductPage(Model model, @PathVariable long id) {
        Optional<Product> currProduct = this.productService.fetchProductById(id);
        model.addAttribute("newProduct", currProduct.get());
        return "/admin/product/update";
    }
    @PostMapping("/admin/product/update")
    public String postUpdateUser(Model model, @ModelAttribute("newProduct") @Valid Product pr,
                                    BindingResult newProductBindingResult,
                                    @RequestParam("hoidanitFile") MultipartFile file) {
            if (newProductBindingResult.hasErrors()) {
                return "admin/product/update";
            }
            Product currProduct = this.productService.fetchProductById(pr.getId()).get();
            if (currProduct != null) {
                if (!file.isEmpty()) {
                    String img = this.uploadService.handleSaveUploadFile(file, "product");
                    currProduct.setImage(img);
                }
                currProduct.setName(pr.getName());
                currProduct.setPrice(pr.getPrice());
                currProduct.setQuantity(pr.getQuantity());
                currProduct.setDetailDesc(pr.getDetailDesc());
                currProduct.setShortDesc(pr.getShortDesc());
                currProduct.setFactory(pr.getFactory());
                currProduct.setTarget(pr.getTarget());
                
                this.productService.createProduct(currProduct);
            }

        return "redirect:/admin/product";
    }
}
