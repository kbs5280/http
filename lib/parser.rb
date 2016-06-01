require_relative 'server'

class Parser
  attr_reader :request_lines #, :output

  def initialize(request_lines)
    @request_lines = request_lines
    # @output = {}
  end
  #
  # def parse_request(request_lines)
  #   verb(request_lines)
  #   path(request_lines)
  #   param_name(request_lines)
  #   param_value(request_lines)
  #   protocol(request_lines)
  #   host(request_lines)
  #   port(request_lines)
  #   origin(request_lines)
  #   accept(request_lines)
  #   output
  # end

  def parser_output
    { "Verb:"=>verb, "Path:"=>path, "Param Name:"=>param_name,
      "Param Value:"=>param_value, "Protocol:"=>protocol, "Host:"=>host,
      "Port:"=>port, "Origin:"=> origin, "Accept:"=>accept }
  end

  def verb
    request_lines[0].split[0]
  end

  def path
	   request_lines[0].split[1].split("?")[0]
  end

  def param_name
    if request_lines[0].include?("?")
      request_lines[0].split[1].split("?")[1].split("=")[0]
    end
  end

  def param_value
    if request_lines[0].include?("?")
  	  request_lines[0].split[1].split("?")[1].split("=")[1]
    end
  end

  def protocol
    request_lines[0].split[2]
  end

  def host
    request_lines[1].split(":")[1].strip
  end

  def port
    request_lines[1].split(":")[2]
  end

  def origin
    request_lines[1].split(":")[1].strip
  end

  def accept
    request_lines[6].split[1]
  end

end
