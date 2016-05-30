require './test/test_helper.rb'
require './lib/server.rb'

server = Server.new(9292)

diagnostics = Diagnostics.new(server.ready_for_request)
diagnostics.start

server.sending_response(diagnostics.print_output)
