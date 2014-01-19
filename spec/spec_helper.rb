$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rspec'
require 'bundler-sass'
require 'fileutils'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|

  def teardown_test_directory directory
    FileUtils.rm_rf directory
  end

  def build_file_and_hash filename, dependencies
    hash = {filename => dependencies}
    file = SassCreator::SassFiles.new(hash)
    file.build_import_comments
    hash
  end
end
