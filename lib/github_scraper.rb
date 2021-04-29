require_relative "./scraper"

class Github_scraper < Scraper
   # username - first argument to command line
   first, *rest = ARGV
   @@username = first
   @start_urls = ["https://github.com/#{@@username}"]
   @@user_info = {}

   def scrape_profile_info
      doc = browser.current_response
      name = doc.css('.p-name').text.gsub(/\n/, "").strip
      username = doc.css(".p-nickname").text.gsub(/\n/, "").strip
      bio = doc.css(".user-profile-bio > div").text.gsub(/\n/, "").strip
      contributions = doc.css(".js-yearly-contributions h2").text.gsub(/\n/, "").strip.split(" ")[0]

      @@user_info[:name] = name
      @@user_info[:username] = username
      @@user_info[:bio] = bio
      @@user_info[:contributions] = contributions
      @@user_info[:pinned_repos] = []

      pinned_repos = doc.css("li > div.pinned-item-list-item").each do |list_element|
         repo_title = list_element.css("span.repo").text.gsub(/\n/, "").strip
         repo_description = list_element.css("p.pinned-item-desc").text.gsub(/\n/, "").strip
         repo_language = list_element.css("span.repo-language-color ~ span").text.gsub(/\n/, "").strip

         @@user_info[:pinned_repos] << {
            :repo_title => repo_title, :repo_description => repo_description, :repo_language => repo_language
         }
      end
      
      save_to "#{@@username}_profile.json".downcase!, @@user_info, format: :json
   end

   def parse(response, url:, data: {})
      scrape_profile_info
      @@user_info
      p "done"
   end
end

Github_scraper.crawl!