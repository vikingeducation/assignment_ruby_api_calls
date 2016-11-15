class Parser
  attr_accessor :weather

  def initialize(weather)
    @weather = json_parse(weather)
  end

  def json_parse(weather)
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

  def hi_temps
    weather.list
  end

  def lo_temps

  end

  def today

  end

  def tomorrow

  end

end
