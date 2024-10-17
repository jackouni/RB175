require 'rackup'
require 'socket' 

def parse_request(request_line)
  method, path_and_params, version = request_line.split(' ')
  path, params = path_and_params.split('?')
  if params
    queries = params.split('&').map { |param| param.split('=') }.to_h
  else
    queries = {}
  end

  [method, path, queries, version]
end

server = TCPServer.new('localhost', 3003)

loop do
  client = server.accept

  request_line = client.gets
  next if !request_line || request_line =~ /favicon/
  puts request_line
  
  next unless request_line

  method, path, queries, version = parse_request(request_line)

  
  puts parse_request(request_line)
  
  client.puts "HTTP/1.1 200 OK"
  client.puts "Content-Type: text/html"
  client.puts
  client.puts "<body>"
  client.puts "<pre>"
  client.puts method
  client.puts path
  client.puts queries
  client.puts "</pre>"

  client.puts "<h1>Counter</h1>"

  number = queries["number"].to_i
  increment = queries["increment"]

  client.puts "<p>The current number is: #{number}.</p>"

  client.puts "<a href='?number=#{number + 1}'>Increment</a>"
  client.puts "<a href='?number=#{number - 1}'>Decrement</a>"

  client.puts "</body>"
  client.puts "</html>"
  client.close
end