# Basecamp Status

shows a single page with projects/todo lists/todo items (with due date and responsible)

if your deploying to heroku do this first

heroku config:add BASECAMP_TOKEN=YOURAPITOKENHERE BASECAMP_URL=YOURCOMPANY.BASECAMPHQ.COM

if your in dev, change these 2 variables in the Board model to your actually url and api token

/model/board/board.rb

APITOKEN = ENV['BASECAMP_TOKEN']
URL = ENV['BASECAMP_URL']

