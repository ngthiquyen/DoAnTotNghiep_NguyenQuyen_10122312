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
