class BoardsController < ApplicationController
  
  def index
     @b = Board.new
     @b.connection
     @p = @b.get_projects
  end

end
