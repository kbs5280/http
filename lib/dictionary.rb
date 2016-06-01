class Dictionary
  attr_reader :words

  def initialize
    @words = File.read('/usr/share/dict/words').split("\n")
  end

  # this class should handle the words 

end
