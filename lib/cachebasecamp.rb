require 'basecamp'

class Cachebasecamp

  def initialize(url = ENV['BASECAMP_URL'], token = ENV['BASECAMP_TOKEN'])
    Basecamp.establish_connection!(!url.nil? ? url : ENV['BASECAMP_URL'], !token.nil? ? token : ENV['BASECAMP_TOKEN'], 'X', true)
  end
  
  def get_projects
    Basecamp::Project.all  
  end  
  
  def get_todos(project_id)
    Basecamp::TodoList.all(project_id).flatten
  end

  def get_person_by_project(project_id)
    Basecamp::Person.find(:all, :params => {:project_id => project_id})
  end
  
  def update_todo_item_assigned(params)
   item = Basecamp::TodoItem.find(params[:item_id])
   item.responsible_party = params[:responsible_party_id]
   item.save
  end

  def update_todo_item_due_date(params)
   item = Basecamp::TodoItem.find(params[:item_id])
   item.due_at = params[:new_date]
   item.save
  end

  def save_todos 
    get_projects.each do |project|
      if project.status == "active" 
        get_todos(project.id).each do |todo|  
          todo.todo_items.each do |item|
            if item.completed == false
              ctodo = CachedTodo.first(:item_id => item.id)
              if !ctodo.nil?
                ctodo.project_name = project.name
                ctodo.todo_list = item.content
                ctodo.todo_item = (todo.name.nil? ? todo.description : todo.name)
                ctodo.due_date = (!item.due_at.nil? ? item.due_at.strftime("%d %b %Y") : '')
                ctodo.asigned_to = (item.responsible_party_name? ? item.responsible_party_name : '')
                ctodo.save
              else
                CachedTodo.new(:project_name => project.name, :project_id => project.id, :todo_id => todo.id, :item_id => item.id, :todo_list => item.content, :todo_item => (todo.name.nil? ? todo.description : todo.name), :due_date => (!item.due_at.nil? ? item.due_at.strftime("%d %b %Y") : ''), :asigned_to => (item.responsible_party_name? ? item.responsible_party_name : '')).save
              end
            end
          end
        end
      end
    end
  end
  
end