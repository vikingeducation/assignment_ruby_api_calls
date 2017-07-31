# weatherforecast
require_relative 'environment'
require 'HTTParty'
require 'date'
require 'pry'
require 'pry-byebug'
require_relative 'sample_response'

class WeatherForecast
  API_KEY = WEATHER_KEY
  attr_reader :location, :num_days, :response_hash, :raw_response

# comment
  def initialize(location = 'france', num_days = 5)
    @location = location
    @num_days = num_days
    # @raw_response
    send_request
  end
  # high temperatures organized by date
  def hi_temps
    puts "The highs:"
    print_temps(@response_hash, "temp_max", "High of ")
  end

  # low temperatures organized by date
  def lo_temps
    puts "The lows:"
    print_temps(@response_hash, "temp_min", "Low of ")
  end

  # today's forecast
  def today
    puts "Today's forecast:"
    print_forecast(@response_hash, Date.today)
  end
 # tomorrow's forecast
  def tomorrow
    puts "Tomorrow's forecast:"
    tomorrow = Date.today + 1
    print_forecast(@response_hash, tomorrow)
  end

  # three more responses
  def rain_forecast
    if is_raining?(Date.today)
      puts "It's gonna rain"
    else
      puts "Leave the umbrella at home."
    end
  end

  # basic
  def basic_five_day
    # gives a basic description of the weather
    puts "Here's your basic five-day forecast:"
      day_1 = Date.today
      5.times do
        print_description(day_1)
        day_1 += 1
        puts
      end
    end

  # five_day
  def five_day
  # creates a 5 day forecast
  puts "Here's your detailed five-day forecast:"
    day_1 = Date.today
    5.times do
      print_forecast(@response_hash, day_1)
      day_1 += 1
      puts
    end
  end

  private
  def send_request
    @raw_response = HTTParty.get('http://api.openweathermap.org/data/2.5/forecast?id=524901&APPID=' + API_KEY)
    parse_response
  end

  def parse_response
    @response_hash = JSON.parse(@raw_response.body)
  end

  # print_temps
  def print_temps(hash, temp_type, msg)
    city = hash["city"]["name"]
    daily_forecasts = hash["list"]
    puts "Weather for #{city}:"
    daily_forecasts.each do |day|
      puts pretty_date(convert_date(day["dt_txt"]))
      temperature = get_temp(day, temp_type)
      puts msg + temperature.to_s
    end
  end

  def print_description(date)
    forecast_hash = get_forecast(@response_hash, date)
    precip_hash = forecast_hash["weather"][0]
    puts pretty_date(date)
    puts precip_hash["description"].capitalize
  end

  # print_forecast
  def print_forecast(hash, date)
    # prints a forecast for a particular date

    # forecast_hash is all of the data associated with a given date
    forecast_hash = get_forecast(hash, date)
    max = get_temp(forecast_hash, "temp_max")
    min = get_temp(forecast_hash, "temp_min")

    precip_hash = forecast_hash["weather"][0]
    description = precip_hash["description"].capitalize

    # These values fall under the "main" key
    main_hash = forecast_hash["main"]
    pressure = main_hash["pressure"]
    humidity = main_hash["humidity"]

    # Rain has it's own nexted hash
    rain_hash = forecast_hash["rain"]
    if rain_hash.empty?
      rain = 0
    else
      rain = rain_hash["3h"]
    end
    puts "Forecast for #{pretty_date(date)}:\n#{description}\nPressure: #{pressure}\nHumidity: #{humidity}%\nHigh of #{max}, low of #{min}\nChance of rain: #{(rain * 100).round(2)}%"
  end

  def is_raining?(date)
    forecast_hash = get_forecast(@response_hash, date)
    if forecast_hash["rain"].empty?
      true
    else
      false
    end
  end

  # get_forecast
  def get_forecast(hash, date)
    # checks value of a date against dates in the hash
    # returns the hash of that date if a match
    hash["list"].each do |day|
      day_in_hash = day["dt_txt"]
      converted_date = convert_date(day_in_hash)
      if date == converted_date
        return day
        break
      end
    end
  end

  # get_temp
  def get_temp(day, temp_type)
    # gets the temperatures of a day, requires a temp_type (hi/lo)
    temps = day["main"]
    req_temp = temps[temp_type]
    convert_temp(req_temp)
  end

  # converts temperature to celcius
  def convert_temp(temp)
    output = (temp + -273.15).to_i
    return output.to_s
  end

  # converts unix date
  def convert_date(date_as_string)
    Date.parse(date_as_string)
  end

  # pretty_date
  def pretty_date(date)
    date.strftime('%a %b %d %Y')
  end

end
