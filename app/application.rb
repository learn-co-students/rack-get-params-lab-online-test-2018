class Application
  @@items = %w[Apples Carrots Pears]
  @@cart = %w[Apples Carrots Pears]
  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each { |item| resp.write "#{item}\n" }
    elsif req.path.match(/search/)
      search_term = req.params['q']
      resp.write handle_search(search_term)
    elsif req.path.match(/cart/)
      resp.write parse_cart(resp)
    else
      resp.write 'Path Not Found'
    end

    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end

  def parse_cart(resp)
    if @@cart.length > 0
      @@cart.each { |item| resp.write "#{item}]\n" }
    else
      resp.write 'Your cart is empty'
    end
  end
end
