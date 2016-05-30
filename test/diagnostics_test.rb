require './test/test_helper.rb'
require './lib/diagnostics.rb'

class DiagnosticsTest < Minitest::Test
  attr_reader :diagnostics

  def setup
    @diagnostics = Diagnostics.new(["GET / HTTP/1.1",
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
    assert_instance_of Diagnostics, diagnostics
  end

  def test_it_gets_request_lines_from_server
    assert_equal ["GET / HTTP/1.1", "Host: localhost:9292", "Connection: keep-alive", "Cache-Control: no-cache", "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.102 Safari/537.36", "Postman-Token: 256d818b-208d-47e0-522e-06d4bb4d0d7e", "Accept: */*", "Accept-Encoding: gzip, deflate, sdch", "Accept-Language: en-US,en;q=0.8"], diagnostics.request_lines
  end

  def test_it_gets_the_verb
    assert_equal "GET", diagnostics.verb
  end

  def test_it_gets_the_path
    assert_equal "/", diagnostics.path
  end

  def test_it_gets_the_protocol
    assert_equal "HTTP/1.1", diagnostics.protocol
  end

  def test_it_gets_the_host
    assert_equal "localhost", diagnostics.host
  end

  def test_it_gets_the_port
    assert_equal "9292", diagnostics.port
  end

  def test_it_gets_the_origin
    assert_equal "localhost", diagnostics.origin
  end

  def test_it_gets_the_accept
    assert_equal "*/*", diagnostics.accept
  end

  def test_it_can_coallate_the_ouput
    diagnostics.verb
    diagnostics.path
    diagnostics.protocol
    assert_equal ({"Verb: "=>"GET", "Path: "=>"/", "Protocol: "=>"HTTP/1.1"}), diagnostics.output
  end

end
