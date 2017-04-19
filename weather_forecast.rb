require 'typhoeus'
require 'pp'
require 'httparty'
require 'envyable'

class WeatherForecast
  include HTTParty
  Envyable.load('config/env.yml')
  API_KEY = ENV["API_KEY"]
  BASE_URI = "http://api.openweathermap.org/data/2.5/forecast/daily?units=imperial"
  VALID_FORMATS = [:json]
  VALID_PERIODS = (1..16).to_a

  def initialize(location=4350359, days=1, mode=JSON )
    validate_format!(mode)
    validate_time_period!(days)
    @days = days
    @mode = mode
    @options = {:query => {:id => location, :appid => API_KEY, :cnt => days}}
    @response = HTTParty.get(BASE_URI, @options)
  end

  # def hi_temps
  #   puts @response
  # end
  #
  # def low
  #
  # end
  #
  # def today
  #
  # end
  #
  # def tomorrow
  #
  # end
  #
  # def weather
  #
  # end
  #
  def humidity(days=@days)
     response = @response  #send_request("humidity", days)
    trim_response(response)
  end
  #
  # def pressure
  #
  # end

  private

   def send_request(category, days)
     return unless category && days
     uri = [ BASE_URI, "cnt=#{days}", cat=category].join("&")
     params = { "api-key" => API_KEY }
     request = Typhoeus::Request.new( uri, :method => :get, :params => params )
     request.run
   end

   def validate_time_period!(days)
     unless VALID_PERIODS.include?(days)
       raise "Invalid time period"
     end
   end

   def validate_format!(mode)
     unless VALID_FORMATS.include?(mode.to_s.downcase.to_sym)
       raise "Invalid response format"
     end
   end

   def trim_response(response)
     response_body = JSON.parse(response.body)
     results = response_body["list"] #[ 0..(@days - 1)
    results.each {|key, value| puts "#{key} is #{value}"}
        #  "high"           =>  date[list.temp.max],
        #  "low"          =>  date[list.temp.min],
        #  "pressure"       =>  date[list.pressure],
        #  "humidity" =>  date[list.humidity],
        #  "weather"      =>  date[list.weather.main],

   end
end

wf = WeatherForecast.new
wf.humidity
