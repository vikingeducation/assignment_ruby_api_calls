require "httparty"
require "pry"
require "pp"

class WeatherForecast

  attr_accessor :weather_info

  include HTTParty

  base_uri('api.openweathermap.org')

  def initialize(location = "New_York,US", num_days = "3")

    @options = { :query => { :q => location, :cnt => num_days, :mode => "JSON", :units => "imperial",  } }
    #APPID => ENV[API_KEY]

  end

  def current

    self.class.get('/data/2.5/weather?', @options)
    binding.pry

  end

  def forecast

    @fore = self.class.get('/data/2.5/forecast?', @options)
    binding.pry

  end

  def parse(response)

    @weather_info = JSON.parse(response.body)
  end

  def hi_temps #this creates array of high temp 
    #@weather_info["list"][0]["main"]["temp_max"] gives day 1 high temp
    hi_temps = []

    @weather_info["list"].each do |day|
      hi_temps << [day["main"]["temp_max"],day["dt_txt"]]
    end

  end

  def hi_temps #this creates array of lo temp 
    #@weather_info["list"][0]["main"]["temp_max"] gives day 1 high temp
    lo_temps = []

    @weather_info["list"].each do |day|
      lo_temps << [day["main"]["temp_min"],day["dt_txt"]]
    end

  end



end

w = WeatherForecast.new
#current = w.current
forecast = w.forecast