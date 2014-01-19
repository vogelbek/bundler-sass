module SassPartial
  def self.shorthandify string
    clean_underscore! string
    clean_scss! string
  end

  private

  def self.clean_underscore! string
    string.gsub! /\_/, ''
  end

  def self.clean_scss! string
    string.gsub! /\.scss/, ''
  end
end
