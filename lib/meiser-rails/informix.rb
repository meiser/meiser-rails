module MeiserRails
  module Informix

   CONNECTION_PARAMS= ['database','host','port','protocol','username','password', 'parameterized']

   def self.included(base)
     base.extend(ClassMethods)
   end

   module ClassMethods
    def baan_available?
     IBM_DB.connect(Rails.application.config.meiser.baan, "", "").nil? ? false : true
    end

    def baan
     if baan_available?
      yield IBM_DB.connect(Rails.application.config.meiser.baan, "", "")
     end
    end

   end

  end
end

