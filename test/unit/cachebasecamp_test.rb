require File.dirname(__FILE__) + '/../test_helper'
require 'cachebasecamp'

class CachebasecampTest < Test::Unit::TestCase

  def clean_cached_db
    CachedTodo.delete_all
  end

  def setup
    clean_cached_db
    FakeWeb.register_uri(:get, 'https://testtoken123:X@testurl.basecamphq.com/projects.xml',
                         :response => File.expand_path('test/fixtures/projects.xml'))

    FakeWeb.register_uri(:get, 'https://testtoken123:X@testurl.basecamphq.com/projects/7638134/todo_lists.xml?filter=all',
                         :response => File.expand_path('test/fixtures/todolists.xml'))

    FakeWeb.register_uri(:get, 'https://testtoken123:X@testurl.basecamphq.com/todo_lists/15312005/todo_items.xml',
                         :response => File.expand_path('test/fixtures/todo_items.xml'))    
     
    
    @cachebasecamp_object = Cachebasecamp.new
    @cachebasecamp_object.save_todos
    @projects = @cachebasecamp_object.get_projects
    @todos = @cachebasecamp_object.get_todos(@projects.last.id)
  end

  def test_cachebaseacmp_get_projects
    assert_equal @projects.last.class, Basecamp::Project
  end

  def test_cachebasecamp_get_todos
    assert_equal @todos.last.class, Basecamp::TodoList
  end
  
  def test_cachebasecamp_todo_items
    item = @todos.last.todo_items
    assert_equal item.last.class, Basecamp::TodoItem
  end

  def test_items_is_cached?
    assert_equal CachedTodo.all.size, 3
  end
  
  def test_items_assigned_to_orlando
    items = CachedTodo.where(:asigned_to => "Orlando Del Aguila")
     assert_equal items.size, 2
  end
  
  def test_get_venue_name
    item = CachedTodo.last
    assert_equal item.venue, "VenueName"
  end
  
  def test_get_event_name
    item = CachedTodo.last
    assert_equal item.event, "EventName"
  end

end