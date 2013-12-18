module MeiserRails
  module Informix

   CONNECTION_PARAMS= ['database','host','port','protocol','username','password', 'parameterized']

   def self.included(base)
     base.extend(ClassMethods)
   end

   module ClassMethods
    def baan_available?
     begin
      #MeiserRails::Db.connection.nil? ? false : true
      IBM_DB.connect(Rails.application.config.meiser.baan, "", "").nil? ? false : true
     rescue
      puts "Connection failed: #{IBM_DB::conn_errormsg}"
     end
    end

    def foreach_baan(query, params = [], &block)

      params = informix_date_conversion(params)

      begin
       #conn = MeiserRails::Db.connection
       conn = IBM_DB.connect(Rails.application.config.meiser.baan, "", "")

       if stmt = IBM_DB.prepare(conn,query)
        IBM_DB.execute(stmt, params)
        while row = IBM_DB.fetch_assoc(stmt)
         yield row
        end
        IBM_DB.free_result(stmt)
       else
        raise "Statement execution failed: #{IBM_DB::getErrormsg(conn,stmt)}"
       end
      rescue
       raise "Connection error: #{IBM_DB::getErrormsg(conn,IBM_DB::DB_CONN)}"
      ensure
       #IBM_DB::close(conn)
      end
    end


    def update_baan(query, params = [])
      begin
        params = informix_date_conversion(params)
        conn = IBM_DB.connect(Rails.application.config.meiser.baan, "", "")
        #conn = MeiserRails::Db.connection
	stmt = IBM_DB.prepare(conn, query)
        return IBM_DB.execute(stmt,params)
      rescue
	raise "Statement execution failed"
      ensure
        IBM_DB::free_result(stmt)
      end
    end


    private

    def informix_date_conversion(params=[])
      params.collect! do |v|
        v.kind_of?(DateTime) ? v.utc.strftime("%Y-%m-%d %H:%M:%S.%6N") : v
      end
    end


   end

  end
end

