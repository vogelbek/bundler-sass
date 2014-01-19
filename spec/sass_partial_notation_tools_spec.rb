require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require File.expand_path(File.dirname(__FILE__) + '/../lib/sass_partial_notation_tools')

describe "Sass Partial Notation Tools" do
  before :all do
    @test_directory = "test_files"
    @root_directory = Dir.getwd
    Dir.mkdir @test_directory
  end
  after :all do
    teardown_test_directory @test_directory
  end
end
