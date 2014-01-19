require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require File.expand_path(File.dirname(__FILE__) + '/../lib/sass_partial_notation_tools')

describe "Sass Partial Notation Tools" do
  before :all do
    @test_directory = "test_files"
    @root_directory = Dir.getwd
    Dir.mkdir @test_directory
  end

  before :each do
    Dir.chdir @test_directory
  end

  context "turn 'partialname' shorthand into '_partialname.sass' partial" do
    it "Should determine which file the shorthand is referring to" do
      pending "Don't yet know the testing approach"
    end
    it "Should warn if the shorthand doesn't refer to a known file" do
      pending "Need to figure out warnings"
    end
    it "Should warn if the shorthand ambigiously points to multiple files" do
      pending "Wouldn't normally be reasonable in a Sass project anyways"
    end
  end

  context "turn '_partialname.sass' partial into 'partialname' shorthand" do
    it "Should trim .sass or .scss" do
      pending "Trim either ending"
    end
    it "Should trim .css as well" do
      pending "Should trim .css.scss or .css"
    end
  end

  after :each do
    Dir.chdir @root_directory
  end

  after :all do
    teardown_test_directory @test_directory
  end
end
