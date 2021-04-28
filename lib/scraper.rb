require "kimurai"

class Scraper < Kimurai::Base
   @engine = :mechanize
   @config = {
      user_agent: "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.84 Safari/537.36",
      before_request: {
         delay: 4..7
      }
   }
end

# Scraper.crawl!