require 'rack'
load 'app/app.rb'
port = 3000                     # Change this to change port number

Rack::Handler::WEBrick.run(
  Application.new,
  :Port => port
)