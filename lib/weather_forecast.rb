require 'httparty'

# q=London&mode=xml&units=metric&cnt=7
# q={city name},{country code}&cnt={cnt}
class WeatherForecast
  BASE_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?"
  COUNTRY_CODE = "US"

  def initialize(location: "Denver", days: '5', key:)
    location = set_location(location)
    count = set_count(days.to_i)
    @forecast = get_forecast( build_url(location, count, key) )
  end

  def high_temps
    forecast.map do |day|
      "#{day["temp"]["max"]} °C"
    end
  end

  def lo_temps
    forecast.map do |day|
      "#{day["temp"]["min"]} °C"
    end
  end

  def today
    parse_day(forecast[0])
  end

  def tomorrow
    parse_day(forecast[1])
  end

  def pressures
    forecast.map do |day|
      "#{day["pressure"]} hPa"
    end
  end

  def rain_probabilities
    forecast.map do |day|
      hpa = (1013 - day["pressure"].to_f).abs/1000
      probability = ((day["humidity"].to_i/100 + hpa)* 100).to_i
      "#{probability}\% chance of rain"
    end
  end

  def descriptions
    forecast.map do |day|
      day["weather"]["main"]
    end
  end

  def raw
    forecast
  end

  private
    attr_reader :forecast

    def get_forecast(url)
      response = HTTParty.get(url)
      parse_response( response )
    end

    def parse_response( response )
      raise "Unable to retrieve the forecast." unless response['list']
      response['list']
    end

    def build_url(location, count, key)
      BASE_URL + "units=metric&q=#{location}&cnt=#{count}&appid=#{key}"
    end

    def set_location(location)
      raise ArgumentError unless location.is_a? String
      "#{location.capitalize},#{COUNTRY_CODE}"
    end

    def set_count(days)
      return 1 if days < 1
      return 16 if days > 15
      days
    end

    def parse_day(day)
      {
        description: day["weather"]["main"],
        high: "#{day["temp"]["max"]} °C",
        low: "#{day["temp"]["min"]} °C",
        humidity: "#{day["humidity"]} %"
      }
    end
end
