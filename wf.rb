require 'httparty'
require 'json'

require 'pry-byebug'
require 'pp'



class WeatherForecast

  # BASE_URI = "http://api.openweathermap.org/data/2.5/"

  API_KEY = ENV["API_KEY"]

  #number of days = 0 : current weather = weather?
  #number of days = 1-5 : 5 day forecast = forecast?
  #number of days 5- 16 : 16 day forecast = forecast/daily?
  #number of days beyond 16 raises error

  include HTTParty

  base_uri('http://api.openweather.org/data/2.5/')

  def initialize(city_name, num_of_days)
    @options = { :query => { :q => city_name, :mode => "json", :cnt => num_of_days, :APPID => API_KEY }}

    # params = { "api-key" => API_KEY }
  end


  def current
    self.class.get("weather?", @options)
  end

  def forecast
    self.class.get("forecast/daily?", @options)
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


  def send_request
    # @options = { :query => { :zip => zipcode, :cnt=> num} }
    
    # uri = [BASE_URI, @forecast_type, zipcode_uri, "&cnt=#{@num_of_days}"].join
    base_uri ''
    # puts uri.inspect

    params = { "api-key" => API_KEY }

    response = HTTParty.get(uri, params)
    # pp request.body

  end

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