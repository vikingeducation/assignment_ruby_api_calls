require 'httparty'
require 'pp'

class WeatherForecast
  @@key=File.readlines('key.md')[0]

  def initialize (location="London", days=5)
    @results=HTTParty.get(generate_results(location, days))
    print
    @daily_results = @results["list"]
    #@results = load_json(@results)
    #http://api.openweathermap.org/data/2.5/forecast/city?id=524901&APPID={APIKEY}
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

  def compare_temps(location, days)
    results = []
    @other_results = HTTParty.get(generate_results(location, days))["list"]
    @daily_results.each do |res|
      
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


end
weather = WeatherForecast.new

p "High temps: #{weather.hi_temps}"
p "Low temps: #{weather.lo_temps}"
p "Wind speeds: #{weather.wind_speed}"
weather.today