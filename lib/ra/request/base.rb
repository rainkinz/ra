module Ra
  module Request

    class Base
      attr_reader :method, :url

      def initialize(method, url)
        @method = method
        @url = url
      end
    end
  end
end
