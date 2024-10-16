require 'socket' 

def parse_request(request_line)
  method, path_and_params, version = request_line.split(' ')
  path, params = path_and_params.split('?')
  queries = params.split('&').map { |param| param.split('=') }

  [method, path, queries.to_h, version]
end

server = TCPServer.new('localhost', 3003)

loop do
  client = server.accept

  request_line = client.gets
  next if !request_line || request_line =~ /favicon/
  puts request_line

  method, path, queries, version = parse_request(request_line)
  
  puts parse_request(request_line)

  rolls = queries["rolls"].to_i
  sides = queries["sides"].to_i
  
  client.puts "HTTP/1.1 200 OK"
  client.puts "Content-Type: text/html"
  client.puts
  client.puts "<body>"
  client.puts "<pre>"
  client.puts method
  client.puts path
  client.puts queries
  client.puts "</pre>"
  client.puts "<h1>ROLLS:</h1>"
  client.puts "<p>", rolls, "</p>"
  client.puts "<h1>NUMBERS ROLLED:</h1>"
  rolls.times do |roll|
    client.puts "<p>", "Roll ##{roll+1} ==> #{rand(sides) + 1}", "</p>"
    client.puts
  end
  client.puts "</body>"
  client.puts "</html>"
  client.close
end