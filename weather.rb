require 'httparty'

class WeatherForecast
  include HTTParty

  attr_reader :url

  def initialize(location="San Francisco", days=3)
    @url = "http://api.openweathermap.org/data/2.5/forecast/daily?q=#{location}&cnt=#{days.to_s}&appid=#{ENV["WEATHERAPI"]}"
  end

  def results
    response = self.class.get(@url)
    response_body = JSON.parse(response.body)
    puts response_body["city"]["name"]
  end

end
