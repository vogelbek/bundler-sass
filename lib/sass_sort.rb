require File.expand_path(File.dirname(__FILE__) + '/sass_reader')

class SassSort
  include SassReader


  def self.import_order
    unsorted = SassReader.list_partials
    unsorted.inject([]) do |ordered, file|
      ordered = ordered | depth_first(file, ordered)
      puts "Ordered: #{ordered}"
      ordered
    end
  end

  private
  def self.depth_first file, sorted
    local_hash = SassReader.dependencies file
    puts local_hash
    local_depends = local_hash.values
    local_depends.each do |partial|
      unless partial.empty? or sorted.include?(partial[0])
        sorted = sorted | depth_first(partial[0], sorted)
      end
    end
    sorted << file
  end
end