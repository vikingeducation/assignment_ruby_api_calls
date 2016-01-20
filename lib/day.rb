class Day
  attr_accessor :date, :min, :max, :humidity, :weather_description, :wind_speed, :wind_direction

  def initialize(opts = {})
    @date = opts.fetch(:date)
    @min = opts.fetch(:min)
    @max = opts.fetch(:max)
    @humidity = opts.fetch(:humidity)
    @weather_description = opts.fetch(:weather_description)
    @wind_speed = opts.fetch(:wind_speed)
    @wind_direction = opts.fetch(:wind_direction)
  end

  def self.from_json(json)
    options = {
      date: Time.at(json['dt']),
      min: json['temp']['min'],
      max: json['temp']['max'],
      humidity: json['humidity'],
      weather_description: json['weather'][0]['main'],
      wind_speed: json['speed'],
      wind_direction: json['deg']
    }
    new(options)
  end

  def date_string
    date.strftime("%D")
  end

  def today?
    date.to_date == Time.now.to_date
  end

  def tomorrow?
    date.to_date == Time.now.to_date+1
  end

  def rain?
    weather_description =~ /[rR]ain/
  end

  def to_kelvin
    (min + 459.67) * (5/9.0)
  end

end
