require 'httparty' 
require 'json'
require 'pp'
require 'envyable'

Envyable.load('config/env.yml')

class WeatherForecast

  include HTTParty

  BASE_URL = "http://api.openweathermap.org/data/2.5/forecast/daily"
  API_KEY = ENV["owm_key"]


  def initialize(location = "Charlotte,us" , days = 7)
    @options =  { query: {q: location, units: 'imperial', cnt: days, 
                          APPID: API_KEY, type: 'accurate'} }
    @days = days
    get_forecast
  end


  def hi_temps
    puts "Highs for the next #{@days} days in " + 
         "#{@response["city"]["name"]}, #{@response["city"]["country"]}"
    @response["list"].each do |day|
      date = format_date(day["dt"])
      puts "#{date}: #{day["temp"]["max"]}"
    end
  end


  def low_temps
    puts "Lows for the next #{@days} days in " + 
         "#{@response["city"]["name"]}, #{@response["city"]["country"]}"
    @response["list"].each do |day|
      date = format_date(day["dt"])
      puts "#{date}: #{day["temp"]["min"]}"
    end
  end


  def forecasts
    puts "Forecasts for the next #{@days} days in " + 
         "#{@response["city"]["name"]}, #{@response["city"]["country"]}"
    @response["list"].each do |day|
      date = format_date(day["dt"])
      print "#{date}: #{day["weather"][0]["description"]}, "
      print "High of #{day["temp"]["max"]}, "
      print "Low of #{day["temp"]["min"]}, "
      print "Humidity: #{day["humidity"]}%\n"
    end
  end


  def today
    puts "Today's weather in " + 
         "#{@response["city"]["name"]}, #{@response["city"]["country"]}: " +
         "#{@response["list"][0]["weather"][0]["description"]}"
    puts "High of #{@response["list"][0]["temp"]["max"]}"
    puts "Low of #{@response["list"][0]["temp"]["min"]}"
    puts "Humidity: #{@response["list"][0]["humidity"]}%"
  end


  def tomorrow
    puts "Tomorrow's weather in " + 
         "#{@response["city"]["name"]}, #{@response["city"]["country"]}: " +
         "#{@response["list"][1]["weather"][0]["description"]}"
    puts "High of #{@response["list"][1]["temp"]["max"]}"
    puts "Low of #{@response["list"][1]["temp"]["min"]}"
    puts "Humidity: #{@response["list"][1]["humidity"]}%"
  end


  private


  def get_forecast
    @response = self.class.get(BASE_URL, @options)
    raise "Could not get forecast" if response["cod"] != "200"
  end


  def format_date(timestamp)
    Time.at(timestamp).strftime("%A, %b-%-d")
  end

end

