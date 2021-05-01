require_relative "../lib/github_scraper.rb"
require "minitest/autorun"
require "nokogiri"
require "json"

class ScraperTest < Minitest::Test
   FILES_PATH = "test/files"
   GITHUB_PROFILE_PATH = "#{FILES_PATH}/github_profile.html"
   GITHUB_PROFILE_JSON_PATH = "mayowa-ojo_profile.json"

   def test_scrape_profile_info
      doc = Nokogiri.parse(File.read(GITHUB_PROFILE_PATH))

      scraper = Github_scraper.new
      scraper.scrape_profile_info(doc)
      # puts doc
      
      exists = File.exist? GITHUB_PROFILE_JSON_PATH
      assert_equal exists, true

      file = File.read GITHUB_PROFILE_JSON_PATH
      data, *rest = JSON.parse file

      assert_equal data["name"], "Mayowa Ojo"
      assert_equal data["username"], "Mayowa-Ojo"
      assert_equal data["bio"].split("|").length, 3
      assert_equal data["pinned_repos"].length, 6
   end
end