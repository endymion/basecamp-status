class BoardsController < ApplicationController

  def index
     @b = Board.new
     @b.connection
     @p = @b.get_projects
     response.headers['Cache-Control'] = 'public, max-age=300'
  end

end
