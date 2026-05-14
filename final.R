# FINAL


library(shiny)
library(shinyjs)
library(base64enc)

ORDERS_FILE <- "orders.rds"
DATA_FILE <- "products.rds"

# ==================== VALID USERS ====================

valid_users <- list(
  "admin" = "cookie123",
  "user1" = "choco123",
  "guest" = "sugar123"
)

# ==================== UI ====================

ui <- fluidPage(
  
  useShinyjs(),
  
  tags$head(
    
    tags$link(
      rel = "stylesheet",
      href = "https://fonts.googleapis.com/css2?family=Dancing+Script:wght@400;600;700&display=swap"
    ),
    
    tags$link(
      rel = "stylesheet",
      href = "https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;600;700&display=swap"
    ),
    
    tags$style(HTML("
/* ================= GLOBAL ================= */

html, body {
  height: 100%;
  width: 100%;
  margin: 0;
  padding: 0;
  overflow-x: hidden;
  font-family: 'Segoe UI', sans-serif;
  background: transparent;
}

body {
  background: linear-gradient(rgba(0,0,0,0.25), rgba(0,0,0,0.25)),
              url(https://png.pngtree.com/thumb_back/fh260/background/20250121/pngtree-easter-bunny-surrounded-by-pink-and-blue-eggs-image_16940173.jpg);
  background-size: cover;
  background-position: center;
  background-attachment: fixed;
}
/* ================= NAVBAR ================= */

.navbar {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;

  background: rgba(255,255,255,0.85);
  backdrop-filter: blur(10px);

  display: flex;
  justify-content: space-between;
  align-items: center;

  padding: 15px 5vw;
  z-index: 9999;
}

.nav-logo {
  font-family: 'Dancing Script', cursive;
  font-size: 38px;
  font-weight: 600;
  color: #83513E;
}

.nav-links {
  display: flex;
  gap: 25px;
}

.nav-links a {
  text-decoration: none;
  color: #83513E;
  font-weight: 600;
  transition: 0.3s;
}

.nav-links a:hover {
  color: #F78AA1;
}

.nav-login-btn {
  background: #F78AA1;
  color: white !important;
  border: none;
  border-radius: 25px;
  padding: 8px 20px;
  font-weight: bold;
  transition: 0.3s ease;
}

.nav-login-btn:hover {
  background: #83513E;
  transform: scale(1.05);
}

/* ================= HERO SECTION ================= */

.hero-section {
  height: 100vh;
  width: 100%;

  display: flex;
  align-items: center;
  justify-content: center;

  text-align: center;

  background:
    linear-gradient(rgba(0,0,0,0.4), rgba(0,0,0,0.4)),
    url(https://png.pngtree.com/thumb_back/fh260/background/20250121/pngtree-easter-bunny-surrounded-by-pink-and-blue-eggs-image_16940173.jpg);

  background-size: cover;
  background-position: center;
  background-repeat: no-repeat;

  padding-top: 70px; /* IMPORTANT for fixed navbar */
  box-sizing: border-box;
}

.hero-card {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;

  background: rgba(255,255,255,0.18);
  backdrop-filter: blur(18px);

  padding: 60px 50px;
  border-radius: 28px;

  box-shadow: 0 20px 60px rgba(0,0,0,0.15);

  max-width: 720px;
  width: 90%;
}

.hero-title {
  font-family: 'Playfair Display', serif;
  font-size: 90px;
  font-weight: 700;
  color: white;
  margin-bottom: 10px;
  line-height: 1;
}

.hero-subtitle {
  font-size: 22px;
  color: white;
  margin-bottom: 35px;
  letter-spacing: 1px;
}

/* ================= SHOP BUTTON ================= */

.shop-btn {
  background: linear-gradient(135deg, #F78AA1, #ffb6c1);
  color: white !important;
  border: none !important;
  border-radius: 40px !important;

  padding: 14px 40px !important;
  font-size: 20px !important;
  font-weight: bold !important;

  transition: all 0.3s ease;
  box-shadow: 0 10px 25px rgba(0,0,0,0.2);
}

.shop-btn:hover {
  transform: scale(1.08);
  background: linear-gradient(135deg, #83513E, #F78AA1);
}

/* ================= BUTTONS ================= */

.action-btn {
  background: linear-gradient(135deg,#00b894,#00cec9);
  color: white;
  border: none;
  border-radius: 30px;
  padding: 12px;
  width: 100%;
  margin-top: 10px;
}

.action-btn:hover {
  transform: scale(1.03);
}

/* ================= PRODUCTS ================= */

.product-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 15px;
}

.product-card {
  border: 1px solid #ddd;
  border-radius: 15px;
  padding: 15px;
  background: white;
  text-align: center;
}

.product {
  background: #fff5f7;
  padding: 15px;
  border-radius: 15px;
  margin: 10px 0;
}

/* ================= FILTER BAR ================= */

.filter-bar {
  display: flex;
  gap: 10px;
  margin-bottom: 15px;
}

/* ================= FORMS ================= */

.center-form {
  display: flex;
  justify-content: center;
  margin-top: 20px;
}

.form-box {
  width: 60%;
  text-align: center;
}

/* ================= APP CONTAINER ================= */

.app-container {
  background: white;
  border-radius: 25px;
  padding: 35px;
  width: 92%;
  max-width: 700px;
  box-shadow: 0 20px 50px rgba(0,0,0,0.1);
  text-align: center;
  border: 5px solid #ff6b6b;
  margin: auto;
  margin-top: 30px;
}

/* ================= HOMEPAGE ================= */

.homepage {
  height: 100vh;
  background:
    linear-gradient(rgba(0,0,0,0.4), rgba(0,0,0,0.4)),
    url(https://pin.it/4HzYh9G7b);

  background-size: cover;
  background-position: center;

  display: flex;
  justify-content: center;
  align-items: center;

  text-align: center;
  color: white;
}

.home-content {
  background: rgba(255,255,255,0.15);
  padding: 50px;
  border-radius: 25px;
  backdrop-filter: blur(8px);
  width: 90%;
  max-width: 600px;
}

.store-title {
  font-size: 55px;
  font-weight: bold;
  margin-bottom: 10px;
}

.store-slogan {
  font-size: 20px;
  margin-bottom: 35px;
  font-style: italic;
}

.role-buttons {
  display: flex;
  gap: 15px;
  justify-content: center;
}

.home-btn {
  background: linear-gradient(135deg,#ff6b81,#ff8e53);
  color: white;
  border: none;
  padding: 15px 35px;
  border-radius: 30px;
  font-size: 18px;
  transition: 0.3s ease;
}

.home-btn:hover {
  transform: scale(1.05);
  background: linear-gradient(135deg,#ff8e53,#ff6b81);
}

/* ================= ABOUT PAGE ================= */

  .about-box {
  position: relative;
  margin: 120px auto 0 auto;

  background: rgba(255, 255, 255, 0.88);
  backdrop-filter: blur(12px);

  border-radius: 25px;
  padding: 25px 35px;

  width: 80%;
  max-width: 750px;

  text-align: center;

  box-shadow: 0 15px 40px rgba(0,0,0,0.12);
  border: 2px solid rgba(247, 138, 161, 0.3);

  overflow: hidden;
}

.about-box p {
  font-size: 14px;
  line-height: 1.4;
  margin-bottom: 8px;
}

.about-box h2 {
  font-family: 'Dancing Script', cursive;
  font-size: 38px;
  margin-bottom: 15px;
  color: #83513E;
}

.about-box p {
  font-size: 15px;
  line-height: 1.5;
  margin-bottom: 10px;
  color: #5a4a42;
}

.main {
  margin-left: 240px;
  padding: 20px;
  width: calc(100% - 240px);
  box-sizing: border-box;
  min-height: 100vh;
}


.about-box h2,
.shared-box h2,
.contact-box h2 {
  font-family: 'Dancing Script', cursive;
  font-size: 38px;
  margin-bottom: 15px;
  color: #83513E;
}

.about-box p,
.shared-box p,
.contact-box p {
  font-size: 15px;
  line-height: 1.5;
  margin-bottom: 10px;
  color: #5a4a42;
}


.sidebar {
  z-index: 999;
}

.no-sidebar .main {
  margin-left: 0 !important;
  width: 100% !important;
}


.sidebar {
  position: fixed;
  left: 0;
  top: 70px; /* below navbar */
  width: 220px;
  height: calc(100vh - 70px);
  background: #fff;
  padding: 20px;
  box-shadow: 2px 0 10px rgba(0,0,0,0.08);
}

.main {
  margin-left: 240px; /* THIS removes “left empty space” feeling */
  padding: 20px;
  width: calc(100% - 240px);
  box-sizing: border-box;
}



/* ================= MODERN GLASS + SOFT NEON THEME ================= */

body {
  font-family: 'Helvetica', sans-serif;
  background: linear-gradient(135deg, #ffd9c2 0%, #fff5ef 50%, #b2e2e2 100%);
  background-attachment: fixed;
}

/* ================= SIDEBAR GLASS EFFECT ================= */
.sidebar {
  width: 230px;
  height: 100vh;
  position: fixed;
  left: 0;
  top: 0;

  background: rgba(255, 255, 255, 0.75);
  backdrop-filter: blur(10px);

  padding: 20px;
  box-shadow: 10px 0 30px rgba(0,0,0,0.08);
  border-right: 2px solid rgba(255,107,107,0.2);
}

/* ================= MAIN AREA ================= */
.main {
  margin-left: 230px;
  padding: 25px;
  width: calc(100% - 230px);
}

/* ================= FLOATING CARD DESIGN ================= */
.product-card {
  border-radius: 18px;
  padding: 15px;
  background: rgba(255,255,255,0.9);
  box-shadow: 0 10px 25px rgba(0,0,0,0.08);

  transition: all 0.3s ease;
}

.product-card:hover {
  transform: translateY(-5px) scale(1.02);
  box-shadow: 0 15px 35px rgba(255,105,135,0.25);
}

/* ================= GRID ================= */
.product-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
  gap: 18px;
}

/* ================= BUTTON (GLOW + WAVE STYLE YOU LIKE) ================= */
.action-btn {
  padding: 12px;
  border-radius: 30px;
  border: none;

  background: linear-gradient(135deg, #ff9aa2, #ffb7b2);
  color: white;
  font-weight: bold;
  font-size: 16px;

  cursor: pointer;
  transition: all 0.3s ease;

  box-shadow: 0 6px 15px rgba(255, 105, 135, 0.2);
}

.action-btn:hover {
  transform: scale(1.05);
  background: linear-gradient(135deg, #ffb7b2, #ff9aa2);
  box-shadow: 0 10px 25px rgba(255, 105, 135, 0.4);
}

/* ================= LOGIN PANEL (CLEAN GLASS CARD) ================= */
.login-panel {
  background: rgba(255,255,255,0.85);
  border-radius: 25px;
  padding: 45px;

  width: 90%;
  max-width: 450px;

  text-align: center;

  border: 2px solid rgba(255,107,107,0.4);
  box-shadow: 0 20px 50px rgba(0,0,0,0.1);

  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
}

.login-panel input {
  width: 80%;
  margin: 10px auto;
  display: block;
  text-align: center;
}

.login-panel button {
  width: 80%;
  margin: 10px auto;
  display: block;
}

.login-panel {
  display: flex;
  flex-direction: column;
  align-items: center;
}

.login-panel input,
.login-panel .shiny-input-container {
  width: 85% !important;
  margin: 10px auto !important;
}

.login-panel .form-group {
  text-align: center;
}

.center-form {
  display: flex;
  justify-content: center;
  align-items: center;
  width: 100%;
}

.form-box {
  width: 60%;
  max-width: 450px;
  background: rgba(255,255,255,0.7);
  padding: 25px;
  border-radius: 20px;

  display: flex;
  flex-direction: column;
  align-items: center;
  text-align: center;
}

.form-box input {
  width: 90% !important;
  margin: 8px auto !important;
  display: block;
  text-align: center;
}

/* ================= APP CONTAINER ================= */
.app-container {
  background: rgba(255,255,255,0.9);
  border-radius: 25px;
  padding: 30px;

  box-shadow: 0 20px 50px rgba(0,0,0,0.08);
  border: 2px solid rgba(255,107,107,0.2);
}

/* ================= FILTER BAR ================= */
.filter-bar {
  display: flex;
  gap: 10px;
  flex-wrap: wrap;
  margin-bottom: 15px;
}

"))
  ),
  
  uiOutput("main_ui")  # <-- THIS MUST BE OUTSIDE tags$head
)
# ==================== SERVER ====================

server <- function(input, output, session) {
  
  # ==================== REACTIVE VALUES ====================
  
  page <- reactiveVal("role")
  role <- reactiveVal(NULL)
  
  edit_index <- reactiveVal(NULL)
  
  dash_filter <- reactiveVal("All")
  
  customer_filter <- reactiveVal("All")
  
  show_form <- reactiveVal(FALSE)
  
  customer_info <- reactiveVal(NULL)
  
  special_request <- reactiveVal("")
  
  # Store the ORIGINAL (unfiltered) row index when a product is selected
  selected_item <- reactiveVal("")
  selected_price <- reactiveVal(0)
  selected_orig_index <- reactiveVal(NULL)  #track original product row index
  
  orders <- reactiveVal(
    if (file.exists(ORDERS_FILE)) {
      readRDS(ORDERS_FILE)
    } else {
      list()
    }
  )
  
  cart <- reactiveVal(
    data.frame(
      item=character(),
      price=numeric(),
      qty=numeric(),
      stringsAsFactors=FALSE
    )
  )
  
  ARCHIVE_FILE <- "archived_orders.rds"
  
  archived_orders <- reactiveVal(
    if (file.exists(ARCHIVE_FILE)) {
      readRDS(ARCHIVE_FILE)
    } else {
      list()
    }
  )
  
  save_archived <- function(x) saveRDS(x, ARCHIVE_FILE)
  
  # ==================== ORDER ACTIONS (FIXED) ====================
  observeEvent(input$special_request_btn, {
    
    showModal(
      modalDialog(
        title = "✨ Special Request",
        
        textAreaInput(
          "special_request_text",
          "Your request:",
          placeholder = "e.g. custom design, bulk order, etc.",
          rows = 4
        ),
        
        actionButton("save_special", "Save Request ❀", class = "action-btn"),
        easyClose = TRUE
      )
    )
  })
  
  observeEvent(input$save_special, {
    
    req(input$special_request_text)
    
    if (nchar(trimws(input$special_request_text)) == 0) {
      showNotification("Please enter a request!", type = "error")
      return()
    }
    
    special_request(input$special_request_text)
    
    removeModal()
    
    showNotification("Special request saved!", type = "message")
  })
  
  observeEvent(orders(), {
    
    ord <- orders()
    
    lapply(seq_along(ord), function(i) {
      
      local({
        
        my_i <- i
        
        # MARK AS DONE
        observeEvent(input[[paste0("done_", my_i)]], {
          
          ord <- orders()
          arch <- archived_orders()
          
          req(my_i <= length(ord))
          
          done_order <- ord[[my_i]]
          done_order$status <- "Done"
          
          arch <- append(arch, list(done_order))
          ord <- ord[-my_i]
          
          orders(ord)
          archived_orders(arch)
          
          save_orders(ord)
          save_archived(arch)
          
        }, ignoreInit = TRUE, ignoreNULL = TRUE)
        
        
        # DELETE ORDER
        observeEvent(input[[paste0("delete_", my_i)]], {
          
          ord <- orders()
          
          req(my_i <= length(ord))
          
          ord <- ord[-my_i]
          
          orders(ord)
          save_orders(ord)
          
        }, ignoreInit = TRUE, ignoreNULL = TRUE)
        
      })
      
    })
  })
  
  # ==================== PRODUCTS ====================
  
  products <- reactiveVal(
    if (file.exists(DATA_FILE)) {
      readRDS(DATA_FILE)
    } else {
      data.frame(
        category=character(),
        name=character(),
        price=numeric(),
        qty=numeric(),
        img=character(),
        stringsAsFactors=FALSE
      )
    }
  )
  
  save_products <- function(x) saveRDS(x, DATA_FILE)
  save_orders <- function(x) saveRDS(x, ORDERS_FILE)
  
  # ==================== STOCK BADGE FUNCTION ====================
  
  stock_badge <- function(qty) {
    
    if (qty <= 0) {
      
      div(
        class = "sold-out-badge",
        "SOLD OUT"
      )
      
    } else if (qty <= 5) {
      
      div(
        class = "low-stock-badge",
        paste("LOW STOCK:", qty)
      )
      
    } else {
      
      div(
        class = "in-stock-badge",
        paste("IN STOCK:", qty)
      )
    }
  }
  
  
  # ==================== BUY BUTTON OBSERVERS ====================
  # FIX: Register observers on the FULL (unfiltered) products list.
  # The menu UI now uses the original row index as the button ID suffix,
  # so buy_3 always means row 3 of the full products list regardless of filter.
  
  observe({
    
    plist <- products()
    
    req(nrow(plist) > 0)
    
    lapply(seq_len(nrow(plist)), function(i) {
      
      local({
        
        my_i <- i
        
        # Button ID uses the ORIGINAL row index (my_i), not filtered index
        observeEvent(input[[paste0("buy_", my_i)]], {
          
          # Re-read products to get current data
          current_plist <- products()
          item <- current_plist[my_i, ]
          
          selected_item(item$name)
          selected_price(item$price)
          selected_orig_index(my_i)  # Store original index
          
          showModal(
            modalDialog(
              title = item$name,
              
              numericInput("qty", "Quantity", 1, min = 1),
              
              actionButton(
                "add_cart",
                "Add to Cart 🛒",
                class = "action-btn"
              ),
              
              easyClose = TRUE
            )
          )
          
        }, ignoreInit = TRUE)
        
      })
      
    })
  })
  
  
  # ==================== NAVIGATION ====================
  
  observeEvent(input$customer_btn, {
    role("customer")
    page("home")
  })
  
  observeEvent(input$admin_btn, {
    page("login")
  })
  
  observeEvent(input$back_btn, {
    page("role")
    show_form(FALSE)
  })
  
  observeEvent(input$logout_btn, {
    role(NULL)
    page("role")
  })
  
  observeEvent(input$nav_dashboard, page("admin_dashboard"))
  observeEvent(input$nav_products, page("admin_products"))
  observeEvent(input$nav_orders, page("admin_orders"))
  observeEvent(input$nav_archive, page("admin_archive"))
  
  observeEvent(input$go_menu, page("menu"))
  observeEvent(input$go_cart, page("cart"))
  observeEvent(input$go_orders, page("customer_orders"))
  
  
  observeEvent(input$nav_home, page("role"))
  observeEvent(input$nav_about, page("about"))
  observeEvent(input$nav_contact, page("contact"))
  
  # ==================== ADMIN LOGIN ====================
  
  observeEvent(input$login_btn, {
    
    if (!is.null(input$username) &&
        input$username %in% names(valid_users) &&
        valid_users[[input$username]] == input$password) {
      
      role("admin")
      page("admin_dashboard")
      
    } else {
      
      showNotification(
        "Invalid username or password. Please try again.",
        type="error"
      )
    }
  })
  
  # ==================== DELIVERY ====================
  
  observeEvent(input$yes_mandaluyong, {
    show_form(TRUE)
  })
  
  observeEvent(input$no_mandaluyong, {
    
    showModal(
      modalDialog(
        title="🚨 Delivery Notice",
        "Sorry, this shop currently only accepts orders within Mandaluyong City.",
        easyClose=TRUE
      )
    )
  })
  
  # ==================== CUSTOMER INFO ====================
  
  observeEvent(input$confirm_info, {
    
    # EMPTY FIELD VALIDATION
    
    if (
      input$name == "" ||
      input$address == "" ||
      input$contact == "" ||
      input$email == ""
    ) {
      
      showNotification(
        "Please fill out all required fields.",
        type = "error"
      )
      
      return()
    }
    
    # CONTACT NUMBER VALIDATION
    contact_clean <- gsub("[^0-9]", "", input$contact)
    
    if (
      nchar(contact_clean) != 11 ||
      !grepl("^09", contact_clean)
    ) {
      showNotification(
        "Invalid contact number. Please try again.",
        type = "error",
        duration = 10
      )
      return()
    }
    
    # EMAIL VALIDATION
    
    valid_email <- grepl(
      "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$",
      input$email
    )
    
    if (!valid_email) {
      
      showNotification(
        "Invalid email address. Please try again.",
        type = "error"
      )
      
      return()
    }
    
    # SAVE CUSTOMER INFO
    
    customer_info(list(
      name = input$name,
      address = input$address,
      contact = input$contact,
      email = input$email
    ))
    
    # SUCCESS MODAL
    
    showModal(
      modalDialog(
        title = "Welcome to SweetSpot! 🤗",
        HTML("
          <h4>Your information has been successfully validated.</h4>

          <br>

          <p><b>Thank you for visiting SweetSpot Bites!</b></p>

          <p>You can now start ordering your favorite treats.</p>

          <br>

          <p>For further questions, feel free to contact our Instagram account.</p>

          <p>💌 Instagram: <b>@sweetspot_bites</b></p>
        "),
        easyClose = TRUE
      )
    )
    
    page("menu")
  })
  
  # ==================== PRODUCT MODALS ====================
  
  show_product_modal <- function(name, price) {
    
    selected_item(name)
    selected_price(price)
    
    showModal(
      modalDialog(
        title=name,
        
        numericInput("qty","Quantity",1,min=1),
        
        actionButton(
          "add_cart",
          "Add to Cart 🛒",
          class="action-btn"
        ),
        
        easyClose=TRUE
      )
    )
  }
  
  # ==================== ADD TO CART ====================
  
  observeEvent(input$add_cart, {
    
    req(selected_item(),
        selected_price(),
        input$qty)
    
    cart(
      rbind(
        cart(),
        data.frame(
          item=selected_item(),
          price=selected_price(),
          qty=input$qty,
          stringsAsFactors=FALSE
        )
      )
    )
    
    removeModal()
    
    showNotification("Added to cart!", type="message")
  })
  
  # ==================== REVIEW ORDER ====================
  
  observeEvent(input$place_order, {
    
    req(nrow(cart()) > 0)
    
    showModal(
      
      modalDialog(
        
        title = "❓ Confirm Order",
        
        "Are you sure about your order?",
        
        br(),
        br(),
        
        footer = div(
          
          style = "
    display:flex;
    gap:10px;
    justify-content:center;
  ",
          
          actionButton(
            "confirm_order",
            "Confirm Order ❤️",
            class = "action-btn",
            style = "width:220px;"
          ),
          
          actionButton(
            "order_more",
            "Order More 🚫",
            class = "action-btn",
            style = "width:220px;"
          )
        ),
        
        easyClose = TRUE
      )
    )
  })
  
  # ==================== GO TO ORDER SUMMARY ====================
  
  observeEvent(input$confirm_order, {
    
    removeModal()
    
    page("customer_orders")
  })
  
  observeEvent(input$order_more, {
    
    removeModal()
  })
  
  # ==================== FINAL PLACE ORDER ====================
  
  observeEvent(input$final_place_order, {
    
    cust <- customer_info()
    
    cart_df <- cart()
    
    subtotal <- sum(cart_df$price * cart_df$qty)
    
    delivery_fee <- 50
    
    grand_total <- subtotal + delivery_fee
    
    # ================= STOCK VALIDATION BEFORE CHECKOUT =================
    
    plist <- products()
    
    insufficient <- character(0)
    
    for (j in seq_len(nrow(cart_df))) {
      
      prod_row <- which(
        plist$name == cart_df$item[j]
      )
      
      if (length(prod_row) > 0) {
        
        if (plist$qty[prod_row] < cart_df$qty[j]) {
          
          insufficient <- c(
            insufficient,
            cart_df$item[j]
          )
        }
      }
    }
    
    if (length(insufficient) > 0) {
      
      showNotification(
        
        paste0(
          "Insufficient stock for: ",
          paste(insufficient, collapse = ", ")
        ),
        
        type = "error"
      )
      
      return()
    }
    new_order <- list(
      
      order_no = length(orders()) + 1,
      
      name = cust$name,
      address = cust$address,
      contact = cust$contact,
      email = cust$email,
      
      items = cart_df,
      
      special_request = special_request(),
      
      total = grand_total,
      
      status = "Pending"
    )
    
    updated_orders <- append(
      orders(),
      list(new_order)
    )
    
    orders(updated_orders)
    
    save_orders(updated_orders)
    
    # ==================== STOCK DEDUCTION ====================
    
    plist <- products()
    
    for (k in seq_len(nrow(cart_df))) {
      
      item_name <- cart_df$item[k]
      qty_bought <- cart_df$qty[k]
      
      product_index <- which(plist$name == item_name)
      
      if (length(product_index) > 0) {
        
        plist$qty[product_index] <-
          plist$qty[product_index] - qty_bought
      }
    }
    
    products(plist)
    
    save_products(plist)
    
    showModal(
      
      modalDialog(
        
        title = "Thank You for Ordering! 🥰",
        
        HTML("
        <h4>Your order has been successfully placed.</h4>

        <br>

        <p>Please keep in line while we prepare your order.</p>

        <p>SweetSpot will contact you soon regarding delivery updates.</p>

        <br>

        <p>Thank you for supporting SweetSpot Bites!</p>
      "),
        
        easyClose = TRUE
      )
    )
    
    cart(
      data.frame(
        item=character(),
        price=numeric(),
        qty=numeric(),
        stringsAsFactors=FALSE
      )
    )
    
    special_request("")
  })
  # ==================== DASHBOARD FILTER ====================
  
  observeEvent(input$dash_all, dash_filter("All"))
  observeEvent(input$dash_cookies, dash_filter("Cookies"))
  observeEvent(input$dash_flowers, dash_filter("Flowers"))
  observeEvent(input$dash_mix, dash_filter("Mix and Match"))
  
  observeEvent(input$filter_all, customer_filter("All"))
  observeEvent(input$filter_cookies, customer_filter("Cookies"))
  observeEvent(input$filter_flowers, customer_filter("Flowers"))
  observeEvent(input$filter_mix, customer_filter("Mix and Match"))
  
  # ==================== ADD PRODUCT ====================
  
  observeEvent(input$add_product, {
    
    req(input$prod_name)
    req(input$prod_category)
    req(input$prod_price)
    req(input$prod_qty)
    
    img <- ""
    
    if (!is.null(input$prod_img) && nzchar(input$prod_img$datapath)) {
      img <- base64enc::dataURI(
        file = input$prod_img$datapath,
        mime = input$prod_img$type
      )
    }
    
    new <- data.frame(
      category = input$prod_category,
      name = input$prod_name,
      price = input$prod_price,
      qty = input$prod_qty,
      img = img,
      stringsAsFactors = FALSE
    )
    
    current <- products()
    
    if (is.null(current) || nrow(current) == 0) {
      updated <- new
    } else {
      updated <- rbind(current, new)
    }
    
    products(updated)
    save_products(updated)
    
    showNotification("Product saved!", type = "message")
  })
  
  # ==================== PRODUCT RENDER ====================
  
  output$product_cards <- renderUI({
    
    plist <- products()
    
    if (nrow(plist) == 0) {
      
      return(
        div(
          style="padding:20px;",
          "No products available."
        )
      )
    }
    
    div(class="product-grid",
        
        lapply(seq_len(nrow(plist)), function(i) {
          
          div(class="product-card",
              
              if (plist$img[i] != "")
                tags$img(
                  src=plist$img[i],
                  height="100px"
                ),
              
              h4(plist$name[i]),
              p(plist$category[i]),
              p(paste("₱", plist$price[i])),
              p(paste("Stock:", plist$qty[i])),
              
              actionButton(
                paste0("edit_", i),
                "Edit ✏️"
              )
          )
        })
    )
  })
  
  # ==================== EDIT PRODUCT ====================
  
  observe({
    plist <- products()
    
    lapply(seq_len(nrow(plist)), function(i) {
      
      local({
        my_i <- i
        
        observeEvent(input[[paste0("edit_", my_i)]], {
          
          edit_index(my_i)
          
          showModal(
            modalDialog(
              title = "Edit Product",
              
              textInput("edit_name", "Name", plist$name[my_i]),
              
              selectInput(
                "edit_category",
                "Category",
                choices = c("Cookies","Flowers","Mix and Match"),
                selected = plist$category[my_i]
              ),
              
              numericInput("edit_price", "Price", plist$price[my_i]),
              numericInput("edit_qty", "Qty", plist$qty[my_i]),
              fileInput("edit_img", "Image"),
              
              actionButton("save_edit", "Save"),
              easyClose = TRUE
            )
          )
          
        }, ignoreInit = TRUE)
        
      })
    })
  })
  # ==================== SAVE EDIT ====================
  
  observeEvent(input$save_edit, {
    
    i <- edit_index()
    req(i)
    
    plist <- products()
    
    plist$name[i] <- input$edit_name
    plist$price[i] <- input$edit_price
    plist$qty[i] <- input$edit_qty
    
    # CATEGORY UPDATE
    plist$category[i] <- input$edit_category
    
    # IMAGE FIX: keep old image if none uploaded
    if (!is.null(input$edit_img) && nzchar(input$edit_img$datapath)) {
      plist$img[i] <- base64enc::dataURI(
        file = input$edit_img$datapath,
        mime = input$edit_img$type
      )
    }
    
    products(plist)
    save_products(plist)
    
    removeModal()
    showNotification("Updated!", type="message")
  })
  
  # ==================== CART TABLE ====================
  
  output$cart_table <- renderTable({
    
    cart_df <- cart()
    
    if (nrow(cart_df) == 0) {
      
      return(
        data.frame(
          Message="Cart is empty!"
        )
      )
    }
    
    cart_df
  })
  
  # ==================== ORDERS TABLE ====================
  
  output$orders_table <- renderUI({
    
    ord <- orders()
    
    if (length(ord) == 0) {
      return(div("No orders yet"))
    }
    
    lapply(seq_along(ord), function(i) {
      
      o <- ord[[i]]
      
      name <- o[["name"]]
      address <- o[["address"]]
      contact <- o[["contact"]]
      email <- o[["email"]]
      items <- o[["items"]]
      total <- o[["total"]]
      
      div(
        style="
        border: 2px solid #ff6b6b;
        border-radius: 15px;
        padding: 15px;
        margin-bottom: 15px;
        background: #fff5f7;
      ",
        
        h4(paste("🧾 Order #", i)),
        
        p(paste("👤 Name:", name)),
        p(paste("🏰 Address:", address)),
        p(paste("📞 Contact:", contact)),
        p(paste("💌 Email:", email)),
        p(paste("📌 Status:", o[["status"]])),
        
        if (!is.null(o[["special_request"]]) &&
            o[["special_request"]] != "") {
          
          p(
            paste(
              "✨ Special Request:",
              o[["special_request"]]
            )
          )
        },
        
        hr(),
        h5("🛒 Items"),
        
        if (!is.null(items) && is.data.frame(items) && nrow(items) > 0) {
          
          lapply(seq_len(nrow(items)), function(j) {
            p(
              paste0(
                items$item[j],
                " x", items$qty[j],
                " = ₱", items$price[j] * items$qty[j]
              )
            )
          })
          
        } else {
          p("No items found")
        },
        
        hr(),
        h4(paste("💰 Total: ₱", total)),
        
        br(),
        actionButton(paste0("done_", i), "Mark as Done 💯"),
        actionButton(paste0("delete_", i), "Delete 🗑")
      )
    })
  })
  
  # ==================== MAIN UI ====================
  
  output$main_ui <- renderUI({
    
    if (page()=="role") {
      
      tagList(
        
        # ===== NAVBAR =====
        
        div(
          class = "navbar",
          div(
            class = "nav-logo",
            "Sweet Spot"
          ),
          
          div(
            class = "nav-links",
            
            actionButton("nav_home", "Home", class = "nav-login-btn"),
            actionButton("nav_about", "About", class = "nav-login-btn"),
            actionButton("nav_contact", "Contact", class = "nav-login-btn"),
            actionButton("admin_btn", "Admin", class = "nav-login-btn")
          )
        ),
        
        # ===== HERO SECTION =====
        
        div(
          class = "hero-section",
          
          div(
            class = "hero-card",
            
            h1(class = "hero-title", "Sweet Spot"),
            
            p(class = "hero-subtitle",
              tags$em("... where one bite is never enough ִָ𓂃 ࣪˖ ִֶָ🐇་༘࿐")
            ),
            
            actionButton(
              "customer_btn",
              "Shop Now",
              class = "shop-btn"
            )
          )
        )
        
      )
      
    } else if (page()=="login") {
      
      div(
        class="login-panel",
        
        h2("˚ʚ🧸ɞ˚ Admin Login"),
        
        textInput("username","Username"),
        passwordInput("password","Password"),
        
        actionButton(
          "login_btn",
          "Login",
          class="action-btn"
        ),
        
        actionButton(
          "back_btn",
          "Back",
          class="action-btn"
        )
      )
      
    } else if (page()=="home") {
      
      div(
        class="app-container",
        
        actionButton(
          "back_btn",
          "⬅ Go Back",
          class="action-btn"
        ),
        
        h2("🛵 Delivery Check"),
        
        h4("Is your address in Mandaluyong City?"),
        
        if (!show_form()) {
          
          tagList(
            
            actionButton(
              "yes_mandaluyong",
              "Yes",
              class="action-btn"
            ),
            
            actionButton(
              "no_mandaluyong",
              "No",
              class="action-btn"
            )
          )
        },
        
        if (show_form()) {
          
          div(
            class="center-form",
            
            div(
              class="form-box",
              
              h4("Contact Information"),
              
              textInput("name","Full Name"),
              textInput("address","Address"),
              textInput("contact","Contact Number"),
              textInput("email","Email"),
              
              actionButton(
                "confirm_info",
                "Confirm",
                class="action-btn"
              )
            )
          )
        }
      )
      
    } else if (page()=="menu") {
      
      tagList(
        
        # ================= SIDEBAR =================
        
        div(
          class="sidebar",
          
          h3("ʕ´•ᴥ•`ʔ CUSTOMER"),
          
          actionButton(
            "go_menu",
            "Menu",
            class="action-btn"
          ),
          
          actionButton(
            "go_cart",
            "Cart",
            class="action-btn"
          ),
          
          actionButton(
            "go_orders",
            "Order Summary",
            class="action-btn"
          ),
          
          hr(),
          
          actionButton(
            "logout_btn",
            "Log Out",
            class="action-btn"
          )
        ),
        
        # ================= MAIN PAGE =================
        
        div(
          class="main",
          
          h2("🌸🍪 Menu"),
          
          # ===== CATEGORY BUTTONS UNDER MENU =====
          
          div(
            class="filter-bar",
            
            actionButton("filter_all", "All"),
            
            actionButton("filter_cookies", "Cookies"),
            
            actionButton("filter_flowers", "Flowers"),
            
            actionButton("filter_mix","Mix and Match")
          ),
          
          br(),
          
          actionButton(
            "special_request_btn",
            "✨ Special Request",
            class="action-btn"
          ),
          
          br(),
          br(),
          
          {
            # Get the FULL product list and record original row indices
            full_plist <- products()
            
            # Apply category filter — keep original row numbers
            if (customer_filter() != "All") {
              keep <- which(full_plist$category == customer_filter())
            } else {
              keep <- seq_len(nrow(full_plist))
            }
            
            if (length(keep) == 0) {
              
              div("No products yet")
              
            } else {
              
              div(
                class="product-grid",
                
                # FIX: use `orig_i` (original row index) as the button ID suffix,
                # NOT the filtered loop counter. This ensures buy_3 always means
                # row 3 of the full products list, matching the observer registration.
                lapply(keep, function(orig_i) {
                  
                  item <- full_plist[orig_i, ]
                  
                  div(
                    class="product-card",
                    
                    if (item$img != "")
                      tags$img(src=item$img, height="100px"),
                    
                    h4(item$name),
                    
                    p(item$category),
                    
                    p(paste0("₱", item$price)),
                    
                    p(paste("Stock:", item$qty)),
                    
                    # KEY FIX: button ID uses orig_i (original row), not a counter
                    actionButton(
                      paste0("buy_", orig_i),
                      "Add",
                      class="action-btn"
                    )
                  )
                })
              )
            }
          }
        )
      )
      
      
    } else if (page()=="cart") {
      
      tagList(
        
        div(
          class="sidebar",
          
          h3("ʕ´•ᴥ•`ʔ CUSTOMER"),
          
          actionButton("go_menu", "Menu", class="action-btn"),
          actionButton("go_cart", "Cart", class="action-btn"),
          actionButton("go_orders", "Order Summary", class="action-btn"),
          
          hr(),
          
          actionButton("logout_btn", "Log Out", class="action-btn")
        ),
        
        div(
          class="main",
          
          h2("🛒 Your Cart"),
          
          tableOutput("cart_table"),
          
          br(),
          
          h4(
            paste0(
              "Total: ₱",
              sum(cart()$price * cart()$qty)
            )
          ),
          
          br(),
          
          actionButton(
            "place_order",
            "Place Order ❤️",
            class="action-btn"
          )
        )
      )
      
      # ================= ORDER SUMMARY PAGE =================
      
    } else if (page()=="customer_orders") {
      
      tagList(
        
        div(
          class="sidebar",
          
          h3("ʕ´•ᴥ•`ʔ CUSTOMER"),
          
          actionButton("go_menu", "Menu", class="action-btn"),
          actionButton("go_cart", "Cart", class="action-btn"),
          actionButton("go_orders", "Order Summary", class="action-btn"),
          
          hr(),
          
          actionButton("logout_btn", "Log Out", class="action-btn")
        ),
        
        div(
          class="main",
          
          h2("🧾 Order Summary Receipt"),
          
          {
            
            cust <- customer_info()
            
            cart_df <- cart()
            
            subtotal <- sum(cart_df$price * cart_df$qty)
            
            delivery_fee <- 50
            
            grand_total <- subtotal + delivery_fee
            
            div(
              
              style="
            background:white;
            padding:25px;
            border-radius:20px;
            border:2px solid #ff6b6b;
          ",
              
              h3("📌 Customer Information"),
              
              p(paste("👤 Name:", cust$name)),
              p(paste("🏠 Address:", cust$address)),
              p(paste("📞 Contact:", cust$contact)),
              p(paste("📧 Email:", cust$email)),
              
              hr(),
              
              h3("🛒 Orders Received"),
              
              lapply(seq_len(nrow(cart_df)), function(i) {
                
                p(
                  paste0(
                    cart_df$item[i],
                    " x",
                    cart_df$qty[i],
                    " = ₱",
                    cart_df$price[i] * cart_df$qty[i]
                  )
                )
              }),
              
              hr(),
              
              if (special_request() != "") {
                
                tagList(
                  
                  h4("✨ Special Request"),
                  
                  p(special_request()),
                  
                  hr()
                )
              },
              
              h4(paste("Subtotal: ₱", subtotal)),
              
              h4("Delivery Fee: ₱50"),
              
              h3(
                style="color:#e17055;",
                paste("Grand Total: ₱", grand_total)
              ),
              
              br(),
              
              actionButton(
                "final_place_order",
                "Place Order ❤️",
                class="action-btn"
              )
            )
          }
        )
      )
      
    } else if (page()=="admin_dashboard") {
      
      tagList(
        
        div(
          class="sidebar",
          
          h3("˚ʚ🧸ɞ˚ADMIN"),
          
          actionButton("nav_dashboard","Dashboard",class="action-btn"),
          actionButton("nav_products","Products",class="action-btn"),
          actionButton("nav_orders","Orders",class="action-btn"),
          actionButton("nav_archive","Archive",class="action-btn"),
          
          hr(),
          
          actionButton("logout_btn","Log Out",class="action-btn")
        ),
        
        div(
          class="main",
          
          h2("🎯 Dashboard Overview"),
          
          div(
            class="filter-bar",
            
            actionButton("dash_all","All"),
            actionButton("dash_cookies","Cookies"),
            actionButton("dash_flowers","Flowers"),
            actionButton("dash_mix","Mix and Match")
          ),
          
          br(),
          
          {
            plist <- products()
            
            if (dash_filter() != "All") {
              plist <- plist[plist$category == dash_filter(), , drop = FALSE]
            }
            
            if (nrow(plist) == 0) {
              div(style="padding:20px;", "No products available.")
            } else {
              div(class="product-grid",
                  lapply(seq_len(nrow(plist)), function(i) {
                    div(class="product-card",
                        if (plist$img[i] != "")
                          tags$img(src=plist$img[i], height="100px"),
                        h4(plist$name[i]),
                        p(plist$category[i]),
                        p(paste("₱", plist$price[i])),
                        p(paste("Stock:", plist$qty[i]))
                    )
                  })
              )
            }
          }
        )
      )
    } else if (page()=="admin_products") {
      
      tagList(
        
        div(
          class="sidebar",
          
          h3("˚ʚ🧸ɞ˚ADMIN"),
          
          actionButton("nav_dashboard","Dashboard",class="action-btn"),
          actionButton("nav_products","Products",class="action-btn"),
          actionButton("nav_orders","Orders",class="action-btn"),
          actionButton("nav_archive","Archive",class="action-btn"),
          
          hr(),
          
          actionButton("logout_btn","Log Out",class="action-btn")
        ),
        
        div(
          class="main",
          
          h2("📦 Products"),
          
          selectInput(
            "prod_category",
            "Category",
            c("Cookies","Flowers","Mix and Match")
          ),
          
          textInput("prod_name","Name"),
          
          numericInput("prod_price","Price",0),
          
          numericInput("prod_qty","Qty",1),
          
          fileInput("prod_img","Image"),
          
          actionButton(
            "add_product",
            "Add Product ❤️",
            class="action-btn"
          ),
          
          hr(),
          
          uiOutput("product_cards")
        )
      )
      
    } else if (page()=="admin_orders") {
      
      tagList(
        
        div(
          class="sidebar",
          
          h3("˚ʚ🧸ɞ˚ADMIN"),
          
          actionButton("nav_dashboard","Dashboard",class="action-btn"),
          actionButton("nav_products","Products",class="action-btn"),
          actionButton("nav_orders","Orders",class="action-btn"),
          actionButton("nav_archive","Archive",class="action-btn"),
          
          hr(),
          
          actionButton("logout_btn","Log Out",class="action-btn")
        ),
        
        div(
          class="main",
          
          h2("📢 Orders"),
          
          uiOutput("orders_table")
        )
      )
      
    } else if (page()=="admin_archive") {
      
      tagList(
        div(
          class="sidebar",
          
          h3("˚ʚ🧸ɞ˚ADMIN"),
          
          actionButton("nav_dashboard","Dashboard",class="action-btn"),
          actionButton("nav_products","Products",class="action-btn"),
          actionButton("nav_orders","Orders",class="action-btn"),
          actionButton("nav_archive","Archive",class="action-btn"),
          
          hr(),
          
          actionButton("logout_btn","Log Out",class="action-btn")
        ),
        
        div(
          class="main",
          
          h2("📦 Archived Orders"),
          
          {
            arch <- archived_orders()
            
            if (length(arch) == 0) {
              div("No archived orders yet")
            } else {
              lapply(seq_along(arch), function(i) {
                o <- arch[[i]]
                
                div(
                  style="border: 2px solid #ccc; border-radius: 15px; padding: 15px; margin-bottom: 15px; background: #f9f9f9;",
                  
                  h4(paste("🧾 Archived Order #", i)),
                  p(paste("👤 Name:", o$name)),
                  p(paste("📌 Status:", o$status)),
                  h5("⭐ Completed Order")
                )
              })
            }
          }
        )
      )
      
    } else if (page()=="about") {
      
      tagList(
        
        div(
          class="navbar",
          div(class="nav-logo", "Sweet Spot"),
          
          div(
            class="nav-links",
            actionButton("nav_home", "Home", class = "nav-login-btn"),
            actionButton("nav_about", "About", class = "nav-login-btn"),
            actionButton("nav_contact", "Contact", class = "nav-login-btn"),
            actionButton("admin_btn", "Admin", class = "nav-login-btn")
          )
        ),
        
        div(
          class = "about-box",
          
          h2("About Sweet Spot"),
          p("Sweet Spot is an online bakery shop established in 2025, created with the goal of bringing joy through freshly made, affordable, and high-quality sweet treats. We specialize in cookies, floral-inspired desserts, and customizable mix-and-match products designed to match every customer’s taste and preference."),
          p("At Sweet Spot, we believe that every bite should feel special—whether it’s a simple snack or a gift for someone meaningful. Our shop is built to provide a smooth and enjoyable ordering experience while offering products that are both delightful and satisfying."),
          p("From our kitchen to your doorstep, Sweet Spot is here to make every moment a little sweeter.")
        )
      )
      
    } else if (page() == "contact") {
      
      tagList(
        
        div(
          class = "navbar",
          div(class = "nav-logo", "Sweet Spot"),
          
          div(
            class = "nav-links",
            actionButton("nav_home", "Home", class = "nav-login-btn"),
            actionButton("nav_about", "About", class = "nav-login-btn"),
            actionButton("nav_contact", "Contact", class = "nav-login-btn"),
            actionButton("admin_btn", "Admin", class = "nav-login-btn")
          )
        ),
        
        div(
          class = "about-box",
          
          h2("Contact Us"),
          
          p("Thank you for visiting SweetSpot Bites!"),
          
          br(),
          
          p("For further questions, feel free to contact our Instagram account."),
          p("💌 Instagram: @sweetspot_bites")
        )
      )
    }
    
  })
  
}

shinyApp(ui, server)