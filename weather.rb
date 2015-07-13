require 'httparty'
require 'pp'

class  WeatherForecast 
  @@key=File.readlines('key.md')[0]

  def initialize (location="London", days=5)
    @results=HTTParty.get("api.openweathermap.org/data/2.5/forecast?q=#{location}&cnt=#{days}&APPID=96a0ba87471a4d76285f7bfa76e9bbbb")
    print
    #http://api.openweathermap.org/data/2.5/forecast/city?id=524901&APPID={APIKEY}
  end

  def print
    pp @results
  end


end

WeatherForecast.new