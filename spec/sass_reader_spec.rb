require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require File.expand_path(File.dirname(__FILE__) + '/../lib/sass_creator')
require File.expand_path(File.dirname(__FILE__) + '/../lib/sass_reader')

describe "SassReader" do
  before(:all) do
    build_test_directory
  end
  before(:each) do
    enter_test_directory

    
  end

  context "build a dependency hash" do

    before(:each) do
      @filename_1 = "_1.sass"
      @dependencies_1 = ["_2.sass", "_3.sass"]
      @hash_1 = {@filename_1 => @dependencies_1}
      @file_1 = SassCreator::SassFile.new(@hash_1)
      @file_1.build_import_comments

      @filename_2 = "_empty.sass"
      @dependencies_2 = []
      @hash_2 = {@filename_2 => @dependencies_2}
      @file_2 = SassCreator::SassFile.new(@hash_2)
      @file_2.build_import_comments
    end

    it "should read all //import comments into an hash" do
      SassReader.dependencies(@filename_1).should eq @hash_1
    end

    it "should be cool with a file without dependencies" do
      SassReader.dependencies(@filename_2).should eq @hash_2
    end
  end

  context "find all the sass files in a directory" do
  end

  after(:each) do
    leave_test_directory
  end
  after(:all) do
    teardown_test_directory
  end
end