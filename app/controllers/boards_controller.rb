class BoardsController < ApplicationController

  def index
    response.headers['Cache-Control'] = 'public, max-age=180'
    @time = Time.now.strftime("%D - %T")
    @b = Board.new
    @b.connection
    @p = @b.get_projects
  end

end
