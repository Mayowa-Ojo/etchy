require_relative "./scraper"

class Indeed_scraper < Scraper
   @start_urls = ["https://www.indeed.com/jobs?q=software+engineer&l=New+York%2C+NY"]
   @@jobs = []

   def scrape_jobs
      doc = browser.current_response
      returned_jobs = doc.css('td#resultsCol')
      returned_jobs.css('div.jobsearch-SerpJobCard').each do |char_element|
         title = char_element.css('h2 a')[0].attributes["title"].value.gsub(/\n/, "")
         link = "https://indeed.com" + char_element.css('h2 a')[0].attributes["href"].value.gsub(/\n/, "")
         description = char_element.css('div.summary').text.gsub(/\n/, "")
         company = description = char_element.css('span.company').text.gsub(/\n/, "")
         location = char_element.css('div.location').text.gsub(/\n/, "")
         salary = char_element.css('div.salarySnippet').text.gsub(/\n/, "")
         requirements = char_element.css('div.jobCardReqContainer').text.gsub(/\n/, "")

         # creating a job object
         job = {title: title, link: link, description: description, company: company, location: location, salary: salary, requirements: requirements}

         # adding the object if it is unique
         self.class.class_variable_get(:@@jobs) << job if !@@jobs.include?(job)
      end 
   end

   def parse(response, url:, data: {})
      scrape_jobs
      @@jobs
      puts "jobs length: " + @@jobs.length.to_s
   end
end

Indeed_scraper.crawl!