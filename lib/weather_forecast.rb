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

  2.
  - initialize should let you input a location
  - and a number of days. (There should be defaults). (DONE)

  ######!! I'm gonna go the 16 day option!

  3.
  - Poke around the response object you get back,
  - and see what you might want to make easier to access.

  * data seems to be stored within a mixture of arrays and hashes.

  All the details on how to acceses this can be found on - http://openweathermap.org/forecast16#JSON

  "list" - First you want to get everything from the list group.

  "dt" - seems to indicate the day, not too sure how the data actually represents the day though.

  t = Time.at(WeatherForecast.new.send_request["list"][0]["dt"])

  pp t.day
  pp t.month
  pp t.year

  "min" - minimum for the day

  "max" - maximum for the day

  4.
  - hi_temps should be a collection of the high temperatures you get back, organized by date

  5.
  - lo_temps should be a collection of the low temperatures you get back, organized by date

  6.
  - today and tomorrow should be convenient breakdowns of just those single day forecasts

  7.
  - Create 3 more convenience methods that access various pieces of the raw_response object and present them to you in an easily accessible way

  8. Output these to your CLI.

=end

# Run from CLI with `$ API_KEY=your_key_here ruby weather_forecast.rb`

require 'httparty'
require 'json'

# For better debugging
require 'pp'

class WeatherForecast

  BASE_URI = "http://api.openweathermap.org/data/2.5/forecast/daily?q="

  API_KEY = ENV["API_KEY"]
  VALID_DAYS = (1..16).to_a

  # Only going to use JSON for this.

  def initialize(city='Brisbane', country='AU', days="7")
    # Considering there's so many options out there, I don't think it's worth me doing a valid city or country check for now.
    raise "Date range has to be from '1' to '16'" unless VALID_DAYS.include? days.to_i
    @city = city
    @country = country
    @days = days
    @response = send_request
  end

  # Construct and initiate the new request
  def send_request

    # Build our URL
    uri = "#{BASE_URI}#{@city},#{@country}&cnt=#{@days}&units=metric&APPID=#{API_KEY}&mode=json"


    # Build the request
    request = HTTParty.get(uri)

  end

end

# t = Time.at(WeatherForecast.new.send_request["list"][0]["dt"])

# pp t.day
# pp t.month
# pp t.year