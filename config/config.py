import os
from dotenv import load_dotenv

load_dotenv()

BASE_URL = os.getenv("BASE_URL", "https://lct-a4g-qa.accoladeelectronics.com/login")
DASHBOARD_URL = os.getenv("DASHBOARD_URL", "https://lct-a4g-qa.accoladeelectronics.com/dashboard")
USERNAME = os.getenv("USERNAME", "")
PASSWORD = os.getenv("PASSWORD", "LWj09BEg")
BROWSER = os.getenv("BROWSER", "chromium")
HEADLESS = os.getenv("HEADLESS", "false").lower() == "true"
SCREENSHOT_ON_FAILURE = os.getenv("SCREENSHOT_ON_FAILURE", "true").lower() == "true"
LOG_LEVEL = os.getenv("LOG_LEVEL", "INFO")
VIDEO_RECORDING = os.getenv("VIDEO_RECORDING", "false").lower() == "true"
USER_NAME = os.getenv("super.admin@accoladeelectronics.com")
PASS_WORD = os.getenv("LWj09BEg")
