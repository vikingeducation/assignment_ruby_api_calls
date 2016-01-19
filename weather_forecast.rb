require 'httparty'

class WeatherForecast

  BASE_URI = "http://api.openweathermap.org/data/2.5/forecast"
  API_KEY = ENV["OPEN_WEATHER_MAP_KEY"]
  JSON_FORMAT = "mode=json"

  def initialize(location="524901",days=5, daily=true)
     
    raise ArgumentError if !days.is_a?(Integer) && days > 0
    raise ArgumentError if !location.is_a?(Fixnum) || !location.is_a?(String)

    #validate_time_period!(time_period)
    #validate_format!(response_format)
    @location = location
    @days = days
    @daily_str = daily ? "/daily" : ""  
    @location = location.is_a?(String) ? "q=#{location}" : "id=#{location}"
    @response = nil
  end

  def get_base_uri
    @response = HTTParty.get(BASE_URI + "#{@daily_str}?id=#{@location}&#{JSON_FORMAT}")
  end  




end

w_api = WeatherForecast.new("London,us",3,false)



# # Actually run the request using their `get` convenience method
#   def questions
#     self.class.get("/2.2/questions", @options)
#   end

#   def users
#     self.class.get("/2.2/users", @options)
#   end
# end

# # This creates a link to `api.stackexchange.com/?site=stackoverflow&page=1`
# stack_exchange = StackExchange.new("stackoverflow", 1)
# puts stack_exchange.questions
# puts stack_exchange.users

#api.openweathermap.org/data/2.5/forecast?q=London,us&mode=xml