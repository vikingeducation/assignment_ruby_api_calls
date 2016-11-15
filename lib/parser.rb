
require 'date'

class Parser
  attr_accessor :weather

  def initialize(args = {})
    @weather = json_parse(args.fetch(:weather, nil))
  end

  def json_parse(weather)
    raise "Need JSON string" unless weather
    JSON.parse(weather)
  end

  def parse
    {
      hi_temps: hi_temps,
      lo_temps: lo_temps,
      today: today,
      tomorrow: tomorrow
    }
  end

  def days
    days = {}
    weather['list'].map do |day|
      date = Time.at(day['dt']).to_date.to_s
      day.delete('dt')
      days[date] = day
    end
    days
  end

  def hi_temps
    #days.map do |day|
      #[]day['max']
    #end
  end

  def lo_temps

  end

  def today

  end

  def tomorrow

  end

end
