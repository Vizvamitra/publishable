$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "publishable/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "publishable"
  s.version     = Publishable::VERSION
  s.authors     = ["d.krasnov"]
  s.email       = ["d.krasnov@1tvch.ru"]
  s.homepage    = "http://github.com/tvch1/publishable"
  s.summary     = "adds publishable logics to your models"
  s.description = "adds publishable logics to your models"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", ">= 4.1.0"

  s.add_development_dependency "sqlite3"
end
