require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require File.expand_path(File.dirname(__FILE__) + '/../lib/sass_partial_notation_tools')

describe "Sass Partial Notation Tools" do
  before :all do
    @test_directory = "test_files"
    @root_directory = Dir.getwd
    Dir.mkdir @test_directory
  end

  context "turn 'partialname' shorthand into '_partialname.sass' partial" do
    pending "Need to cross-reference partialname with all partials to infer the ending"
  end

  context "turn '_partialname.sass' partial into 'partialname' shorthand" do
    pending "Just need to trim _ and .sass"
  end

  after :all do
    teardown_test_directory @test_directory
  end
end
