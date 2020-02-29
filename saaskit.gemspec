lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "saaskit/version"

Gem::Specification.new do |spec|
  spec.name          = "saaskit"
  spec.version       = Saaskit::VERSION
  spec.authors       = ["Tim"]
  spec.email         = ["tim@tgav.co"]

  spec.summary       = "SaaSKit is the Rails SaaS starter kit for building your SaaS business"
  spec.description   = "DRY (Don't repeat yourself) for developing the same features over and over again. Let " \
                       "building your SaaS platform in a week instead of months with SaaSKit."
  spec.homepage      = "https://saaskitapp.com"
  spec.license       = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/tgavhq/saaskit"
  spec.metadata["changelog_uri"] = "https://github.com/tgavhq/saaskit/blob/master/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
