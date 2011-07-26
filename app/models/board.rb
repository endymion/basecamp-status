require 'basecamp'

APITOKEN = "ec20d0d864592cdfee706ca466af4e3b13398454"
URL = "hashlabs.basecamphq.com"

class Board
  
  def connection
    Basecamp.establish_connection!(URL, APITOKEN, 'X', true)
  end

  def get_projects
    Basecamp::Project.all #array with projects
  end

  def get_todos(project)
    Basecamp::TodoList.all(project.id).flatten #array with todo lists from project
  end

  

end

