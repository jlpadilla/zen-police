require 'octokit'

puts ">>> ZEN Police <<<\n\n"

### Verify required env variables.
if "#{ENV["GITHUB_TOKEN"]}" == "" then
    abort("ENV GITHUB_TOKEN is required.")
end
# TODO: I'm using this repo for testing, but we can target any repo once the script is ready.
github_repo = "jlpadilla/zen-police"
puts "Target repo:\t#{github_repo}"


### Build client and print logged user.
client = Octokit::Client.new(:access_token => "#{ENV["GITHUB_TOKEN"]}")
client.user
user = client.user
puts "Current user:\t#{user.name}"
# puts user.fields


### List issues matching a label.
### NOTE: need to use the search API to find issues missing a label.
### API Doc: http://octokit.github.io/octokit.rb/Octokit/Client/Issues.html#list_issues-instance_method
### API Example: https://api.github.com/repos/jlpadilla/zen-police/issues?labels=bug
puts "\nList issues containing a label [bug]."
issues = Octokit.list_issues("#{github_repo}", :labels => 'bug')
puts "Found #{issues.length()} issues.\n\n"
issues.each { |issue| 
    puts "#{issue.number} \t#{issue.title}" # (#{issue.html_url})"
    issue.labels.each { |label|
        puts "\t > #{label.name}"
    }
}


### Search issues missing labels.
### API Doc: http://octokit.github.io/octokit.rb/Octokit/Client/Search.html#search_issues-instance_method
### API Example: https://api.github.com/search/issues?q=-label:bug+state:open+repo:jlpadilla/zen-police
puts "\nList issues missing a label. [bug]"
issues = Octokit.search_issues("repo:#{github_repo} -label:bug state:open")
puts "Found #{issues.total_count} issues.\n\n"
issues.items.each { |issue| 
    puts "#{issue.number} \t#{issue.title}" # (#{issue.html_url})"
    issue.labels.each { |label|
        puts "\t > #{label.name}"
    }
}

### Search issues with enhancement label missing milestone.
### API Doc: http://octokit.github.io/octokit.rb/Octokit/Client/Search.html#search_issues-instance_method
### API Example: https://api.github.com/search/issues?q=label:enhancement+milestone:none+state:open+repo:jlpadilla/zen-police
puts "\nList issues with enhancement label and missing milestone."
issues = Octokit.search_issues("repo:#{github_repo} label:enhancement milestone:none state:open")
puts "Found #{issues.total_count} issues.\n\n"
issues.items.each { |issue| 
    puts "#{issue.number} \t#{issue.title}" 
    issue.labels.each { |label|
        puts "\t > #{label.name}"
    }
}
