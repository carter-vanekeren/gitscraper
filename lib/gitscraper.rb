################################################################################
# Copyright Carter Van Ekeren - 2019								    #
# Email : vanek015@umn.edu
# File : gitscraper.rb									         #
################################################################################
require 'json'
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

			@scrape_results << new
		end
		puts "GitScraper$ Hello! I have found #{@scrape_results.count} trending GitHub Repositories."

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

			puts "#{start+1}:  Repo Name: #{@scrape_results[start][:name]}"
			puts "    Description: #{@scrape_results[start][:description]}"
			puts "    Language: #{@scrape_results[start][:language]}"
			puts "    Link: #{@scrape_results[start][:link]}"
			puts "================================================="
			start += 1
		end
		@position += 1
	end

	def visitPage(index)
		if index > 24
			puts "Visit requires a valid number (1-25) as an argument"
		else
			Launchy.open(@scrape_results[index][:link])
		end
	end

	def save_repo(index)
		if index > 24
			puts "Saving a repo requires a valid number (1-25) as an argument"
		else
			repo = {
				"Name" => "#{@scrape_results[index][:name]}",
				"Description" => "#{@scrape_results[index][:description]}",
				"Language" => "#{@scrape_results[index][:language]}",
				"Link" => "#{@scrape_results[index][:link]}"
			}
			file = File.open('favorite_repos.json', 'r')
			content = file.read
			file.close
			favorites = JSON.parse(content)
			favorites["repos"] << repo
			File.open('favorite_repos.json', 'w') do |f|
				f.write(favorites.to_json)
			end
			file.close
		end
	end
end
