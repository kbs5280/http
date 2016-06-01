require './test/test_helper.rb'
require './lib/response.rb'

class ResponseTest < Minitest::Test
  attr_reader :response

  def setup
    @response = Response.new
  end

  def test_it_exists
    assert_instance_of Response, response
  end

  def test_it_can_get_path_response
    input = ({"Verb:"=>"GET", "Path:"=>"/", "Protocol:"=>"HTTP/1.1", "Host:"=>"localhost", "Port:"=>"9292", "Origin:"=>"localhost", "Accept:"=>"*/*"})

    expected = "Verb: GET\nPath: /\nProtocol: HTTP/1.1\nHost: localhost\nPort: 9292\nOrigin: localhost\nAccept: */*"

    assert_equal expected, response.response_generator(input)
  end

  def test_it_can_get_hello_response
    input = ({"Verb:"=>"GET", "Path:"=>"/hello"})

    expected = "Hello, World! (1)"

    assert_equal expected, response.response_generator(input)
  end

  def test_it_can_get_shutdown_response
    input = ({"Verb:"=>"GET", "Path:"=>"/shutdown"})

    expected_1 = "Total requests: 1"
    expected_2 = "Total requests: 2"

    assert_equal expected_1, response.response_generator(input)
    assert_equal expected_2, response.response_generator(input)
  end

  def test_it_can_send_datetime_response #NEED TO TEST TIME
    skip
    input = ({"Verb:"=>"GET", "Path:"=>"/datetime"})

    expected = date&time

    assert_equal expected, response.response_generator(input)
  end

  def test_it_can_get_a_correct_word_search_response
    input = {"Param Value:" => "pizza"}

    assert_equal "pizza is a known word", response.word_search(input)
  end

  def test_it_can_get_a_correct_word_search_response_with_capital_letters
    input = {"Param Value:" => "PIZZA"}

    assert_equal "pizza is a known word", response.word_search(input)
  end

  def test_it_can_get_an_incorrect_word_search_response
    input = {"Param Value:" => "alot"}

    assert_equal "alot is not a known word", response.word_search(input)
  end

  def test_it_can_get_an_incorrect_word_search_response_with_fragment
    input = {"Param Value:" => "pizzz"}

    assert_equal "pizzz is not a known word", response.word_search(input)
  end

  def test_it_can_get_an_incorrect_word_search_response_with_gibberish
    input = {"Param Value:" => "x..!.iI"}

    assert_equal "x..!.ii is not a known word", response.word_search(input)
  end

  def test_it_can_get_an_incorrect_word_search_response_with_gibberish
    input = {"Param Value:" => ""}

    assert_equal " is not a known word", response.word_search(input)
  end

end
