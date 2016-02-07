=begin

  Part 1: OpenWeatherMap

  1. What is OpenWeatherMap?
    It's a respectable public API
  2. What does it return and in what format?
    It returns basic weather data and it accommodates GET requests for JSON, XML and HTML.
  3. What's my job in this part of the assignment?
    My job is to make a simple wrapper for the OpenWeatherMap API which outputs the forecast data to the command line.

------------------------------------------------

  Building an API Wrapper

  1.
  - Create a class WeatherForecast in Ruby (DONE)
  - that uses the HTTParty gem to access OpenWeatherMap for the weather forecast. (DONE)
  - Remember to use ENV vars to store your API key! (DONE)
  - If you accidentally commit your key, you'll need to issue a new one. (DONE)
=end

# Run from CLI with `$ API_KEY=your_key_here ruby weather_forecast.rb`

class WeatherForecast

  API_KEY = ENV["API_KEY"]

end