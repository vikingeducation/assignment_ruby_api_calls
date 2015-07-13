require "httparty"
require "pry"
require "pp"

class WeatherForecast

  attr_accessor :weather_info

  include HTTParty

  base_uri('api.openweathermap.org')

  def initialize(location = "New_York,US", num_days = "3")

    @options = { :query => { :q => location, :cnt => num_days, :mode => "JSON", :units => "imperial" } }
    #APPID => ENV[API_KEY]

  end

  def current_weather

    self.class.get('/data/2.5/weather?', @options)

  end

  def hour_forecast

    self.class.get('/data/2.5/forecast?', @options)

  end

  def daily_forecast

    self.class.get('/data/2.5/forecast/daily?', @options)

  end

  def parse(response)

    @weather_info = JSON.parse(response.body)

  end

  def hi_temps #this creates array of high temp 
    #@weather_info["list"][0]["main"]["temp_max"] gives day 1 high temp
    response = daily_forecast
    parse(response)
    hi_temps = []

    @weather_info["list"].each do |day|
      hi_temps << [day["main"]["temp_max"],day["dt_txt"]]
    end

    p hi_temps

  end

  def lo_temps #this creates array of lo temp 
    #@weather_info["list"][0]["main"]["temp_min"] gives day 1 lo temp
    response = daily_forecast
    parse(response)
    lo_temps = []

    @weather_info["list"].each do |day|
      lo_temps << [day["main"]["temp_min"],day["dt_txt"]]
    end

    pp lo_temps

  end

  def today

    response = current_weather
    parse(response)

    #binding.pry

    puts "The forecast for #{Time.today} is: "

    pp @weather_info["main"]

  end

  def tomorrow

    response = daily_forecast
    parse(response)

    #binding.pry

    date = @weather_info["list"][1]["dt"]

    puts "The forecast for #{Time.at(date)} is:"

    pp @weather_info["list"][1]["temp"]

  end

  def daily_cloud

    response = daily_forecast
    parse(response)

    # binding.pry

    @weather_info["list"].each do |day|

      print "Cloud coverage for #{Time.at(day["dt"])} is "

      puts day["clouds"]

    end

  end

  def chance_of_rain

    response = daily_forecast
    parse(response)

    @weather_info["list"].each do |day|

      print "Rain forecast for #{Time.at(day["dt"])} is: "

      puts day["weather"][0]["description"]

    end

  end

  def daily_temps

    response = daily_forecast
    parse(response)

    @weather_info["list"].each do |day|

      print "Temperatures for #{Time.at(day["dt"])} are: "

      puts day["temp"]

    end

  end



end

w = WeatherForecast.new
# w.daily_cloud
# w.chance_of_rain
w.daily_temps