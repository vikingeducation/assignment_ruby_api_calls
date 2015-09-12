require 'yaml'

class ENVLoader
	attr_accessor :path

	def initialize(options={})
		@path = options[:path]
	end

	def load
		file = File.read(path)
		yaml = YAML.load(file)
		yaml.each do |key, value|
			self.class.send(:attr_accessor, key)
			send("#{key}=".to_sym, value)
		end
	end
end