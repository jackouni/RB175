# Lesson 2: Handling Requests Manually 

## Lesson 2, Assignment 3

Before watching the entirety of the walkthrough portion I want to see if I can guess what the code initially displayed for the mock-server represents.

**Here are my inital guesses (in the comments):***
```ruby
require 'socket' 
# A module used for creating connections between applications.
# A 'socket connection' being end-points for data.

server = TCPServer.new('localhost', 3003)
# TCPServer is a class from the 'socket' module
# An object that represents a TCP connection
# Assigning it a host name of 'localhost'
# Assigning it a port of `3003`
# My assumption is that the server is located locally, hence the name.

loop do # Loop to run while the connection is active?
  client = server.accept
  # `client` is a "start-point" for data that will be sent to `server`
  # `client` has a 

  request_line = client.gets
  # Possibly represents the input data from the client 

  puts request_line
  # I think this will output the request line inputted

  client.puts request_line
  # Maybe this outputs the request line along with data about the client

  client.close
  # Maybe this closes the connection the client has, ending the `server` TCP connection?
end
```

**Here's summary of what is actually happening:**
#### `require 'socket'`
Is used to import the `socket` core library. This library is used for setting up networking connections and servers.

#### `server = TCPServer.new('localhost', 3003)`
This creates a `TCPServer` object that represents a server using a TCP connection. This server is a process running on port `3003` on our local machine (`localhost`).

#### `loop do`
This is an infinite loop. This is done so that the server can stay open and coninuously listen for incoming requests.

#### `client = server.accept`
`server.accept` is listening for any requests being sent to the server. When a request is sent, `server.accept` returns an object that represents the client/sender of that request.

#### `request_line = client.gets`
`client.gets` returns the first line of the request that was sent by `client`

#### `puts request_line`
This outputs the request line to the terminal

#### `client.puts request_line`
Sends the request line back to the client.

#### `client.close`
Closes/terminates the TCP connection between `client` and `server`



## Lesson 2 Summary:

- HTTP is just text formatted in a certain way, that is parsed and interpreted.
- HTTP is stateless
- *State* can be simulated through the use of query parameters. These query parameters can contain values that we can use on the server side to dynmically generate content. By using `<a>` tags in the response body's HTML, we can apply logic to the hyper-link's URL structure on the server side to dynamically generate URL's for a client to use.
- When crafting our own low-level servers, using conditional statements can help us avoid errors that may be encountered from client HTTP requests. **Example**: client not including query parameters when our server expects query parameters
- Generally, we are not doing stuff at this low of a level. Usually devs are using tools built to abstract a lot of these lower-level implementations to interpret, parse and construct HTML to send in a body.

---

---


# Lesson 3: Working With Sinatra

## What is Rack (Ruby)?

