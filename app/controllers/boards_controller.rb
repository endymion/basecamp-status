class BoardsController < ApplicationController

  def index
    response.headers['Cache-Control'] = 'public, max-age=300'
    page = !params[:page].nil? ? params[:page] : 1
    @todos = CachedTodo.paginate({ :per_page => 200,  :page => page})
  end

end
