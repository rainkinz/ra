require 'yajl'

module Ra
  module Console
    def connect(url = "http://localhost:8983/solr/collection1", opts = {})
      @solr = Ra::HttpSolrServer.new(url, opts = {})
    end

    def solr
      @solr ||= connect
    end

    def books
      @books ||= begin
                   books_path = File.expand_path("../../../spec/data/books.json", __FILE__)
                   Yajl::Parser.parse(File.read(books_path))
                 end
    end
  end
end
