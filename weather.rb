require 'httparty'


class WeatherForecast

	def initialize(location = "London,GB", days = 2)
		@days = days
		@location = location
		@id = 524901
	end

	def request
		options = { :query => {location: "#{@location}", cnt: "#{@days}", APPID: ENV["TOKEN"]} }
		HTTParty.get("http://api.openweathermap.org/data/2.5/forecast/daily?", options)
	end

end

# q={city name},{country code}&cnt={cnt}