require "sqlite3"

class Db

  # Setting up the database
  # 
  # Params:
  # +name+:: The database's name
  def initialize (name)
    raise "Please define a database." unless name.is_a? String
    @name = name + ".db"
    create
  end

  public

  # Insert an item into the DB
  def insert (uri, title)
    raise "Please set an URI" if uri.nil?
    raise "Please set a title" if title.nil?
    @db.execute("INSERT INTO pages (uri, title) VALUES (?, ?)", uri, title)
  end

  # Select all from the DB or specified by a column and a search term. 
  # 
  # Params:
  # +key+::   The column name (may be nil)
  # +value+:: The search term (may be nil)
  def select (key = nil, value = nil)
    return @db.execute("SELECT * FROM pages") if key.nil? or value.nil?
    @db.execute("SELECT * FROM pages WHERE #{key} LIKE (?)", value + "%")
  end

  protected

  # Creates the table if it doesn't exist
  def create
    @db = SQLite3::Database.new @name
    @db.execute <<-SQL
      CREATE TABLE IF NOT EXISTS pages (
        uri     VARCHAR(256) PRIMARY KEY,
        title   VARCHAR(256),
        created datetime default current_timestamp
      )
    SQL
  end

end