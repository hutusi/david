require 'sqlite3'
require 'active_support/all'

module David
  class Command
    def initialize(config, str)
      @config = config
      @str = str
      @db = config.db
      analyze
    end

    def execute
      @db.execute("INSERT INTO stories (action, thing, happend_at, created_at) VALUES (?, ?, ?, ?)", [@predicate, @object_clause, @date.to_s, @date.to_s])
    end

  private

    def analyze
      @subject, @predicate, @object_clause = @str.split ' ', 3
      @date = Time.zone.now
    end
  end
end
