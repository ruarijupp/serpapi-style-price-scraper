require "httparty"
require "nokogiri"
require "json"

class ProductScraper
  BASE_URL = "https://scrapeme.live/shop/"

  def initialize
    @url = BASE_URL
    @all_products = []
  end

  def run
    puts "SerpApi scraper booting up..."
    puts "Loop starting bruv..."

    loop do
      puts "Scraping: #{@url}"

      response = HTTParty.get(@url)
      parsed_page = Nokogiri::HTML(response.body)

      products = parsed_page.css(".woocommerce-loop-product__title")
      puts "Found #{products.size} products on this page"

      break if products.empty?

      product_names = products.map { |product| product.text.strip }
      @all_products.concat(product_names)

      next_page_link = parsed_page.css(".next.page-numbers").first

      break unless next_page_link

      puts "Next page link found: #{next_page_link['href']}"

      new_url = next_page_link['href'].start_with?("http") ? next_page_link['href'] : "https://scrapeme.live#{next_page_link['href']}"

      break if new_url == @url

      @url = new_url
    end

    save_results
  end

  private

  def save_results
    File.write("output.json", @all_products.to_json)
    puts "Scraped #{@all_products.size} products total."
  end
end

# Execute it
scraper = ProductScraper.new
scraper.run
