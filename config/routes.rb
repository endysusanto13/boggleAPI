class Route
  ROUTES = {
    "GET" => {
      "/"  => :index
    }
  }

  attr_accessor :name                # To access instance variable @name outside Route class

  def initialize(env)
    path = env["PATH_INFO"]
    http_method = env["REQUEST_METHOD"]
    @name = (ROUTES[http_method] && ROUTES[http_method][path]) || 404      # Assign ROUTES[http_method][path] if path exists. Else, assign 404.
  end
  end
