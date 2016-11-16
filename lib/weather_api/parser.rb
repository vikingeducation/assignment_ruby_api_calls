
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
    hi_temps = {}
    days.map do |day, data|
      hi_temps[day] = data['temp']['max']
    end
    hi_temps
  end

  def lo_temps
    lo_temps = {}
    days.map do |day, data|
      lo_temps[day] = data['temp']['min']
    end
    lo_temps
  end

  def today
    today = Time.now.to_date.to_s
    format_daily(days[today])
  end

  def tomorrow
    tomorrow = (Time.now + 86_400).to_date.to_s
    format_daily(days[tomorrow])
  end

  def description
    description = {}
    days.map do |day, data|
      description[day] = data['weather'][0]['description']
    end
    description
  end

  def clouds
    clouds = {}
    days.map do |day, data|
      clouds[day] = data['clouds']
    end
    clouds
  end

  def wind
    wind = {}
    days.map do |day, data|
      wind[day] = data['speed']
    end
    wind
  end

  def format_daily(day)
    {
      high: day['temp']['max'],
      low:  day['temp']['min'],
      desc: day['weather'][0]['description'],
     }
  end
end
