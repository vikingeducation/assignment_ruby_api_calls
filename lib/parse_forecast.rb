require 'json'
require 'pry'
require 'pry-byebug'


class ParseForecast

  def initialize(location = '33613', days = 5, key)
    w = GetWeatherForecast.new(location, days, key)
    @json = w.get
    render_temps
  end

  def render_temps
    high_temps
    low_temps
    get_today
  end


  def high_temps
    get_days.each do |day|
      date = day["dt_text"]
      hi_temp = day["main"]["temp_max"]
      puts "Date: #{Time.at(day["dt"]).strftime("%m/%d/%Y   %H%M")}"
      puts "High Temp: #{hi_temp}"
      puts
    end
  end

  def low_temps
    get_days.each do |day|
      date = day["dt_text"]
      low_temp = day["main"]["temp_min"]
      puts "Date: #{Time.at(day["dt"]).strftime("%m/%d/%Y   %H%M")}"
      puts "Low Temp: #{low_temp}"
      puts
    end
  end

  def get_today
    days = get_days
    today = days[0]
    temp = today["main"]["temp"]
    humidity = today["main"]["humidity"]
    # binding.pry
    overall = today["weather"][0]["main"]
    description = today["weather"][0]["description"]
    wind = today["wind"]["speed"]
    puts "The outlook for today is a temp of #{temp}, humidity of #{humidity}, overall it will be #{overall}, and #{description}, with wind of #{wind} miles per hour"
  end


  def get_days
    @json['list']
  end

end