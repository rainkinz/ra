require 'spec_helper'

module Ra

  describe HttpConnection do

    subject { HttpConnection.new("http://localhost:8983") }

    describe "#execute" do

      describe "PostRequest" do

        it "should execute a post for a PostRequest" do

          response = subject.execute(
            Request.new(
              :path => "/update",
              :method => :post,
              :data => books_json
            )
          )


        end
      end

    end
  end
end
