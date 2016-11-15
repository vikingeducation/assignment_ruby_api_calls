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
  end

  def lo_temps
  end

  def today
  end

  def tomorrow
  end

  def pressures
  end

  def rain_probabilities
  end

  def descriptions
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
end
