// (function ($) {
//   "use strict";

//   // Spinner
//   var spinner = function () {
//     setTimeout(function () {
//       if ($("#spinner").length > 0) {
//         $("#spinner").removeClass("show");
//       }
//     }, 1);
//   };
//   spinner(0);

//   // Fixed Navbar
//   $(window).scroll(function () {
//     if ($(window).width() < 992) {
//       if ($(this).scrollTop() > 55) {
//         $(".fixed-top").addClass("shadow");
//       } else {
//         $(".fixed-top").removeClass("shadow");
//       }
//     } else {
//       if ($(this).scrollTop() > 55) {
//         $(".fixed-top").addClass("shadow").css("top", 0);
//       } else {
//         $(".fixed-top").removeClass("shadow").css("top", 0);
//       }
//     }
//   });

//   // Back to top button
//   $(window).scroll(function () {
//     if ($(this).scrollTop() > 300) {
//       $(".back-to-top").fadeIn("slow");
//     } else {
//       $(".back-to-top").fadeOut("slow");
//     }
//   });
//   $(".back-to-top").click(function () {
//     $("html, body").animate({ scrollTop: 0 }, 1500, "easeInOutExpo");
//     return false;
//   });

//   $(".quantity button").on("click", function () {
//     const button = $(this);
//     const input = button.parent().parent().find("input");
//     const oldValue = parseFloat(input.val());
//     const id = input.attr("data-cart-detail-id");
//     const price = parseFloat(input.attr("data-cart-detail-price"));

//     let newVal;
//     if (button.hasClass("btn-plus")) {
//       newVal = oldValue + 1;
//     } else {
//       newVal = oldValue > 1 ? oldValue - 1 : 1;
//     }

//     input.val(newVal);

//     $(`#quantity-${id}`).val(newVal);

//     const priceElement = $(`p[data-cart-detail-id='${id}']`);
//     if (priceElement.length) {
//       const newRowPrice = price * newVal;
//       priceElement.text(formatCurrency(newRowPrice) + " đ");
//     }
//     updateCartTotal();
//   });

//   $('input[name="cartDetailIds"]').on("change", function () {
//     updateCartTotal();
//   });

//   function updateCartTotal() {
//     let total = 0;
//     const totalPriceElements = $(`p[data-cart-total-price]`);

//     $('input[name="cartDetailIds"]:checked').each(function () {
//       const row = $(this).closest("tr");
//       const inputQuantity = row.find(".quantity input");
//       const quantity = parseFloat(inputQuantity.val());
//       const price = parseFloat(inputQuantity.attr("data-cart-detail-price"));
//       total += price * quantity;
//     });

//     totalPriceElements.each(function () {
//       $(this).text(formatCurrency(total) + " đ");
//       $(this).attr("data-cart-total-price", total);
//     });
//   }

//   $('form[action="/confirm-checkout"]').on("submit", function (e) {
//     const checkedCount = $('input[name="cartDetailIds"]:checked').length;
//     if (checkedCount === 0) {
//       alert("Vui lòng chọn ít nhất một sản phẩm để tiếp tục thanh toán!");
//       e.preventDefault();
//       return false;
//     }
//   });

//   function formatCurrency(value) {
//     const formatter = new Intl.NumberFormat("vi-VN", {
//       style: "decimal",
//       minimumFractionDigits: 0,
//     });
//     return formatter.format(value).replace(/\./g, ",");
//   }

//   $(document).ready(function () {
//     updateCartTotal();

//     const navElement = $("#navbarCollapse");
//     const currentUrl = window.location.pathname;
//     navElement.find("a.nav-link").each(function () {
//       const link = $(this);
//       if (link.attr("href") === currentUrl) {
//         link.addClass("active");
//       } else {
//         link.removeClass("active");
//       }
//     });

//     // Video Modal
//     var $videoSrc;
//     $(".btn-play").click(function () {
//       $videoSrc = $(this).data("src");
//     });
//     $("#videoModal").on("shown.bs.modal", function (e) {
//       $("#video").attr(
//         "src",
//         $videoSrc + "?autoplay=1&amp;modestbranding=1&amp;showinfo=0",
//       );
//     });
//     $("#videoModal").on("hide.bs.modal", function (e) {
//       $("#video").attr("src", $videoSrc);
//     });
//   });

