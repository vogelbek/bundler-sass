module SassReader
  def self.dependencies file
    dependency_array = File.open(file, 'r').inject( [] ) do |dependency_array, line|
      dependency_array << line if line =~ /\/\/import /
    end
    clean_dependency_array = clean_array( dependency_array )
    hash = {file => clean_dependency_array}
  end

  def self.list_partials
    Dir['**/*.*'].select{|partial| partial =~ /_\S+s[ac]ss\z/}
    #http://rubular.com/r/YCT1k8IaIv, but not at the start of string (for nested files)
  end

  def self.build_dependency_hash partials
    partials.inject({}) do |hash, partial|
      hash.merge self.dependencies(partial)
    end
  end

  private

  def self.clean_array dirty_array
    dirty_array.map do |entry|
      clean_import! entry
      clean_quote! entry
      clean_return! entry
    end
  end

  def self.clean_import! string
    string.gsub! /\/\/import\s\"/, ""
  end

  def self.clean_quote! string
    string.gsub! /\"/, ""
  end

  def self.clean_return! string
    string.gsub! /\n/, ""
  end
end
