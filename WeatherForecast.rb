require "httparty"
require "pry"
require "pp"

class WeatherForecast

  attr_accessor :weather_info

  include HTTParty

  base_uri('api.openweathermap.org')

  def initialize(location = "New_York,US", num_days = "3")

    @options = { :query => { :q => location, :cnt => num_days, :mode => "JSON", :units => "imperial", APPID => ENV[API_KEY] } }

  end

  def current

    self.class.get('/data/2.5/weather?', @options)
    binding.pry

  end

  def forecast

    self.class.get('/data/2.5/forecast?', @options)

  end

  def parse(response)

    @weather_info = response.to_hash

  end

  def hi_temps



  end



end

w = WeatherForecast.new
#current = w.current
forecast = w.forecast