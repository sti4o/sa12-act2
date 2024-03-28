require 'httparty'

def fetch_most_starred_repo(username)
  url = "https://api.github.com/users/sti4o/repos"
  response = HTTParty.get(url)
  repos = response.parsed_response

  most_starred_repo = repos.max_by { |repo| repo["stargazers_count"] }

  if most_starred_repo
    {
      name: most_starred_repo["name"],
      description: most_starred_repo["description"],
      stars: most_starred_repo["stargazers_count"],
      url: most_starred_repo["html_url"]
    }
  else
    "No repositories found or error fetching repositories."
  end
end

# Replace 'username' with a real GitHub username
username = "sti4o"
most_starred = fetch_most_starred_repo(username)

if most_starred.is_a?(Hash)
  puts "Most Starred Repository:"
  puts "Name: #{most_starred[:name]}"
  puts "Description: #{most_starred[:description]}"
  puts "Stars: #{most_starred[:stars]}"
  puts "URL: #{most_starred[:url]}"
else
  puts most_starred # Outputs error message
end
