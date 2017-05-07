require 'pp'
require 'httparty'
require 'envyable'
require 'pry'
require 'json'
class WeatherForecast
	attr_accessor :forecast
  include HTTParty

  Envyable.load('config/env.yml')

	API_KEY = ENV["API_KEY"]

	base_uri "http://api.openweathermap.org"



	def initialize(location = "San Jose", days = 5)
		@location = location
		@days = days
		@options = {:query => {q: location, :APPID => API_KEY } }
		@forecast = self.class.get("/data/2.5/forecast/daily", @options).parsed_response
		
	end

	def hi_temp
		weather = @forecast
		 weather["list"].each_with_index do |day, i|
		 	puts "Day #{i + 1} highs: #{day["temp"]["max"]}"
		 end
	end

	def low_temp
		weather = @forecast
		 weather["list"].each_with_index do |day, i|
		 	puts "Day #{i + 1} lows: #{day["temp"]["min"]}"
		 end
	end

	def today
		weather = @forecast
		
		puts weather["list"][0]["temp"]["day"]
		

	end
end


weather = WeatherForecast.new

weather.today