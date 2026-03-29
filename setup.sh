#!/bin/bash

set -e

echo "Initializing Playwright + Pytest Framework..."

echo "Creating virtual environment..."
python -m venv venv

# Detect OS paths
if [[ "$OSTYPE" == "linux-gnu"* ]] || [[ "$OSTYPE" == "darwin"* ]]; then
    VENV_PYTHON="venv/bin/python"
    VENV_PIP="venv/bin/pip"
    VENV_PLAYWRIGHT="venv/bin/playwright"
else
    VENV_PYTHON="venv/Scripts/python"
    VENV_PIP="venv/Scripts/pip"
    VENV_PLAYWRIGHT="venv/Scripts/playwright"
fi

echo "Upgrading pip..."
$VENV_PYTHON -m pip install --upgrade pip

echo "Installing required packages..."
$VENV_PIP install pytest playwright pytest-playwright python-dotenv pytest-xdist allure-pytest

echo "Installing Playwright browsers..."
$VENV_PLAYWRIGHT install

echo "Creating project structure..."
mkdir -p tests pages config utils reports artifacts logs data

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
BASE_URL=https://example.com
BROWSER=chromium
HEADLESS=false
SCREENSHOT_ON_FAILURE=true
LOG_LEVEL=INFO
VIDEO_RECORDING=false
EOL

# ---------------- CONFIG ----------------
cat <<'EOL' > config/config.py
import os
from dotenv import load_dotenv

load_dotenv()

BASE_URL = os.getenv("BASE_URL", "https://example.com")
BROWSER = os.getenv("BROWSER", "chromium")
HEADLESS = os.getenv("HEADLESS", "false").lower() == "true"
SCREENSHOT_ON_FAILURE = os.getenv("SCREENSHOT_ON_FAILURE", "true").lower() == "true"
LOG_LEVEL = os.getenv("LOG_LEVEL", "INFO")
VIDEO_RECORDING = os.getenv("VIDEO_RECORDING", "false").lower() == "true"
EOL

# ---------------- GLOBAL VARS ----------------
cat <<'EOL' > config/global_var.py
import os
import platform

if platform.system() == "Windows":
    path_divider = "\\"
else:
    path_divider = "/"

ROOT_DIR = os.path.dirname(os.path.dirname(__file__))
CONFIG_PATH = os.path.join(ROOT_DIR, "config")
DATA_FILES_PATH = os.path.join(ROOT_DIR, "data")
ALLURE_RESULTS_PATH = os.path.join(ROOT_DIR, f"reports{path_divider}allureReport")
SCREENSHOT_PATH = os.path.join(ROOT_DIR, f"artifacts{path_divider}screenshots")
REPORT_PATH = os.path.join(ROOT_DIR, "reports")
LOGS_PATH = os.path.join(ROOT_DIR, f"logs{path_divider}testLogs")
VIDEO_DIR = os.path.join(ROOT_DIR, f"artifacts{path_divider}videos")
EOL

# ---------------- BASE PAGE ----------------
cat <<'EOL' > pages/base_page.py
class BasePage:
    def __init__(self, page):
        self.page = page

    def navigate(self, url, wait_until="load", timeout=None):
        return self.page.goto(url, wait_until=wait_until, timeout=timeout)

    def get_title(self):
        return self.page.title()

    def click(self, locator, **kwargs):
        self.page.click(locator, **kwargs)

    def fill(self, locator, text, **kwargs):
        self.page.fill(locator, text, **kwargs)
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

def test_home_page_loads(page):
    home = HomePage(page)
    home.navigate(BASE_URL)
    assert home.get_title() is not None
EOL

# ---------------- README ----------------
cat <<EOL > README.md
# Playwright + Pytest Framework

Playwright + Pytest Automation Framework

## Setup

Activate virtual environment:

Mac/Linux:
    source venv/bin/activate

Windows (Git Bash):
    source venv/Scripts/activate

## Run Tests

pytest

## Project Structure

tests/      -> Test cases
pages/      -> Page Object Model
utils/      -> Utility classes
config/     -> Environment configuration
reports/    -> Test reports
artifacts/  -> Screenshots, videos, traces
logs/       -> Log files
data/       -> Static test data

## Configuration

Modify .env to change:
- BASE_URL
- BROWSER
- HEADLESS
EOL

## install dependencies
pip install -r requirements.txt
pip install playwright --upgrade

echo ""
echo "Framework Setup Completed!"
echo ""
echo "Next:"
echo "   cd PROJECT_NAME"
echo "   source venv/Scripts/activate"
echo "   pytest"
echo ""
echo "Your automation framework is fully ready."
