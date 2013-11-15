require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require File.expand_path(File.dirname(__FILE__) + '/../lib/sass_partial')

describe "SassPartial" do
  include SassPartial
  it "should be a type of file" do
    SassPartial
  end
end
