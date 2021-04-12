require "rack"
require_relative "../config/template.rb"
require_relative "../config/routes.rb"

class Application
  def call(env)
    response_headers = {}
  
    route = Route.new(env)
    response_status = 200

    template = Template.new(route.name)

    response_body = [template.render]

    [response_status, response_headers, response_body]
  end
end