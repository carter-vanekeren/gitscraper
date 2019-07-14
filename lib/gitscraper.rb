################################################################################
# Copyright Carter Van Ekeren - 2019								    #
# Email : vanek015@umn.edu										    #
# File : gitscraper.rb									              #
################################################################################
require 'json'
require_relative 'scraper.rb'

class GitScraper < Scraper
	def scrape()
		trending = @parsed_page.css('body > div.application-main > main > div.explore-pjax-container.container-lg.p-responsive.pt-6 > div > div > article')
		trending.each do |repo|
			new = {
				name: repo.css('h1 > a')[0].text.strip,
			     link: "https://github.com" + repo.css('h1 > a')[0].attributes["href"].value.strip,
				description: repo.css('p').text.strip,
				language: repo.css("span[itemprop='programmingLanguage']").text.strip
			}
			@scrape_results << new
		end
		puts "GitScraper$ Hello! I have found #{@scrape_results.count} trending GitHub Repositories."
		puts "GitScraper$ Here are the top 5:"
		showFive()
	end

	def showFive()
		if @position > 4
			@position = @position % 5
		end
		start = @position * 5
		while start < (@position + 1) * 5 do
			# Output repo information
			puts "================================================="
			puts "#{start+1}:  Repo Name: #{@scrape_results[start][:name]}"
			puts "    Description: #{@scrape_results[start][:description]}"
			puts "    Language: #{@scrape_results[start][:language]}"
			puts "    Link: #{@scrape_results[start][:link]}"
			puts "================================================="
			start += 1
		end
		@position += 1
	end

	def visitPage(index, favorites)
		if favorites
			saved = getJSON()
			Launchy.open(saved["repos"][index]["Link"])
		else
			if index > 24
				puts "Visit requires a valid number (1-25) as an argument"
			else
				Launchy.open(@scrape_results[index][:link])
			end
		end

	end

	def save(index)
		if index > 24
			puts "Saving a repo requires a valid number (1-25) as an argument"
		else
			# Store repo of interest in a hash
			repo = {
				"Name" => "#{@scrape_results[index][:name]}",
				"Description" => "#{@scrape_results[index][:description]}",
				"Language" => "#{@scrape_results[index][:language]}",
				"Link" => "#{@scrape_results[index][:link]}"
			}
			# Open file and read contents for json parsing
			favorites = getJSON()
			file = File.open('saved/favorite_repos.json', 'w')
			# Add repo to the parsed json
			favorites["repos"] << repo
			# Write modified json to file
			file.write(favorites.to_json)
			file.close
		end
	end

	def viewSaved()
		# Open file and read contents for json parsing
		saved = getJSON()
		number = 1
		saved["repos"].each do |repo|
			puts "#{number}. #{repo["Name"]}"
			number += 1
		end
	end

	def getJSON()
		file = File.open('saved/favorite_repos.json', 'r')
		content = file.read
		file.close
		saved = JSON.parse(content)
	end
end
