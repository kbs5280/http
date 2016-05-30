require 'socket'
require 'pry'
require_relative 'diagnostics'

class Server
  attr_reader :client, :marker, :request_lines

  def initialize(port)
    tcp_server = TCPServer.new(port)
    @client = tcp_server.accept
    @marker = 1
  end

  def ready_for_request
    puts "Ready for a request"
    request_lines = []
    while line = client.gets and !line.chomp.empty?
      request_lines << line.chomp
    end
    got_request(request_lines)
    diagnostics(request_lines)
  end

  def got_request(request_lines)
    puts "Got this request:"
    puts request_lines.inspect
  end

  def diagnostics(request_lines)
    diagnostics = Diagnostics.new(request_lines)
    diagnostics.start
    sending_response(diagnostics.print_output)
  end

  def sending_response(response)
    puts "Sending response."
    response = "<pre>" + "\n#{response}\n" + "</pre>"
    output = "<html><head></head><body>#{response} Hello World! (#{@marker})
              </body></html>"
    headers = ["http/1.1 200 ok",
              "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
              "server: ruby",
              "content-type: text/html; charset=iso-8859-1",
              "content-length: #{output.length}\r\n\r\n"].join("\r\n")
    client.puts headers
    client.puts output
    puts ["Wrote this response:", headers, output].join("\n")
    @marker += 1
    ready_for_request
  end

  def close
    client.close
    puts "\nResponse complete, exiting."
  end

end
