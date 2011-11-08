class CachedTodo
  include MongoMapper::Document
  timestamps!
  
  def venue
    if self.project_name[0] == "*"
      self.project_name[(self.project_name.index(':')+2)..(self.project_name.length)]
    elsif self.project_name[0] == "_"
      "AMG Marketing"
    else
      !self.project_name.index('.').nil? ? self.project_name[0..(self.project_name.index('.')-4)] : 'N/D'
    end
  end 
  
  def event
    if self.project_name[0] == "*"
      "*Creative Requests"
    elsif self.project_name[0] == "_"
      self.project_name[(self.project_name.index(':')+2)..(self.project_name.length)]
    else
      !self.project_name.index(':').nil? ? self.project_name[(self.project_name.index(':')+2)..(self.project_name.length)] : 'N/D'
    end
  end
  
  def event_date
    !self.project_name[/\d{1,2}[.]\d{1,2}[.]\d{1,2}/].nil? ? self.project_name[/\d{1,2}[.]\d{1,2}[.]\d{1,2}/] : "N/D"
  end
  
end
