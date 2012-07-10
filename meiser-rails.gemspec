$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "meiser-rails/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "meiser-rails"
  s.version     = MeiserRails::VERSION
  s.authors     = ["Stephan Keller"]
  s.email       = ["s.keller@meiser.de"]
  s.homepage    = ""
  s.summary     = ""
  s.description = "Library for using Rails in Meiser company."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", ">= 3.1.0"
  s.add_dependency "ibm_db", "~> 2.5.10"


  s.add_development_dependency "sqlite3"
end

