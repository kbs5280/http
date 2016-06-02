require_relative 'parser'
require_relative 'server'
require_relative 'dictionary'

class Response
  attr_reader :input, :paths, :hello_counter, :total_requests, :dictionary

  def initialize
    @dictionary = Dictionary.new
    @hello_counter = 0
    @total_requests = 0
  end

  def response_generator(input)
    verb = input["Verb:"]
    path = input["Path:"]
    counter_manager(path)
    path_router(verb, path, input)
  end

  def counter_manager(path)
    @total_requests += 1
    @hello_counter += 1             if path == "/hello"
  end

  def path_router(verb, path, input)
    return path_response(input)     if path == "/"
    return hello_response(input)    if path == "/hello"
    return datetime_response(input) if path == "/datetime"
    return shutdown_response(input) if path == "/shutdown"
    return word_search(input)       if path == "/word_search"
    return start_game(input)        if path == "/start_game" && verb == "POST"
  end

  def path_response(input)
    input.map { |key, value| "#{key} #{value}"}.join("\n")
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
    word = input["Param Value:"].to_s.downcase
    known_word = dictionary.words.include?(word)
    known_word ? "#{word} is a known word" : "#{word} is not a known word"
  end

  def start_game(input)
    "Good luck!"
  end

end
