require 'httparty'
require 'env'

class WeatherForecast

  END_POINT = 'http://api.apixu.com/v1/forecast.json?'

  def initialize(params)
    @search_params = params
  end

  def build_query

    url =[END_POINT, @key, ]
  end

  def query_string
    query_string = END_POINT
    query_string
  end


end
