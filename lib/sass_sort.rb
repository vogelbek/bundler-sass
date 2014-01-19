require File.expand_path(File.dirname(__FILE__) + '/sass_reader')

module SassSort
  include SassReader


  def self.import_order
    unsorted = SassReader.list_all_partials
    unsorted.inject( [] ) do |ordered, file|
      ordered = ordered | depth_first(file, ordered)
    end
  end

  private
  def self.depth_first file, sorted
    local_hash = SassReader.dependencies file
    local_depends = local_hash.values
    local_depends.each do |partial|
      unless partial.empty? or sorted.include?(partial[0])
        sorted = sorted | depth_first(partial[0], sorted)
      end
    end
    sorted << file
  end
end
