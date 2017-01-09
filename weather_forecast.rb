

# TODO : Major improvement -> Create a dic of cities by reading city.list.json and creating a hash
# TODO : Handle user interactions to get input from user

DayForecast = Struct.new(:low, :high, :rain, :wind_speed, :humidity)

require 'httparty'

class WeatherForecast

	include HTTParty

	base_uri "http://api.openweathermap.org/data/2.5"

	def initialize(location = "5368361", num_days = 5)
		@forecasts = {}
		@options = { query: { "APPID" => ENV["OPEN_WEATHER_APIKEY"], "id" => location, "cnt" => num_days * 8} }
		@num_days = num_days
  	end

	def run
		response = self.class.get('/forecast?', @options)
		response["list"].each do |day_forecast|
			rain = false
			unless day_forecast["rain"].empty?
				rain = true
			end
			wind_speed = day_forecast["wind"]["speed"]
			humidity = day_forecast["main"]["humidity"]
			date = Time.at(day_forecast["dt"])
			formatted_date = date.strftime('%a, %d %b %Y')
			min_t_k = day_forecast["main"]["temp_min"]
			min_t_f = ((min_t_k * 9.0) / 5.0 - 459.67).round(2)
			max_t_k = day_forecast["main"]["temp_max"]
			max_t_f = ((max_t_k * 9.0) / 5.0 - 459.67).round(2)
			unless @forecasts[formatted_date]
				new_forcast = DayForecast.new(min_t_f, max_t_f, rain, wind_speed, humidity)
				@forecasts[formatted_date] = new_forcast
			else
				prev_low  = @forecasts[formatted_date].low
				prev_high = @forecasts[formatted_date].high
				if prev_low > min_t_f
					@forecasts[formatted_date].low = min_t_f
				end
				if prev_high < max_t_f
					@forecasts[formatted_date].high = max_t_f
				end
				if rain
					@forecasts[formatted_date].rain = rain
				end
				if wind_speed > @forecasts[formatted_date].wind_speed
					@forecasts[formatted_date].wind_speed = wind_speed
				end
				if humidity > @forecasts[formatted_date].humidity
					@forecasts[formatted_date].humidity = humidity
				end
			end

		end
	end

	def highest_wind_speed
		highest = 0
		highest_date = nil
		i = 0
		@forecasts.each do |date, forecast|
			if highest < forecast.wind_speed
				highest = forecast.wind_speed
				highest_date = date
			end
			i += 1
			break if i == @num_days
		end
		p "Highest wind speed will be on #{highest_date} : #{highest}"
	end

	def highest_humidity
		highest = 0
		highest_date = nil
		i = 0
		@forecasts.each do |date, forecast|
			if highest < forecast.humidity
				highest = forecast.humidity
				highest_date = date
			end
			i += 1
			break if i == @num_days
		end
		p "Highest humidity will be on #{highest_date} : #{highest}"
	end

	def rain?
		i = 0
		@forecasts.each do |date, forecast|
			if forecast.rain
				p "It will rain on #{date}"
			end
			i += 1
			break if i == @num_days
		end
	end

	def hi_temps
		i = 0
		@forecasts.each do |date, forecast|
			p "Forecast for #{date} : High = #{forecast.high}"
			i += 1
			break if i == @num_days
		end
	end

	def lo_temps
		i = 0
		@forecasts.each do |date, forecast|
			p "Forecast for #{date} : Low = #{forecast.low}"
			i += 1
			break if i == @num_days
		end
	end

	def today
		i = 0
		@forecasts.each do |date, forecast|
			p "Today's Forecast"
				puts "\tLow  = #{forecast.low}"
				puts "\tHigh = #{forecast.high}"
			i += 1
			break if i == 1
		end
	end

	def tomorrow
		i = 0
		@forecasts.each do |date, forecast|
			if i == 1
				p "Tomorrow's Forecast"
				puts "\tLow  = #{forecast.low}"
				puts "\tHigh = #{forecast.high}"
			end
			i += 1
			break if i == 2
		end
	end

end

wf = WeatherForecast.new
wf.run
#wf.highest_humidity
#wf.highest_wind_speed
#wf.rain?
#wf.hi_temps
#wf.lo_temps
#wf.today
#wf.tomorrow