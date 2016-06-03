require_relative 'parser'
require_relative 'server'
require_relative 'dictionary'
require_relative 'game'

class Response
  attr_reader :input, :paths, :hello_counter, :total_requests, :dictionary

  def initialize
    @dictionary     = Dictionary.new
    @hello_counter  = 0
    @total_requests = 0
  end

  def response_generator(input)
    return "Invalid" if input == "Invalid"
    verb    = input["Verb:"]
    path    = input["Path:"]
    counter_manager(path)
    response_router(verb, path, input)
  end

  def counter_manager(path)
    @total_requests += 1
    @hello_counter += 1             if path == "/hello"
  end

  def response_router(verb, path, input)
    return path_response(input)     if path == "/"
    return hello_response(input)    if path == "/hello"
    return datetime_response(input) if path == "/datetime"
    return shutdown_response(input) if path == "/shutdown"
    return word_search(input)       if path == "/word_search"
    game_router(verb, path, input)
  end

  def path_response(input)
    condensed = input.delete_if { |key, value| key == "Param Name:" || key == "Param Value:" || key == "Content Length:" }
    condensed.map { |key, value| "#{key} #{value}"}.join("\n")
  end

  def hello_response(input)
    "Hello, World! (#{hello_counter})"
  end

  def datetime_response(input)
    Time.now.strftime('%I:%M%p on %A, %B %e, %Y')
  end

  def shutdown_response(input)
    "Total requests: #{total_requests}"
  end

  def word_search(input)
    word       = input["Param Value:"].to_s.downcase
    known_word = dictionary.words.include?(word)
    known_word ? "#{word} is a known word" : "#{word} is not a known word"
  end

  def game_router(verb, path, input)
    return start_game(input)        if verb+path == "POST/start_game"
    return game_info(input)         if verb+path == "GET/game"
    return game_play(input)         if verb+path == "POST/game"
  end

  def start_game(input)
    @game = Game.new
    "Good luck!"
  end

  def game_info(input)
    @game.game_info
  end

  def game_play(input)
    guess = input["Content Length:"]
    @game.guess(guess)
    nil
  end

end
