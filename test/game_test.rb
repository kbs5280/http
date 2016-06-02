require './test/test_helper.rb'
require './lib/game.rb'

class GameTest < Minitest::Test

  def test_game_exists
    game = Game.new
    assert_instance_of Game, game
  end

  def test_generates_random_number_when_initialized
    game = Game.new
    assert_equal Fixnum, game.answer.class
  end

  def test_game_initializes_random_number_between_0_and_100
    game = Game.new
    assert game.answer < 101 && game.answer > 0
  end

  def test_game_evaluates_a_correct_guess
    game = Game.new
    game.answer = 45
    game.store_guess(45)
    assert_equal "Correct!", game.check_guess
  end

  def test_game_evaluates_a_low_guess
    game = Game.new
    game.answer = 45
    game.store_guess(10)
    assert_equal "Too low", game.check_guess
  end

  def test_game_evaluates_a_high_guess
    game = Game.new
    game.answer = 45
    game.store_guess(70)
    assert_equal "Too high", game.check_guess
  end

  def test_gets_no_guesses_response
    game = Game.new
    assert_equal "No guesses made", game.check_guess
  end

  def test_game_starts_with_0_guesses
    game = Game.new
    assert_equal 0, game.number_of_guesses
  end

  def test_game_can_keep_track_of_guesses
    game = Game.new
    game.store_guess(6)
    game.store_guess(27)
    assert_equal 2, game.number_of_guesses
  end

end
