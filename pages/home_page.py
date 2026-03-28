from pages.base_page import BasePage

class HomePage(BasePage):

    SEARCH_BOX = "input[name='q']"

    def search(self, text):
        self.fill(self.SEARCH_BOX, text)
        self.page.keyboard.press("Enter")
