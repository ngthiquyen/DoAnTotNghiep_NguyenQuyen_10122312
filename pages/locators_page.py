#LOGIN PAGE
LOGIN_URL = "xpath://div[@class='lf']//span[contains(text(),'Đăng nhập')]"
EMAIL_INPUT = "css:input[placeholder='Email']"
PASSWORD_INPUT = "css:input[placeholder='Password']"
LOGIN_BTN = "xpath://button[contains(text(),'Đăng nhập')]"
ERROR_MSG="xpath://div[contains(text(),'Tài khoản hoặc mật khẩu không chính xác')]"

#REGISTER_PAGE
REGISTER_URL="xpath://div[@class='lf']//span[contains(text(),'Đăng ký')]"
#EMAIL_INPUT="css:input[placeholder='Email']"
PASSWORD_INPUT="css:input[placeholder='Password']"
RE_PASSWORD_INPUT="css:input[placeholder='Re-password']"
REGISTER_BTN="xpath://button[contains(text(),'Đăng ký')]"
ERROR_MSG_REGISTER="css:div[id='WGR_html_alert'] div"


#HOME_PAGE
URL = "https://ella.vn/"
ACCOUNT_NAME = "xpath://div[@class='i bold bluecolor']"
ACCOUNT_PAGE="xpath://div[@class='lf']//span[contains(text(),'Tài khoản')]"
LOGOUT_BTN="xpath://div[@class='lf']//span[contains(text(),'Thoát')]"


#SEARCH PAGE
SEARCH_INPUT = "css:input[name='q']"  
SEARCH_BTN = "css:button[type='submit']"
PRODUCTS_NAME="xpath:(//div[@class='thread-list-title text-center'])"
PRODUCT_ITEMS = "css:li.hide-if-gia-zero a.WGR-fixed-atag"

#ORDER PAGE
ADD_TO_CART_BTN="xpath://div[@class='detail-muangay-button detail-muangay-center detail-muangay-topcenter details-ankhi-hethang d-none fullsize-if-mobile']//div//button[@type='button'][contains(text(),'Cho vào giỏ hàng')]"
CART_ICON="css:a[title='Giỏ hàng']"
CHECKOUT_BTN="xpath://button[contains(text(),'Thanh toán')]"
SUBMIT_ORDER="xpath://button[@id='sb_submit_cart']"
NAME_INPUT="id:t_ten"
PHONE_INPUT="id:t_dienthoai"
EMAIL_INPUT_ORDER="id:t_email"
ADDRESS_INPUT="id:t_diachi"
NOTE_INPUT="id:t_ghichu"
PAYMENT_METHOD = "css:.cart-paymethod-{}"
ORDER_ERROR_MSG="css:div[id='WGR_html_alert'] div"
ORDER_SUCCESS_MSG="css:.big.text-center.upper"


