require 'httparty'
require 'json'
require 'pry-byebug'
require 'pp'

class WeatherForecast
  include HTTParty

  base_uri 'api.openweathermap.org'
  API_KEY = ENV['weather_api_key']

  def initialize( location = 1819729, nb_days = 3, units = "metric")
    valid_nb_days( nb_days )
    @response = nil
    @days = nb_days
    @options = { query: {id: location, cnt: nb_days, units: units, appid: API_KEY} }
  end

  def loop_user
    loop do
      puts "
            1- high temperatures
            2- low temperatures
            3- weather of today
            4- weather of tomorrow
            q- quit"
      choice = gets.chomp until ["1","2","3","4",'q','Q'].include?( choice )
      case choice
      when "q" || "Q"
        exit
      when "1"
        puts hi_temps
      when "2"
        puts lo_temps
      when "3"
        puts today
      when "4"
        puts tomorrow
      else
        next
      end
    end
  end

  def hi_temps
    forecast if @response.nil?
    trim_response_temp( "max" )
  end

  def lo_temps
    @response = forecast if @response.nil?
    trim_response_temp( "min" )
  end

  def today
    @response = forecast if @response.nil?
    trim_response_day( 0 )
  end

  def tomorrow
    @response = forecast if @response.nil?
    trim_response_day( 1 )
  end

  def trim_response_temp( option )
    results = {}
    @days.times do |day|
      results["day #{day}"] = @response["list"][day]["temp"][option]
    end
    results
  end

  def trim_response_day( day )
    weather = @response["list"][day]
    results = {}
    results["temp"] = weather["temp"]["day"]
    results["weather"] = weather["weather"][0]["main"]
    results["weather desc"] = weather["weather"][0]["description"]
    results["clouds"] = weather["clouds"]
    results["rain"] = weather["rain"]
    results["humidity"] = weather["humidity"]
    results
  end

  def forecast
    @response = self.class.get("/data/2.5/forecast/daily", @options)
  end

  def valid_nb_days( nb_days )
    raise "Invalid number of days" unless (1..16).include?( nb_days )
  end
end

forecast = WeatherForecast.new
forecast.loop_user