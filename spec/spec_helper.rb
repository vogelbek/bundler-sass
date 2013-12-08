$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rspec'
require 'bundler-sass'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  def build_test_directory
    @root_dir = Dir.getwd
    Dir.mkdir("test_files")
  end

  def enter_test_directory
    Dir.chdir("test_files")
  end

  def leave_test_directory
    Dir.chdir @root_dir
  end

  def teardown_test_directory
    destroy_files "test_files"
    Dir.rmdir "test_files"
  end

  def destroy_files directory
    Dir.foreach(directory) do |file|
      File.delete("#{directory}/" + file) unless file == '.' or file == '..'
    end
  end

  def build_file_and_hash filename, dependencies
    hash = {filename => dependencies}
    file = SassCreator::SassFile.new(hash)
    file.build_import_comments
    hash
  end
end