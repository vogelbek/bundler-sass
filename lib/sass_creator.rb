class SassCreator
  
  def initialize file_hash
    file_hash.each do |file, dependancy_list| 
      File.open file, 'w'
    end
    @dependancies = file_hash
  end

  def build_imports
    @dependancies.each do |file, dependancy_list|
      
      File.open(file, 'r+') do |file|
        dependancy_list.each do |dependancy|
          file.write "//import \"#{dependancy.to_s}\"\n"
        end
      end
      
    end
  end
end