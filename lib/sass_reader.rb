module SassReader
  def self.dependencies file
    array = File.open(file, 'r').inject(Array.new) do |array, line|
      array << line if line =~ /\/\/import \"/
    end
    clean_array = array.map {|entry| entry.gsub(/\/\/import\s\"/,"").gsub(/\"\n/,"")}
    hash = {file => clean_array}
  end
end