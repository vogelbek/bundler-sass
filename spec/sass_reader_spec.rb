require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require File.expand_path(File.dirname(__FILE__) + '/../lib/sass_creator')
require File.expand_path(File.dirname(__FILE__) + '/../lib/sass_reader')

describe "SassReader" do
  before(:all) do
    @test_directory = "test_files"
    @root_directory = Dir.getwd
    Dir.mkdir @test_directory
  end
  before(:each) do
    Dir.chdir @test_directory


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
      teardown_test_directory @test_directory

      Dir.mkdir @test_directory
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
      SassReader.list_all_partials.sort.should eq [@filename_3, @filename_1].sort
    end
    it "should create an array of partial filenames in subdirectories" do
      @local_root = Dir.getwd
      @nested_directory = "nest"
      Dir.mkdir @nested_directory
      Dir.chdir @nested_directory

      @filename_4 = "_1_nest.css.sass"
      @dependencies_4 = ["_2.sass"]
      @hash_4 = build_file_and_hash @filename_4, @dependencies_4

      @filename_5 = "_2_nest.scss"
      @dependencies_5 = ["#{@nested_directory}/_1_nest.sass"]
      @hash_5 = build_file_and_hash @filename_5, @dependencies_5

      @second_nested = "secondnest"
      Dir.mkdir @second_nested
      Dir.chdir @second_nested

      @filename_6 = "_3_nest_nest.scss"
      @dependencies_6 = ["#{@nested_directory}/_1_nest.sass"]
      @hash_6 = build_file_and_hash @filename_6, @dependencies_6

      Dir.chdir @local_root
      SassReader.list_all_partials.sort.should eq [@filename_3,
                                          @filename_1,
                                          "#{@nested_directory}/#{@filename_5}",
                                          "#{@nested_directory}/#{@filename_4}",
                                          "#{@nested_directory}/#{@second_nested}/#{@filename_6}"].sort
    end
    it "should create a dependency hashe for all the partials in the array" do
      @dependency_hash = {@filename_1 => @dependencies_1,
                          @filename_3 => @dependencies_3}
      SassReader.build_dependency_hash([@filename_1, @filename_3]).should eq @dependency_hash
    end
  end

  after(:each) do
    Dir.chdir @root_directory
  end
  after(:all) do
    teardown_test_directory @test_directory
  end
end
