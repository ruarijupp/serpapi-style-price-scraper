# serpapi-style-price-scraper

A Ruby web scraper built from scratch to collect full product data from Scrapeme.live — built in the style of a real SerpApi junior dev project.

---

## What It Does

This scraper uses Ruby, HTTParty, Nokogiri, and CSV to:

- Visit every product page on `https://scrapeme.live/shop/`
- Dynamically follow the "Next" button for pagination
- Collect **product name**, **price**, **image URL**, and **product URL**
- Output to clean, structured **JSON** (`output/output.json`)
- Also export to human-friendly **CSV** (`output/output.csv`)
- Automatically create an `output/` folder if missing
- Uses a modular, class-based structure for clean upgrades

---

## Why I Built This

To learn and prove I can:

- Build real-world Ruby scrapers
- Structure code professionally (classes, modular methods)
- Solve scraping challenges you'd face at a company like SerpApi
- Handle pagination, broken selectors, and infinite loop bugs
- Write clear, maintainable code — not just “it works” scripts

---

## Challenges I Encountered & How I Solved Them

### 1. Page 1 URL Structure  
**Problem:** Page 1 didn’t follow the `/page/1/` pattern like other pages.  
**Solution:** I avoided hardcoding and followed the "Next" button dynamically, so it always works no matter how the URLs are structured.

---

### 2. Incorrect CSS Selector  
**Problem:** My original selector `.product-title` didn’t work because Scrapeme updated their HTML.  
**Solution:** Used Chrome DevTools to inspect the page → found the correct selector: `.woocommerce-loop-product__title`.

---

### 3. Infinite Loop on Page 1  
**Problem:** The scraper kept scraping the same page because the "Next" link pointed back to itself.  
**Solution:** I added a check to break the loop if `new_url == current_url`.

---

### 4. Relative vs Absolute URLs  
**Problem:** Next page links were relative (like `/shop/page/2/`) and broke my requests.  
**Solution:** Used `URI.join(BASE_URL, url)` to safely build full absolute URLs.

---

### 5. Ruby Undefined Variable Errors  
**Problem:** Got `undefined local variable` errors because variables like `@all_products` weren't accessible everywhere.  
**Solution:** Wrapped everything in a class, declared instance variables properly, and scoped data handling cleanly.

---

### 6. Nokogiri NodeSet .push Error  
**Problem:** Tried to `.push` Ruby hashes directly into `products` (which was a Nokogiri NodeSet).  
**Solution:** Realized NodeSets only accept HTML Nodes. Fixed it by creating a clean Ruby array `product_data` for my hashes, then merging it into `@all_products`.

---

### 7. Saving Into Missing Folders Error  
**Problem:** Got an error: `No such file or directory @ rb_sysopen - output/output.json` when trying to save results.  
**Solution:** Added `Dir.mkdir("output") unless Dir.exist?("output")` to automatically create the output folder if it's missing.

---

### 8. Git Push Error (Remote Ahead)  
**Problem:** Got `rejected: main -> main (fetch first)` error when pushing to GitHub.  
**Solution:** Pulled remote changes with `git pull origin main`, fixed the README merge conflict manually, then committed & pushed again.

---

## Clean Loop Strategy Learned

1. Scrape current page  
2. Collect clean product data  
3. Check for Next button  
4. Break if none or looping  
5. Follow to next page  
6. Repeat until finished

---

## What's Working Right Now

-  Full product data (name, price, image, URL)
-  Pagination support
-  JSON & CSV output
-  Auto folder creation
-  Clean error handling
-  Modular code ready for upgrades

---

##  Future Improvements

- Add User-Agent rotation  
- Add Proxy support  
- Handle CAPTCHA edge cases  
- CLI options (e.g. `--pages`, `--output csv`)  
- Output to SQLite or Postgres  

---

## ⚙ How to Run It Locally

```bash
git clone https://github.com/ruarijupp/serpapi-style-price-scraper.git
cd serpapi-style-price-scraper
ruby scraper.rb

