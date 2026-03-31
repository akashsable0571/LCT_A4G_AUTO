from pages.base_page import BasePage

class Dashboard(BasePage):
    def __init__(self, page):
        super().__init__(page)

    def validate_page_title(self):
        return self.page.get_by_text("Device Dashboard", exact=True)

    def go_to_dashboard(self, dashboard_url: str):
        self.navigate_to(dashboard_url)
        self.validate_page_title().wait_for(state="visible")
        