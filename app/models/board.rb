require 'basecamp'
 
  APITOKEN = ENV['BASECAMP_TOKEN']
  URL = ENV['BASECAMP_URL']
  
class Board
  
  def connection(url = URL, token = APITOKEN)
    Basecamp.establish_connection!(url, token, 'X', true)
  end

  def get_projects
    Basecamp::Project.all
  end

  def get_todos(project)
    Basecamp::TodoList.all(project.id).flatten
  end

end

