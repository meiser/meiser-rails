module MeiserRails

 class Db

  class << self
   attr_accessor :connection
   
   def establish_connection
    @connection = IBM_DB.connect(Rails.application.config.meiser.baan, "", "") 	
   end
  end
  
 end
 
end