require_relative 'server'

#MAY BE ABLE TO GET RID OF THE diagnostic_output METHOD

class Diagnostics
  attr_reader :request_lines, :output

  def initialize
    @output = {}
  end

  def start(request_lines)
    verb(request_lines)
    path(request_lines)
    protocol(request_lines)
    host(request_lines)
    port(request_lines)
    origin(request_lines)
    accept(request_lines)
    #diagnostic_output
    output
  end

  def verb(request_lines)
    output["Verb:"] = request_lines[0].split[0]
  end

  def path(request_lines)
    output["Path:"] = request_lines[0].split[1]
  end

  def protocol(request_lines)
    output["Protocol:"] = request_lines[0].split[2]
  end

  def host(request_lines)
    output["Host:"] = request_lines[1].split(":")[1].strip
  end

  def port(request_lines)
    output["Port:"] = request_lines[1].split(":")[2]
  end

  def origin(request_lines)
    output["Origin:"] = request_lines[1].split(":")[1].strip
  end

  def accept(request_lines)
    output["Accept:"] = request_lines[6].split[1]
  end

  # def diagnostic_output
  #   # output.map { |key, value| "#{key} #{value}"}.join("\n")
  #   response = Response.new(output)
  #   response.start
  # end

end
