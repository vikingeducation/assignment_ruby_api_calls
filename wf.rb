require 'HTTParty'
require 'json'

require 'pry-byebug'
require 'pp'



class WeatherForecast

  def initialize(zipcode = , num_of_days = 3)
    validate_zip!(zipcode)
    validate_numofdays!(num_of_days)

    @zipcode = zipcode
    @num_of_days = num_of_days
  end

  

end