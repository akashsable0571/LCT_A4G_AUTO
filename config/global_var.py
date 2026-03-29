import os
import platform


if platform.system() == "Windows":
    path_divider = "\\"
else:
    path_divider = "/"

ROOT_DIR = os.path.dirname(os.path.dirname(__file__))
CONFIG_PATH = os.path.join(ROOT_DIR, f"Config")
DATA_FILES_PATH = os.path.join(ROOT_DIR, f"TestData")
ALLURE_RESULTS_PATH = os.path.join(ROOT_DIR,f"Reports{path_divider}allureReport")
SCREENSHOT_PATH = os.path.join(ROOT_DIR, f"Artifacts{path_divider}Screenshots")
REPORT_PATH = os.path.join(ROOT_DIR, f"Reports")
LOGS_PATH = os.path.join(ROOT_DIR, f"Artifacts{path_divider}Logs")
VIDEO_DIR = os.path.join(ROOT_DIR, f"Artifacts{path_divider}Videos")