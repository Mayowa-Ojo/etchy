require "minitest/autorun"
require_relative "../lib/scraper.rb"

class ScraperTest < Minitest::Test
   def test_initializer
      scraper = Scraper.new
      assert_equal scraper.url, "https://github.com"
   end

   def test_class_method
      assert_equal Scraper.scrape, "scraping 5, 4, 3, 2, 1..."
   end
end