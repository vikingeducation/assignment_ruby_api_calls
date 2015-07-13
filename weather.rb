require 'httparty'
require 'pp'

class  WeatherForecast 
  @@key=File.readlines('key.md')[0]

  def initialize (location="London", days=5)
    @results=HTTParty.get("http://api.openweathermap.org/data/2.5/forecast?q=#{location}&cnt=#{days}&APPID=@@key")
    print
    #http://api.openweathermap.org/data/2.5/forecast/city?id=524901&APPID={APIKEY}
  end

  def print
    pp @results
  end

  def hi_temps

  end


end
WeatherForecast.new
puts @@key