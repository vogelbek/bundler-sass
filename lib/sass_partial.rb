class SassPartial < File
  def self.new *files
    files.each{|file| super file, "w"}
  end
end