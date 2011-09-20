if ENV["RAILS_ENV"] == 'test'
  MongoMapper.connection = Mongo::Connection.new('localhost', 27017, { :logger => Rails.logger })
  MongoMapper.database = 'basecamp-status' 
else
  MongoMapper.connection = Mongo::Connection.new('staff.mongohq.com', 10038, { :logger => Rails.logger })
  MongoMapper.database = 'basecamp-status'
  MongoMapper.database.authenticate('basecamp', 'letmein')
end