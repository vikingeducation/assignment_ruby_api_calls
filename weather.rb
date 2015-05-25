require 'httparty'
require 'colorize'

class WeatherForecast
	include HTTParty
	base_uri 'api.openweathermap.org'

	def initialize(location = "Manhattan", count = 7)
		@options = {query: {q: html_friendly(location), cnt: count, mode: 'json', units: 'imperial'} }
		# So we can display a regular location format
		@location = location
	end

	def hi_temps
    response = self.class.get('/data/2.5/forecast/daily', @options)
    puts "High Temperatures for #{@location}".bold
    response["list"].each_with_index do |day, index|
    	puts "#{index+1}) " + "#{day["temp"]["max"]}".red
    end
    true
  end

  def low_temps
    response = self.class.get('/data/2.5/forecast/daily', @options)
    puts "Low Temperatures for #{@location}".bold
    response["list"].each_with_index do |day, index|
    	puts "#{index+1}) " + "#{day["temp"]["min"]}".cyan
    end
    true
  end

  def today
  	response = self.class.get('/data/2.5/forecast/daily', @options)
  	puts "Today's Weather Forecast for #{@location}:".bold
  	today = response["list"][0]
  	today_date = Time.now
  	puts "Today is #{today_date.month}-#{today_date.day}-#{today_date.year}"
  	puts "There is a high temp of " + "#{today["temp"]["max"]}".red
  	puts "with a low of " + "#{today["temp"]["min"]}".cyan
  	puts "the weather will be " + "#{today["weather"][0]["description"]}".green
  end

  def tomorrow
  	response = self.class.get('/data/2.5/forecast/daily', @options)
  	puts "Tomorrow's Weather Forecast for #{@location}:".bold
  	tomorrow = response["list"][1]
  	today_date = Time.now
  	puts "Tomorrow will be #{today_date.month}-#{today_date.day+1}-#{today_date.year}"
  	puts "There will be a high temp of " + "#{tomorrow["temp"]["max"]}".red
  	puts "with a low of " + "#{tomorrow["temp"]["min"]}".cyan
  	puts "the weather will be " + "#{tomorrow["weather"][0]["description"]}".green
  end

private
	def html_friendly(location)
		location.split(' ').join('%20')
	end

end