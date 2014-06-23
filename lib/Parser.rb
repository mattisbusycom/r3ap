require "nokogiri"
require "open-uri"
require_relative "Db"

class Parser

  # Setting up the parser
  # 
  # Params:
  # +uri+::    The URI of the website
  def initialize (uri)
    raise "Please define a URI." if uri.nil?
    @db = Db.new("r3ap")
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
      end
      @uris.shift
    end
  end

  protected

  # Loading a page's contents and omitting everything
  # that's not of the type "text/html"
  def load (uri)
    open(uri) do |file|
      yield file if file.content_type == "text/html"
    end
  end

  # Gets and stores the contents of a website's page
  def scrape (uri)
    load(uri) do |file|
      doc = Nokogiri::HTML(file)
      title = doc.css("title")
      @db.insert(uri, title.first.text)
      puts ">> " + uri
      @max -= 1
      doc.css("a").each do |anchor|
        href = anchor.attr("href")
        next if href.nil?
        next unless @uris.index(href).nil? and href.match(@internal)
        @uris << href[/^[^#]+/]
      end
    end
  end

end