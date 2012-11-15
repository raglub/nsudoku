# -*- encoding: utf-8 -*-
require File.expand_path('../lib/nsudoku/version', __FILE__)

Gem::Specification.new do |gem|
  gem.platform      = Gem::Platform::RUBY
  gem.authors       = ["Michał Szyma"]
  gem.email         = ["raglub.ruby@gmail.com"]
  gem.date          = "2012-11-15"
  gem.description   = %q{This gem solve puzzle game sudoku (n^2, n^2), for example (3^2, 3^2) = (9, 9)}
  gem.summary       = %q{This gem solve puzzle game sudoku}
  gem.homepage      = "http://github.com/raglub/nsudoku"

  gem.files         = `git ls-files`.split($\)
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "nsudoku"
  gem.require_paths = ["lib"]
  gem.version       = NSudoku::VERSION

  gem.add_development_dependency "rspec", ">= 2.10.0"
end
