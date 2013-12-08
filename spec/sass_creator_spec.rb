require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require File.expand_path(File.dirname(__FILE__) + '/../lib/sass_creator')

describe "SassCreator module" do
  before(:all) do
    @root_directory = Dir.getwd
    build_test_directory "test_files"
  end
  
  before(:each) do
    enter_test_directory "test_files"
  end
  
  context "create partials" do
    
    it "should create multiple Sass files" do
      SassCreator::SassFile.new({"_1.sass" => [], "_2.sass" => []})
      Dir.chdir(@root_directory)
      Dir.entries("test_files").include?("_2.sass").should eq true
    end

    it "should make any kind of Sass file" do
      SassCreator::SassFile.new({"1.sass" => [], "2.sass.css" => [], "3.sass" => []})
      Dir.chdir(@root_directory)
      Dir.entries("test_files").include?("2.sass.css").should eq true
    end
  end

  context "create files with dependencies" do
    it "should create a file with an //import statement" do
      @partial = SassCreator::SassFile.new({"_1.sass" => ["_2.sass"], "_2.sass" => []})
      @partial.build_import_comments
      File.open("_1.sass", 'r').each do |line|
        line.chomp.should eq '//import "_2.sass"'
      end
    end

    it "should create a file with many //import comments" do
      @partial = SassCreator::SassFile.new({"_1.sass" => ["_2.sass", "_3.sass", "_4.sass"]})
      @partial.build_import_comments
      @lines = String.new
      File.open("_1.sass", 'r').each_with_index do |line, index|
        @lines << line
      end
      @lines.should eq "//import \"_2.sass\"\n//import \"_3.sass\"\n//import \"_4.sass\"\n"
    end
  end

  context "create files with @import directives" do
    it "should create a file with @import directives" do
      @build = SassCreator::SassFile.new({"manifest.sass" => ["_1.sass", "_3.sass", "_2.sass"]})
      @build.build_imports
      @lines = String.new
      File.open("manifest.sass", 'r').each do |line|
        @lines << line
      end
      @lines.should eq "@import \"_1.sass\"\n@import \"_3.sass\"\n@import \"_2.sass\"\n"
    end
  end
  
  after(:each) do
    leave_test_directory @root_directory
  end
  after(:all) do
    teardown_test_directory "test_files"
  end
end
