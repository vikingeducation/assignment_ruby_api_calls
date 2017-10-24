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
In your main project folder, create a file called `.env`
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
Open up the `weather_forecast_main.rb` file
Modify the `WeatherForecast.new(...` line to include the zip code and number of days you want to see
Save, then run `ruby weather_forecast_api.rb`
Comment out the line `forecast.send_request`
Tinker around with running any of the convenience methods listed in that file

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

TBD

### GitHub API Info

TBD