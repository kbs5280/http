require './test/test_helper.rb'
require './lib/server.rb'

server = Server.new(9292)
server.ready_for_request

# server.sending_response(diagnostics.print_output)
