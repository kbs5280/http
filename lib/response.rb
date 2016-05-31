require_relative 'diagnostics'

class Response
  attr_reader :input, :paths, :marker

  def initialize(diagnostic_output)
    @input = diagnostic_output
    @marker = 0
  end

  #need a method to run the methods

  def path
    input["Path:"]
  end

  def direct_the_path
    if path == "/"
      send_path_response
    elsif path == "/hello"
      send_hello_response
    elsif path == "/datetime"
      send_datetime_response
    elsif path == "/shutdown"
      send_shutdown_response
    end
  end

  def send_path_response
    input.map { |key, value| "#{key} #{value}"}.join("\n")
  end

  def send_hello_response
    puts "Hello, World! (#{marker})"
    @marker += 1
    12
  end

  def send_datetime_response
    Time.now.strftime('%I:%M%p on %A, %B %e, %Y')
  end

  def send_shutdown_response
    # this method needs to call server.shutdown
    100
  end

end
















# def takes url and returns the path
#   #this method will return path
# end
#
# def something(path)
#   # if the path == / then call the sending_root_response_method
#   # if the past == /hello then print "hello world" and increment counter
#   # if the /date and time then give them the date and Time
#   # if shutdown then shutdown and give total count
#   # else prints everything
# end
