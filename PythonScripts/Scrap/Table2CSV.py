import csv
from selenium import webdriver
from selenium.webdriver.chrome.options import Options
import configparser
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from bs4 import BeautifulSoup, Comment
from urllib.parse import urlparse, parse_qs
import re  # Import the re module for regular expressions

# Create Chrome options
chrome_options = Options()
chrome_options.add_argument("--headless")  # Run Chrome in headless mode

# Function to login and return configuration
def login(driver, config_path='config.ini'):
    config = configparser.ConfigParser()
    config.read(config_path)
    return config

# Open the browser
# driver = webdriver.Chrome()

# Create a new WebDriver instance with Chrome options
driver = webdriver.Chrome(options=chrome_options)

# Call the login function to retrieve the configuration
config = login(driver)

# Load the website URL
driver.get(config['URL']['website_url'])

# Wait for the second table with ID 't1' to be present
table = WebDriverWait(driver, 10).until(
    EC.presence_of_element_located((By.ID, "t1"))
)

# Get the page source
page_source = driver.page_source

# Parse the HTML using BeautifulSoup
soup = BeautifulSoup(page_source, "html.parser")

# Find the second table with ID 't1'
table = soup.find("table", {"id": "t1"})

# Find all rows in the table
rows = table.find_all("tr")

# Initialize lists to store department names, URLs, and IDs
dept_names = []
urls = []
dept_ids = []

# Iterate over rows, ignoring commented rows
for row in rows[1:]:
    is_commented = False

    # Check for empty department names (row with only an anchor tag)
    if len(row.find_all('a')) == 1 and not row.text.strip():
        is_commented = True
    else:
        # Check for commented-out content (considering the provided example)
        for child in row.children:
            if isinstance(child, str) and child.strip().startswith("  "):
                is_commented = True
                break

    if not is_commented:
        # Find the anchor element in the first column (assuming structure)
        anchor = row.find("a")
        # Extract department name and URL (assuming structure)
        if anchor:
            # Extract department name and remove multiple consecutive spaces
            dept_name = re.sub(r'\s+', ' ', anchor.text.strip())
            url = anchor["href"]
            # Parse URL to extract department ID
            parsed_url = urlparse(url)
            dept_id = parse_qs(parsed_url.query).get('deptt', [''])[0]
            # Append data to lists
            dept_names.append(dept_name)
            urls.append(url)
            dept_ids.append(dept_id)

# Write data to CSV file
with open("dept.csv", "w", newline="") as csvfile:
    writer = csv.writer(csvfile)
    # Write headers
    writer.writerow(["Dept Name", "URL", "Dept ID"])
    # Write data rows
    for dept_name, url, dept_id in zip(dept_names, urls, dept_ids):
        writer.writerow([dept_name, url, dept_id])

# Close the browser
driver.quit()

# Open faculty.csv file for writing
with open("faculty.csv", "w", newline="") as csvfile:
    writer = csv.writer(csvfile)
    # Write headers
    writer.writerow(["Name", "Designation", "Email", "Dept ID", "Dept Name"])

    # Iterate over URLs
    for url, dept_id, dept_name in zip(urls, dept_ids, dept_names):
        # Open the browser
        # driver = webdriver.Chrome()
        driver = webdriver.Chrome(options=chrome_options)
        # Load the webpage
        driver.get(url)
        # Wait for the table to be present (adjust locator as per your HTML structure)
        table = WebDriverWait(driver, 10).until(
            EC.presence_of_element_located((By.TAG_NAME, "table"))
        )
        # Parse the HTML using BeautifulSoup
        soup = BeautifulSoup(driver.page_source, "html.parser")
        # Find the table (assuming it's the first table on the page)
        table = soup.find("table")
        # Find all rows in the table
        rows = table.find_all("tr")
        # Iterate over rows (skipping header if exists)
        for row in rows[1:]:
            # Extract Name, Designation, and Email (assuming structure)
            cols = row.find_all("td")
            name = re.sub(r'\s+', ' ', cols[0].get_text(strip=True))  # Remove multiple consecutive spaces
            designation = cols[1].get_text(strip=True)
            email = cols[2].get_text(strip=True)
            # Write data row to CSV
            writer.writerow([name, designation, email, dept_id, dept_name])
        # Close the browser
        driver.quit()

print("CSV file saved successfully.")
