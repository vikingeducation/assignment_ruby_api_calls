require 'httparty'
require 'json'
require 'pry-byebug'
require 'pp'

class WeatherForecast

  API_KEY = ENV["API_KEY"]

  #number of days = 0 : current weather = weather?
  #number of days = 1-5 : 5 day forecast = forecast?
  #number of days 5- 16 : 16 day forecast = forecast/daily?
  #number of days beyond 16 raises error

  include HTTParty

  base_uri('api.openweathermap.org')

  def initialize(city_name, num_of_days)
    @options = { :query => { :q => city_name, :mode => "JSON", :cnt => num_of_days, :units => "imperial", "api-key" => API_KEY  }}

    # params = { "api-key" => API_KEY }
  end

  def current
    self.class.get("/data/2.5/weather?", @options)
  end

  def forecast
    self.class.get("/data/2.5/forecast/daily?", @options)
  end

  def hi_temps
    response = forecast
    response_body = JSON.parse(response.body)
    response_body["list"].map {|l| l["temp"]["max"]}
  end

  def low_temps
    response = forecast
    response_body = JSON.parse(response.body)
    response_body["list"].map {|l| l["temp"]["min"]}
  end

  def weather
    response = forecast
    response_body = JSON.parse(response.body)
    response_body["list"].map {|l| l["weather"][0]["main"]}
  end

  def description
    response = forecast
    response_body = JSON.parse(response.body)
    response_body["list"].map {|l| l["weather"][0]["description"]}
  end

  def wind
    response = forecast
    response_body = JSON.parse(response.body)
    response_body["list"].map {|l| l["speed"]}
  end

  def today
    response = current
    response_body = JSON.parse(response.body)
    hi_temps = response_body["main"]["temp_max"]
    low_temps = response_body["main"]["temp_min"]
    weather = response_body["weather"][0]["main"]
    des = response_body["weather"][0]["description"]
    wind = response_body["wind"]
    puts "Today, #{weather}, #{des}."
    puts "Tempurature from #{hi_temps} to #{low_temps}."
    puts "Wind #{wind}."
  end

  def tomorrow
    response = forecast
    response_body = JSON.parse(response.body)
    l =response_body["list"][0]
    hi_temps = l["temp"]["max"]
    low_temps = l["temp"]["min"]
    weather = l["weather"][0]["main"]
    des = l["weather"][0]["description"]
    wind = l["speed"]

    puts "Tomorrow, #{weather}, #{des}."
    puts "Tempurature from #{hi_temps} to #{low_temps}."
    puts "Wind #{wind}."
  end

  # def send_request

  # end

  # def initialize(zipcode = 93546, num_of_days = 10)
  #   validate_zip!(zipcode)
  #   validate_numofdays!(num_of_days)

  #   @zipcode = zipcode
  #   @num_of_days = num_of_days
  #   @forecast_type = convert_days_to_forecast_type
  # end

  # def hi_temps
  #   response = send_request
  #   response_body = JSON.parse(response.body)
  #   @hi_temps = []
  #   case @forecast_type
  #   when "weather?"
  #     current(response_body)
  #   when "forecast?"
  #     next_5days(response_body)
  #   when "forecast/daily?"
  #     next_16days(response_body)
  #   end
  #   @hi_temps
  # end


  # def convert_days_to_forecast_type
  #   if @num_of_days == 0
  #     return "weather?"
  #   elsif (1..5).include?(@num_of_days)
  #     return "forecast?"
  #   elsif (6..16).include?(@num_of_days)
  #     return "forecast/daily?"
  #   end
  # end

  # def zipcode_uri
  #   "zip=#{@zipcode},us"
  # end


  # def send_request
  #   # @options = { :query => { :zip => zipcode, :cnt=> num} }
    
  #   # uri = [BASE_URI, @forecast_type, zipcode_uri, "&cnt=#{@num_of_days}"].join
  #   base_uri ''
  #   # puts uri.inspect

  #   params = { "api-key" => API_KEY }

  #   response = HTTParty.get(uri, params)
  #   # pp request.body

  # end

  # def validate_zip!(zipcode)
  #   raise "Invalid zip code." unless (10000..99999).include?(zipcode)
  #   zipcode
  # end

  # def validate_numofdays!(num_of_days)
  #   raise "The forecast is up to 16 days later" unless (0..16).include?(num_of_days)
  #   num_of_days
  # end

  # def current(response_body)
  #   @hi_temps << response_body["main"]["temp_max"]
  #   # @low_temps << response_body["main"]["temp_min"]
  #   # @weather << response_body["weather"][0]["main"]
  #   # @des << response_body["weather"][0]["description"]
  #   # @wind << response_body["wind"]
  # end

  # def next_5days(response_body)
  #   response_body["list"].each do |l|
  #     @hi_temps << l["main"]["temp_max"]
  #     # @low_temps << l["main"]["temp_min"]
  #     # @weather << l["weather"][0]["main"]
  #     # @des << l["weather"][0]["description"]
  #     # @wind << l["wind"]
  #   end
  # end

  # def next_16days(response_body)
  #   response_body["list"].each do |l|
  #     @hi_temps << l["temp"]["max"]
  #     # @low_temps << l["temp"]["min"]
  #     # @weather << l["weather"][0]["main"]
  #     # @des << l["weather"][0]["description"]
  #     # @wind << l["speed"]
  #   end
  # end

end