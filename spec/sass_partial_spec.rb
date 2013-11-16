require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require File.expand_path(File.dirname(__FILE__) + '/../lib/sass_partial')

describe "SassPartial" do
  context "create and destroy" do
    before(:each) do
      Dir.mkdir("test_files")
      Dir.chdir("test_files")
      partial_1 = SassPartial.new "_1.sass", "w"
      Dir.chdir("..")
    end
    it "should create a file" do
      Dir.entries("test_files").include?("_1.sass").should eq true
    end
    after(:all) do
      Dir.foreach("test_files")do |partial|
        File.delete("test_files/" + partial) unless partial == '.' or partial == '..'
      end
      Dir.rmdir("test_files/")
    end
  end
end
