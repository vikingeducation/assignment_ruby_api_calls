class WeatherForecast

  API_KEY = ENV["TOKEN"]

  BASE_URI = "http://api.openweathermap.org/data/2.5/forecast/city?id=524901&APPID="

  URI = BASE_URI + API_KEY

  def initialize(location = "Austin", days = 5)

    url = create_url(location, days)

    response = HTTParty.get(url)

  end


  def create_url(location, days)

    "api.openweathermap.org/data/2.5/forecast?q=#{location},us&mode=json&cnt=#{days}&APPID=#{API_KEY}"

  end

end