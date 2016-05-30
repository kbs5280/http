require_relative 'server'

class Diagnostics
  attr_reader :request_lines, :output

  def initialize(request_lines)
    @request_lines = request_lines
    @output = {}
  end

  def verb
    output["Verb: "] = request_lines[0].split[0]
  end

  def path
    output["Path: "] = request_lines[0].split[1]
  end

  def protocol
    output["Protocol: "] = request_lines[0].split[2]
  end

  def host
    output["Host: "] = request_lines[1].split(":")[1].strip
  end

  def port
    output["Port: "] = request_lines[1].split(":")[2]
  end

  def origin
    output["Origin: "] = request_lines[1].split(":")[1].strip
  end

  def accept
    output["Accept: "] = request_lines[6].split[1]
  end

end
