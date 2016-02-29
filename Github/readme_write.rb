# require_relative 'gitfitti'

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

  def include?(dm)
    file = File.open("#{CLONE}/README.md", "r")
    commits = file.readlines
    commits.include?("Date: #{dm[0]}, Message: #{dm[1]} \n")
  end



end
#
# r = ReadmeWriter.new
#
# r.include?("a")
