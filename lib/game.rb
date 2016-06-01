
class Game
  attr_accessor :answer

  def initialize
    @answer = Random.new.rand(100)
    @guesses = []
  end

  # def generate_random_number
  #   number = Random.new
  #   number.rand(100)
  # end

  def store_guess(number)
    @guesses << number
  end

  def check_guess
    return "No guesses made" if @guesses.empty?

    case @guesses.last <=> answer
    when -1
      return "Too low"
    when 0
      return "Correct!"
    when 1
      return "Too high"
    end
  end

  def number_of_guesses
    @guesses.count
  end

end
