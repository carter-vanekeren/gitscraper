require 'launchy'
load 'scraper.rb'

# Set exit variable
quit = false
# Set help string
help =
"  The following are accepted commands:
            quit : Exit the program
            help : Show all available commands
            more : Show five more trending repos
             all : Show all trending repos
  visit <number> : Open GitHub repository in default browser (number is
	          displayed next to the name of repo)"

# Variable used for showing repos, keeps track of what we have already seen
# in the list of scraped repos
factor = 0

# Function that shows the next five repos in the scraped list, loops
# back around if it has already shown all of the repos
def show_five(factor, trending_repos)
	if factor > 4
		factor = factor % 5
	end
	start = factor * 5

	while start < (factor + 1) * 5 do
		# Output repo information
		puts "#{start+1}:  Repo Name: #{trending_repos[start][:name]}"
		puts "    Description: #{trending_repos[start][:description]}"
		puts "    Language: #{trending_repos[start][:language]}"
		puts "    Link: #{trending_repos[start][:link]}"
		puts "\n"
		start += 1
	end

end

# Get the trending repos
trending_repos = scrape
# Start interactions
puts "GitScraper$ Hello! I have found #{trending_repos.count} trending GitHub Repositories."
puts "GitScraper$ Here are the top 5:"
show_five(factor, trending_repos)
# Have to increment after every use of show_five to keep track of where we are
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
	when "all"
		factor = 0
		while factor < 5 do
			show_five(factor, trending_repos)
			factor += 1
		end
	when "more"
		show_five(factor, trending_repos)
		factor += 1
	when /(visit\s\d+)/
		# Get integer from regular expression
		index = command[/\d+/].to_i - 1
		if index > 24
			puts "Visit requires a valid number (1-25) as an argument"
		else
			# Open repo in default browser
			Launchy.open(trending_repos[index][:link])
		end
	else
		puts "I do not recognize that command. "
	end
end
