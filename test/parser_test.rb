require './test/test_helper.rb'
require './lib/parser.rb'

class DiagnosticsTest < Minitest::Test
  attr_reader :parser, :request_lines, :request_word

  def setup
    @parser = Parser.new
    @request_lines = (["GET / HTTP/1.1",
                       "Host: localhost:9292",
                       "Connection: keep-alive",
                       "Cache-Control: no-cache",
                       "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.102 Safari/537.36",
                       "Postman-Token: 256d818b-208d-47e0-522e-06d4bb4d0d7e",
                       "Accept: */*",
                       "Accept-Encoding: gzip, deflate, sdch",
                       "Accept-Language: en-US,en;q=0.8"])
    @request_word    = (["GET /word_search?word=pizza HTTP/1.1",
                       "Host: localhost:9292",
                       "Connection: keep-alive",
                       "Cache-Control: no-cache",
                       "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.102 Safari/537.36",
                       "Postman-Token: 256d818b-208d-47e0-522e-06d4bb4d0d7e",
                       "Accept: */*",
                       "Accept-Encoding: gzip, deflate, sdch",
                       "Accept-Language: en-US,en;q=0.8"])
  end

  def test_it_exist
    assert_instance_of Parser, parser
  end

  def test_it_gets_the_verb
    assert_equal "GET", parser.verb(request_lines)
  end

  def test_it_gets_the_path
    assert_equal "/", parser.path(request_lines)
    assert_equal "/word_search", parser.path(request_word)
  end

  def test_it_gets_the_param_name
    assert_equal "word", parser.param_name(request_word)
    assert_equal nil, parser.param_name(request_lines)
  end

  def test_it_gets_the_param_value
    assert_equal "pizza", parser.param_value(request_word)
    assert_equal nil, parser.param_value(request_lines)
  end

  def test_it_gets_the_protocol
    assert_equal "HTTP/1.1", parser.protocol(request_lines)
  end

  def test_it_gets_the_host
    assert_equal "localhost", parser.host(request_lines)
  end

  def test_it_gets_the_port
    assert_equal "9292", parser.port(request_lines)
  end

  def test_it_gets_the_origin
    assert_equal "localhost", parser.origin(request_lines)
  end

  def test_it_gets_the_accept
    assert_equal "*/*", parser.accept(request_lines)
  end

  def test_it_can_coallate_the_output
    parser.verb(request_lines)
    parser.path(request_lines)
    parser.protocol(request_lines)
    assert_equal ({"Verb:"=>"GET", "Path:"=>"/", "Protocol:"=>"HTTP/1.1"}), parser.output
  end

  def test_it_can_generate_the_compete_output
    parser.parse_request(request_word)
    expected = {"Verb:"=>"GET", "Path:"=>"/word_search", "Param Name:"=>"word", "Param Value:"=>"pizza", "Protocol:"=>"HTTP/1.1", "Host:"=>"localhost", "Port:"=>"9292", "Origin:"=>"localhost", "Accept:"=>"*/*"}
    assert_equal expected, parser.output
  end
  
end
