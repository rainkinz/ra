require 'uri'
require 'net/http'

module Ra

  class Request
    attr_reader :path, :method, :headers, :data

    def initialize(args = {})
      @path = args.fetch(:path)

      @method = args.fetch(:method) { :get }
      @headers = args.fetch(:headers) { default_headers }
      @data = args[:data]
    end

    private

    def default_headers
      {
        'Content-Type' => 'application/json'
      }
    end

    def convert_to_uri(uri_or_string)
      uri_or_string.is_a?(URI) ? uri_or_string : URI.parse(uri_or_string)
    end
  end

  class HttpConnection

    ConnectionError = Class.new(StandardError)

    attr_reader :uri

    def initialize(uri, opts = {})
      @uri = uri.is_a?(URI) ? uri : URI.parse(uri)
    end

    def execute(request)
      raw_request = raw_request(request)
      raw_response = http.request(raw_request)
      charset = raw_response.type_params["charset"]
      {
        :status => raw_response.code.to_i,
        :headers => raw_response.to_hash,
        :body => force_charset(raw_response.body, charset)
      }
    rescue Timeout::Error, Errno::ECONNREFUSED => e
      raise ConnectionError.new(e)
    end

    def raw_request(request)
      http_method = case request.method
                    when :get
                      Net::HTTP::Get
                    when :post
                      Net::HTTP::Post
                    when :head
                      Net::HTTP::Head
                    else
                      raise ArgumentError, "Method must be one of :get, :post and :head"
                    end

      raw_request = http_method.new(request.path)
      raw_request.initialize_http_header(request.headers)
      if request.method == :post
        raw_request.body = request.data
      end

      # TODO: Handle basic auth?
      raw_request
    end

    def http
      @http ||= begin
                  h = Net::HTTP.new(uri.host, uri.port)
                  # TODO: Set timeout options etc
                  h
                end
    end

    def join(path)
      URI.join(self.uri, path)
    end

    private

    def force_charset(body, charset)
      return body unless charset && body.respond_to?(:force_encoding)
      body.force_encoding(charset)
    end

  end
end
