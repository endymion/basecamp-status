class BoardsController < ApplicationController

  def index
     @b = Board.new
     @b.connection
     @p = @b.get_projects
     response.headers['Cache-Control'] = 'public, max-age=180'
     @time = Time.now.strftime("%D - %T")
  end

end
