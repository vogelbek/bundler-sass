require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require File.expand_path(File.dirname(__FILE__) + '/../lib/sass_creator')
require File.expand_path(File.dirname(__FILE__) + '/../lib/sass_reader')

describe "SassReader" do
  before(:all) do
    @test_directory = "test_files"
    @root_directory = Dir.getwd
    build_test_directory @test_directory
  end
  before(:each) do
    enter_test_directory @test_directory

    
  end

  context "build a dependency hash" do

    before(:each) do
      @filename_1 = "_1.sass"
      @dependencies_1 = ["_2.sass", "_3.sass"]
      @hash_1 = build_file_and_hash @filename_1, @dependencies_1

      @filename_2 = "_empty.sass"
      @dependencies_2 = []
      @hash_2 = build_file_and_hash @filename_2, @dependencies_2
    end

    it "should read all //import comments into an hash" do
      SassReader.dependencies(@filename_1).should eq @hash_1
    end

    it "should be cool with a file without dependencies" do
      SassReader.dependencies(@filename_2).should eq @hash_2
    end
    after(:all) do
      destroy_files @test_directory
    end
  end

  context "process all the sass partials in a directory" do
    before(:each) do
      @filename_1 = "_1.sass"
      @dependencies_1 = ["_2.sass"]
      @hash_1 = build_file_and_hash @filename_1, @dependencies_1

      @filename_2 = "A.sass"
      @dependencies_2 = ["_1.sass"]
      @hash_2 = build_file_and_hash @filename_2, @dependencies_2

      @filename_3 = "_2.sass"
      @dependencies_3 = []
      @hash_3 = build_file_and_hash @filename_3, @dependencies_3
    end
    it "should create an array of partial filenames in a directory" do
      SassReader.list_partials.should eq [@filename_1, @filename_3]
    end
    it "should create an array of partial filenames in subdirectories" do
      pending "dont yet know how this will work"
    end
    it "should create an hash of dependency hashes for all the partials in the array" do
      pending
    end
  end

  after(:each) do
    leave_test_directory @root_directory
  end
  after(:all) do
    teardown_test_directory @test_directory
  end
end