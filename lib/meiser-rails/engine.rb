module MeiserRails

 class Engine < Rails::Engine


  initializer "read_baan_informix_database_config",:before=> :load_config_initializers do |app|

   config = Rails.configuration.database_configuration['baan']
   if config
    Informix::CONNECTION_PARAMS.each do |param|
     unless config.key?(param)
      p "Baan database configuration needs #{Informix::CONNECTION_PARAMS.to_sentence}"
      exit
     end
    end
    MeiserConfig = Struct.new(:baan)
    app.config.meiser = MeiserConfig.new "DATABASE=#{config["database"]};HOSTNAME=#{config["host"]};PORT=#{config["port"]};PROTOCOL=#{config["protocol"]};UID=#{config["username"]};PWD=#{config["password"]};".freeze
   else
    Rails.logger.warn 'Please add baan database settings to your database.yml file to work correctly'
   end

  end
  
  initializer "read_baan_informix_database_config",:after=> :load_config_initializers do |app|
   MeiserRails::Db.establish_connection
  end

 end

end

