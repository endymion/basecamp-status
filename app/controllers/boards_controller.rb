require 'cachebasecamp'

class BoardsController < ApplicationController

  def index
    response.headers['Cache-Control'] = 'public, max-age=300'
    page = !params[:page].nil? ? params[:page] : 1
    @todos = CachedTodo.paginate({ :per_page => 200,  :page => page, :order => :created_at.asc})
  end
  
  def get_person_by_project
    @b_obj = Cachebasecamp.new('angelmg.basecamphq.com','74154e8fa88ade84971717cddb3e59fdb619800f')
    persons = @b_obj.get_person_by_project(params[:project_id])
    render :json => persons
  end
  
  def update_todo_item_assigned
    @b_obj = Cachebasecamp.new('angelmg.basecamphq.com','74154e8fa88ade84971717cddb3e59fdb619800f')
    @b_obj.update_todo_item_assigned(params)
    item = CachedTodo.first(:item_id => params[:item_id].to_i)
    item.asigned_to = params[:responsible_party_name]
    item.save
    render :text => 'updated'
  end

end
