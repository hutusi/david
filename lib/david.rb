require "david/version"

module David
  class Error < StandardError; end
  # Your code goes here...

  def self.main
    p 'Hello, David!'
    p ARGV
  end
end
