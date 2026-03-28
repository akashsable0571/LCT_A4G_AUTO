from pages.home_page import HomePage
from config.config import BASE_URL

def test_google_search(page):
    home = HomePage(page)
    home.navigate(BASE_URL)
    assert "AEPL LCT-A4G" in home.get_title()
 