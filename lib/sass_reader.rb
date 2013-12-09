module SassReader
  def self.dependencies file
    array = File.open(file, 'r').inject(Array.new) do |array, line|
      array << line if line =~ /\/\/import \"/
    end
    clean_array = array.map {|entry| entry.gsub(/\/\/import\s\"/,"").gsub(/\"\n/,"")}
    hash = {file => clean_array}
  end

  def self.list_partials
    list_partials_in_folder(Dir.getwd)
  end

  private
  def self.list_partials_in_folder folder
    Dir.foreach(folder).inject([]) do |array, file|
      if File.directory?(file) and file != '.' and file != '..'
        list_partials_in_folder(file).each{|nested_file| array << nested_file}
      else
        array << file if file =~ /\A_/ and file =~ /.sass\z/ 
        #http://rubular.com/r/DMlfsegYIK for underscore at start
        #http://rubular.com/r/fRM0JX3Nv3 for .sass at end
      end
      array
    end
  end
end