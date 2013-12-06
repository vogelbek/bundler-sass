module SassCreator
  class SassFile
    def initialize file_hash
      file_hash.each do |file, dependency_list| 
        File.open file, 'w'
      end
      @dependencies = file_hash
    end

    def build_import_comments
      @dependencies.each do |file, dependency_list|
        
        File.open(file, 'r+') do |file|
          dependency_list.each do |dependency|
            file.write "//import \"#{dependency.to_s}\"\n"
          end
        end
        
      end
    end

    def build_imports
      @dependencies.each do |file, dependency_list|

        File.open(file, 'r+') do |file|
          dependency_list.each do |dependency|
            file.write "@import \"#{dependency.to_s}\"\n"
          end
        end

      end
    end
  end
end