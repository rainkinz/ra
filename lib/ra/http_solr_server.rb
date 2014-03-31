require 'yajl'

module Ra

  class HttpSolrServer
    attr_reader :connection

    def initialize(connection_or_url, opts = {})
      if connection_or_url.is_a?(HttpConnection)
        @connection = connection_or_url
      else
        @connection = HttpConnection.new(connection_or_url, opts)
      end
    end


    # TODO: Right now this is really weak. It should take a an
    # 1 or more SolrDocuments which know how to serialize themselves
    # to json, rather than a large hash
    def add(docs)
      docs = Array(docs)

      request = Request.new(
        :method => :post,
        :path => '/update',
        :data => Yajl::Encoder.encode(docs)
      )

      @connection.execute(request)
    end

    # def update(opts = {})
      # opts[:headers] ||= {}
      # opts[:headers]['Content-Type'] ||= 'application/json'
      # post('update', opts)
    # end

  end
end
