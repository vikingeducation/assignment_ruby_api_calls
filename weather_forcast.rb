require 'pry-byebug'
require 'httparty'
require 'JSON'

=begin

class StackExchange
  include HTTParty
  base_uri 'api.stackexchange.com'

  def initialize(service, page)
    @options = { query: {site: service, page: page } }
    binding.pry
  end

  def questions
    self.class.get("/2.2/questions", @options)
    binding.pry
  end

  def users
    self.class.get("/2.2/users", @options)
    binding.pry
  end
end
=end
#stack_exchange = StackExchange.new("stackoverflow", 1)
#stack_exchange.questions
#stack_exchange.users


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

	# read on API Structure
	# options for location and cit
	def five_day_forecast

		# api.openweathermap.org/data/2.5/forecast?q=London,us&mode=xml
		self.class.get( "?q=#{ location }", @options )

	end

	def forecast
		#api.openweathermap.org/data/2.5/forecast/daily?q={city name},{country code}&cnt={cnt}
		self.class.get( "/daily?", @options )

	end


end

weather_forecast = WeatherForecast.new("Chicago, IL", 8 )
out = weather_forecast.forecast
binding.pry
puts out
