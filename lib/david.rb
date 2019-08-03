require "david/version"
require "david/configure"

module David
  class Error < StandardError; end
  # Your code goes here...

  def self.main
    p 'Hello, David!'
    p ARGV

    conf = Configure.new
    conf.interact
  end
end
