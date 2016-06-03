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
    game.guess(45)

    assert_equal "Your guess was 45, and it was correct!", game.check_guess
  end

  def test_it_evaluates_a_low_guess
    game = Game.new
    game.answer = 45
    game.guess(10)

    assert_equal "Your guess was 10, and it was too low.", game.check_guess
  end

  def test_it_evaluates_a_high_guess
    game = Game.new
    game.answer = 45
    game.guess(70)

    assert_equal "Your guess was 70, and it was too high.", game.check_guess
  end

  def test_it_starts_with_0_guesses
    game = Game.new

    assert_equal 0, game.guesses.count
  end

  def test_it_can_keep_track_of_guesses
    game = Game.new
    game.guess(6)
    game.guess(27)

    assert_equal 2, game.guesses.count
  end

  def test_it_gets_game_info
    game = Game.new
    game.answer = 10
    game.guess(6)
    game.guess(27)

    expected = "2 guess(es) have been taken. Your guess was 27, and it was too high."
    assert_equal 2, game.guesses.count
    assert_equal expected, game.game_info
  end




end
