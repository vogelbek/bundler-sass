class SassReader
  def self.dependencies file
    array = []
    File.open(file, 'r').each do |line|
      array << line if line =~ /\/\/import \"/
    end
    clean_array = array.map {|entry| entry.gsub(/\/\/import\s\"/,"").gsub(/\"\n/,"")}
  end
end