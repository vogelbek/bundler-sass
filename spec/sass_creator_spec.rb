require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require File.expand_path(File.dirname(__FILE__) + '/../lib/sass_creator')

describe "SassCreator" do
  before(:all) do
    @root_dir = Dir.getwd
    Dir.mkdir("test_files")
  end
  before(:each) do
    Dir.chdir("test_files")
  end
  
  context "create partials" do
    
    it "should create multiple Sass files" do
      SassCreator.new({"_1.sass" => [], "_2.sass" => []})
      Dir.chdir(@root_dir)
      Dir.entries("test_files").include?("_2.sass").should eq true
    end

    it "should make any kind of Sass file" do
      SassCreator.new({"1.sass" => [], "2.sass.css" => [], "3.sass" => []})
      Dir.chdir(@root_dir)
      Dir.entries("test_files").include?("2.sass.css").should eq true
    end
  end

  context "create files with dependencies" do
    it "should create a file with an //import statement" do
      @partial = SassCreator.new({"_1.sass" => ["_2.sass"], "_2.sass" => []})
      @partial.build_import_comments
      File.open("_1.sass", 'r').each do |line|
        line.chomp.should eq '//import "_2.sass"'
      end
    end

    it "should create a file with many //import comments" do
      @partial = SassCreator.new({"_1.sass" => ["_2.sass", "_3.sass", "_4.sass"]})
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
      @build = SassCreator.new({"manifest.sass" => ["_1.sass", "_3.sass", "_2.sass"]})
      @build.build_imports
      @lines = String.new
      File.open("manifest.sass", 'r').each do |line|
        @lines << line
      end
      @lines.should eq "@import \"_1.sass\"\n@import \"_3.sass\"\n@import \"_2.sass\"\n"
    end
  end

  after(:each) do
    Dir.chdir @root_dir
  end

  after(:all) do
    Dir.foreach("test_files") do |file|
      File.delete("test_files/" + file) unless file == '.' or file == '..'
    end
    Dir.rmdir("test_files")
  end
end
