module SassPartial
  def self.shorthandify string
    cleaning_agents = [/\_/, /\.scss/, /\.sass/, /\.css/]
    clean! string, cleaning_agents
  end

  def self.partialize string
    string.insert(find_underscore(string), '_')
  end

  private

  def self.clean! string, cleaning_agents
    cleaning_agents.inject( string ) do |cleaner_string, cleaning_regex|
      cleaner_string.gsub cleaning_regex, ''
    end
  end

  def self.find_underscore string
    string.index /\w*$/
    # http://rubular.com/r/5hoxyVTsso
  end
end
