module SassReader
  def self.dependencies file
    array = File.open(file, 'r').inject(Array.new) do |array, line|
      array << line if line =~ /\/\/import \"/
    end
    clean_array = array.map {|entry| entry.gsub(/\/\/import\s\"/,"").gsub(/\"\n/,"")}
    hash = {file => clean_array}
  end

  def self.list_partials
    #list_partials_in_folder(Dir.getwd)
    Dir['**/*.*'].select{|partial| partial =~ /_\S+s[ac]ss\z/}
    #http://rubular.com/r/YCT1k8IaIv, but not at the start of string (for nested files)
  end
end