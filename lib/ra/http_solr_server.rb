module Ra

  class HttpSolrServer
    attr_reader :connection

    def initialize(connection_or_url, opts = {})
      if connection_or_url.is_a?(Connection)
        @connection = connection_or_url
      else
        @connection = HttpConnection.new(connection_or_url, opts)
      end
    end


    def add(doc)

    end

#     def update(opts = {})
      # opts[:headers] ||= {}
      # opts[:headers]['Content-Type'] ||= 'application/json'
      # post('update', opts)
    # end

    def post(path, opts = {})

      raw_response = connection.post()

    end

  end
end
