task default: %w[test]

task :run do
   ruby "lib/scraper.rb"
end

task :test_github do
   system('TEST=true ruby "test/github_scraper_test.rb"')
end