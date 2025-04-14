require "httparty"
require "nokogiri"
require "json"
require 'uri'
require 'csv'   # lets us save csv files

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

      products = parsed_page.css('.product')   # still scraping all the product HTML cards
      product_data = []   
      puts "Found #{products.size} products on this page"

      break if products.empty?

      parsed_page.css('.product').each do |product|     # loop through every product card
        
        title = product.at_css('.woocommerce-loop-product__title')&.text   # grab product name
        price = product.at_css('.price')&.text || "Price unavailable"     # grab price or fallback
        image_url = product.at_css('img')&.[]('src')                      # grab image link
        url = product.at_css('a')&.[]('href')                             # grab product link
        url = URI.join(BASE_URL, url).to_s if url                        # build full link if exists
      
        product_data << {                                                   # add this product to array
          title: title,
          price: price,
          image_url: image_url,
          url: url
        }
      end
      
      @all_products.concat(product_data)

      next_page_link = parsed_page.css(".next.page-numbers").first

      break unless next_page_link

      puts "Next page link found: #{next_page_link['href']}"

      new_url = next_page_link['href'].start_with?("http") ? next_page_link['href'] : "https://scrapeme.live#{next_page_link['href']}"

      break if new_url == @url

      @url = new_url
    end

    save_results
    save_csv
  end

  private

  def save_results
    Dir.mkdir("output") unless Dir.exist?("output")
  
    File.write("output/output.json", JSON.pretty_generate({ products: @all_products }))
    puts "Saved JSON with #{@all_products.size} products."
  end

  def save_csv
    Dir.mkdir("output") unless Dir.exist?("output")
  
    CSV.open("output/output.csv", "w") do |csv|
      csv << ["title", "price", "image_url", "url"]
  
      @all_products.each do |product|
        csv << [product[:title], product[:price], product[:image_url], product[:url]]
      end
    end
  
    puts "Saved CSV with #{@all_products.size} products."
  end

end
# Execute it
scraper = ProductScraper.new
scraper.run
   