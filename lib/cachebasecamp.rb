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
  
  def save_todos 
    get_projects.each do |project|
      if project.status == "active" && project.name != '*Creative Requests'
        get_todos(project.id).each do |todo|  
          todo.todo_items.each do |item|
            CachedTodo.new(:project_id => project.id, :todo_id => todo.id, :venue => split_project_name("venue", project.name), :event => split_project_name("event", project.name), :event_date => split_project_name("event_date", project.name), :todo_list => item.content, :todo_item => (todo.name.nil? ? todo.description : todo.name), :due_date => (!item.due_at.nil? ? item.due_at.strftime("%d %b %Y") : ''), :asigned_to => (item.responsible_party_name? ? item.responsible_party_name : '')).save
          end
        end
      end
    end
  end

  def split_project_name(part, project_name)
    dotPos = project_name.index('.')
    colonPos = project_name.index(':')
      case part
        when "venue"
          !dotPos.nil? ? project_name[0..(dotPos-4)] : 'N/D'
        when "event"
          !colonPos.nil? ? project_name[(colonPos+2)..(project_name.length)] : 'N/D'
        when "event_date"
          project_name[/\d{1,2}[.]\d{1,2}[.]\d{1,2}/]
      end
  end
end