//   // Testimonial carousel
//   $(".testimonial-carousel").owlCarousel({
//     autoplay: true,
//     smartSpeed: 2000,
//     center: false,
//     dots: true,
//     loop: true,
//     margin: 25,
//     nav: true,
//     navText: [
//       '<i class="bi bi-arrow-left"></i>',
//       '<i class="bi bi-arrow-right"></i>',
//     ],
//     responsive: { 0: { items: 1 }, 992: { items: 2 } },
//   });

//   // Vegetable carousel
//   $(".vegetable-carousel").owlCarousel({
//     autoplay: true,
//     smartSpeed: 1500,
//     center: false,
//     dots: true,
//     loop: true,
//     margin: 25,
//     nav: true,
//     navText: [
//       '<i class="bi bi-arrow-left"></i>',
//       '<i class="bi bi-arrow-right"></i>',
//     ],
//     responsive: {
//       0: { items: 1 },
//       768: { items: 2 },
//       992: { items: 3 },
//       1200: { items: 4 },
//     },
//   });
//   //handle filter products
//   $("#btnFilter").click(function (event) {
//     event.preventDefault();

//     let factoryArr = [];
//     let targetArr = [];
//     let priceArr = [];
//     //factory filter
//     $("#factoryFilter .form-check-input:checked").each(function () {
//       factoryArr.push($(this).val());
//     });

//     //target filter
//     $("#targetFilter .form-check-input:checked").each(function () {
//       targetArr.push($(this).val());
//     });

//     //price filter
//     $("#priceFilter .form-check-input:checked").each(function () {
//       priceArr.push($(this).val());
//     });

//     //sort order
//     let sortValue = $('input[name="radio-sort"]:checked').val();

//     const currentUrl = new URL(window.location.href);
//     const searchParams = currentUrl.searchParams;

//     // Add or update query parameters
//     searchParams.set("page", "1");
//     searchParams.set("sort", sortValue);

//     if (factoryArr.length > 0) {
//       searchParams.set("factory", factoryArr.join(","));
//     }
//     if (targetArr.length > 0) {
//       searchParams.set("target", targetArr.join(","));
//     }
//     if (priceArr.length > 0) {
//       searchParams.set("price", priceArr.join(","));
//     }

//     // Update the URL and reload the page
//     window.location.href = currentUrl.toString();
//   });

//   //handle auto checkbox after page loading
//   // Parse the URL parameters
//   const params = new URLSearchParams(window.location.search);

//   // Set checkboxes for 'factory'
//   if (params.has("factory")) {
//     const factories = params.get("factory").split(",");
//     factories.forEach((factory) => {
//       $(`#factoryFilter .form-check-input[value="${factory}"]`).prop(
//         "checked",
//         true,
//       );
//     });
//   }

//   // Set checkboxes for 'target'
//   if (params.has("target")) {
//     const targets = params.get("target").split(",");
//     targets.forEach((target) => {
//       $(`#targetFilter .form-check-input[value="${target}"]`).prop(
//         "checked",
//         true,
//       );
//     });
//   }

//   // Set checkboxes for 'price'
//   if (params.has("price")) {
//     const prices = params.get("price").split(",");
//     prices.forEach((price) => {
//       $(`#priceFilter .form-check-input[value="${price}"]`).prop(
//         "checked",
//         true,
//       );
//     });
//   }

