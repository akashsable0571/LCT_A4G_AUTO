import os
from dotenv import load_dotenv

load_dotenv()

# BASE_URL = os.getenv("BASE_URL", "http://lct-a4g-qa.accoladeelectronics.com/login")
DASHBOARD_URL = os.getenv("DASHBOARD_URL", "http://lct-a4g-qa.accoladeelectronics.com/device-dashboard-page")
BROWSER = os.getenv("BROWSER", "chromium")
HEADLESS = os.getenv("HEADLESS", "false").lower() == "true"
SCREENSHOT_ON_FAILURE = os.getenv("SCREENSHOT_ON_FAILURE", "true").lower() == "true"
LOG_LEVEL = os.getenv("LOG_LEVEL", "INFO")
VIDEO_RECORDING = os.getenv("VIDEO_RECORDING", "false").lower() == "true"
USERNAME = os.getenv("APP_USERNAME")
PASSWORD = os.getenv("APP_PASSWORD")

BASE_URL = os.getenv("BASE_URL")
# USERNAME = os.getenv("USERNAME")
# PASSWORD = os.getenv("PASSWORD")