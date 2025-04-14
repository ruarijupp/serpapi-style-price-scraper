# serpapi-style-price-scraper

A Ruby web scraper built from scratch to collect product data from Scrapeme.live — built in the style of a real SerpApi junior dev project.

## What it does

This scraper uses Ruby, HTTParty, and Nokogiri to:

- Visit every page of products on https://scrapeme.live/shop/
- Dynamically follow the "Next" button (not hardcoded page numbers)
- Collect all product names
- Save them to a clean, pretty JSON file (`output.json`)

## Why I built this

→ To learn & prove I can:

- Build real Ruby web scrapers
- Handle scraping challenges like a developer would at SerpApi
- Structure code professionally in a class
- Debug problems like scope errors, infinite loops, pagination issues
- Write clean, readable, maintainable code


## Challenges I Encountered & How I Solved Them

## 1. Page 1 URL Structure
Problem: Page 1 didn’t follow the same /page/1/ pattern as other pages.
Solution: I handled page 1 manually or scraped dynamically using the "Next" button so the scraper could navigate without relying on hardcoded URLs.

## 2. Incorrect CSS Selector
Problem: My initial selector .product-title wasn’t returning any data because Scrapeme updated their HTML structure.
Solution: Used browser DevTools to find the correct selector .woocommerce-loop-product__title and updated my Nokogiri query.

## 3. Infinite Loop on Page 1
Problem: The scraper kept re-scraping Page 1 because the Next button was leading back to the same page.
Solution: I added a check to break the loop if new_url == current_url — preventing infinite loops.

## 4. Relative vs Absolute URLs
Problem: The Next page link was sometimes a relative path like /shop/page/2/ instead of a full URL.
Solution: I added logic to check if the link started with http. If not, I prepended the base URL manually.

## 5. Ruby Undefined Variable Errors
Problem: Early on I got errors like undefined local variable when using all_products inside the loop.
Solution: I fixed this by declaring @all_products and other key variables properly within the class so they were accessible everywhere I needed them.

## 6. Detecting End of Pagination
Problem: I needed a reliable way to know when there were no more pages to scrape.
Solution: I searched for .next.page-numbers on each page. If it didn’t exist, the loop broke cleanly and the scraper stopped.

## Clean Loop Strategy Learned
- Scrape current page
- Collect products
- Check for Next page link
- Break if none or looping
- Move to next page
- Repeat

## Future Improvements
- Scrape product prices, images, and other data
- Add User-Agent rotation
- Add Proxy support
- Handle CAPTCHA situations
- Save results to CSV or database
- CLI options for custom URLs

  ## How to run it locally

Clone the repo:

```bash
git clone https://github.com/ruarijupp/serpapi-style-price-scraper.git
cd serpapi-style-price-scraper
```

## Final Thoughts

This project was built to show I can approach scraping the way real developers do — with structured code, clean problem-solving, and clear output.


