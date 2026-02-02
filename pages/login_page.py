from selenium.webdriver.common.by import By

class LoginPage:
    URL = "https://debac.vn/user/signin"

    USERNAME = "id:username"
    PASSWORD = "id:password"
    LOGIN_BTN = "id:btnSubmit"
    ERROR_MESSAGE = "xpath://ul[contains(@class,'errors')]/li"
    SUCCESS_MESSAGE = "xpath://p[span[normalize-space(.)='Email']]"
    ACCOUNT_ICON = "css:i.fa.fa-user-o"  # icon tài khoản
