class SassPartial < File
  def initialize *files
    files.each{|file| File.open file, "w"}
  end
end