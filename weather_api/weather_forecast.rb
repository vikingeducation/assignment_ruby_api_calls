require 'httparty'
require 'pp'
require 'pry'

class WeatherForecast

  attr_reader :location, :days, :response, :temp_to_string

  BASE_URI = 'http://api.apixu.com/v1/forecast.json'

  def initialize(args = {})
    @location = args.fetch(:location, "San Francisco")
    @days = args.fetch(:days, 7)
    @response = get_response
    @conditions = conditions
  end

  def get_response
    end_point = BASE_URI + "?key=#{ENV['WEATHER_KEY']}&q=#{location}&days=#{days}"
    response = HTTParty.get(end_point)

    response.parsed_response
  end

  def hi_temps
    # response['forecast']['forecastday'].each do |day|

    #    day['date']['maxtemp_f']
    response['forecast']['forecastday'].each_with_object({}) do  |day, object|
      object[day['date']] = day['day']['maxtemp_f']

    end

  end

  def lo_temps
    response['forecast']['forecastday'].each_with_object({}) do  |day, object|
      object[day['date']] = day['day']['mintemp_f']
    end
  end

  def forecast_day
    response['forecast']['forecastday']
  end

  def today
    forecast_day[0]['day']
  end

  def today_date
    forecast_day[0]
  end

  def tomorrow
    forecast_day[1]['day']
  end

  def tomorrow_date
    forecast_day[1]
  end

  def conditions
    temp_strings = {
      "maxtemp_f" => "Max Temperature in Fahrenheit",
      "mintemp_f" => "Min Temperature in Fahrenheit",
      "avgtemp_f" => "Average Temp in Fahrenheit",
      "maxwind_mph" => "Max wind speed (mph)",
      "totalprecip_in" => "Total precipitation (inches)"
    }
    temp_strings
  end

  def weather_display(day)
    str = "\nWeather conditions for #{today_date['date']}\n"
    str << "-" * str.length 
    str << "\n"

    conditions.each do |key, value|
      str << "#{value}: #{day[key]}"
      str << "\n"
    end
    str
  end

  def temps_display(temperatures)
    str = "\nLowest temperatures for each day (in Fahrenheit):\n"
    str << "-" * str.length
    str << "\n"

    temperatures.each do |date, temperature|
      str << "#{date}: #{temperature}"
      str << "\n"
    end
    str
  end

end


# Run program
wf = WeatherForecast.new
today = wf.today
tomorrow = wf.tomorrow
puts wf.weather_display(today)
puts wf.weather_display(tomorrow)
puts wf.temps_display(wf.lo_temps)
puts wf.temps_display(wf.hi_temps)

