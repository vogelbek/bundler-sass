require File.expand_path(File.dirname(__FILE__) + '/sass_reader')

class SassSort
  include SassReader
  def self.import_order
    @unsorted = SassReader.list_partials
    @dependencies = SassReader.build_dependency_hash @unsorted
    depth_first @dependencies
  end

  private
  def self.depth_first dependency_array
    dependency_array.inject([]) do |sorted, file|
      local_dependencies = SassReader.dependencies file
      if local_dependencies
        depth_first local_dependencies
      else
        sorted << file
      end
      sorted
    end
  end
end