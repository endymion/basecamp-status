MongoMapper.connection = Mongo::Connection.new('staff.mongohq.com', 10038, { :logger => Rails.logger })
MongoMapper.database = 'basecamp-status'
MongoMapper.database.authenticate('basecamp', 'letmein')