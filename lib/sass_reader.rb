module SassReader
  def self.dependencies file
    array = File.open(file, 'r').inject(Array.new) do |array, line|
      array << line if line =~ /\/\/import /
    end
    if array.empty?
      hash = {file => []}
    else
      clean_array = array.map do |entry|
        clean_import! entry
        clean_quote! entry
        clean_return! entry
      end
      hash = {file => clean_array}
    end
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
