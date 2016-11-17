require "httparty"
require "pp"

#write an alias to call from command line

class WeatherForecast 
  def initialize(location = "Philadelphia")
    @my_token = ENV["FORECAST_KEY"]
    @url = "http://api.openweathermap.org/data/2.5/forecast?q=#{location}&mode=json&units=imperial&appid=#{@my_token}"
  end

  def run
    result = get_url
    days_info = trim_results(result)
    render(days_info)
  end

  def get_url
    HTTParty.get(@url)
  end

  def trim_results(result)
    first_day = result["list"][0..8]
    second_day = result["list"][8..16]
    [first_day, second_day]
  end  


  def render(days_info)
    days_info.each_with_index do |day, number|
      puts "\n \nForecast for #{get_date(day)}"
      puts "The high is #{avg_temp_high(day)}"
      puts "The low is #{avg_temp_low(day)}"
      puts "The weather will be #{get_weather(day)}"
    end
  end

  def get_date(array)
    array[4]["dt_txt"][0..9]
  end

  def get_weather(array)
    array[4]["weather"][0]["main"]
  end 

  def avg_temp_high(day)
    total = 0
    day.each do |hour|
      total += hour["main"]["temp_max"]
    end
    total / 8
  end

  def avg_temp_low(day)
    total = 0
    day.each do |hour|
      total += hour["main"]["temp_min"]
    end
    total / 8
  end
end