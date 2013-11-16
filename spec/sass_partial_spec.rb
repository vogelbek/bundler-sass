require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require File.expand_path(File.dirname(__FILE__) + '/../lib/sass_partial')

describe "SassPartial" do
  context "create and destroy" do
    before(:all) do
      @root_dir = Dir.getwd
      Dir.mkdir("test_files")
    end
    it "should create multiple files" do
      Dir.chdir("test_files")
      SassPartial.new ["_1.sass", "_2.sass"]
      Dir.chdir(@root_dir)
      Dir.entries("test_files").include?("_2.sass").should eq true
    end
    after(:all) do
      Dir.chdir(@root_dir) # in case test has failed and couldn't chdir back to root
      Dir.foreach("test_files") do |partial|
        File.delete("test_files/" + partial) unless partial == '.' or partial == '..'
      end
      Dir.rmdir("test_files")
    end
  end
end
