module Ra
  module Console
    def connect(url = "http://localhost:8983", opts = {})
      @solr = Ra::HttpSolrServer.new(url, opts = {})
    end

    def solr
      @solr ||= connect
    end

  end
end
