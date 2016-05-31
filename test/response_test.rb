require './test/test_helper.rb'
require './lib/response.rb'

class ResponseTest < Minitest::Test
  attr_reader :input_path, :input_hello, :input_datetime, :input_shutdown, :response

  def setup
    @input_path = ({"Verb:"=>"GET", "Path:"=>"/", "Protocol:"=>"HTTP/1.1", "Host:"=>"localhost", "Port:"=>"9292", "Origin:"=>"localhost", "Accept:"=>"*/*"})
    @input_hello = ({"Verb:"=>"GET", "Path:"=>"/hello"})
    @input_datetime = ({"Verb:"=>"GET", "Path:"=>"/datetime"})
    @input_shutdown = ({"Verb:"=>"GET", "Path:"=>"/shutdown"})
  end

  # def test_it_exists
  #   response = Response.new(input_path)
  #   assert_instance_of Response, response
  # end
  #
  # def test_it_gets_the_diagnostic_output
  #   response = Response.new(input_path)
  #   assert_equal ({"Verb:"=>"GET", "Path:"=>"/", "Protocol:"=>"HTTP/1.1", "Host:"=>"localhost", "Port:"=>"9292", "Origin:"=>"localhost", "Accept:"=>"*/*"}), response.input
  # end
  #
  # def test_it_can_find_the_path
  #   response = Response.new(input_path)
  #   assert_equal "/", response.path
  # end
  #
  # def test_it_can_send_path_response
  #   response = Response.new(input_path)
  #   response.path
  #   assert_equal "Verb: GET\nPath: /\nProtocol: HTTP/1.1\nHost: localhost\nPort: 9292\nOrigin: localhost\nAccept: */*", response.direct_the_path
  # end

  def test_it_can_send_hello_response
    response = Response.new
    response.start(input_hello)
    assert_equal "Hello, World! (1)", response.direct_the_path("/hello", input_hello)
  end

  def test_it_can_send_shutdown_response
    response = Response.new
    response.start(input_hello)
    assert_equal "\nResponse complete, exiting.", response.direct_the_path("/shutdown", input_shutdown)
  end

  # def test_it_can_send_datetime_response #NEED TO TEST TIME
  #   skip
  #   response = Response.new(input_datetime)
  #   response.path
  #   assert_equal "time", response.direct_the_path
  # end
  #
  # def test_it_can_send_shutdown_response #NEED TO SHUTDOWN !!! BUT not TEST shutdown!!!
  #   response = Response.new(input_shutdown)
  #   response.path
  #   assert_equal 100, response.direct_the_path
  # end

end
