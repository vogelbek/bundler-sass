require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require File.expand_path(File.dirname(__FILE__) + '/../lib/sass_creator')
require File.expand_path(File.dirname(__FILE__) + '/../lib/sass_reader')

describe "SassReader" do
  before(:all) do
    @root_dir = Dir.getwd
    Dir.mkdir("test_files")
  end
  before(:each) do
    Dir.chdir("test_files")
    @filename_1 = "_1.sass"
    @dependencies_1 = ["_2.sass", "_3.sass"]
    @hash_1 = {@filename_1 => @dependencies_1}
    @file_1 = SassCreator.new(@hash_1)
    @file_1.build_import_comments
  end

  context "build a dependency hash" do

    it "should read all //import comments into an hash" do
      SassReader.dependencies(@filename_1).should eq @hash_1
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