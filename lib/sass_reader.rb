require File.expand_path(File.dirname(__FILE__) + '/sass_partial_notation_tools')

module SassReader
  include SassPartialTools

  def self.dependencies file
    dependency_array = File.open(file, 'r').inject( [] ) do |dependency_array, line|
      dependency_array << line if is_import_comment? line
    end
    clean_dependency_array = clean_array( dependency_array )
    hash = {file => clean_dependency_array}
  end

  def self.list_all_partials
    Dir['**/*.*'].select{|partial| partial =~ /_\S+s[ac]ss\z/}
    #http://rubular.com/r/YCT1k8IaIv, but not at the start of string (for nested files)
  end

  def self.build_dependency_hash partials
    partials.inject({}) do |hash, partial|
      hash.merge dependencies(partial)
    end
  end

  private

  def self.clean_array dirty_array
    cleaning_agents = [/\/\/import\s/, /\"/, /\n/]
    dirty_array.map do |dirty_string|
      SassPartialTools.clean! dirty_string, cleaning_agents
    end
  end

  def self.is_import_comment? line_to_try
    line_to_try =~ /\/\/import /
  end
end
