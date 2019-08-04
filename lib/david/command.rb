require 'david/extensions'
require 'david/configure'
require 'sqlite3'
require 'active_support/all'

module David
  class Command
    def initialize(config, cmd_str)
      @config = config
      @child_name = @config.child_name
      @cmd_str = cmd_str
      unless @cmd_str.nil?
        analyze
      end

      @db = @config.db
    end

    def parse_args(args)
      if args[0].start_with? '-'
        args.delete_at 0
      else
      end

      @predicate = args[0]
      @happend_at = Time.zone.now
      @created_at = Time.zone.now

      on_index = args.rindex 'on'
      if (on_index.nil?)
        @object_clause = args[1..].join(' ')
      else
        datetime = args[(on_index+1)..].join(' ')
        @happend_at = datetime&.to_datetime_safe 

        if @happend_at.nil?
          @object_clause = args[1..].join(' ')
        else
          @object_clause = args[1..(on_index-1)].join(' ')
        end
      end

      self
    end

    def execute
      @db.execute("INSERT INTO stories (action, thing, happend_at, created_at) VALUES (?, ?, ?, ?)", [@predicate, @object_clause, @happend_at.to_s, @created_at.to_s])
      puts "#{@child_name} #{@predicate} #{@object_clause} on #{@happend_at.to_date}."
    end

    def self.interact(config)
      while true
        puts "What's news about #{config.child_name}?"
        input = gets.strip
        if input.empty?
          next
        elsif ['quit', 'q', 'bye'].include? input
          puts 'bye.'
          break
        end

        cmd = Command.new(config, input)
        cmd.execute
      end 
    end

  private

    def analyze
      @subject, @predicate, @object_clause = @cmd_str.split ' ', 3
      @happend_at = Time.zone.now
      @created_at = Time.zone.now

      tokens = @object_clause.split(' on ')
      if (tokens.size > 1)
        @happend_at = tokens.last&.to_datetime_safe 

        if @happend_at.nil?
          @happend_at = Time.zone.now
        else
          @object_clause = tokens[0, tokens.size - 1].join ' on '
        end
      end
    end
  end
end
