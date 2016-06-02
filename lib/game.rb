
class Game
  attr_accessor :answer

  def initialize
    @answer = Random.new.rand(100)
    @guesses = []
  end

  def store_guess(number)
    @guesses << number
  end

  def check_guess
    return "No guesses made" if @guesses.empty?

    if @guesses.last > 100 || @guesses.last < 0
      "Please enter a number between 0 and 100"
    elsif @guesses.last < answer
      "Too low"
    elsif @guesses.last == answer
      "Correct!"
    elsif @guesses.last > answer
      "Too high"
    else
      "Keep trying"
    end
  end

  def number_of_guesses
    @guesses.count
  end

end
