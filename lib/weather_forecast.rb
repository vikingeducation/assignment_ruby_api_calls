require 'httparty'
require 'json'

class WeatherForecast
  attr_reader :forecast
  include HTTParty
  base_uri 'api.openweathermap.org'

  def initialize(location='Singapore', days=7)
    @options = { :query => {:q => location, :mode => 'json', :cnt => days, :units =>'metric', :APPID => ENV['API'] }}
    @days = days
  end

  def get_forecast
    @forecast = self.class.get('/data/2.5/forecast/daily', @options)
  end

  def today
    puts "Here's the forecast for today, #{Time.at(@forecast['list'][0]['dt']).strftime('%a, %d %b %Y')}:"
    puts "Weather: #{@forecast['list'][0]['weather'][0]['description']}"
    puts "Highs: #{@forecast['list'][0]['temp']['max']}ºC"
    puts "Lows: #{@forecast['list'][0]['temp']['min']}ºC"
    puts "Humidity: #{@forecast['list'][0]['humidity']}%"
  end

  def tomorrow
    puts "Here's the forecast for tomorrow, #{Time.at(@forecast['list'][1]['dt']).strftime('%a, %d %b %Y')}:"
    puts "Weather: #{@forecast['list'][1]['weather'][0]['description']}"
    puts "Highs: #{@forecast['list'][1]['temp']['max']}ºC"
    puts "Lows: #{@forecast['list'][1]['temp']['min']}ºC"
    puts "Humidity: #{@forecast['list'][1]['humidity']}%"
  end

  def hi_temps
    puts "Here are the highs for the next #{@days} day(s)"
    @forecast['list'].each do | list|
      puts "#{Time.at(list['dt']).strftime('%a, %d %b %Y')}: #{list['temp']['max']}ºC"
    end
  end

  def lo_temps
    puts "Here are the highs for the next #{@days} day(s)"
    @forecast['list'].each do | list|
      puts "#{Time.at(list['dt']).strftime('%a, %d %b %Y')}: #{list['temp']['min']}ºC"
    end
  end

  def limit_general
    puts "Here's the general forecast for the next #{@days} day(s):"
    @forecast['list'].each do |list|
      puts "#{Time.at(list['dt']).strftime('%a')}: #{list['weather'][0]['description']}ºC"
    end
  end

  def limit_day
    puts "Here are the day temperatures for next #{@days} day(s):"
    @forecast['list'].each do |list|
      puts "#{Time.at(list['dt']).strftime('%a')}: #{list['temp']['day']}ºC"
    end
  end

  def limit_night
    puts "Here are the night temperatures for next #{@days} day(s):"
    @forecast['list'].each do |list|
      puts "#{Time.at(list['dt']).strftime('%a')}: #{list['temp']['night']}ºC"
    end
  end
end
