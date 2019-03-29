$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "replace_with_destroy/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "replace_with_destroy"
  s.version     = ReplaceWithDestroy::VERSION
  s.authors     = ["Alexander Leyva"]
  s.email       = ["cyberxander90@gmail.com"]
  s.homepage    = "https://github.com/cyberxander90/replace_with_destroy"
  s.summary     = "Call destroy callback on removed records when Rails update join models"
  s.description = "By default automatic deletion of join models is direct, no destroy callbacks are triggered. This gem allow changes the default Rails behavior."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.0.7", ">= 5.0.7.2"
end
