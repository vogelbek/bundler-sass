class SassPartial
  def self.new *files
    puts files
    files.each{|file| File.open file, "w"}
  end
end
