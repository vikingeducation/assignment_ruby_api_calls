require 'httparty'

class WeatherForecast

	def initialize(location = "LosAngeles,US", days = 2)
    @location = location
    @days = days
    request
	end

	def request
		options = { :query => {q: @location, cnt: @days, APPID: ENV["TOKEN"], units: "imperial"} }
		@response ||= HTTParty.get("http://api.openweathermap.org/data/2.5/forecast/daily?", options)
	end

  def hi_temps
    hi_temps = []
    request["list"].each do |i|
      date = "#{DateTime.strptime(i["dt"].to_s, "%s").month}/#{DateTime.strptime(i["dt"].to_s, "%s").day}"
      max = "#{(i["temp"]["max"]).round(2)} F"
      hi_temps << [date,max]
    end
    hi_temps
  end

  def lo_temps
    lo_temps = []
    request["list"].each do |i|
      date = "#{DateTime.strptime(i["dt"].to_s, "%s").month}/#{DateTime.strptime(i["dt"].to_s, "%s").day}"
      min = "#{(i["temp"]["min"]).round(2)} F"
      lo_temps << [date,min]
    end
    lo_temps
  end

  def today
    high = (request["list"][0]["temp"]["max"]).round(2)
    low = (request["list"][0]["temp"]["min"]).round(2)
    description = request["list"][0]["weather"][0]["description"]
    puts "Today's weather: High #{high}, Low #{low}, with #{description}"
  end

  def tomorrow
  	high = (request["list"][1]["temp"]["max"]).round(2)
    low = (request["list"][1]["temp"]["min"]).round(2)
    description = request["list"][1]["weather"][0]["description"]
    "Today's weather: High #{high}, Low #{low}, with #{description}"
  end

  def morning_walk?
  	morn_temp = (request["list"][0]["temp"]["morn"]).round(2) < 90
  	rain = request["list"][1]["weather"][0]["main"]	!= "Rain"
  	wind = request["list"][1]["speed"] < 8
  	morn_temp && rain && wind
  end

  def evening_walk?
  	eve_temp = (request["list"][0]["temp"]["eve"]).round(2) < 90 && (request["list"][0]["temp"]["eve"]).round(2) > 60
  	rain = request["list"][1]["weather"][0]["main"]	!= "Rain"
  	wind = request["list"][1]["speed"] < 8
  	eve_temp && rain && wind
  end

end