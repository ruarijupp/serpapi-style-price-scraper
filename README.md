serpapi-style-price-scraper

A Ruby web scraper built from scratch to collect product data from Scrapeme.live — built in the style of a real SerpApi junior dev project.
What it does

This scraper uses Ruby, HTTParty, and Nokogiri to:

Visit every page of products on https://scrapeme.live/shop/

Dynamically follow the "Next" button (not hardcoded page numbers)

Collect all product names

Save them to a clean, pretty JSON file (output.json)

Why I built this
→ To learn & prove I can:

Build real Ruby web scrapers

Handle scraping challenges like a developer would at SerpApi

Structure code professionally in a class

Debug problems like scope errors, infinite loops, pagination issues

Write clean, readable, maintainable code

How to run it locally
Clone the repo:

bash
Copy
git clone https://github.com/ruarijupp/serpapi-style-price-scraper.git
cd serpapi-style-price-scraper
Install gems:

bash
Copy
bundle install
Run the scraper:

bash
Copy
bundle exec ruby scraper.rb
Results will be saved in:

lua
Copy
output.json
Challenges & Solutions I Encountered
Problem	Solution
Page 1 didn't follow the page/1/ URL pattern	Used dynamic Next button scraping instead of hardcoding page numbers
Scrapeme changed the product class from .product-title to .woocommerce-loop-product__title	Inspected page with Dev Tools, updated Nokogiri selector
Infinite loop on page 1	Added break condition if new URL matched current URL
Relative vs Absolute URLs	Checked if link started with "http" before appending base URL
Ruby undefined variable errors	Scoped @all_products and @url properly inside a class
Handling end of pagination	Break loop if no Next button found
Clean Loop Strategy Learned
Scrape current page

Collect products

Check for Next page link

Break if none or looping

Move to next page

Repeat

Future Improvements
Scrape product prices, images, and other data

Add User-Agent rotation

Add Proxy support

Handle CAPTCHA situations

Save results to CSV or database

CLI options for custom URLs

Final Thoughts
This project was built to show I can approach scraping the way real developers do — with structured code, clean problem-solving, and clear output.
