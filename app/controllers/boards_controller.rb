require 'cachebasecamp'
require 'rake'

class BoardsController < ApplicationController

  def index
    page = !params[:page].nil? ? params[:page] : 1
    @todos = CachedTodo.all
    @venues  = []
    finded = false
    @todos.each do |item|
      @venues.each do |venue|
        if venue == item.venue
          finded = true
          break
        end
      end
      if finded == false
        @venues << item.venue
      else
        finded = false
      end
    end
  end
  
  def loading
    render :layout => 'loading'
  end
  
  def cachedUpdateFinished
    render :text => CachedTodo.last.update_finish
  end
  
  def reload
    rake = Rake::Application.new
    Rake.application = rake
    Rake::Task.define_task(:environment)
    load "#{Rails.root}/lib/tasks/cached.rake"
    rake["cached:save"].invoke
    render :text => 'reloaded'
  end
  
  def get_person_by_project
    @b_obj = Cachebasecamp.new('angelmg.basecamphq.com', '74154e8fa88ade84971717cddb3e59fdb619800f')
    persons = @b_obj.get_person_by_project(params[:project_id])
    render :json => persons
  end
  
  def update_todo_item_assigned
    @b_obj = Cachebasecamp.new
    @b_obj.update_todo_item_assigned(params)
    item = CachedTodo.first(:item_id => params[:item_id].to_i)
    item.asigned_to = params[:responsible_party_name]
    item.save
    render :text => 'updated'
  end
  
  def update_todo_item_due_date
    @b_obj = Cachebasecamp.new
    @b_obj.update_todo_item_due_date(params)
    item = CachedTodo.first(:item_id => params[:item_id].to_i)
    item.due_date = params[:new_date]
    item.save
    render :text => 'updated'
  end
  
  def mark_item_as_completed
    @b_obj = Cachebasecamp.new('angelmg.basecamphq.com', '74154e8fa88ade84971717cddb3e59fdb619800f')
    ids = params[:item_ids].split(',')
    ids.each do |id_number|
      @b_obj.mark_item_as_completed(id_number.to_i)
      item = CachedTodo.first(:item_id => id_number.to_i)
      item.delete
    end
    render :text => 'updated'
  end

end
