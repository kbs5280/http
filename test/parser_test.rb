require './test/test_helper.rb'
require './lib/parser.rb'

class DiagnosticsTest < Minitest::Test
  attr_reader :parser, :request_lines, :request_word, :request_faraday

  def setup
    @request_lines = (["GET / HTTP/1.1",
                       "Host: 127.0.0.1:9292",
                       "Connection: keep-alive",
                       "Cache-Control: no-cache",
                       "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.102 Safari/537.36",
                       "Postman-Token: 256d818b-208d-47e0-522e-06d4bb4d0d7e",
                       "Accept: */*",
                       "Accept-Encoding: gzip, deflate, sdch",
                       "Accept-Language: en-US,en;q=0.8"])
    @request_faraday = ["GET / HTTP/1.1",
                        "User-Agent: Faraday v0.9.2",
                        "Accept-Encoding: gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
                        "Accept: */*",
                        "Connection: close",
                        "Host: 127.0.0.1:9292"]
    @request_word    = (["GET /word_search?word=pizza HTTP/1.1",
                       "Host: 127.0.0.1:9292",
                       "Connection: keep-alive",
                       "Cache-Control: no-cache",
                       "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.102 Safari/537.36",
                       "Postman-Token: 256d818b-208d-47e0-522e-06d4bb4d0d7e",
                       "Accept: */*",
                       "Accept-Encoding: gzip, deflate, sdch",
                       "Accept-Language: en-US,en;q=0.8"])
  end

  def test_it_exist
    parser = Parser.new(request_lines)

    assert_instance_of Parser, parser
  end

  def test_it_gets_the_verb
    parser = Parser.new(request_lines)

    assert_equal "GET", parser.verb
  end

  def test_it_gets_the_path
    parser = Parser.new(request_lines)
    parser_2 = Parser.new(request_word)

    assert_equal "/", parser.path
    assert_equal "/word_search", parser_2.path
  end

  def test_it_gets_the_param_name
    parser = Parser.new(request_lines)
    parser_2 = Parser.new(request_word)

    assert_equal nil, parser.param_name
    assert_equal "word", parser_2.param_name
  end

  def test_it_gets_the_param_value
    parser = Parser.new(request_lines)
    parser_2 = Parser.new(request_word)

    assert_equal nil, parser.param_value
    assert_equal "pizza", parser_2.param_value
  end

  def test_it_gets_the_protocol
    parser = Parser.new(request_lines)

    assert_equal "HTTP/1.1", parser.protocol
  end

  def test_it_gets_the_host
    parser = Parser.new(request_lines)

    assert_equal "127.0.0.1", parser.host
  end

  def test_it_gets_the_host_faraday
    parser = Parser.new(request_faraday)

    assert_equal "127.0.0.1", parser.host
  end

  def test_it_gets_the_port
    parser = Parser.new(request_lines)

    assert_equal "9292", parser.port
  end

  def test_it_gets_the_port_faraday
    parser = Parser.new(request_faraday)

    assert_equal "9292", parser.port
  end

  def test_it_gets_the_origin
    parser = Parser.new(request_lines)

    assert_equal "127.0.0.1", parser.origin
  end

  def test_it_gets_the_origin
    parser = Parser.new(request_faraday)

    assert_equal "127.0.0.1", parser.origin
  end

  def test_it_gets_the_accept
    parser = Parser.new(request_lines)

    assert_equal "*/*", parser.accept
  end

  def test_it_gets_the_accept_faraday
    parser = Parser.new(request_faraday)

    assert_equal "*/*", parser.accept
  end

  def test_it_can_call_methods_via_output_hash
    parser = Parser.new(request_lines)
    parser_2 = Parser.new(request_word)

    expected = ({"Verb:"=>"GET", "Path:"=>"/", "Param Name:"=>nil, "Param Value:"=>nil, "Protocol:"=>"HTTP/1.1", "Host:"=>"127.0.0.1", "Port:"=>"9292", "Origin:"=>"127.0.0.1", "Accept:"=>"*/*"})
    expected_2 = ({"Verb:"=>"GET", "Path:"=>"/word_search", "Param Name:"=>"word", "Param Value:"=>"pizza", "Protocol:"=>"HTTP/1.1", "Host:"=>"127.0.0.1", "Port:"=>"9292", "Origin:"=>"127.0.0.1", "Accept:"=>"*/*"})

    assert_equal expected, parser.parser_output
    assert_equal expected_2, parser_2.parser_output
  end

end
