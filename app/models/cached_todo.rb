class CachedTodo
  include MongoMapper::Document
  timestamps!
  
  def self.venue
    dotPos = self.project_name.index('.')
    !dotPos.nil? ? self.project_name[0..(dotPos-4)] : 'N/D'
  end 
  
  def self.event
    colonPos = self.project_name.index(':')
    !colonPos.nil? ? self.project_name[(colonPos+2)..(self.project_name.length)] : 'N/D'
  end
  
  def self.event_date
    self.project_name[/\d{1,2}[.]\d{1,2}[.]\d{1,2}/]
  end
  
end
