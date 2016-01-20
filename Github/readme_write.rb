require_relative 'gitfitti'

Figaro.application = Figaro::Application.new(
  environment: "development",
  path: "config/application.yml"
)
Figaro.load

class ReadmeWriter

  CLONE = Figaro.env.CLONE


  def write(dm)
    file = File.open("#{CLONE}/README.md", "a")
    file.write("Date: #{dm[0]}, Message: #{dm[1]} \n")
    file.close
  end




end