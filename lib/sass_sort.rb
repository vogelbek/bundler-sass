require File.expand_path(File.dirname(__FILE__) + '/sass_reader')

class SassSort
  include SassReader
  def self.import_order
    @unsorted = SassReader.list_partials
    depth_first @unsorted, []
  end

  private
  def self.depth_first dependency_array, sorted_array
    if dependency_array.empty? == false
      puts dependency_array.to_s
      dependency_array.inject([]) do |sorted, file|
        local_hash = SassReader.dependencies(file)
        puts local_hash
        puts "Sorted: #{sorted}"
        local_dependencies = local_hash.values.flatten.select do |partial|
          sorted_array.include?(partial) == false
        end
        puts "Depens: #{local_dependencies.to_s}"
        puts "Empty: #{local_dependencies.empty?}"
        if local_dependencies.empty?
          puts "Inserting #{file}"
          sorted << file
        else
          puts "Before: #{sorted}"
          sorted = sorted + depth_first(local_dependencies.flatten, sorted)
          puts "After: #{sorted}"
        end
        puts "So far: #{sorted}"
        sorted
      end
    end
  end
end