require "httparty"
require "pry"
require "pp"

class WeatherForecast

  include HTTParty

  base_uri('api.openweathermap.org')

  def initialize(location = "New_York,US", num_days = "3")

    @options = { :query => { :q => location, :cnt => num_days, :mode => "JSON", :units => "imperial" } }

  end

  def current

    current = self.class.get('/data/2.5/weather?', @options)
    binding.pry

  end

  def forecast

    forecast = self.class.get('/data/2.5/forecast?', @options)
    binding.pry

  end



end

w = WeatherForecast.new
#current = w.current
forecast = w.forecast