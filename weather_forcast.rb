require 'pry-byebug'
require 'httparty'
require 'JSON'


class WeatherForecast

# http://api.openweathermap.org/data/2.5/forecast/city?id=524901&APPID={APIKEY}

	include HTTParty

	base_uri 'http://api.openweathermap.org/data/2.5/forecast'


	def initialize( city = 'Chicago, IL', days = 7, site = "" )

			@city_render = city

			@options = { query:

									{ "site"  => site,
										"q"     => city,
										"cnt"   => days,
										"units" => "imperial",
										"APPID" => ENV["OPENWEATHER"] } }

	end


	def get_forecast
		#api.openweathermap.org/data/2.5/forecast/daily?q={city name},{country code}&cnt={cnt}
		@output = self.class.get( "/daily?", @options )

	end


	def print_daily

		 puts "Daily average for #{ @city_render }"
		 day = 0

		 @output["list"].each { |s| puts "Day #{day += 1} : #{s["temp"]["day"]}" }

	end


	def print_highs

		puts "Daily highs for #{ @city_render }"
		day = 0

		@output["list"].each { |s| puts "Day #{day += 1} : #{s["temp"]["max"]}" }

	end


	def get_description

		puts "Daily description for Chicago, IL"
		day = 0

		 @output["list"].each do |s|

		 	s["weather"].each do | w |

		 		puts "Day #{day += 1} : #{w["description"]}"

		 	end

		 end


	end

end

weather_forecast = WeatherForecast.new("Chicago, IL", 8 )
weather_forecast.get_forecast
puts ""
weather_forecast.print_daily
puts ""
weather_forecast.print_highs
puts ""
weather_forecast.get_description
