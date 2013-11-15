require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require File.expand_path(File.dirname(__FILE__) + '/../lib/sass_partial')

describe "SassPartial" do
  include SassPartial
  before(:each) do
    partial_1 = SassPartial.new
  end
  it "should be a type of file" do
    partial_1.should be_a(File)
  end
end
