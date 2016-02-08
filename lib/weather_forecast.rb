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

  1. (DONE)
  - Create a class WeatherForecast in Ruby (DONE)
  - that uses the HTTParty gem to access OpenWeatherMap for the weather forecast. (DONE)
  - Remember to use ENV vars to store your API key! (DONE)
  - If you accidentally commit your key, you'll need to issue a new one. (DONE)

  2. (DONE)
  - initialize should let you input a location
  - and a number of days. (There should be defaults). (DONE)

  ######!! I'm gonna go the 16 day option!

  3. (DONE)
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

  4. (DONE)
  - hi_temps should be a collection of the high temperatures you get back, organized by date

  5. (DONE)
  - lo_temps should be a collection of the low temperatures you get back, organized by date

  6. (DONE)
  - today and tomorrow should be convenient breakdowns of just those single day forecasts

  7. (DONE)
  - Create 3 more convenience methods that access various pieces of the raw_response object and present them to you in an easily accessible way

  8. (DONE)
  - Output these to your CLI.

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

    # We only want the stuff in the "list section"
    request["list"]
  end

  # I'm thinking it should return an array full of arrays e.g. [[timedate, hitemp],[timedate, hitemp]]
  def hi_temps
    high_temps =[]
    @response.each_with_index do |day, index|
      high_temps << []
      high_temps[index][0] = get_date(day["dt"])
      high_temps[index][1] = day["temp"]["max"]
    end
    high_temps
  end

  # Returning same format at #hi_temps
  def lo_temps
    low_temps =[]
    @response.each_with_index do |day, index|
      low_temps << []
      low_temps[index][0] = get_date(day["dt"])
      low_temps[index][1] = day["temp"]["min"]
    end
    low_temps
  end

  # today and tomorrow should be convenient breakdowns of just those single day forecasts
  # on a break down of a day I think I'd like to see
  # date
  # minimum
  # maximum
  # humidity
  # description
  def today
    puts ""
    puts "Today: #{get_date(@response[0]["dt"])}"
    output_day_details(0)
  end

  def tomorrow
    puts ""
    puts "Tomorrow: #{get_date(@response[1]["dt"])}"
    output_day_details(1)
  end

  def output_day_details(index)
    puts "Min: #{@response[index]["temp"]["min"]}"
    puts "Max: #{@response[index]["temp"]["max"]}"
    puts "Humidity: #{@response[index]["humidity"]}"
    puts "Description: #{@response[index]["weather"][0]["description"]}"
    puts ""
  end

  # Create 3 more convenience methods that access various pieces of the raw_response object and present them to you in an easily accessible way

  def this_week
    index = 0
    loop do

      if index == 0
        today
      elsif index == 1
        tomorrow
      else
        puts ""
        puts "Date: #{get_date(@response[index]["dt"])}"
        output_day_details(index)
      end

      break if index == 6

      index += 1
    end
  end

  # For those kite enthusiasts
  def wind_speed_this_week
    index = 0
    loop do
      puts ""
      puts "Date: #{get_date(@response[index]["dt"])}"
      puts "Wind Speed: #{@response[index]["speed"]} meters/sec"
      puts ""

    break if index == 6

    index += 1
    end
  end

  # Least cloudy day coming up
  def return_clearest_day
    clouds = 100
    clearest_day = nil
    @response.each do |day|
      clearest_day = day if day["clouds"] < clouds
      clouds = day["clouds"] if day["clouds"] < clouds
    end
    puts ""
    puts "Date: #{get_date(clearest_day["dt"])}"
    puts "Cloudiness: #{clouds}%"
    puts ""
  end

  private

  def get_date(seconds)
    t = Time.at(seconds)
    "#{t.day}-#{t.month}-#{t.year}"
  end

end

# WeatherForecast.new("Brisbane", "AU", "16").today
# WeatherForecast.new("Brisbane", "AU", "16").tomorrow
# WeatherForecast.new("Brisbane", "AU", "16").wind_speed_this_week
WeatherForecast.new("Brisbane", "AU", "16").return_clearest_day
