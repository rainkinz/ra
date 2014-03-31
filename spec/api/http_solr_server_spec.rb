require 'spec_helper'

module Ra

  module HttpSolrServerHelper
    def solr
      @solr ||= begin
                  #connection = Ra::Connection.new(
                  #  :url => "http://localhost:8983/solr"
                  #)

                  Ra::HttpSolrServer.new(connection)
                end
    end
  end

  describe HttpSolrServer do

    context "#update" do
      include ClientHelper

      it "should send a post with json encoded data" do

        client.connection.should_receive(:post).with(
          client, hash_including({
          })
        ).and_return(
          :status => 200,
          :body => '',
          :headers => { "Content-Type" => "text/json" }
        )
        client.update()
      end

    end

  end

end

