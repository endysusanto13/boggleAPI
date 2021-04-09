require 'rack'

class Application
    def call(env)
      response_status = 200
      response_headers = {}
      response_body = [
        "Hello World!"
      ]
      [response_status, response_headers, response_body]
    end
  end