//   // Set radio buttons for 'sort'
//   if (params.has("sort")) {
//     const sort = params.get("sort");
//     $(`input[type="radio"][name="radio-sort"][value="${sort}"]`).prop(
//       "checked",
//       true,
//     );
//   }
// })(jQuery);
(function ($) {
  "use strict";

  // 1. Spinner xử lý lúc load trang
  var spinner = function () {
    setTimeout(function () {
      if ($("#spinner").length > 0) {
        $("#spinner").removeClass("show");
      }
    }, 1);
  };
  spinner(0);

  // 2. Fixed Navbar khi cuộn trang
  $(window).scroll(function () {
    if ($(window).width() < 992) {
      if ($(this).scrollTop() > 55) {
        $(".fixed-top").addClass("shadow");
      } else {
        $(".fixed-top").removeClass("shadow");
      }
    } else {
      if ($(this).scrollTop() > 55) {
        $(".fixed-top").addClass("shadow").css("top", 0);
      } else {
        $(".fixed-top").removeClass("shadow").css("top", 0);
      }
    }
  });

  // 3. Nút Back to top
  $(window).scroll(function () {
    if ($(this).scrollTop() > 300) {
      $(".back-to-top").fadeIn("slow");
    } else {
      $(".back-to-top").fadeOut("slow");
    }
  });
  $(".back-to-top").click(function () {
    $("html, body").animate({ scrollTop: 0 }, 1500, "easeInOutExpo");
    return false;
  });

  // 4. Xử lý tăng giảm số lượng trong giỏ hàng
  $(".quantity button").on("click", function () {
    const button = $(this);
    const input = button.parent().parent().find("input");
    const oldValue = parseFloat(input.val());
    const id = input.attr("data-cart-detail-id");
    const price = parseFloat(input.attr("data-cart-detail-price"));

    let newVal;
    if (button.hasClass("btn-plus")) {
      newVal = oldValue + 1;
    } else {
      newVal = oldValue > 1 ? oldValue - 1 : 1;
    }

    input.val(newVal);
    $(`#quantity-${id}`).val(newVal);

    const priceElement = $(`p[data-cart-detail-id='${id}']`);
    if (priceElement.length) {
      const newRowPrice = price * newVal;
      priceElement.text(formatCurrency(newRowPrice) + " đ");
    }
    updateCartTotal();
  });

  $('input[name="cartDetailIds"]').on("change", function () {
    updateCartTotal();
  });

  // 5. Cập nhật tổng tiền giỏ hàng
  function updateCartTotal() {
    let total = 0;
    const totalPriceElements = $(`p[data-cart-total-price]`);

    $('input[name="cartDetailIds"]:checked').each(function () {
      const row = $(this).closest("tr");
      const inputQuantity = row.find(".quantity input");
      const quantity = parseFloat(inputQuantity.val());
      const price = parseFloat(inputQuantity.attr("data-cart-detail-price"));
      total += price * quantity;
    });

    totalPriceElements.each(function () {
      $(this).text(formatCurrency(total) + " đ");
      $(this).attr("data-cart-total-price", total);
    });
  }

  // Kiểm tra trước khi Checkout
  $('form[action="/confirm-checkout"]').on("submit", function (e) {
    const checkedCount = $('input[name="cartDetailIds"]:checked').length;
    if (checkedCount === 0) {
      alert("Vui lòng chọn ít nhất một sản phẩm để tiếp tục thanh toán!");
      e.preventDefault();
      return false;
    }
  });

  // Định dạng tiền tệ VNĐ
  function formatCurrency(value) {
    const formatter = new Intl.NumberFormat("vi-VN", {
      style: "decimal",
      minimumFractionDigits: 0,
    });
    return formatter.format(value).replace(/\./g, ",");
  }

  //XỬ LÝ LỌC REALTIME
  function handleFilter() {
    let factoryArr = [];
    let targetArr = [];
    let priceArr = [];

    // Thu thập dữ liệu
    $("#factoryFilter .form-check-input:checked").each(function () {
      factoryArr.push($(this).val());
    });

    $("#targetFilter .form-check-input:checked").each(function () {
      targetArr.push($(this).val());
    });

    $("#priceFilter .form-check-input:checked").each(function () {
      priceArr.push($(this).val());
    });

    let sortValue = $('input[name="radio-sort"]:checked').val();

    // Xử lý URL Params
    const currentUrl = new URL(window.location.href);
    const searchParams = currentUrl.searchParams;

    searchParams.set("page", "1"); // Reset trang khi lọc
    searchParams.set("sort", sortValue);

    // Update hoặc Delete param tùy vào trạng thái check
    if (factoryArr.length > 0)
      searchParams.set("factory", factoryArr.join(","));
    else searchParams.delete("factory");

    if (targetArr.length > 0) searchParams.set("target", targetArr.join(","));
    else searchParams.delete("target");

    if (priceArr.length > 0) searchParams.set("price", priceArr.join(","));
    else searchParams.delete("price");

    // Reload trang với URL mới
    window.location.href = currentUrl.toString();
  }

  $(document).ready(function () {
    updateCartTotal();

    // Active Navbar link
    const navElement = $("#navbarCollapse");
    const currentPath = window.location.pathname;
    navElement.find("a.nav-link").each(function () {
      const link = $(this);
      if (link.attr("href") === currentPath) {
        link.addClass("active");
      } else {
        link.removeClass("active");
      }
    });

    // Lắng nghe sự kiện change REALTIME
    $("#factoryFilter, #targetFilter, #priceFilter").on(
      "change",
      ".form-check-input",
      function () {
        handleFilter();
      },
    );

    $('input[name="radio-sort"]').on("change", function () {
      handleFilter();
    });

    // Giữ sự kiện cho nút bấm (nếu người dùng vẫn nhấn)
    $("#btnFilter").click(function (event) {
      event.preventDefault();
      handleFilter();
    });

    // Tự động tích lại checkbox dựa trên URL khi load trang
    const params = new URLSearchParams(window.location.search);

    const syncCheckboxes = (paramName, containerId) => {
      if (params.has(paramName)) {
        const values = params.get(paramName).split(",");
        values.forEach((val) => {
          $(`${containerId} .form-check-input[value="${val}"]`).prop(
            "checked",
            true,
          );
        });
      }
    };

    syncCheckboxes("factory", "#factoryFilter");
    syncCheckboxes("target", "#targetFilter");
    syncCheckboxes("price", "#priceFilter");

    if (params.has("sort")) {
      const sort = params.get("sort");
      $(`input[type="radio"][name="radio-sort"][value="${sort}"]`).prop(
        "checked",
        true,
      );
    }
    $("#avatarInput").change(function (e) {
      const file = e.target.files[0];
      if (file) {
        // Kiểm tra xem file có phải là ảnh không (để tránh lỗi)
        const fileType = file["type"];
        const validImageTypes = [
          "image/gif",
          "image/jpeg",
          "image/png",
          "image/webp",
        ];
        if ($.inArray(fileType, validImageTypes) < 0) {
          alert("Vui lòng chọn định dạng ảnh (jpg, png, webp, gif)");
          return;
        }

        const reader = new FileReader();
        reader.onload = function (event) {
          // Thay đổi src của thẻ img có id là avatarPreview
          $("#avatarPreview").attr("src", event.target.result);
        };
        reader.readAsDataURL(file);
      }
    });
    //change-password
    $(document).on("click", ".toggle-password", function () {
      $(this).toggleClass("bi-eye bi-eye-slash");
      let input = $(this).closest(".input-group").find("input");
      if (input.attr("type") == "password") {
        input.attr("type", "text");
      } else {
        input.attr("type", "password");
      }
    });

    // 2. Kiểm tra mật khẩu khớp nhau trước khi Submit
    $("#changePasswordForm").on("submit", function (e) {
      let newPass = $("#newPassword").val();
      let confirmPass = $("#confirmPassword").val();

      // Kiểm tra độ dài
      if (newPass.length < 6) {
        alert("Mật khẩu mới phải có ít nhất 6 ký tự!");
        e.preventDefault();
        return;
      }

      // Kiểm tra trùng khớp
      if (newPass !== confirmPass) {
        $("#passwordError").show();
        e.preventDefault();
      } else {
        $("#passwordError").hide();
      }
    });

    // --- Video Modal ---
    var $videoSrc;
    $(".btn-play").click(function () {
      $videoSrc = $(this).data("src");
    });
    $("#videoModal").on("shown.bs.modal", function (e) {
      $("#video").attr(
        "src",
        $videoSrc + "?autoplay=1&amp;modestbranding=1&amp;showinfo=0",
      );
    });
    $("#videoModal").on("hide.bs.modal", function (e) {
      $("#video").attr("src", $videoSrc);
    });

    // Carousels
    $(".testimonial-carousel").owlCarousel({
      autoplay: true,
      smartSpeed: 2000,
      dots: true,
      loop: true,
      margin: 25,
      nav: true,
      navText: [
        '<i class="bi bi-arrow-left"></i>',
        '<i class="bi bi-arrow-right"></i>',
      ],
      responsive: { 0: { items: 1 }, 992: { items: 2 } },
    });

    $(".vegetable-carousel").owlCarousel({
      autoplay: true,
      smartSpeed: 1500,
      dots: true,
      loop: true,
      margin: 25,
      nav: true,
      navText: [
        '<i class="bi bi-arrow-left"></i>',
        '<i class="bi bi-arrow-right"></i>',
      ],
      responsive: {
        0: { items: 1 },
        768: { items: 2 },
        992: { items: 3 },
        1200: { items: 4 },
      },
    });
  });
})(jQuery);
