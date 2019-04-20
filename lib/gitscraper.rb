<<<<<<< HEAD
require 'launchy'
=======
################################################################################
# Copyright Carter Van Ekeren - 2019								    #
# Email : vanek015@umn.edu
# File : gitscraper.rb									         #
################################################################################
>>>>>>> refactor/scraper
load 'lib/scraper.rb'

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
<<<<<<< HEAD
			@results << new
		end
		puts "GitScraper$ Hello! I have found #{@results.count} trending GitHub Repositories."
=======
			@scrape_results << new
		end
		puts "GitScraper$ Hello! I have found #{@scrape_results.count} trending GitHub Repositories."
>>>>>>> refactor/scraper
		puts "GitScraper$ Here are the top 5:"
		show_five()
	end

	def show_five()
		if @position > 4
			@position = @position % 5
		end
		start = @position * 5

		while start < (@position + 1) * 5 do
			# Output repo information
			puts "================================================="
<<<<<<< HEAD
			puts "#{start+1}:  Repo Name: #{@results[start][:name]}"
			puts "    Description: #{@results[start][:description]}"
			puts "    Language: #{@results[start][:language]}"
			puts "    Link: #{@results[start][:link]}"
=======
			puts "#{start+1}:  Repo Name: #{@scrape_results[start][:name]}"
			puts "    Description: #{@scrape_results[start][:description]}"
			puts "    Language: #{@scrape_results[start][:language]}"
			puts "    Link: #{@scrape_results[start][:link]}"
>>>>>>> refactor/scraper
			puts "================================================="
			start += 1
		end
		@position += 1
	end

<<<<<<< HEAD
	def show_all()
		@position = 0
		while @position < 5 do
			show_five()
		end
	end

=======
>>>>>>> refactor/scraper
	def visitPage(index)
		if index > 24
			puts "Visit requires a valid number (1-25) as an argument"
		else
<<<<<<< HEAD
			Launchy.open(@results[index][:link])
=======
			Launchy.open(@scrape_results[index][:link])
>>>>>>> refactor/scraper
		end
	end
end
