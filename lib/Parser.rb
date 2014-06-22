require "nokogiri"
require "open-uri"
require_relative "Db"

class Parser

  # Setting up the parser
  # 
  # Params:
  # +dbname+:: The name of the database to store the results
  # +uri+::    The URI of the website
  def initialize (dbname, uri)
    raise "Please define a database name." if dbname.nil?
    raise "Please define a URI." if uri.nil?
    @db = Db.new(dbname)
    @uris = [uri]
    @internal = /^(\.?\/|#{uri[/[^\/]+\/\/[^\/]+/i]})/i
  end

  public 

  # Starts the scraping process
  # 
  # Params:
  # +max+:: Number of pages to scrape and store (default: 100)
  def read (max)
    @max = max ? max.to_i : 100
    while @uris.length > 0 do
      exit if @max <= 0
      if @db.select("uri", @uris[0]).empty?
        scrape(@uris[0])
        puts ">> " + @uris[0]
      end
      @uris.shift
    end
  end

  protected

  # Gets and stores the contents of a website's page
  # 
  # Params:
  # +uri+:: The page's URI
  def scrape (uri)
    begin
      doc = Nokogiri::HTML(open(uri))
    rescue
      return
    end
    title = doc.css("title")
    return if title.empty?
    @db.insert(uri, title.first.text)
    @max -= 1
    doc.css("a").each do |anchor|
      href = anchor.attr("href")
      next if href.nil?
      next unless @uris.index(href).nil? and href.match(@internal)
      @uris << href[/^[^#]+/]
    end
  end

end