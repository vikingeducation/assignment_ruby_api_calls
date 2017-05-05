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

  def initialize(location=4350359, days=4, mode=JSON )
    validate_format!(mode)
    validate_time_period!(days)
    @days = days
    @mode = mode
    @options = {:query => {:id => location, :appid => API_KEY, :cnt => days}}
    @res = HTTParty.get(BASE_URI, @options)
    @response = JSON.parse(@res.body)
  end

  def hi_temps
    puts "HIGH TEMPS"
    @days.times do |day|
      puts "High temperature on day #{day + 1} is #{@response["list"][day]["temp"]["max"]} degrees"
    end
  end

  def lo_temps
    puts "LOW TEMPS"
    @days.times do |day|
      puts "Low temperature on day #{day + 1} is #{@response["list"][day]["temp"]["min"]} degrees"
    end
  end

  def today
    puts "TODAY"
    puts "High temperature today is #{@response["list"][0]["temp"]["max"]} degrees"
    puts "Low temperature today is #{@response["list"][0]["temp"]["min"]} degrees"
    puts "The general condition for today is #{@response["list"][0]["weather"][0]["description"]}."
  end

  def tomorrow
    puts "High temperature tomorrow is #{@response["list"][1]["temp"]["max"]} degrees."
    puts "Low temperature tomorrow is #{@response["list"][1]["temp"]["min"]} degrees."
    puts "The general condition for tomorrow is #{@response["list"][1]["weather"][0]["description"]}."
  end

  def weather_description
    puts "GENERAL CONDITIONS"
    @days.times do |day|
      puts "The general condition on day #{day + 1} is #{@response["list"][day]["weather"][0]["description"]}."
    end
  end

  def humidity
    puts "HUMIDITY"
    @days.times do |day|
      puts "Humidity on day #{day + 1} is #{@response["list"][day]["humidity"]} %"
    end
  end

  def pressure
    puts "PRESSURE"
    @days.times do |day|
      puts "Pressure on day #{day + 1} is #{@response["list"][day]["pressure"]}."
    end
  end

  private

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

end

wf = WeatherForecast.new(2643743, 7)
wf.today
wf.tomorrow
wf.hi_temps
wf.lo_temps
wf.pressure
wf.humidity
wf.weather_description
