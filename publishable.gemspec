$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "publishable/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "publishable"
  s.version     = Publishable::VERSION
  s.authors     = ["d.krasnov"]
  s.email       = ["d.krasnov@1tvch.ru"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Publishable."
  s.description = "TODO: Description of Publishable."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.0"

  s.add_development_dependency "sqlite3"
end
