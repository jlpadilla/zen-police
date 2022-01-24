# zen-police
Zen Police is a script to automate status checks for Github issues and Zenhub board.
The goal is to detect issues with missing labels, incorrect milestones, or in the wrong pipeline and automatically correct the issues.

## Why Ruby?
This project uses Ruby just because I wanted to try something different. 
If we find this script useful, I can add a JS implementation for easy maintenance.

## Prerequisites
1. Verify Ruby is installed. (It was installed on my mac.)
  ```
  $ ruby -v     
  ruby 2.6.3p62 (2019-04-16 revision 67580) [universal.x86_64-darwin19]
  ```
2. Install the ocktokit library.
  ```
  gem install octokit
  ```
3. Create a github access token and add to env.
  ```
  export GITHUB_TOKEN=your-access-token
  ```

## Run the script
```
ruby zen-police.rb
```