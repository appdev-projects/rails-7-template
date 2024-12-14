require "dotenv/load"

pp ENV.fetch("GITHUB_ID")
pp ENV.fetch("GITHUB_SECRET")
