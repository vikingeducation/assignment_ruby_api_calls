# weatherforecast
require_relative 'environment'
require 'HTTParty'
require 'date'



class WeatherForecast
  API_KEY = WEATHER_KEY
  attr_reader :location, :num_days, :response_hash, :raw_response

# comment
  def initialize(location = 'france', num_days = 5)
    @location = location
    @num_days = num_days
    @raw_response = String.new
    @response_hash = Hash.new

  end
  # high temperatures organized by date
  def hi_temps
    send_request
    print_temps(@response_hash, "max", "High of ")
  end

  # low temperatures organized by date
  def lo_temps
    send_request
    print_temps(@response_hash, "min", "Low of ")
  end

  # today's forecast
  def today
    send_request
    print_forecast(@response_hash, Date.today)
  end
 # tomorrow's forecast
  def tomorrow
    send_request
    tomorrow = Date.today + 1
    print_forecast(@response_hash, tomorrow)
  end

  # three more responses

  private
  def send_request
    # puts 'api.openweathermap.org/data/2.5/forecast?id=524901&APPID=' + API_KEY
    @raw_response = HTTParty.get('http://api.openweathermap.org/data/2.5/forecast?id=524901&APPID=' + API_KEY)


  # mockup of json response from API
    # @raw_response = '{"city":{"id":0,"name":"Washington","coord":{"lon":-76.9901,"lat":38.9024},"country":"US","population":0},"cod":"200","message":10.2783552,"cnt":7,"list":[{"dt":1499533200,"temp":{"day":303.82,"min":295.71,"max":304.04,"night":295.71,"eve":301.25,"morn":300.08},"pressure":1016.82,"humidity":67,"weather":[{"id":500,"main":"Rain","description":"light rain","icon":"10d"}],"speed":3.81,"deg":276,"clouds":36,"rain":0.3},{"dt":1499619600,"temp":{"day":300.82,"min":292.57,"max":301.71,"night":292.57,"eve":299.49,"morn":295.01},"pressure":1024.85,"humidity":58,"weather":[{"id":800,"main":"Clear","description":"sky is clear","icon":"01d"}],"speed":1.67,"deg":298,"clouds":0},{"dt":1499706000,"temp":{"day":303.86,"min":296.43,"max":304.31,"night":297.9,"eve":302.6,"morn":296.43},"pressure":1022.55,"humidity":52,"weather":[{"id":800,"main":"Clear","description":"sky is clear","icon":"02d"}],"speed":3.31,"deg":217,"clouds":8},{"dt":1499792400,"temp":{"day":304.87,"min":296.71,"max":304.87,"night":296.71,"eve":300.66,"morn":297.35},"pressure":1018.96,"humidity":0,"weather":[{"id":501,"main":"Rain","description":"moderate rain","icon":"10d"}],"speed":2.38,"deg":225,"clouds":17,"rain":3.67},{"dt":1499878800,"temp":{"day":302.85,"min":296.11,"max":302.85,"night":296.11,"eve":297.54,"morn":297.6},"pressure":1017.29,"humidity":0,"weather":[{"id":502,"main":"Rain","description":"heavy intensity rain","icon":"10d"}],"speed":3.31,"deg":168,"clouds":92,"rain":43.2},{"dt":1499965200,"temp":{"day":298.11,"min":295.21,"max":298.11,"night":295.21,"eve":297.24,"morn":296.42},"pressure":1017.53,"humidity":0,"weather":[{"id":501,"main":"Rain","description":"moderate rain","icon":"10d"}],"speed":5.66,"deg":53,"clouds":38,"rain":7.63},{"dt":1500051600,"temp":{"day":299.25,"min":294.97,"max":299.25,"night":294.97,"eve":298.52,"morn":295.36},"pressure":1017.44,"humidity":0,"weather":[{"id":501,"main":"Rain","description":"moderate rain","icon":"10d"}],"speed":3.3,"deg":30,"clouds":40,"rain":7.23}]}
  # '
    parse_response
  end

  def parse_response
    @response_hash = JSON.parse(@raw_response.body)
  end

  def print_temps(hash, temp_type, msg)
    city = hash["city"]["name"]
    daily_forecasts = hash["list"]
    puts "Weather for #{city}:"
    daily_forecasts.each do |day|
      puts get_date(day["dt"])
      temperature = get_temp(day, temp_type)
      puts msg + temperature.to_s
    end
  end

# prints a forecast for a particular date
  def print_forecast(hash, date)
    unix_date = date.to_time.to_i
    date_str = get_date(unix_date)
    daily_forecasts = hash["list"]
    forecast_hash = get_forecast(hash, date)
    precip_hash = forecast_hash["weather"][0]
    description = precip_hash["description"]
    pressure = forecast_hash["pressure"]
    humidity = forecast_hash["humidity"]
    max = get_temp(forecast_hash, "max")
    min = get_temp(forecast_hash, "min")
    if forecast_hash.has_key?("rain")
      rain = forecast_hash["rain"]
    else
      rain = 0
    end
    puts "Forecast for #{date_str}:\n#{description}\nPressure: #{pressure}\nHumidity: #{humidity}\nHigh of #{max}, low of #{min}\nChance of rain: #{(rain * 100)}%"
  end

  def get_forecast(hash, date)
    hash["list"].each do |day|
      day_in_hash = day["dt"]
      if Time.at(day_in_hash).to_date === date
        return day
        break
      end
    end
  end

  # gets the temperatures of a day
  def get_temp(day, temp_type)
    temp = day["temp"][temp_type]
    convert_temp(temp)
  end

  # gets the date of the forecast
  def get_date(unix_date)
    date = unix_to_date(unix_date)
    return date.strftime('%a %b %d %Y')
  end

  # converts temperature to celcius
    def convert_temp(temp)
      output = (temp + -273.15).to_i
      return output.to_s
    end

# converts unix date
  def unix_to_date(unix_date)
    return Date.strptime(unix_date.to_s,'%s')
  end
end
