require 'nokogiri'
require 'httparty'

def scraper
	url = "https://github.com/trending"
	# Get the webpage
	unparsed_page = HTTParty.get(url)
	# Parse the webpage
	parsed_page = Nokogiri::HTML(unparsed_page)
	# Get trending topics
	repos = Array.new
	trending = parsed_page.css('li.py-4')
	trending.each do |repo|
		new = {
			name: repo.css('a')[0].attributes["href"].value.strip[1..-1],
		     link: "https://github.com" + repo.css('a')[0].attributes["href"].value.strip,
			description: repo.css('p').text.strip,
			language: repo.css("span[itemprop='programmingLanguage']").text.strip
		}
		repos << new
	end
	return repos
end
