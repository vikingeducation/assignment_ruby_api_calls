require 'HTTParty'

class WeatherForecast

  API_KEY = ENV["TOKEN"]

  def initialize(location = "Austin", days = 5)

    url = create_url(location, days)

    response = HTTParty.get(url)
    @body = response.parsed_response

  end


  def create_url(location, days)

    "http://api.openweathermap.org/data/2.5/forecast?q=#{location},us&mode=json&cnt=#{days}&APPID=#{API_KEY}"

  end

  def hi_temps
    hi_temps = []
    @body["list"].each do |day|
      hi_temps << k_to_f(day["main"]["temp_max"])
    end
    hi_temps
  end

  def lo_temps
    lo_temps = []
    @body["list"].each do |day|
      lo_temps << k_to_f(day["main"]["temp_min"])
    end
    lo_temps
  end

  def today
    weather_details(0)
  end

  def tomorrow
    weather_details(1)
  end

  def description
    desc =[]
    @body["list"].each do |day|
      desc << day["weather"][0]["description"]
    end
    desc
  end

  def humidity
    desc =[]
    @body["list"].each do |day|
      desc << day["main"]["humidity"]
    end
    desc
  end

  def avg_temp
    t = []
    @body["list"].each do |day|
      t << k_to_f(day["main"]["temp"])
    end
    t.inject(:+)/t.length.to_f.round
  end

  def weather_details(day)
    h = Hash.new
    t = @body["list"][day]
    h["max_temp"]= k_to_f(t["main"]["temp_max"])
    h["min_temp"]= k_to_f(t["main"]["temp_min"])
    h["humidity"]= t["main"]["humidity"]
    h["description"] = t["weather"][0]["description"]
    h
  end

  def k_to_f(temp_k)
    ((temp_k-273.15) * 1.8 + 32).round
  end


end