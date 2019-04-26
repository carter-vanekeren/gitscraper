# GitScraper
GitScraper is small command-line application that scrapes the top 25 trending GitHub repositories.
Once scraped, you can execute several commands to save, visit or show more trending repos.

## Design
I designed GitScraper to be extended to support more scrapers.  Every scraper is inherits functionality from a base Scraper class, allowing for more scrapers to be added relatively easily.  

## Next Steps 
##### Short term
I would like to add a scraper that retrieves job listings from a specified website and provides the same functionality as the GitHub scraper.  

##### Long term
My ultimate goal is to create an application that can create a scraper for you based on information about what website you want to scrape information from and what type of information you would like to scrape.

## How to use
### Mac
#### You must have the following installed 
Ruby 2.6.3 - [Update](http://codingpad.maryspad.com/2017/04/29/update-mac-os-x-to-the-current-version-of-ruby/)
You will need the following gems installed and up to date: 

- nokogiri
- launchy
- httparty
- bundler 
##### To update/install gems 
```
gem update --system
gem install bundler
```
[Installing/updating gems](https://guides.rubygems.org/rubygems-basics/)
#### To run 
```
bundle install
bin/gitscraper
```
### Linux
#### You must have the following installed 
Ruby 2.6.3 - [Install instructions](https://linuxize.com/post/how-to-install-ruby-on-ubuntu-18-04/https://linuxize.com/post/how-to-install-ruby-on-ubuntu-18-04/) 

You will need the following gems installed and up to date: 
- nokogiri
- launchy
- httparty
- bundler 
##### To update/install gems 
You will need RubyGems installed first - [Install instructions](https://www.vultr.com/docs/how-to-install-rubygems-on-linux)
Once installed...
```
gem update --system
gem install bundler
```
[Installing/updating gems](https://guides.rubygems.org/rubygems-basics/)
#### To run 
```
bundle install
bin/gitscraper
