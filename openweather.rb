require 'httparty'
require 'uri'

class WeatherForecast

  END_POINT = "http://api.openweathermap.org/data/2.5/forecast/?q="

  def initialize(options={})
    @key = options[:key] || ENV["pusher_key"]
    @location = options[:location] || "London"
    @days = options[:days].to_i - 1 || 0
  end

  def get(params)
    sleep(0.5)
    url = build_url(params)
    response = HTTParty.get(url)
    response = JSON.parse(response.body)
    File.open("temp.txt", "w") do |f|
      json = JSON.pretty_generate(response)
      f.write(json)
    end
    parse(response)
  end

  def parse(response)
    new_arr = []
    response["list"].each_with_index do |interval, index|
      new_arr << interval if index % 8 == 0
    end
    new_arr[0..@days]
  end

  def hi_temps(response)
    0.upto(@days) do |day|
      temp = response[day]["main"]["temp_max"]
      day = response[day]["dt_txt"].split(' ')
      p "High temp for #{day[0]} is #{temp}"
    end
  end

  def lo_temps(response)
    0.upto(@days) do |day|
      temp = response[day]["main"]["temp_min"]
      day = response[day]["dt_txt"].split(' ')
      p "Low temp for #{day[0]} is #{temp}"
    end
  end

  def today
    
  end

  def tomorrow

  end

  private

  def build_url(params)
    @location = params[:location]
    @days = params[:days].to_i - 1
    query_string = "#{END_POINT}#{@location}&units=imperial&APPID=#{@key}"
  end

end
