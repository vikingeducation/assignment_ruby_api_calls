# ruby_api_calls
Simple Ruby API Call Assignment

by Anne Richardson

## Part 1: OpenWeatherMap API

This is a practice app that makes calls to a weather api.

### How to Use It

#### Clone the App
Fork and clone the repo

Run `bundle`

#### Set up the API key
In your main project folder, create a file called `.env`. This app uses the `dotenv` gem to manage environment variables.
```
touch .env
```

Get yourself an api key here: https://home.openweathermap.org/api_keys

Copy that key then set up an environment variable in your `.env` file.
```
# .env

OWM_API_KEY = 'your-api-key-goes-here'

```

#### Running the App

Open up the `lib/weather_forecast_main.rb` file

Modify the `WeatherForecast.new(...` line to include the zip code and number of days you want to see

Save, then run `ruby lib/weather_forecast_api.rb`

Comment out the line `forecast.send_request`

Play around with running any of the convenience methods listed in that file

#### Example Convenience Methods

`forecast.high_temps` gives you a list of high temps for the given zip code, sorted by day.

```
High Temperatures in New Orleans

Highs for 10-23-2017
64.7F
68.4F
70.8F

Highs for 10-24-2017
65.9F
68.9F
69.7F

Highs for 10-25-2017
66.2F
63.0F
64.3F
```

`forecast.low_temps` does the same thing, but for low temps

`forecast.today` gives you a snapshot of the weather for today for the given city

```
Weather for Denver 10-23-2017:
High: 57.3F
Low: 52.7F
Average Humidity: 32%
Description: clear sky
```

`forecast.tomorrow` does the same thing, but for tomorrow

### Weather API Info:

https://openweathermap.org/appid#get

Access personal api info: https://home.openweathermap.org/api_keys

Note: only hit the api once every 10 min per API key, max 60 per minute per user

## Part 2: GitHub API

### How to Use It

#### Clone the App
Fork and clone the repo

Run `bundle`

#### Set up Your Personal Token
If this doesn't exist already, in your main project folder, create a file called `.env`. This app uses the `dotenv` gem to manage environment variables.
```
touch .env
```

Get yourself a GitHub token here: https://github.com/settings/tokens

Copy that token then set up an environment variable in your `.env` file.
```
# .env

GITHUB_TOKEN = 'your-token-goes-here'
```

#### Running the App

Open up the `lib/github_main.rb` file

Modify these lines to have the info you want to see:
```
github.render_recent_repo_names(user: 'your-username', qty: 10)

github.render_recent_repo_commits(user: 'your-username', qty: 10)
```

Save, then run `ruby lib/github_main.rb`

Please note that you only get 60 calls to the API per hour, so make your requests wisely.

#### About the Convenience Methods

`render_recent_repo_names` outputs the names of the most recent n repos:

```
The 10 Most Recent Repos for lortza:
assignment_ruby_api_calls: 10-20-2017
assignment_web_scraper: 10-19-2017
assignment_web_server: 10-17-2017
assignment_rspec_ruby_tdd: 10-10-2017
assignment_rspec_viking: 10-05-2017
assignment_rspec_calculator: 09-28-2017
assignment_file_ops_sprint: 09-11-2017
assignment_oop_warmups_2: 09-08-2017
assignment_oop_warmups_1: 09-06-2017
assignment_toh: 09-04-2017
```

`render_recent_repo_commits` outputs the most recent n commits for the most recent n repos

```
Commits for assignment_ruby_api_calls
 - Finish docs for OWM api app
 - WIP github api wrapper
 - WIP readmen updates

Commits for assignment_web_scraper
 - Change csv setting to append mode
 - Fix bugs: move salary to field
 - Remove end comments

Commits for assignment_web_server
 - Add WIP servers to folder
 - Move content to outside of loop for better use of resources
 - Change output to render the content of the html
```

### GitHub API Info

Gem https://github.com/piotrmurach/github

API https://developer.github.com/v3/

Rate Limit: You are allowed to make 60 requests per hour

https://developer.github.com/v3/#rate-limiting