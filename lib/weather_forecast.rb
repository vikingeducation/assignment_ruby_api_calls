require 'httparty'


class WeatherForecast
  
  def initialize(location: "Denver", days: 5, key:)
    # api.openweathermap.org/data/2.5/forecast/daily?q=#{location}&mode=json&units=metric&cnt=#{days}&appid=#{key}
  end
end