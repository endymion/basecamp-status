require 'basecamp'
  
  ENV['BASECAMP_TOKEN'] = "ec20d0d864592cdfee706ca466af4e3b13398454"
  ENV['BASECAMP_URL'] = "hashlabs.basecamphq.com"
  
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

