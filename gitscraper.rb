require 'nokogiri'
require 'httparty'
require 'launchy'
load 'scraper.rb'

class GitScraper < Scraper
	def scrape()
		trending = @parsed_page.css('li.py-4')
		trending.each do |repo|
			new = {
				name: repo.css('a')[0].attributes["href"].value.strip[1..-1],
			     link: "https://github.com" + repo.css('a')[0].attributes["href"].value.strip,
				description: repo.css('p').text.strip,
				language: repo.css("span[itemprop='programmingLanguage']").text.strip
			}
			@results << new
		end
		puts "GitScraper$ Hello! I have found #{@results.count} trending GitHub Repositories."
		puts "GitScraper$ Here are the top 5:"
		show_five(0)
	end

	def show_five(factor)
		if factor > 4
			factor = factor % 5
		end
		start = factor * 5

		while start < (factor + 1) * 5 do
			# Output repo information
			puts "#{start+1}:  Repo Name: #{@results[start][:name]}"
			puts "    Description: #{@results[start][:description]}"
			puts "    Language: #{@results[start][:language]}"
			puts "    Link: #{@results[start][:link]}"
			puts "\n"
			start += 1
		end
	end

	def visitPage(index)
		Launchy.open(@results[index][:link])
	end
end
