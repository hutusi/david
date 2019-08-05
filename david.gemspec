lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "david/version"

Gem::Specification.new do |spec|
  spec.name          = "dave"
  spec.version       = David::VERSION
  spec.authors       = ["John Hu"]
  spec.email         = ["huziyong@gmail.com"]

  spec.summary       = %q{A ruby gem (command line) to record child's stories for geek daddy or mommy.}
  spec.description   = %q{David is a command line tool that used to record child's daily stories.}
  spec.homepage      = "https://github.com/hutusi/david"
  spec.license       = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/hutusi/david"
  spec.metadata["changelog_uri"] = "https://github.com/hutusi/david/blob/master/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "bin"
  spec.executables   = ['david']
  spec.require_paths = ["lib"]

  spec.add_dependency "sqlite3", ">= 1.4"
  spec.add_dependency "activesupport", ">= 5.2"

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
