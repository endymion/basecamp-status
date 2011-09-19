class BoardsController < ApplicationController

  def index
    response.headers['Cache-Control'] = 'public, max-age=300'
    @todos = CachedTodo.all
  end

end
