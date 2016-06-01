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
    expected = "Verb: GET\nPath: /\nProtocol: HTTP/1.1\nHost: localhost\nPort: 9292\nOrigin: localhost\nAccept: */*"
    input_path = ({"Verb:"=>"GET", "Path:"=>"/", "Protocol:"=>"HTTP/1.1", "Host:"=>"localhost", "Port:"=>"9292", "Origin:"=>"localhost", "Accept:"=>"*/*"})
    assert_equal expected, response.output(input_path)
  end

  def test_it_can_get_hello_response
    expected = "Hello, World! (1)"
    input_hello = ({"Verb:"=>"GET", "Path:"=>"/hello"})
    assert_equal expected, response.output(input_hello)
  end

  def test_it_can_get_shutdown_response
    expected_1 = "Total requests: 1"
    expected_2 = "Total requests: 2"
    input_shutdown = ({"Verb:"=>"GET", "Path:"=>"/shutdown"})
    assert_equal expected_1, response.output(input_shutdown)
    assert_equal expected_2, response.output(input_shutdown)
  end

  # def test_it_can_send_datetime_response #NEED TO TEST TIME
  #   skip
  #   input_datetime = ({"Verb:"=>"GET", "Path:"=>"/datetime"})
  #   expected = date&time
  #   assert_equal expected, response.output(input_datetime)
  # end

  def test_it_can_get_word_search_response
    assert_equal "Pizza is a known word", response.word_search({"Param Value:" => "pizza"})
  end

end
