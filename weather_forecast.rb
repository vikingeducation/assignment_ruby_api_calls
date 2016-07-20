require 'httparty'
require 'uri'


class WeatherForecast
  ENDPOINT = "http://api.apixu.com/v1/forecast.json?"

  def initialize(location = "98109", days = "5")
    @location = location
    @days = days
  end

  def generate_forecast
    forecast_data = get
    hi_temps = get_hi_temps(forecast_data)
    low_temps = get_low_temps(forecast_data)
    conditions = get_conditions(forecast_data)
    precipitation = get_precipitation(forecast_data)
    sunrise = get_sunrise(forecast_data)
    sunset = get_sunset(forecast_data)
  end

  def get_sunset(forecast_data)
    sunsets = {}
     @days.to_i.times do |day|
      date = forecast_data["forecast"]["forecastday"][day]["date"]
      sunset = forecast_data["forecast"]["forecastday"][0]["astro"]["sunset"]
      sunsets[date] = sunset
    end
    sunsets
  end

  def get_sunrise(forecast_data)
    sunrises = {}
    @days.to_i.times do |day|
      date = forecast_data["forecast"]["forecastday"][day]["date"]
      sunrise = forecast_data["forecast"]["forecastday"][day]["astro"]["sunrise"]
      sunrises[date] = sunrise
    end
    sunrises
  end  

  def get_precipitation(forecast_data)
    precipitaion = {}
    @days.to_i.times do |day|
      date = forecast_data["forecast"]["forecastday"][day]["date"]
      inches = forecast_data["forecast"]["forecastday"][day]["day"]["totalprecip_in"]
      precipitaion[date] = inches
    end
    precipitaion
  end

  def get_conditions(forecast_data)
    conditions = {}
    @days.to_i.times do |day|
      date = forecast_data["forecast"]["forecastday"][day]["date"]
      condition = forecast_data["forecast"]["forecastday"][day]["day"]["condition"]["text"]
      conditions[date] = condition
    end
    conditions
  end

  def get_low_temps(forecast_data)
    low_temps = {}
    @days.to_i.times do |day|
      date = forecast_data["forecast"]["forecastday"][day]["date"]
      low_temp = forecast_data["forecast"]["forecastday"][day]["day"]["mintemp_f"]
      low_temps[date] = low_temp
    end
    low_temps
  end

  def get_hi_temps(forecast_data)
    hi_temps = {}
    @days.to_i.times do |day|
      date = forecast_data["forecast"]["forecastday"][day]["date"]
      hi_temp = forecast_data["forecast"]["forecastday"][day]["day"]["maxtemp_f"]
      hi_temps[date] = hi_temp
    end
    hi_temps
  end

  def get
    params = {"q" => @location, "days" => @days}
    url = build_url(params)
    response = HTTParty.get(url)
  end

  def build_url(params)
    query_string = "key=#{ENV["WEATHER_KEY"]}&"
    query_string += build_query_string(params)
    "#{ENDPOINT}#{query_string}"

  end

  def build_query_string(params)
    params.map do |key, value|
      value = URI.encode(value)
      "#{key}=#{value}"
    end.join("&")
  end

end

# date = response["forecast"]["forecastday"][0]["date"]
# high = response["forecast"]["forecastday"][0]["day"]["maxtemp_f"]
# low =response["forecast"]["forecastday"][0]["day"]["mintemp_f"]
# descripion = response["forecast"]["forecastday"][0]["day"]["condition"]["text"]
# precipitation = response["forecast"]["forecastday"][0]["day"]["totalprecip_in"]
# sunrise = response["forecast"]["forecastday"][0]["astro"]["sunrise"]
# sunset = response["forecast"]["forecastday"][0]["astro"]["sunset"]
# for tomorrow, use 1 after forecastday




