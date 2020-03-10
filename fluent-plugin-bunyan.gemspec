lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name    = "fluent-plugin-bunyan"
  spec.version = "0.1.0"
  spec.authors = ["Gildas Cherruel"]
  spec.email   = ["gildas@breizh.org"]

  spec.summary       = %q{Fluentd Parser for applications that produce [Bunyan](https://github.com/trentm/node-bunyan) logs.}
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/gildas/fluent-plugin-bunyan"
  spec.license       = "MIT"

  spec.metadata["homepage_uri"]    = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"]   = "https://github.com/gildas/fluent-plugin-bunyan/blob/master/CHANGELOG.md"

  test_files, files  = `git ls-files -z`.split("\x0").partition do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.files         = files
  spec.executables   = files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = test_files
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 12.0"
  spec.add_development_dependency "test-unit", "~> 3.0"
  spec.add_runtime_dependency "fluentd", [">= 0.14.10", "< 2"]
end
