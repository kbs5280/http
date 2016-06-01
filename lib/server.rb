require 'socket'
require 'pry'
require_relative 'parser'
require_relative 'response'

class Server
  attr_reader :client, :parser, :response, :running

  def initialize(port)
    tcp_server = TCPServer.new(port)
    @client = tcp_server.accept
    @parser = Parser.new
    @response = Response.new
    @running = true
  end

  def ready_for_request
    while running do
      puts "Ready for a request"
      request_lines = []
      while line = client.gets and !line.chomp.empty?
        request_lines << line.chomp
      end
      got_request(request_lines)
      parser_output = parser.parse_request(request_lines)
      output_to_client = response.output(parser_output)
      sending_response(output_to_client)
    end
    exit
  end

  def got_request(request_lines)
    puts "Got this request:"
    puts request_lines.inspect
  end

  def sending_response(response)
    puts "Sending response."
    response = "<pre>" + "\n#{response}\n" + "</pre>"
    output = "<html><head></head><body>#{response}</body></html>"
    headers = ["http/1.1 200 ok",
      "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
      "server: ruby",
      "content-type: text/html; charset=iso-8859-1",
      "content-length: #{output.length}\r\n\r\n"].join("\r\n")
      client.puts headers
      client.puts output
      puts ["Wrote this response:", headers, output].join("\n")
    if response.include?("Total request")
      @running = false
    end
  end

end
