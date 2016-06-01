require_relative 'diagnostics'
require_relative 'server'
require_relative 'dictionary'

class Response
  attr_reader :input, :paths, :hello_counter, :total_requests, :dictionary

  def initialize
    @dictionary = Dictionary.new
    @hello_counter = 0
    @total_requests = 0
  end

  def start(input)
    direct_the_path(input["Path:"], input)
  end

  def direct_the_path(path, input)
    @total_requests += 1
    if path == "/"
      path_response(input)
    elsif path == "/hello"
      @hello_counter += 1
      hello_response(input)
    elsif path == "/datetime"
      datetime_response(input)
    elsif path == "/shutdown"
      shutdown_response(input)
    elsif path == "/word_search"
      word_search(input)
    end
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
    word = input["Param Value:"]
    if dictionary.words.include?(word)
      "#{word} is a known word"
    else
      "#{word} is not a known word"
    end
  end

end
