require 'httparty'


class WeatherForecast

	def initialize(location = "London,GB", days = 2)
    request(location, days)
	end

	def request
		options = { :query => {q: @location, cnt: @days, APPID: ENV["TOKEN"]} }
		@response ||= HTTParty.get("http://api.openweathermap.org/data/2.5/forecast/daily?", options)
	end

  def hi_temps
    hi_temps = []
    request["list"].each do |i|
      date = "#{DateTime.strptime(i["dt"].to_s, "%s").month}/#{DateTime.strptime(i["dt"].to_s, "%s").day}"
      max = "#{(i["temp"]["max"]-272.15).round(2)} C"
      hi_temps << [date,max]
    end

    hi_temps
  end

  def lo_temps
    lo_temps = []
    request["list"].each do |i|
      date = "#{DateTime.strptime(i["dt"].to_s, "%s").month}/#{DateTime.strptime(i["dt"].to_s, "%s").day}"
      min = "#{(i["temp"]["min"]-272.15).round(2)} C"
      lo_temps << [date,min]
    end
    lo_temps
  end

  def today
    request["list"][0]


  end

  def tomorrow

  end


end

# q={city name},{country code}&cnt={cnt}