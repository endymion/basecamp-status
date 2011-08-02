class BoardsController < ApplicationController

  def index
    response.headers['Cache-Control'] = 'public, max-age=300'
    @time = Time.now.strftime("%D - %T")
    @b = Board.new
    @b.connection
    @p = @b.get_projects
  end

end
