require 'httparty'

class WeatherForecast
  include HTTParty
  base_uri 'api.openweathermap.org/data/2.5/forecast/daily/'

  attr_reader :response

  def initialize(location, num_of_days)
    @response = self.class.get("", options(location, num_of_days))
  end

  def hi_temps
    time_series { |day| find_hi_temp_for day }
  end

  def lo_temps
    time_series { |day| find_lo_temp_for day }
  end

  def pressure
    time_series { |day| find_pressure_for day }
  end

  def humidity
    time_series { |day| find_humidity_for day }
  end

  def description
    time_series { |day| find_description_for day }
  end

  def today
    day_profile 0
  end

  def tomorrow
    day_profile 1
  end

  private

  def options(location, num_of_days)
    { query:
      { APPID: "792e1c1c875a40384098681fd4f859cf",
        q: location,
        mode: "json",
        cnt: num_of_days,
        units: "imperial"
      }
    }
  end

  def time_series
    @response["list"].each_with_object({}) do |day, series|
      date = formatted_date day
      data = yield(day)
      series[date] = data
    end
  end

  def formatted_date(day)
    Time.at(day["dt"]).strftime("%a, %e %b %Y")
  end

  def data_extractor(target_object, search_terms)
    data = target_object[search_terms[0]]
    if search_terms.length == 1
      data
    else
      data_extractor(data, [search_terms[1]])
    end
  end

  def day_profile(which)
    profile_generator @response["list"][which]
  end

  def profile_generator(day)
    { description: find_description_for(day),
      low_temp: find_lo_temp_for(day),
      hi_temp: find_hi_temp_for(day),
      pressure: find_pressure_for(day),
      humidity: find_humidity_for(day) }
  end

  def find_hi_temp_for(day)
    data_extractor day, ["temp","max"]
  end

  def find_lo_temp_for(day)
    data_extractor day, ["temp","min"]
  end

  def find_description_for(day)
    day["weather"][0]["description"]
  end

  def find_pressure_for(day)
    data_extractor day, ["pressure"]
  end

  def find_humidity_for(day)
    data_extractor day, ["humidity"]
  end
end
