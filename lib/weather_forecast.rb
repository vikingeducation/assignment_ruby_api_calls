require 'date'
require_relative 'weather_api'

class WeatherForecast
	attr_accessor :location, :days, :key

	def initialize(options={})
		@location = options[:location] || 'Philadelphia'
		@days = options[:days] || 5
		@key = options[:key]
		update
	end

	def update
		create_api
		@api.get
		@data = @api.filter
	end

	def today
		@data.each do |day|
			return day if day[:date] == Date.today.to_s
		end
	end

	def tomorrow
		@data.each do |day|
			return day if day[:date] == Date.today.next.to_s
		end
	end

	def precipitation
		results = {}
		@data.each do |day|
			date = day[:date].to_sym
			results[date] = day[:precipitation]
		end
		results
	end

	def wind
		results = {}
		@data.each do |day|
			date = day[:date].to_sym
			results[date] = {
				:wind_speed => day[:wind_speed],
				:wind_direction => day[:wind_direction]
			}
		end
		results
	end

	def clouds
		results = {}
		@data.each do |day|
			date = day[:date].to_sym
			results[date] = day[:clouds]
		end
		results
	end

	def highs
		results = {}
		@data.each do |day|
			date = day[:date].to_sym
			results[date] = day[:high]
		end
		results
	end

	def lows
		results = {}
		@data.each do |day|
			date = day[:date].to_sym
			results[date] = day[:low]
		end
		results
	end

	private
		def create_api
			@api = WeatherAPI.new(
				:location => @location,
				:days => @days,
				:key => @key
			)
		end
end