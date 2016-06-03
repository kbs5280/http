require './test/test_helper.rb'
require './lib/dictionary.rb'

class DictionaryTest < Minitest::Test

  def test_it_exists
    dictionary = Dictionary.new
    assert_instance_of Dictionary, dictionary
  end

  def test_it_counts_all_words
    dictionary = Dictionary.new
    assert_equal 235886, dictionary.words.length
  end

end
