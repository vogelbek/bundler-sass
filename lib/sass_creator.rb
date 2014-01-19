module SassCreator
  class SassFiles
    attr_reader :file_hash
    def initialize file_hash
      file_hash.each do |file, dependency_list|
        File.open file, 'w'
      end
      @file_hash = file_hash
    end

    def build_import_comments
      @file_hash.each do |file, dependency_list|

        File.open(file, 'r+') do |file|
          dependency_list.each do |dependency|
            file.write "//import \"#{dependency.to_s}\"\n"
          end
        end

      end
    end

    def build_imports
      @file_hash.each do |file, dependency_list|

        File.open(file, 'r+') do |file|
          dependency_list.each do |dependency|
            file.write "@import \"#{dependency.to_s}\"\n"
          end
        end

      end
    end
  end
end
