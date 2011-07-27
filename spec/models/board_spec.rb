require 'spec_helper'
require 'fakeweb'

FakeWeb.allow_net_connect = false

describe Board do

  before(:each) do
    FakeWeb.register_uri(:get, 'https://testtoken123:X@testurl.basecamphq.com/projects.xml',
                         :response => File.expand_path('test/fixtures/projects.xml'))

    FakeWeb.register_uri(:get, 'https://testtoken123:X@testurl.basecamphq.com/projects/7638134/todo_lists.xml?filter=all',
                         :response => File.expand_path('test/fixtures/todolists.xml'))

    FakeWeb.register_uri(:get, 'https://testtoken123:X@testurl.basecamphq.com/todo_lists/15312005/todo_items.xml',
                         :response => File.expand_path('test/fixtures/todo_items.xml'))
  end

  it "should create a Board instance" do
    b = Board.new    
  end

  it "should return a Basecamp::Connection object on connect" do
    b = Board.new
    b.connection.class.should equal(Basecamp::Connection)
  end

  it "should have get_projects and get_todos methods" do
    b = Board.new
    b.should respond_to(:get_projects)
    b.should respond_to(:get_todos)
  end
  
  it "should return projects" do
    b = Board.new
    projects = b.get_projects
    projects.should have(1).items
    projects.first.class.should equal(Basecamp::Project)
  end

  it "should return todos from a single project" do
    b = Board.new
    project = b.get_projects.first
    todo_lists = b.get_todos(project)
    todo_lists.should have(1).items
    todo_lists.first.class.should equal(Basecamp::TodoList)
  end

  it "should return todo items from a todo list" do
    b = Board.new
    todo_list = b.get_todos(b.get_projects.first).first
    todo_items = todo_list.todo_items
    todo_items.should have(3).items
    todo_items.first.class.should equal(Basecamp::TodoItem)    
  end

end
