class SassPartial
  
  def self.new file_hash
    file_hash.each do |file, dependancy_list| 
      File.open(file, 'w')
    end
    @dependancies = file_hash
  end
end