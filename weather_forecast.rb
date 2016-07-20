require 'httparty'
require 'pp'


class WeatherForecast
  include HTTParty

  BASE_URI = 'http://api.apixu.com/v1/forecast.json?'

  def initialize (location = 27607, days = 5)
    @days = days
    @key = ENV['apixu']
  end

  def forecast_for(location:)
    path = "#{BASE_URI}q=#{location}&key=#{@key}&days=#{@days}"
    @response = HTTParty.get(path)
    @forecast = @response["forecast"]["forecastday"]
  end

  def high_temp
    @forecast.map { |day| day["day"]["maxtemp_f"] }
  end

  def low_temp
    @forecast.map { |day| day["day"]["mintemp_f"] }
  end

  def today
    day = @forecast[0]["day"]
    {
      date:                 @forecast[0]["date"],
      high:                 day["maxtemp_f"],
      low:                  day["mintemp_f"],
      average:              day["avgtemp_f"],
      max_win_speed:        day["maxwind_mph"],
      total_precipitation:  day["totalprecip_in"],
      condition:            day["condition"]["text"]
    }
  end

  def tomorrow
    day = @forecast[1]["day"]
    {
      date:                 @forecast[1]["date"],
      high:                 day["maxtemp_f"],
      low:                  day["mintemp_f"],
      average:              day["avgtemp_f"],
      max_win_speed:        day["maxwind_mph"],
      total_precipitation:  day["totalprecip_in"],
      condition:            day["condition"]["text"]
    }
  end

  def temp_by_hour(day: 1)
    @forecast[day - 1]["hour"].map { |hour| "At #{hour["time"]} the temperature will be #{hour["temp_f"]} degrees F" }
  end

  def sunrise_sunset(day: 1)
    @forecast[day - 1]["astro"].map { |key, val| "the #{key} is at #{val}" }
  end

  def will_it_rain(day: 1)
    @forecast[day - 1]["hour"].map { |hour| "At #{hour["time"]} the chance of rain will be #{hour["will_it_rain"]}" }
  end

end

w = WeatherForecast.new
w.forecast_for(location: "Raleigh, NC")
pp w.high_temp
pp w.low_temp
pp w.today
pp w.tomorrow
pp w.temp_by_hour(day: 2)
pp w.sunrise_sunset(day: 1)
pp w.will_it_rain(day: 1)
