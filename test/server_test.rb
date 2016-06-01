require './test/test_helper.rb'
require './lib/server.rb'
require 'faraday'
require 'JSON'

class ServerTest < Minitest::Test

# need to test the server/response cycle with Faraday

  def test_sanity_check_server_returns_a_success_response
    response = Faraday.get("http://127.0.0.1:9292/")
    assert response.success?
  end
  #
  # def test_hello_world
  #   response = Faraday.getFaraday.get("")
  #   assert response.body.include?("Hello World!")
  # end


end
