class BoardsController < ApplicationController
caches_action :index 


  def index
     @b = Board.new
     @b.connection
     @p = @b.get_projects
  end

end
