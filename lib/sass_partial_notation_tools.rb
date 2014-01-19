module SassPartial
  def self.shorthandify string
    cleaning_agents = [/\_/, /\.scss/, /\.sass/, /\.css/]
    clean! string, cleaning_agents
  end

  private

  def self.clean! string, cleaning_agents
    cleaning_agents.inject( string ) do |cleaner_string, cleaning_regex|
      cleaner_string.gsub cleaning_regex, ''
    end
  end
end
