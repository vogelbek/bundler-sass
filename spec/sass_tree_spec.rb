require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require File.expand_path(File.dirname(__FILE__) + '/../lib/sass_tree')
require File.expand_path(File.dirname(__FILE__) + '/../lib/sass_creator')

describe "SassTree" do
  before(:all) do
    @test_directory = "test_files"
    @root_directory = Dir.getwd
    build_test_directory @test_directory
  end
  before(:each) do
    enter_test_directory @test_directory
  end

  after(:each) do
    leave_test_directory @root_directory
  end
  after(:all) do
    teardown_test_directory @test_directory
  end
end