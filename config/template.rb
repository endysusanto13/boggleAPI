class Template
  def initialize(page)
    @page = page
    file = File.join(File.dirname(__FILE__), "../app/view/layouts/#{page}.html.erb")
    @template = File.read(file)
  end

  def render
    ERB.new(@template).result(binding)
  end
end