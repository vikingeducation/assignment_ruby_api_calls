require 'httparty'
require 'json'
require 'pp'

class WeatherForecast

  BASE_CURRENT_URI = "http://api.apixu.com/v1/current.json?"
  BASE_FORECAST_URI = "http://api.apixu.com/v1/forecast.json?"
  API_KEY = ENV["API_KEY"]

  attr_accessor :location, :days

  def initialize(location = "Paris", days = 2)
    @location = location
    @days = days
  end

  def forecast_for
    request = HTTParty.get("#{BASE_FORECAST_URI}key=#{API_KEY}&q=#{@location}&days=#{@days}")
  end

  def current_for
    request = HTTParty.get("#{BASE_CURRENT_URI}key=#{API_KEY}&q=#{@location}")
  end

  def hi_temps
    request = forecast_for
    counter = 0
    while counter < @days
      p date = request["forecast"]["forecastday"][counter]["date"]
      p max_temp = request["forecast"]["forecastday"][counter]["day"]["maxtemp_f"]
      counter += 1
    end
  end

  def lo_temps
    request = forecast_for
    counter = 0
    while counter < @days
      p date = request["forecast"]["forecastday"][counter]["date"]
      p max_temp = request["forecast"]["forecastday"][counter]["day"]["mintemp_f"]
      counter += 1
    end
  end

  def will_it_rain
    request = forecast_for
    counter = 0
    while counter < 24
      answer = request["forecast"]["forecastday"][0]["hour"][counter]["will_it_rain"]
      answer == 0 ? answer = "No" : answer = "Yes"
      puts "#{counter}:00: " << answer
      counter += 1
    end
  end

  def astro
    request = forecast_for
    spot = request["forecast"]["forecastday"][0]["astro"]
    puts "Sunrise: #{spot["sunrise"]}"
    puts "Sunset: #{spot["sunset"]}"
    puts "Moonrise: #{spot["moonrise"]}"
    puts "Moonset: #{spot["moonset"]}"
  end

  def precipitation
    request = forecast_for
    counter = 0
    while counter < 24
      answer = request["forecast"]["forecastday"][0]["hour"][counter]["precip_in"]
      puts "#{counter}:00: " << answer.to_s
      counter += 1
    end
  end

  def today
    request = current_for
    spot = request["location"]
    puts "Location: #{spot["name"]}"
    puts "Last Updated: #{spot["last_updated"]}"
    puts "Temperature: #{spot["temp_f"]}"
    puts "Wind: #{spot["wind_mph"]}"
    puts "Humidity: #{spot["humidity"]}"
  end

  def tomorrow(day = 1)
    request = forecast_for
    spot = request["forecast"]["forecastday"][day]
    puts "Date: " + spot["date"].to_s
    puts "High: " + spot["day"]["maxtemp_f"].to_s
    puts "Low: " + spot["day"]["mintemp_f"].to_s
    puts "Condition: " + spot["day"]["condition"]["text"]
    puts "Wind: " + spot["day"]["maxwind_mph"].to_s
    puts "Rain: " + spot["day"]["totalprecip_in"].to_s

  end

end

w = WeatherForecast.new()

# pp w.forecast_for
# w.lo_temps
# pp w.current_for
# w.today
# w.tomorrow
# w.astro
w.will_it_rain