from pages.login_page import LoginPage
from config.config import USERNAME, PASSWORD, DASHBOARD_URL, BASE_URL
from playwright.sync_api import expect

def test_login(page):
    login_page = LoginPage(page)

    login_page.load(BASE_URL)
    print(BASE_URL)
    
    login_page.login(USERNAME, PASSWORD)

    page.wait_for_load_state("networkidle")

    expect(page).to_have_url(DASHBOARD_URL)   # ✅ FIX