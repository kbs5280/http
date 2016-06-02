require 'socket'
require 'pry'
require_relative 'parser'
require_relative 'response'

class Server
  attr_reader :client, :parser, :response, :running, :guess

  def initialize
    tcp_server  = TCPServer.new(9292)
    @client     = tcp_server.accept
    @response   = Response.new
    @running  = true
  end

  def ready_for_request
    while running do
      puts "Ready for a request"
      request_lines = []
      while line = client.gets and !line.chomp.empty?
        request_lines << line.chomp
      end
      route_request_lines(request_lines)
    end
    client.close
  end

  def route_request_lines(request_lines)
    got_request(request_lines)
    parser            = Parser.new(request_lines)
    parser_output     = parser.parser_output
    user_guess = client.read(request_lines[3].split(":")[1].strip.to_i)
    parser_output["Content Length:"] = (user_guess)
    output_to_client  = response.response_generator(parser_output)
    sending_response(output_to_client)
  end

  def got_request(request_lines)
    puts "Got this request:"
    puts request_lines.inspect
  end

  def headers(output)
    ["http/1.1 200 ok",
    "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
    "server: ruby",
    "content-type: text/html; charset=iso-8859-1",
    "content-length: #{output.length}\r\n\r\n"].join("\r\n")
  end

  def sending_response(response)
    puts "Sending response..."
    response = "<pre>" + "\n#{response}\n" + "</pre>"
    output = "<html><head></head><body>#{response}</body></html>"
    client.puts headers(output)
    client.puts output
    puts ["Wrote this response:", headers(output), output].join("\n")
    @running = false if response.include?("Total request")
  end

end
