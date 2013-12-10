require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require File.expand_path(File.dirname(__FILE__) + '/../lib/sass_sort')
require File.expand_path(File.dirname(__FILE__) + '/../lib/sass_creator')

describe "SassTree" do
  before(:all) do
    @test_directory = "test_files"
    @root_directory = Dir.getwd
    Dir.mkdir @test_directory
  end
  before(:each) do
    Dir.chdir @test_directory
  end

  context "Directed Acyclic Graph" do
    it "should be able to sort a non-nested file structure" do
      pending "put all partials in the same directory"
    end

    it "should be able to sort a nested file structure" do
      pending "build several directories with multiple partials"
    end
  end

  context "Cyclic Graph" do
    it "should throw an error when a cyclic graph is detected" do
      pending "such a graph should be impossible in a Sass project"
    end
  end

  after(:each) do
    Dir.chdir @root_directory
  end
  after(:all) do
    teardown_test_directory @test_directory
  end
end