require 'json'

class ParseForecast

  def initialize(path)
    @file = JSON.parse(path)
    p @file.class
    # File.read(path)
  end

  def high_temps
    get_days.each do |day|
      date = day[:dt_text]
      hi_temp = day[:main][:temp_max]
      puts "Date: #{date.strftime("%m/%d/%Y")}"
      puts "High Temp: #{hi_temp}"
      puts
    end
  end

  def get_days
    @file['list']
  end

end