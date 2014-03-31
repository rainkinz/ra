require 'spec_helper'

# This is a very good example of what we should test for:
# https://github.com/sunspot/sunspot/blob/master/sunspot/spec/integration/indexing_spec.rb
describe 'indexing' do

  before(:all) do
    start_solr
  end

  after(:all) do
    stop_solr
  end

  it "should index a model" do
    expect(true).to be_true
  end

  it "should remove a model"
  it "should remove a model by id"

end
