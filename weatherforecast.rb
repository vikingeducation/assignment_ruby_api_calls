require "httparty"
require "pp"

class WeatherForecast 
  def initialize(days = 5, location = "Philadelphia")
    @days = days
    @location = location
    @my_token = ENV["FORECAST_KEY"]
  end

  def get_url
    url = "http://api.openweathermap.org/data/2.5/forecast?q={#{@location}}&mode=json&appid=#{@my_token}"
    result = HTTParty.get(url)
    File.open('weather.json', 'w') do |f|
      json = JSON.pretty_generate(result)
      f.write(json)
    end
  end
end

WeatherForecast.new.get_url