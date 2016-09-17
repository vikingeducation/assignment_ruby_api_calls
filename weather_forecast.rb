require 'httparty'

class WeatherForecast
  include HTTParty

  def initialize(location="New York", key)
    @location = location
    @uri = HTTParty.get("http://api.apixu.com/v1/forecast.json?key=#{key}&q=#{location}")
  end

  def info
    puts "City: #{@uri["location"]["name"]}"
    today
    hi_temps
    lo_temps
  end

  def hi_temps
    puts "The highest temperature for today is #{@uri["forecast"]["forecastday"][0]["day"]["maxtemp_f"]} F"
  end

  def lo_temps
    puts "The lowest is #{@uri["forecast"]["forecastday"][0]["day"]["mintemp_f"]} F"
  end

  def today
    puts "Currently it's #{@uri["current"]["temp_f"]} F"
  end
end


forecast = WeatherForecast.new("San Francisco")

puts forecast.info
