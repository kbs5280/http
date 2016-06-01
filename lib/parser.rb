require_relative 'server'

class Parser
  attr_reader :request_lines

  def initialize(request_lines)
    @request_lines = request_lines
  end

  def parser_output
    { "Verb:"=>verb,
      "Path:"=>path,
      "Param Name:"=>param_name,
      "Param Value:"=>param_value,
      "Protocol:"=>protocol,
      "Host:"=>host,
      "Port:"=>port,
      "Origin:"=> origin,
      "Accept:"=>accept }
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
    host = request_lines.detect { |line| line.include?("Host") }
    host.split(":")[1].strip
  end

  def port
    port = request_lines.detect { |line| line.include?("Host") }
    port.split(":")[2].strip
  end

  def origin
    origin = request_lines.detect { |line| line.include?("Host") }
    origin.split(":")[1].strip
  end

  def accept
    accept = request_lines.detect { |line| line.include?("Accept:") }
    accept.split(":")[1].strip
  end

end
