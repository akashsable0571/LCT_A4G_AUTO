#!/bin/bash

set -e

echo "🚀 Initializing Playwright + Pytest Framework..."

echo "🐍 Creating virtual environment..."
python -m venv venv

# Detect OS paths
if [[ "$OSTYPE" == "linux-gnu"* ]] || [[ "$OSTYPE" == "darwin"* ]]; then
    echo "📦 Installing system dependencies for Playwright..."

    sudo apt update -y && sudo apt install -y python3-venv
    sudo apt install -y nodejs npm
    sudo npm install -g playwright

    VENV_PYTHON="venv/bin/python"
    VENV_PIP="venv/bin/pip"
    VENV_PLAYWRIGHT="venv/bin/playwright"
else
    VENV_PYTHON="venv/Scripts/python"
    VENV_PIP="venv/Scripts/pip"
    VENV_PLAYWRIGHT="venv/Scripts/playwright"
fi

echo "⬆️ Upgrading pip..."
$VENV_PYTHON -m pip install --upgrade pip

echo "📦 Installing required packages..."
$VENV_PIP install pytest playwright pytest-playwright python-dotenv pytest-xdist allure-pytest

echo "🌍 Installing Playwright browsers..."
$VENV_PLAYWRIGHT install

echo "📂 Creating project structure..."
mkdir tests pages config utils reports

# ---------------- REQUIREMENTS ----------------
cat <<EOL > requirements.txt
pytest
playwright
pytest-playwright
python-dotenv
pytest-xdist
allure-pytest
EOL

# ---------------- ENV ----------------
cat <<EOL > .env
BASE_URL=http://lct-a4g-qa.accoladeelectronics.com/login
BROWSER=chromium
HEADLESS=false
EOL

# ---------------- CONFIG ----------------
cat <<'EOL' > config/config.py
import os
from dotenv import load_dotenv

load_dotenv()

BASE_URL = os.getenv("BASE_URL", "http://lct-a4g-qa.accoladeelectronics.com/login")
BROWSER = os.getenv("BROWSER", "chromium")
HEADLESS = os.getenv("HEADLESS", "false").lower() == "true"
EOL

# ---------------- BASE PAGE ----------------
cat <<'EOL' > pages/base_page.py
class BasePage:
    def __init__(self, page):
        self.page = page

    def navigate(self, url):
        self.page.goto(url)

    def get_title(self):
        return self.page.title()

    def click(self, locator):
        self.page.click(locator)

    def fill(self, locator, text):
        self.page.fill(locator, text)
EOL

# ---------------- SAMPLE PAGE ----------------
cat <<'EOL' > pages/home_page.py
from pages.base_page import BasePage

class HomePage(BasePage):

    SEARCH_BOX = "input[name='q']"

    def search(self, text):
        self.fill(self.SEARCH_BOX, text)
        self.page.keyboard.press("Enter")
EOL

# ---------------- UTILS ----------------
cat <<'EOL' > utils/helpers.py
import random
import string

class Helpers:

    @staticmethod
    def generate_random_string(length=6):
        return ''.join(random.choices(string.ascii_letters, k=length))
EOL

# ---------------- CONFTST ----------------
cat <<'EOL' > conftest.py
import pytest
from playwright.sync_api import sync_playwright
from config.config import BROWSER, HEADLESS

@pytest.fixture(scope="session")
def playwright_instance():
    with sync_playwright() as p:
        yield p

@pytest.fixture(scope="session")
def browser(playwright_instance):
    browser_type = getattr(playwright_instance, BROWSER)
    browser = browser_type.launch(headless=HEADLESS)
    yield browser
    browser.close()

@pytest.fixture(scope="function")
def page(browser):
    context = browser.new_context()
    page = context.new_page()
    yield page
    context.close()
EOL

# ---------------- BASIC TEST ----------------
cat <<'EOL' > tests/test_home.py
from pages.home_page import HomePage
from config.config import BASE_URL

def test_google_search(page):
    home = HomePage(page)
    home.navigate(BASE_URL)
    assert "lct-a4g" in home.get_title()
EOL

# ---------------- README ----------------
cat <<EOL > README.md
# $PROJECT_NAME || "DEMO"

Playwright + Pytest Automation Framework

## 🚀 Setup

Activate virtual environment:

Mac/Linux:
    source venv/bin/activate

Windows (Git Bash):
    source venv/Scripts/activate

## ▶ Run Tests

pytest

## 📂 Project Structure

tests/      → Test cases  
pages/      → Page Object Model  
utils/      → Utility classes  
config/     → Environment configuration  
reports/    → Test reports  

## ⚙ Configuration

Modify .env to change:
- BASE_URL
- BROWSER
- HEADLESS
EOL

## install dependencies
pip install -r requirements.txt
pip install playwright --upgrade

echo ""
echo "✅ Framework Setup Completed!"
echo ""
echo "👉 Next:"
echo "   cd PROJECT_NAME"
echo "   source venv/Scripts/activate"
echo "   pytest"
echo ""
echo "🔥 Your automation framework is fully ready."