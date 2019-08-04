require 'david/extensions'
require 'yaml'
require 'sqlite3'
require 'active_support/all'

module David
  class Configure
    attr_reader :yaml, :child_name
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
      @child_name  = @yaml

      @db_file = File.join(@config_dir, "#{@child_name }.db")
      @db = SQLite3::Database.new @db_file
    rescue
      init_profile
    end

  private

    def init_profile
      puts "What 's your child's name?"
      begin
        @child_name  = gets.strip.downcase
      end while @child_name .empty?
      
      begin
        puts "Is #{@child_name } a boy(b) or a girl(g)?"
        @gender = gets.strip.downcase
      end until ['b', 'g',].include? @gender

      begin
        puts "When did #{@child_name } born on? e.g., 2015-05-27"
        birth = gets.strip
        @birthdate = birth.to_datetime_safe 
      end while @birthdate.nil?

      init_config
      init_db
    end

    def init_config
      File.write @config_file, YAML.dump(@child_name )
    end

    def init_db
      @db_file = File.join(@config_dir, "#{@child_name }.db")
      puts "New database #{@db_file}"
      @db = SQLite3::Database.new @db_file

      @db.execute <<-SQL
        CREATE TABLE profiles (
          id INTEGER PRIMARY KEY,
          name VARCHAR(50) NOT NULL,
          gender VARCHAR(1) NOT NULL,
          birthdate DATETIME(5) NOT NULL
        );
SQL

      @db.execute("INSERT INTO profiles (name, gender, birthdate) VALUES (?, ?, ?)", [@child_name , @gender, @birthdate.to_s])

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
