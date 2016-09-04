require 'httparty'
require 'uri'
require_relative './env'
require 'date'
require 'pp'
require 'pry'

class WeatherForecast

  END_POINT = 'http://api.apixu.com/v1/forecast.json?'

  def initialize(params)
    #binding.pry
    @days_info = {}
    params[:days] = "1" if params[:days] == "today"
    if params[:days] == "tomorrow"
      params[:days] = "2"
      @tomorrow = true
    end


    url = build_query(params)
    get(url)
  end

  def build_query(params)
    "#{END_POINT}#{query_string(params)}"
  end

  def query_string(params)
    params.map do |key, value|
      value = URI.encode(value)
      "#{key}=#{value}"
    end.join('&')
  end

  def get(url)
    response = HTTParty.get(url)
    response = JSON.parse(response.body)
    days_doc(response)
  end

  def days_doc(response)
    days = days(response)
    dates(days)
  end

  def days(json_responce)
    json_responce["forecast"]["forecastday"]
  end

  def dates(days)
    days.each do |day|
      date = day["date"]
      @days_info[date] = day_stats(day)
      pretty_date = Date.parse(date)
      @days_info[date][:pretty_day] =  pretty_date.strftime('%a, %b %d')
    end
    print_data
  end

  def print_data
    if @tomorrow
      tomorrow = @days_info.keys.sort[1]
      pp tomorrow
      pp @days_info[tomorrow]
    else
      pp @days_info
    end
  end

  def day_stats(day)
    {
      hi_temps: day["day"]["maxtemp_f"],
      low_temps: day["day"]["mintemp_f"],
      sunrise: day["astro"]["sunrise"],
      sunset: day["astro"]["sunset"],
      chance_rain: "#{rain_chance(day["hour"])}%"
    }
  end

  def rain_chance(hour)
    avg = hour.inject(0.0) { |sum, chance| sum + chance["will_it_rain"].to_f }
    (avg / 24 * 100).to_i
  end
end
