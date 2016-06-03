require './test/test_helper.rb'
require './lib/server.rb'

server = Server.new
server.ready_for_request
