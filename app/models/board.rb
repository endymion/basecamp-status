require 'basecamp'

APITOKEN = "ec20d0d864592cdfee706ca466af4e3b13398454"
URL = "hashlabs.basecamphq.com"

class Board
  
  def connection
    Basecamp.establish_connection!(URL, APITOKEN, 'X', true)
  end

  def get_all_projects
    projects = Basecamp::Project.all
  end

  def get_all_projects_id
    projects_id = Basecamp::Project.all.map {|project| project.id}
  end

  def get_todo_lists(project_id)
    todo_lists = Basecamp::TodoList.all(project_id).first
  end

  def items(todo_list)
    todo_items = todo_list.todo_items
  end

  def generate_data_hash(todo_items)
      hash = Hash.new
    todo_items.each_with_index do |item,index|
      hash[index] = Hash.new
      hash[index].store("id",item.id)
      hash[index].store("content",item.content)
      #hash[index].store("responsible_party_id",item.responsible_party_id)
      #hash[index].store("responsible_party_name",item.responsible_party_name)
      hash[index].store("due_at",item.due_at)
    end
    return hash
  end

end

