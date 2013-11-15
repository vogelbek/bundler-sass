require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require File.expand_path(File.dirname(__FILE__) + '/../lib/sass_partial')

describe "SassPartial" do
  context "create and destroy" do
    before(:each) do
      partial_1 = SassPartial.new "/test_files/_1.sass", "w"
    end
    it "should create a file" do
      Dir.entries("test_files").should eq ["..", ".", "_1.sass"]
    end
  end
end
