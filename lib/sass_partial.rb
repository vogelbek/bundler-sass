class SassPartial
  
  def initialize file_hash
    file_hash.each do |file, dependancy_list| 
      File.open file, 'w'
    end
    @dependancies = file_hash
  end

  def build_imports
    @dependancies.each do |file, dependancy_list|
      dependancy_list.each do |dependancy|
        File.open file, 'r+' do |line|
          line.write "//import \"#{dependancy.to_s}\""
        end
      end
    end
  end
end