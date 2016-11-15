require "httparty"
require "pp"
require "date"

class WeatherForecast 
  def initialize(location = "Philadelphia")
    @my_token = ENV["FORECAST_KEY"]
    @url = "http://api.openweathermap.org/data/2.5/forecast?q=#{@location}&mode=json&units=imperial&appid=#{@my_token}"
  end

  def run
    result = get_url
    pp result
    days_info = trim_results(result)
    # render
  end

  def get_url
    HTTParty.get(@url)
  end

  def trim_results(result)
    first_day = result["list"]
    second_day = result["list"]
    pp first_day
    pp second_day
    # DateTime.strptime("#{result.list.dt}",'%s')
  end  


  def render
    #display 2 day information
  end
end

WeatherForecast.new.run

    # File.open('weather.json', 'w') do |f|
    #   json = JSON.pretty_generate(result)
    #   f.write(json)
    # end