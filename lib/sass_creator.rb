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
      write_to_all_files "//import "
    end

    def build_imports
      write_to_all_files "@import "
    end

    private

    def write_to_all_files start_of_line
      @file_hash.each do |file, dependency_list|

        File.open(file, 'r+') do |this_file|
          dependency_list.each do |dependency|
            this_file.write "#{start_of_line}\"#{dependency.to_s}\"\n"
          end
        end

      end
    end
  end
end
