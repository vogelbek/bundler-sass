require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require File.expand_path(File.dirname(__FILE__) + '/../lib/sass_sort')
require File.expand_path(File.dirname(__FILE__) + '/../lib/sass_creator')

describe "SassTree" do
  before(:all) do
    @test_directory = "test_files"
    @root_directory = Dir.getwd
    Dir.mkdir @test_directory
    Dir.chdir @test_directory
    @directories = ["0_nest", 
                    "0_nest/1_nest_a", 
                    "0_nest/1_nest_b", 
                    "0_nest/1_nest_a/2_nest"]
    
    @directories.each {|directory| Dir.mkdir(directory)}
    Dir.chdir @root_directory

  end
  before(:each) do
    Dir.chdir @test_directory
  end

  context "Directed Acyclic Graph" do
    it "should be able to sort a non-nested file structure" do
      @files = ["_0.scss",
                "_1.css.sass",
                "_2.css.scss"]
      @dependencies = [ [@files[2]],
                        [@files[0]],
                        []]
      @files.each.with_index do |file, index|
        build_file_and_hash file, @dependencies[index]
      end

      # This particular dependency graph only has a single order it can be loaded in
      SassSort.import_order.should eq [@files[2], @files[0], @files[1]]
    end

    it "should be able to sort a nested file structure" do
      @files = ["_0.scss",
                "_1.css.sass",
                "_2.css.scss",
                "#{@directories[0]}/_3.sass",
                "#{@directories[0]}/_4.sass",
                "#{@directories[1]}/_5.sass",
                "#{@directories[2]}/_6.sass",
                "#{@directories[3]}/_7.sass"]
      @dependencies = [ [], #_0.sass
                        ["#{@directories[0]}/_3.sass"], #_1.sass
                        ["#{@directories[0]}/_4.sass"], #_2.sass
                        ["_2.css.scss", "#{@directories[1]}/_5.sass"], #_3.sass
                        ["#{@directories[1]}/_5.sass", "#{@directories[2]}/_6.sass"], #_4.sass
                        [], #_5.sass
                        ["#{@directories[3]}/_7.sass"], #_6.sass
                        ["#{@directories[1]}/_5.sass"]] #_7.sass
      @files.each.with_index do |file, index|
        build_file_and_hash file, @dependencies[index]
      end
      
      @ordered_list = SassSort.import_order

      @ordered_list.first.should eq @files[5]
      @ordered_list.index(@files[7]).should be < @ordered_list.index(@files[6])
      @ordered_list.index(@files[4]).should be < @ordered_list.index(@files[2])
      @ordered_list.index(@files[3]).should be < @ordered_list.index(@files[1])
    end
  end

  context "Cyclic Graph" do
    it "should throw an error when a cyclic graph is detected" do
      @files = ["_0.scss",
                "_1.css.sass",
                "_2.css.scss"]
      @dependencies = [ [@files[2]],
                        [@files[0]],
                        [@files[0]]] #No independent node, graph contains a cycle
      pending "such a graph should be impossible in a Sass project"
    end
  end

  after(:each) do
    Dir.chdir @root_directory
  end
  after(:all) do
    teardown_test_directory @test_directory
  end
end