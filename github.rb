require 'rubygems'
require 'bundler/setup'
require 'github_api'
require 'pp'

class Gh
  include Github
    def initialize(key)
      @key = key
    end


end
