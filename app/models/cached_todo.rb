class CachedTodo
  include MongoMapper::Document
  timestamps!
  
  def venue
    !self.project_name.index('.').nil? ? self.project_name[0..(self.project_name.index('.')-4)] : 'N/D'
  end 
  
  def event
    !self.project_name.index(':').nil? ? self.project_name[(self.project_name.index(':')+2)..(self.project_name.length)] : 'N/D'
  end
  
  def event_date
    !self.project_name[/\d{1,2}[.]\d{1,2}[.]\d{1,2}/].nil? ? self.project_name[/\d{1,2}[.]\d{1,2}[.]\d{1,2}/] : "N/D"
  end
  
end
