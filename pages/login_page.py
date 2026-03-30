class LoginPage:

    def __init__(self, page):
        self.page = page
        self.base_url = "#BASE_URL"
        self.username = "#USER_NAME"
        self.password = "#PASS_WORD"
        
        login = "page.get_by_text("Sign in")"
        

    # 🔹 Open Login Page
    def load(self, base_url):
        self.page.goto(base_url)

    # 🔹 Enter Username
    def enter_username(self, user):
        self.page.locator(self.username).fill(user)

    # 🔹 Enter Password
    def enter_password(self, pwd):
        self.page.locator(self.password).fill(pwd)

    # 🔹 Click Login Button
    def click_login(self):
        self.page.locator(self.login_btn).click()

    # 🔥 🔥 Full Login Method (Most Important)
    def login(self, user, pwd):
        self.enter_username(user)
        self.enter_password(pwd)
        self.click_login()