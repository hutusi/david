require 'david/command'
require 'yaml'
require 'sqlite3'
require 'active_support/all'

module David
  class Configure
    attr_reader :yaml, :name
    attr_reader :db

    def initialize
      Time.zone = 'Beijing'

      @config_dir = File.join(Dir.home, '.david')
      unless File.directory?(@config_dir)
        FileUtils.mkdir_p(@config_dir)
      end

      # default config file: ~/.david/config
      @config_file = File.join(@config_dir, 'config')
      @yaml = YAML.load File.read(@config_file)
      @name = @yaml

      @db_file = File.join(@config_dir, "#{@name}.db")
      @db = SQLite3::Database.new @db_file
    rescue
      init_profile
    end

    def interact
      while true
        p "What's news about #{@name}?"
        input = gets.strip
        if input.empty?
          next
        elsif ['quit', 'q', 'bye'].include? input
          p 'bye.'
          break
        end

        cmd = Command.new(self, input)
        cmd.execute
      end 
    end

  private

    def init_profile
      p "What 's your child's name?"
      begin
        @name = gets.strip.downcase
      end until !@name.empty?

      p "Is #{@name} a boy(b) or a girl(g)?"
      begin
        @gender = gets.strip.downcase
      end until ['b', 'g',].include? @gender

      p "When did #{@name} born on? e.g., 2015-05-27"
      while true 
        begin
          birth = gets.strip
          @birthdate = Time.zone.parse birth
          break
        rescue ArgumentError
          next
        end
      end

      init_config
      init_db
    end

    def init_config
      File.write @config_file, YAML.dump(@name)
    end

    def init_db
      @db_file = File.join(@config_dir, "#{@name}.db")
      p "New database #{@db_file}"
      @db = SQLite3::Database.new @db_file

      @db.execute <<-SQL
        CREATE TABLE profiles (
          id INTEGER PRIMARY KEY,
          name VARCHAR(50) NOT NULL,
          gender VARCHAR(1) NOT NULL,
          birthdate DATETIME(5) NOT NULL
        );
SQL

      @db.execute("INSERT INTO profiles (name, gender, birthdate) VALUES (?, ?, ?)", [@name, @gender, @birthdate.to_s])

      @db.execute <<-SQL
        CREATE TABLE stories (
          id INTEGER PRIMARY KEY,
          action VARCHAR(50) NOT NULL,
          thing VARCHAR(512) NOT NULL,
          remark VARCHAR(512),
          happend_at DATETIME(5) NOT NULL,
          created_at DATETIME(5) NOT NULL,
          updated_at DATETIME(5) 
        );
SQL
    end
  end
end
