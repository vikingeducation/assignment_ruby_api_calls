require 'httparty'
require 'pp'

class WeatherForecast
  @@key=File.readlines('key.md')[0]

  def initialize (location="London", days=5)
    @results=HTTParty.get(generate_results(location, days))
    # print
    @city=location

    @daily_results = @results["list"]
    
  end

  def generate_results(location, days)
    "http://api.openweathermap.org/data/2.5/forecast?q=#{location}&cnt=#{days}&units=imperial&APPID=@@key"
  end

  def hi_temps
    results = []
    @daily_results.each {|res| results << res["main"]["temp_max"]}
    results
  end

  def lo_temps
    results = []
    @daily_results.each {|res| results << res["main"]["temp_min"]}
    results
  end

  def wind_speed
    results = []
    @daily_results.each {|res| results << res["wind"]["speed"].to_s + " mph"}
    results
  end

  def compare_temps(location)
    
    @other_results = HTTParty.get(generate_results(location, @daily_results.length))["list"]
    0.upto(@daily_results.length-1) do |i|
      puts " #{@city} has T= #{@other_results[i]["main"]["temp"]} and #{location} has T= #{@daily_results[i]["main"]["temp"]}"
    end
      
  end



  def today
    individual_day(0)
  end

  def tomorrow
    individual_day(1)
  end

  def individual_day(day)
    puts "#{Time.at(@daily_results[day]["dt"]).strftime("%B %d")}"

    puts "Low: #{@daily_results[day]["main"]["temp_min"]}"
    puts "High: #{@daily_results[day]["main"]["temp_max"]}"

    puts "Weather: #{@daily_results[day]["weather"][0]["description"].capitalize}"
  end

  def print
    pp @results
  end

  def pressure
    @daily_results.each do |day|
      puts "#{Time.at(day["dt"]).strftime("%B %d")} pressure is #{day["main"]["pressure"]}hpa"
    end
  end


end
weather = WeatherForecast.new
weather.pressure
# p "High temps: #{weather.hi_temps}"
# p "Low temps: #{weather.lo_temps}"
 # p "Wind speeds: #{weather.wind_speed}"
# weather.today