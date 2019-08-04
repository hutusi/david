require "david/version"
require "david/configure"
require "david/command"

module David
  class Error < StandardError; end
  # Your code goes here...

  def self.main
    puts ARGV
    args = ARGV

    conf = Configure.new
    cmd = self.get_command(conf, args)

    if cmd.nil?
      Command.interact(conf)
    else
      cmd.execute
    end
  end

  def self.get_command(conf, args)
    if args.size == 1
      if args[0].start_with? '-'
        return nil
      else
        return Command.new(conf, nil).parse_args(args)
      end
    elsif args.size > 1
      return Command.new(conf, nil).parse_args(args)
    else
      return nil
    end
  end
end
