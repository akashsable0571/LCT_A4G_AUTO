#  || "DEMO"

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
fixtures/   -> Shared fixtures and test data builders
utils/      -> Utility helpers
config/     -> Environment configuration
data/       -> Static test data (CSV/JSON/etc.)
artifacts/  -> Test artifacts (screenshots/videos/traces)
reports/    -> Test reports

## Configuration

Modify .env to change:
- BASE_URL
- BROWSER
- HEADLESS
