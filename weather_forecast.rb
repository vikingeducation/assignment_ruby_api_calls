# weatherforecast
class WeatherForecast
  def initialize(location = "france", num_days = 5)
    @location = location
    @num_days = num_days

  end
  # high temperatures organized by date
  def hi_temps
    puts @location
    puts @num_days
  end

  # low temperatures organized by date
  def lo_temps


  end

  # today's forecast
  def today

  end

  def tomorrow

  end

  # three more responses

  private
  def send_request

  end



end

w = WeatherForecast.new
w.hi_temps
