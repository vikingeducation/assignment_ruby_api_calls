require 'httparty'
require 'awesome_print'
require 'json'
require 'pry'
require 'envyable'
require 'stamp'

Envyable.load('env.yml')

class WeatherForecast
  BASE_URI = 'http://api.openweathermap.org/data/2.5/forecast/daily?q='
  API_KEY = ENV['OPEN_WEATHER_API_KEY']

  def initialize(location = 'New Orleans', days = 5)
    @days = days
    @location = location
    @forecast = send_request(location, days)
  end

  def hi_temps
    puts "High Temperatures for the next #{@days} days in #{@location} (Fahrenheit):"
    @forecast.each do |day|
      date = Time.at(day['dt']).stamp("Mon, Dec 3")
      high_temp = day['temp']['max']
      puts " - #{date}: #{high_temp}"
    end
  end

  def lo_temps
    puts "Low Temperatures for the next #{@days} days in #{@location} (Fahrenheit):"
    @forecast.each do |day|
      date = Time.at(day['dt']).stamp("Mon, Dec 3")
      low_temp = day['temp']['min']
      puts " - #{date}: #{low_temp}"
    end
  end

  def humidities
    puts "Humidity for the next #{@days} days in #{@location}:"
    @forecast.each do |day|
      date = Time.at(day['dt']).stamp("Mon, Dec 3")
      humidity = day['humidity']
      puts " - #{date}: #{humidity}%"
    end
  end

  def today
    puts "-" * (34 + @location.length)
    puts "Today in #{@location} (degrees in Fahrenheit):"
    puts "-" * (34 + @location.length)
    day = @forecast.first

    render_day(day)
  end

  def tomorrow
    puts "-" * (34 + @location.length)
    puts "Tomorrow in #{@location} (degrees in Fahrenheit):"
    puts "-" * (34 + @location.length)
    day = @forecast[1]

    render_day(day)
  end

  def pretty_forecast
    puts "-" * (37 + @location.length)
    puts "Forecast in #{@location} (degrees in Fahrenheit):"
    puts "-" * (37 + @location.length)

    @forecast.each do |day|
      render_day(day)
      puts "-" * (37 + @location.length)
    end
  end

  def wind
    puts "Wind speed & direction for the next #{@days} days in #{@location}:"
    @forecast.each do |day|
      date = Time.at(day['dt']).stamp("Mon, Dec 3")
      wind = day['speed']
      direction = get_cardinal_direction(day['deg'])
      puts " - #{date}: #{wind} mph #{direction}"
    end
  end

  private

  def render_day(day)
    date = Time.at(day['dt']).stamp("Mon, Dec 3")
    high_temp = day['temp']['max']
    low_temp = day['temp']['min']
    humidity = day['humidity']
    conditions = day['weather'].first['description']

    puts "              Date: #{date}"
    puts " Low to High Temps: #{low_temp} to #{high_temp}"
    puts "          Humidity: #{humidity}%"
    puts "        Conditions: #{conditions}"
  end

  def send_request(location, days)
    uri_loc = location.gsub(' ', '%20')

    uri = "#{BASE_URI}#{uri_loc},USA&cnt=#{days}&units=imperial&APPID=#{API_KEY}"

    response = HTTParty.get(uri)

    response["list"]
  end

  def get_cardinal_direction(degrees)
    case degrees
    when 0...11
      'N'
    when 11...34
      'NNE'
    when 34...56
      'NE'
    when 56...79
      'ENE'
    when 79...101
      'E'
    when 101...124
      'ESE'
    when 124...146
      'SE'
    when 146...169
      'SSE'
    when 169...191
      'S'
    when 191...214
      'SSW'
    when 214...236
      'SW'
    when 236...259
      'WSW'
    when 259...281
      'W'
    when 281...304
      'WNW'
    when 304...326
      'NW'
    when 326...349
      'NNW'
    else
      'N'
    end
  end

end

forecast = WeatherForecast.new
# forecast.hi_temps
# forecast.lo_temps
# forecast.today
# forecast.tomorrow
# forecast.humidities
# forecast.pretty_forecast
forecast.wind