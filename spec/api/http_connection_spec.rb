require 'spec_helper'

module Ra

  describe HttpConnection do

    subject { HttpConnection.new("http://localhost:8983") }

    describe HttpConnection::ConnectionError do

      it "should raise a ConnectionError when it can't connect" do
        request = Request.new(
          :path => "/update",
          :method => :post,
          :data => books_json
        )
        stub_request(:any, subject.join(request.path)).to_timeout
        expect {
          subject.execute(request)
        }.to raise_error(HttpConnection::ConnectionError)
      end
    end

    describe "#execute" do

      describe "PostRequest" do

        it "should execute a POST for a PostRequest" do
          request = Request.new(
            :path => "/update",
            :method => :post,
            :data => books_json
          )

          stub_request(request.method, subject.join(request.path))
          response = subject.execute(request)
          expect(response[:status]).to eq(200)
        end
      end

      describe "GetRequest" do

        it "should execute a GET for a GetRequest" do
          request = Request.new(
            :path => "/select",
            :method => :get
          )

          stub_request(request.method, subject.join(request.path))
          response = subject.execute(request)
          expect(response[:status]).to eq(200)
        end

      end
    end
  end
end
