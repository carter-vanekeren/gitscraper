require 'nokogiri'
require 'httparty'

class Scraper

	attr_reader :results, :name
	@@scrapers = Array.new
	def initialize (url, name)
		@url = url
		@name = name
		@results = Array.new
		@@scrapers << self

	end

	def setUp()
		page = HTTParty.get(@url)
		@parsed_page = Nokogiri::HTML(page)
	end

	def getScrapers()
		@@scrapers
	end
end
