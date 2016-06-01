require './test/test_helper.rb'
require './lib/server.rb'

server = Server.new(9292)
server.ready_for_request
