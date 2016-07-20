require 'envyable'

module WeatherReportProject

  class WeatherForecast

    attr_reader :key

    
    

    def initialize(key=nil) #loc)
      Envyable.load('/config/env.yml')

      

      @key = ENV['apixu_key']

    end

  end

end