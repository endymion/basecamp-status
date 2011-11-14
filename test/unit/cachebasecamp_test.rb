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
                         :response => File.expand_path('test/fixtures/todo_list.xml'))

    FakeWeb.register_uri(:get, 'https://testtoken123:X@testurl.basecamphq.com/projects/7638135/todo_lists.xml?filter=all',
                         :response => File.expand_path('test/fixtures/todo_list2.xml'))
                         
    FakeWeb.register_uri(:get, 'https://testtoken123:X@testurl.basecamphq.com/projects/7638136/todo_lists.xml?filter=all',
                         :response => File.expand_path('test/fixtures/todo_list3.xml'))

    FakeWeb.register_uri(:get, 'https://testtoken123:X@testurl.basecamphq.com/projects/7638138/todo_lists.xml?filter=all',
                         :response => File.expand_path('test/fixtures/todo_list4.xml'))

    FakeWeb.register_uri(:get, 'https://testtoken123:X@testurl.basecamphq.com/todo_lists/15312005/todo_items.xml',
                         :response => File.expand_path('test/fixtures/todo_item.xml'))
                         
    FakeWeb.register_uri(:get, 'https://testtoken123:X@testurl.basecamphq.com/todo_lists/15312006/todo_items.xml',
                         :response => File.expand_path('test/fixtures/todo_item2.xml'))

    FakeWeb.register_uri(:get, 'https://testtoken123:X@testurl.basecamphq.com/todo_lists/15312007/todo_items.xml',
                         :response => File.expand_path('test/fixtures/todo_item3.xml'))

    FakeWeb.register_uri(:get, 'https://testtoken123:X@testurl.basecamphq.com/todo_lists/15312009/todo_items.xml',
                         :response => File.expand_path('test/fixtures/todo_item4.xml'))
                                                   
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
    assert_equal items.size, 3
  end
  
  def test_get_venue_name_on_format1
    item = CachedTodo.first(:project_id => 7638134)
    assert_equal item.venue, "VenueName"
  end
  
  def test_get_event_name_on_format1
    item = CachedTodo.first(:project_id => 7638134)
    assert_equal item.event, "EventName"
  end

  def test_get_event_date_on_format1
    item = CachedTodo.first(:project_id => 7638134)
    assert_equal item.event_date, "11.01.01"
  end

  def test_get_venue_name_on_format2
    item = CachedTodo.first(:project_id => 7638135)
    assert_equal item.venue, "Test Venue" 
  end
  
  def test_get_event_name_on_format2
    item = CachedTodo.first(:project_id => 7638135)
    assert_equal item.event, "*Creative Requests"
  end

  def test_get_event_date_on_format2
    item = CachedTodo.first(:project_id => 7638135)
    assert_equal item.event_date, "N/D"
  end

  def test_get_venue_name_on_format3
    item = CachedTodo.first(:project_id => 7638136)
    assert_equal item.venue, "AMG Marketing"
  end
  
  def test_get_event_name_on_format3
    item = CachedTodo.first(:project_id => 7638136)
    assert_equal item.event, "Race to 50,000"
  end

  def test_get_event_date_on_format3
    item = CachedTodo.first(:project_id => 7638136)
    assert_equal item.event_date, "N/D"
  end
  
  def test_projects_not_cached
    item = CachedTodo.exists?(:project_id => 7638138)
    assert_equal item, false
  end  
  
  def test_dueDate
    item = CachedTodo.first(:project_id => 7638136)
    item.due_date = '25 Jun 2010'
    assert_equal item.dueDate, "Jun 25, 2010 0:00 AM"
  end

end