load 'gitscraper.rb'

# Set exit variable
quit = false
# Set help string
help =
"  The following are accepted commands:
            quit : Exit the program
            help : Show all available commands
       show more : Show five more trending repos
        show all : Show all trending repos
  visit <number> : Open GitHub repository in default browser (number is
	          displayed next to the name of repo)"

# Variable used for showing repos, keeps track of what we have already seen
# in the list of scraped repos
factor = 0

# Set up GItScraper and scrape page
gitscraper = GitScraper.new("https://github.com/trending", "GitScraper")
gitscraper.setUp
gitscraper.scrape
factor += 1

# Enter command loop
puts "GitScraper$ What would you like to do? (type 'help' for commands)\n"
while !quit do
	print "GitScraper$ "
	command = gets.strip
	case command
	when "help"
		puts help
	when "quit"
		quit = true
		puts "Have a great day!"
	when "show all"
		gitscraper.show_all()
	when "show more"
		gitscraper.show_five(factor)
		factor += 1
	when /(visit\s\d+)/
		# Get integer from regular expression
		index = command[/\d+/].to_i - 1
		gitscraper.visitPage(index)
	else
		puts "I do not recognize that command."
		puts "Type 'help' for command options."
	end
end
