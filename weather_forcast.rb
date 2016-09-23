require 'pry-byebug'
require 'httparty'
require 'JSON'


class WeatherForecast

# http://api.openweathermap.org/data/2.5/forecast/city?id=524901&APPID={APIKEY}

	include HTTParty

	base_uri 'http://api.openweathermap.org/data/2.5/forecast'


	def initialize( city = 'Chicago, IL', days = 7, site = "" )

			@options = { query:

									{ "site"  => site,
										"q"     => city,
										"cnt"   => days,
										"units" => "imperial",
										"APPID" => ENV["OPENWEATHER"] } }

	end


	def forecast
		#api.openweathermap.org/data/2.5/forecast/daily?q={city name},{country code}&cnt={cnt}
		self.class.get( "/daily?", @options )

	end


	def print_daily

		 puts @output["list"].each { |s| puts s["temp"]["day"] }

	end


end

weather_forecast = WeatherForecast.new("Chicago, IL", 8 )
weather_forecast.forecast
weather_forecast.print_daily
