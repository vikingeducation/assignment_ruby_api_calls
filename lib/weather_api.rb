require 'httparty'
require_relative '../weather_results.rb'

class WeatherAPI
	END_POINT = 'http://api.openweathermap.org/data/2.5/forecast/daily'
	
	attr_reader :data

	def initialize(options={})
		@location = options[:location]
		@days = options[:days]
		@key = options[:key]
	end

	def build_url
		query_string = []
		[
			['mode', 'xml'],
			['units', 'imperial'],
			['cnt', @days],
			['APPID', @key],
			['q', @location]
		].each do |param|
			query_string << param.join('=')
		end
		@url = "#{END_POINT}?#{query_string.join('&')}"
	end

	def get
		# build_url
		# @data = HTTParty.get(@url)
		@data = $results
	end

	def filter
		filtered = []
		@data['weatherdata']['forecast']['time'].each do |d|
			day = {}
			day[:precipitation] = d['precipitation'] ? d['precipitation'] : 'None'
			day[:wind_speed] = d['windSpeed']['name']
			day[:wind_direction] = d['windDirection']['name']
			day[:temperature] = d['temperature']
			day[:high] = d['temperature']['max']
			day[:low] = d['temperature']['min']
			day[:clouds] = d['clouds']['value']
			day[:date] = d['day']
			date = d['day'].split('-')
			day[:year] = date[0]
			day[:month] = date[1]
			day[:day] = date[2]
			filtered << day
		end
		filtered
	end
end