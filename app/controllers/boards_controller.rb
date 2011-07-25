class BoardsController < ApplicationController
  
  def index
     b = Board.new
     b.connection
     @hash = b.generate_data_hash(b.get_todo_lists(b.get_all_projects_id.first).todo_items)
  end

end
