################################################################################
# Copyright Carter Van Ekeren - 2019								    #
# Email : vanek015@umn.edu										    #
# File : jobscraper.rb									              #
################################################################################
require 'byebug'
load 'lib/scraper.rb'

class JobScraper < Scraper
	def scrape
		jobs = @parsed_page.css('ul.jlGrid')
		jobs.each do |job|
			new = {
				title: job.css('a.jobLink').text
			}
			@scrape_results << new
		end
		byebug
	end

	def show_five()
	end

	def visitPage(index, favorites)
	end

	def save(index)
	end

	def viewSaved()
	end
end
