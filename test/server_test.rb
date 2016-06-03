require './test/test_helper.rb'
require './lib/server.rb'
require 'faraday'

class ServerTest < Minitest::Test

  def test_it_returns_a_success_response
    skip
   response = Faraday.get("http://127.0.0.1:9292/")
   assert response.success?
  end

  def test_it_gets_path_response
    skip
    response = Faraday.get("http://127.0.0.1:9292/")

    assert response.body.include?("HTTP")
  end

  def test_it_gets_hello_response
    skip
    response = Faraday.get("http://127.0.0.1:9292/hello")

    assert response.body.include?("Hello")
  end

  def test_it_gets_datetime_response
    skip
    response = Faraday.get("http://127.0.0.1:9292/datetime")

    assert response.body.include?("June")
  end

  def test_it_gets_word_search_response
    skip
    response = Faraday.get("http://127.0.0.1:9292/word_search?word=pizza")

    assert response.body.include?("pizza")
  end

  def test_it_takes_post_request
    skip
    response = Faraday.post("http://127.0.0.1:9292/start_game")

    assert response.body.include?("Good luck!")
  end

  def test_game_takes_guess
    skip
    conn = Faraday.new
    conn.post("http://127.0.0.1:9292/start_game")
    response = conn.post("http://127.0.0.1:9292/game")

    refute response.body.include?("Correct")
  end

end
