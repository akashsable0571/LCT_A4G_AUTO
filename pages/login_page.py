import re
from pages.base_page import BasePage
from config.config import USERNAME, PASSWORD

class LoginPage(BasePage):

    def __init__(self, page):
        super().__init__(page)

        # ✅ Enable locators
        self.username = page.get_by_placeholder("Your Email Address")
        self.password = page.get_by_placeholder("Password")
        self.login_btn = page.get_by_role("button", name=re.compile(r"Sign in", re.IGNORECASE))

    # 🔹 Open Login Page
    def load(self, url):
        self.navigate_to(url)   # ✅ FIX

    # 🔹 Perform Login
    def login(self, username=USERNAME, password=PASSWORD):
        self.username.fill(username)
        self.password.fill(password)
        self.login_btn.click()