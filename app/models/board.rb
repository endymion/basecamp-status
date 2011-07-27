require 'basecamp'
  ENV['BASECAMP_URL']="angelmg.basecamphq.com"
  ENV['BASECAMP_TOKEN']="fcc852785aee2af1756a4a4e7709385880013ce0"

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

