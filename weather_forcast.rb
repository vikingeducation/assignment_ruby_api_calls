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


	def initialize( city = 'Chicago, IL', days = 7 )

			@options = { query: { q => city, cnt => days, APPID => ENV["OPENWEATHER"] } }

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
puts weather_forecast.forecast

# API call:

#http://api.openweathermap.org/data/2.5/forecast/city?id=524901&APPID={APIKEY}
#Parameters:

#APPID {APIKEY} is your unique API key
#Example of API call:

# server api.openweathermap.org
# call API by city ID not name city coordiantes or zip


# call by city name -- api.openweathermap.org/data/2.5/weather?q={city name}

# Format
#Description:

#JSON format is used by default. To get data in XML or HTML formats just set up mode = xml or html.

#Parameters:

#mode - possible values are xml and html. If mode parameter is empty the format is JSON by default.
#Examples of API calls:

#JSON api.openweathermap.org/data/2.5/weather?q=London

#XML api.openweathermap.org/data/2.5/weather?q=London&mode=xml

#HTML api.openweathermap.org/data/2.5/weather?q=London&mode=html

# call by city name and days

#API call:

#api.openweathermap.org/data/2.5/forecast/daily?q={city name},{country code}&cnt={cnt}
#Parameters:

#q city name and country code divided by comma, use ISO 3166 country codes

#cnt number of days returned (from 1 to 16)

#Examples of API calls:

#Call 7 days forecast by city name in XML format and metric units api.openweathermap.org/data/2.5/forecast/daily?q=London&mode=xml&units=metric&cnt=7