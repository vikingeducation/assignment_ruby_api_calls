require 'httparty'
require 'pry'
require 'date'

class WeatherForecast
  include HTTParty

  base_uri 'http://api.openweathermap.org/data'

  def initialize(city = "san francisco,us" , days = 7)
    @options = { :query => { :q => city, :APPID => ENV["OPEN_WEATHER_MAP_API"], :cnt => days } }
  end

  def hi_temps
    daily_forecast.map { |item| { item["dt"] => item["temp"]["max"],} }
  end

  def low_temps
    daily_forecast.map { |item| { item["dt"] => item["temp"]["min"],} }
  end

  def wind_speed
    daily_forecast.map { |item| { item["dt"] => item["speed"],} }
  end

  def wind_direction
    daily_forecast.map { |item| { item["dt"] => item["deg"],} }
  end

  def cloud
    daily_forecast.map { |item| { item["dt"] => item["clouds"],} }
  end

  def today
    today_forecast = daily_forecast.first
    {
      :date => Time.at(today_forecast["dt"]),
      :low => today_forecast["temp"]["min"],
      :hi => today_forecast["temp"]["max"],
      :pressure => today_forecast["pressure"],
      :humidity => today_forecast["humidity"],
      :desc => today_forecast["weather"][0]["description"],
    }
  end

  def tomorrow
    tomorrow_forecast = daily_forecast[1]
    {
      :date => Time.at(tomorrow_forecast["dt"]),
      :low => tomorrow_forecast["temp"]["min"],
      :hi => tomorrow_forecast["temp"]["max"],
      :pressure => tomorrow_forecast["pressure"],
      :humidity => tomorrow_forecast["humidity"],
      :desc => tomorrow_forecast["weather"][0]["description"],
    }
  end

  def daily_forecast
    response = self.class.get("/2.5/forecast/daily", @options)
    data_arr = trim_response(response)
  end

  def trim_response(response)
    parsed_response = JSON.parse(response.body)
    parsed_response["list"]
  end
end

weather = WeatherForecast.new("Los Angeles, US", 3)
p weather.hi_temps
p weather.low_temps
p weather.wind_speed
p weather.wind_direction
p weather.cloud
p weather.today
p weather.tomorrow
