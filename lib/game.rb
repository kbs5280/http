class Game
  attr_accessor :answer, :guesses

  def initialize
    @answer = rand(1..100)
    @guesses = []
  end

  def guess(number)
    guesses << number
  end

  def check_guess
    guess = guesses.last.to_i
    case
    when guess > 100 || guess < 1
      "Please enter a number between 1 and 100."
    when guess < answer
      "Your guess was #{guess}, and it was too low."
    when guess == answer
      "Your guess was #{guess}, and it was correct!"
    when guess > answer
      "Your guess was #{guess}, and it was too high."
    end
  end

  def game_info
    return "No guesses have been made." if guesses.empty?
    "#{guesses.count} guess(es) have been taken. #{check_guess}"
  end

end
