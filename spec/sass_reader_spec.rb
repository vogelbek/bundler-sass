require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require File.expand_path(File.dirname(__FILE__) + '/../lib/sass_creator')
require File.expand_path(File.dirname(__FILE__) + '/../lib/sass_reader')

describe "SassReader" do
  before(:all) do
    @root_dir = Dir.getwd
    Dir.mkdir("test_files")
  end

  after(:all) do
    Dir.foreach("test_files") do |file|
      File.delete("test_files/" + file) unless file == '.' or file == '..'
    end
    Dir.rmdir("test_files")
  end
end