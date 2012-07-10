module MeiserRails
  module Informix

   CONNECTION_PARAMS= ['database','host','port','protocol','username','password', 'parameterized']

   def self.included(base)
     base.extend(ClassMethods)
   end

   module ClassMethods
    def baan_available?
     begin
      IBM_DB.connect(Rails.application.config.meiser.baan, "", "").nil? ? false : true
     rescue
      puts "Connection failed: #{IBM_DB::conn_errormsg}"
     end
    end

    def foreach_baan(query, params = nil, &block)
      begin
       conn = IBM_DB.connect(Rails.application.config.meiser.baan, "", "")

       if stmt = IBM_DB.prepare(conn,query)
        IBM_DB.execute(stmt, params)
        while row = IBM_DB.fetch_assoc(stmt)
         yield row
        end
        IBM_DB.free_result(stmt)
       else
        puts "Statement execution failed: #{IBM_DB::getErrormsg(conn,IBM_DB::DB_CONN)}"
       end
      rescue
       puts "Statement execution failed: #{IBM_DB::getErrormsg(conn,IBM_DB::DB_CONN)}"
      ensure
       #IBM_DB::close(conn)
      end
    end

   end

  end
end

